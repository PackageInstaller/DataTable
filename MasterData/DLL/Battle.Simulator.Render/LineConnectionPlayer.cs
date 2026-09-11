using System;
using System.Collections.Generic;
using UnityEngine;

public class LineConnectionPlayer
{
	public float Tension = 0.025f;

	public float Dampening = 0.025f;

	public float Spread = 0.25f;

	private List<TimelineLineConnectionClip> _clips;

	private Vector3 _forward;

	private Vector3 _position;

	public NAgent _nAgent;

	private Vector3[] _points = new Vector3[100];

	private Dictionary<int, GameObject> activeLines = new Dictionary<int, GameObject>(new IntComparer());

	private Dictionary<int, Vector3[]> linePoints = new Dictionary<int, Vector3[]>(new IntComparer());

	public void Initialize(List<TimelineLineConnectionClip> clips, NAgent nAgent = null)
	{
		_clips = clips;
		_nAgent = nAgent;
		for (int i = 0; i < _points.Length; i++)
		{
			_points[i] = Vector3.zero;
		}
		activeLines.Clear();
		linePoints.Clear();
	}

	private void AddClip(int i)
	{
		GameObject gameObject = Asset.Instantiate(_clips[i].effectPath);
		if (!(gameObject == null))
		{
			activeLines[i] = gameObject;
			linePoints[i] = new Vector3[_clips[i].lerpPointNumber];
		}
	}

	private void RemoveClip(int i)
	{
		PooledAsset.DestroyOrReturn(activeLines[i], 0.033f);
		activeLines.Remove(i);
	}

	private Vector3 GetStartOrEndPos(TimelineLineConnectionClip clip, bool isStartPos)
	{
		Transform transform = _nAgent.transform;
		Transform transform2 = null;
		try
		{
			transform2 = transform.Find(clip.handPoint);
			if (transform2 == null)
			{
				transform2 = transform;
			}
		}
		catch (Exception)
		{
			transform2 = transform;
		}
		Vector3 vector = ((!(transform2 == transform)) ? clip.startOffset : (transform2.localPosition + clip.startOffset));
		Vector4 vector2 = new Vector4(vector.x, vector.y, vector.z, 1f);
		if (transform2.parent != null)
		{
			vector2 = transform2.localToWorldMatrix * vector2;
		}
		if (isStartPos)
		{
			return vector2;
		}
		Vector3 vector3;
		try
		{
			_ = _nAgent.AgentID;
			int aimingTarget = (_nAgent.Blackboard as BBHumanoid).AimingTarget;
			vector3 = (NScene.GetCurrentScene() as BattleScene).GetAgentManager().GetAgent(aimingTarget).ChestPosition;
		}
		catch (Exception)
		{
			vector3 = vector2;
		}
		return vector3 + clip.endOffset;
	}

	public void Update(float normalizeTime)
	{
		for (int i = 0; i < _clips.Count; i++)
		{
			if (_clips[i].NormalizedBegin <= normalizeTime && _clips[i].NormalizedEnd >= normalizeTime && !activeLines.ContainsKey(i))
			{
				AddClip(i);
			}
			else if ((double)_clips[i].NormalizedEnd + 0.033 < (double)normalizeTime && activeLines.ContainsKey(i))
			{
				RemoveClip(i);
			}
		}
		foreach (KeyValuePair<int, GameObject> activeLine in activeLines)
		{
			TimelineLineConnectionClip clip = _clips[activeLine.Key];
			GameObject value = activeLine.Value;
			if (value == null)
			{
				continue;
			}
			LineRenderer component = value.GetComponent<LineRenderer>();
			if (component == null)
			{
				continue;
			}
			Vector3 startOrEndPos = GetStartOrEndPos(clip, isStartPos: true);
			Vector3 startOrEndPos2 = GetStartOrEndPos(clip, isStartPos: false);
			if (clip.isCurve)
			{
				int lerpPointNumber = clip.lerpPointNumber;
				for (int j = 0; j < lerpPointNumber; j++)
				{
					Vector3 vector = Vector3.Lerp(startOrEndPos, startOrEndPos2, (float)j / ((float)lerpPointNumber - 1f));
					float num = Mathf.Sin(normalizeTime * clip.shakeSpeed + (float)j / ((float)lerpPointNumber - 1f) * clip.period);
					num += Mathf.PerlinNoise(vector.x, vector.y + Mathf.Sin(normalizeTime * clip.noiseFactor));
					num *= (float)j * (float)(lerpPointNumber - j) / (float)(lerpPointNumber * lerpPointNumber);
					vector.y += num;
					linePoints[activeLine.Key][j] = vector;
				}
				component.positionCount = lerpPointNumber;
				component.SetPositions(linePoints[activeLine.Key]);
			}
			else
			{
				component.positionCount = 2;
				component.SetPosition(0, startOrEndPos);
				component.SetPosition(1, startOrEndPos2);
			}
		}
	}

	public Vector3 AddNoise(Vector3 pointPosition, float factor)
	{
		float x = pointPosition.x + factor;
		float num = pointPosition.y + factor;
		float y = pointPosition.z + factor;
		pointPosition.x += Mathf.PerlinNoise(num, y) - 0.5f;
		pointPosition.y += Mathf.PerlinNoise(x, y) - 0.5f;
		pointPosition.z += Mathf.PerlinNoise(x, num) - 0.5f;
		return pointPosition;
	}

	internal void Shutdown()
	{
		if (activeLines == null)
		{
			return;
		}
		foreach (KeyValuePair<int, GameObject> activeLine in activeLines)
		{
			UnityEngine.Object.Destroy(activeLine.Value);
		}
		activeLines.Clear();
	}
}
