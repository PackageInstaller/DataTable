using System.Collections.Generic;
using UnityEngine;

public abstract class CommonSimpleTimelineClipPlayer<T> : IClipPlayer where T : ITimelineClipBeginNormalized, ITimelineClipLength
{
	private Transform m_transform;

	protected List<T> m_clips;

	protected List<T> m_waitEnterClips = new List<T>(8);

	protected List<T> m_runningClips = new List<T>(8);

	protected List<T> m_waitExitClips = new List<T>(8);

	protected float m_lastNormalized = -1f;

	private bool _Running;

	public Transform Transform
	{
		get
		{
			return m_transform;
		}
		set
		{
			m_transform = value;
			OnInitTransform(value);
		}
	}

	public void Initialize(List<T> clips, float beginNormalized)
	{
		m_clips = clips;
		m_waitEnterClips.Clear();
		m_runningClips.Clear();
		m_waitExitClips.Clear();
		if (clips != null && clips.Count > 0)
		{
			_Running = true;
			m_lastNormalized = beginNormalized - 0.1f;
			_Initialize(m_clips);
		}
	}

	protected virtual void OnInitTransform(Transform transform)
	{
	}

	protected abstract void _Initialize(List<T> clips);

	protected abstract void _EnterNodes(List<T> clipsInThisFrame, float normalized, bool isRolleback = false);

	protected abstract void _UpdateNodes(List<T> clipsInThisFrame, float normalized);

	protected abstract void _ExitNodes(List<T> clipsInThisFrame, float normalized, bool isRolleback = false);

	protected abstract void _Shutdown();

	protected abstract void _Stop(bool isForceClean = true);

	protected abstract bool _CanTriggerOnInOutOneFrame();

	public virtual void UpdateWithoutTimeScale(float realTimeDelta)
	{
	}

	public virtual void Update(float normalized)
	{
		if (m_clips == null || m_clips.Count == 0)
		{
			return;
		}
		if (normalized >= m_lastNormalized)
		{
			List<T>.Enumerator enumerator = m_clips.GetEnumerator();
			while (enumerator.MoveNext())
			{
				T current = enumerator.Current;
				if (!(current.GetBeginNormalized() > m_lastNormalized))
				{
					continue;
				}
				if (!(current.GetBeginNormalized() <= normalized))
				{
					break;
				}
				ITimelineClipEndNormalized timelineClipEndNormalized = current as ITimelineClipEndNormalized;
				if (timelineClipEndNormalized == null || normalized <= timelineClipEndNormalized.GetEndNormalized() || _CanTriggerOnInOutOneFrame())
				{
					m_waitEnterClips.Add(current);
					if (timelineClipEndNormalized != null)
					{
						AddRunningClip(current);
					}
				}
			}
			if (m_waitEnterClips.Count > 0)
			{
				_EnterNodes(m_waitEnterClips, normalized);
				m_waitEnterClips.Clear();
			}
			if (m_runningClips.Count > 0)
			{
				for (int num = m_runningClips.Count - 1; num >= 0; num--)
				{
					ITimelineClipEndNormalized timelineClipEndNormalized2 = m_runningClips[num] as ITimelineClipEndNormalized;
					if (normalized > timelineClipEndNormalized2.GetEndNormalized())
					{
						m_waitExitClips.Add(m_runningClips[num]);
						RemoveAtRunningClip(num);
					}
				}
			}
			if (m_waitExitClips.Count > 0)
			{
				_ExitNodes(m_waitExitClips, normalized);
				m_waitExitClips.Clear();
			}
		}
		else if (normalized < m_lastNormalized)
		{
			if (m_runningClips.Count > 0)
			{
				for (int num2 = m_runningClips.Count - 1; num2 >= 0; num2--)
				{
					if (normalized < m_runningClips[num2].GetBeginNormalized())
					{
						m_waitExitClips.Add(m_runningClips[num2]);
						RemoveAtRunningClip(num2);
					}
				}
			}
			if (m_waitExitClips.Count > 0)
			{
				_ExitNodes(m_waitExitClips, normalized, isRolleback: true);
				m_waitExitClips.Clear();
			}
			for (int num3 = m_clips.Count - 1; num3 >= 0; num3--)
			{
				T val = m_clips[num3];
				if (!(val.GetBeginNormalized() <= normalized))
				{
					break;
				}
				if (val is ITimelineClipEndNormalized)
				{
					if ((val as ITimelineClipEndNormalized).GetEndNormalized() > normalized && !m_runningClips.Contains(val))
					{
						m_waitEnterClips.Add(val);
						AddRunningClip(val);
					}
				}
				else if (val.GetBeginNormalized() == normalized)
				{
					m_waitEnterClips.Add(val);
				}
			}
			if (m_waitEnterClips.Count > 0)
			{
				_EnterNodes(m_waitEnterClips, normalized, isRolleback: true);
				m_waitEnterClips.Clear();
			}
		}
		if (m_runningClips.Count != 0)
		{
			_UpdateNodes(m_runningClips, normalized);
		}
		m_lastNormalized = normalized;
	}

	private void AddRunningClip(T clip)
	{
		m_runningClips.Add(clip);
	}

	private void RemoveAtRunningClip(int index)
	{
		m_runningClips.RemoveAt(index);
	}

	protected List<T> GetRunningClips()
	{
		return m_runningClips;
	}

	protected int GetRunningClipsCount()
	{
		return m_runningClips.Count;
	}

	public virtual void UpdateTransform(Vector3 position, Vector3 forward)
	{
	}

	public void Shutdown()
	{
		if (m_runningClips.Count > 0)
		{
			_ExitNodes(m_runningClips, m_lastNormalized);
		}
		m_waitEnterClips.Clear();
		m_runningClips.Clear();
		m_waitExitClips.Clear();
		m_clips = null;
		m_lastNormalized = -1f;
		_Shutdown();
		_Running = false;
	}

	public void Stop(bool isForceClean = true)
	{
		if (_Running)
		{
			_ExitNodes(m_runningClips, m_lastNormalized);
			_Stop(isForceClean);
			m_waitEnterClips.Clear();
			m_runningClips.Clear();
			m_waitExitClips.Clear();
			m_lastNormalized = -1f;
			_Running = !isForceClean;
		}
	}
}
