using System.Collections.Generic;
using UnityEngine.Pipelines.SimPipeline.Character;

public class TimelineCharacterSliceEffectClipPlayer : CommonSimpleTimelineClipPlayer<CharacterSliceEffectClip>
{
	private SliceEffect m_characterSliceEffect;

	private float m_originOffset;

	private float m_originRange;

	private float m_originDensity;

	private float m_originSpeed;

	private List<BuffCharacterSliceEffect> m_buffList = new List<BuffCharacterSliceEffect>();

	public SliceEffect CharacterSliceEffect
	{
		get
		{
			return m_characterSliceEffect;
		}
		set
		{
			m_characterSliceEffect = value;
			if (m_characterSliceEffect != null)
			{
				m_originOffset = m_characterSliceEffect.offset;
				m_originRange = m_characterSliceEffect.range;
				m_originDensity = m_characterSliceEffect.density;
				m_originSpeed = m_characterSliceEffect.speed;
			}
		}
	}

	public void ResetCharacterSliceParams()
	{
		m_characterSliceEffect.offset = m_originOffset;
		m_characterSliceEffect.range = m_originRange;
		m_characterSliceEffect.density = m_originDensity;
		m_characterSliceEffect.speed = m_originSpeed;
		m_characterSliceEffect.enabled = false;
	}

	protected override void _Initialize(List<CharacterSliceEffectClip> clips)
	{
		ResetCharacterSliceParams();
	}

	protected override void _EnterNodes(List<CharacterSliceEffectClip> clipsInThisFrame, float normalized, bool isRolleback = false)
	{
		ResetCharacterSliceParams();
	}

	protected override bool _CanTriggerOnInOutOneFrame()
	{
		return false;
	}

	protected override void _UpdateNodes(List<CharacterSliceEffectClip> clipsInThisFrame, float normalized)
	{
		if (!m_characterSliceEffect.enabled)
		{
			m_characterSliceEffect.enabled = true;
		}
		CharacterSliceEffectClip characterSliceEffectClip = clipsInThisFrame[clipsInThisFrame.Count - 1];
		float time = (normalized - characterSliceEffectClip.NormalizedBegin) / (characterSliceEffectClip.NormalizedEnd - characterSliceEffectClip.NormalizedBegin);
		m_characterSliceEffect.offset = characterSliceEffectClip.OffsetCurve.Evaluate(time) * characterSliceEffectClip.Offset;
		m_characterSliceEffect.range = characterSliceEffectClip.RangeCurve.Evaluate(time) * characterSliceEffectClip.Range;
		m_characterSliceEffect.density = characterSliceEffectClip.DensityCurve.Evaluate(time) * characterSliceEffectClip.Density;
		m_characterSliceEffect.speed = characterSliceEffectClip.SpeedCurve.Evaluate(time) * characterSliceEffectClip.Speed;
	}

	protected override void _ExitNodes(List<CharacterSliceEffectClip> clipsInThisFrame, float normalized, bool isRolleback = false)
	{
		ResetCharacterSliceParams();
	}

	protected override void _Stop(bool isForceClean = true)
	{
		ResetCharacterSliceParams();
	}

	protected override void _Shutdown()
	{
		ResetCharacterSliceParams();
	}

	public bool HasBuffEffect()
	{
		return m_buffList.Count > 0;
	}

	public BuffCharacterSliceEffect GetMaxOrderBuffEffect()
	{
		if (m_buffList.Count <= 0)
		{
			return null;
		}
		int num = -1;
		int index = m_buffList.Count - 1;
		for (int num2 = m_buffList.Count - 1; num2 >= 0; num2--)
		{
			if (m_buffList[num2].Order > num)
			{
				num = m_buffList[num2].Order;
				index = num2;
			}
		}
		return m_buffList[index];
	}

	public void AddBuffEffect(int creationIndex, int order, float offset, float range, float density, float speed)
	{
		BuffCharacterSliceEffect buffCharacterSliceEffect = FrameObjectPool<BuffCharacterSliceEffect>.Claim();
		buffCharacterSliceEffect.CreationIndex = creationIndex;
		buffCharacterSliceEffect.Order = order;
		buffCharacterSliceEffect.Offset = offset;
		buffCharacterSliceEffect.Range = range;
		buffCharacterSliceEffect.Density = density;
		buffCharacterSliceEffect.Speed = speed;
		m_buffList.Add(buffCharacterSliceEffect);
	}

	public void RemoveBuffEffect(int creationIndex)
	{
		for (int i = 0; i < m_buffList.Count; i++)
		{
			if (m_buffList[i].CreationIndex == creationIndex)
			{
				BuffCharacterSliceEffect obj = m_buffList[i];
				m_buffList.RemoveAt(i);
				FrameObjectPool<BuffCharacterSliceEffect>.Release(obj);
				if (m_buffList.Count == 0)
				{
					ResetCharacterSliceParams();
				}
				break;
			}
		}
	}

	public void ClearBuffEffect()
	{
		for (int i = 0; i < m_buffList.Count; i++)
		{
			FrameObjectPool<BuffCharacterSliceEffect>.Release(m_buffList[i]);
		}
		m_buffList.Clear();
		ResetCharacterSliceParams();
	}

	public void UpdateBuffEffect(int creationIndex, float offset, float range, float density, float speed)
	{
		BuffCharacterSliceEffect buffEffectByCreationIndex = GetBuffEffectByCreationIndex(creationIndex);
		if (buffEffectByCreationIndex != null)
		{
			buffEffectByCreationIndex.Offset = offset;
			buffEffectByCreationIndex.Range = range;
			buffEffectByCreationIndex.Density = density;
			buffEffectByCreationIndex.Speed = speed;
		}
	}

	public BuffCharacterSliceEffect GetBuffEffectByCreationIndex(int creationIndex)
	{
		for (int i = 0; i < m_buffList.Count; i++)
		{
			if (m_buffList[i].CreationIndex == creationIndex)
			{
				return m_buffList[i];
			}
		}
		return null;
	}

	public override void Update(float normalized)
	{
		if (HasBuffEffect())
		{
			BuffCharacterSliceEffect maxOrderBuffEffect = GetMaxOrderBuffEffect();
			if (maxOrderBuffEffect != null)
			{
				if (!m_characterSliceEffect.enabled)
				{
					m_characterSliceEffect.enabled = true;
				}
				m_characterSliceEffect.offset = maxOrderBuffEffect.Offset;
				m_characterSliceEffect.range = maxOrderBuffEffect.Range;
				m_characterSliceEffect.density = maxOrderBuffEffect.Density;
				m_characterSliceEffect.speed = maxOrderBuffEffect.Speed;
				return;
			}
		}
		base.Update(normalized);
	}
}
