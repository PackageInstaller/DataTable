using Cinemachine.Utility;
using UnityEngine;

namespace Cinemachine;

public class CinemachineDollyShotExtension : CinemachineExtensionCustomBase<CameraDollyShotClip>
{
	public float cur;

	public float slowActionTime;

	public bool isOnStartSlow;

	public float startSlowActionTime;

	public int curHashCode;

	public float startSlowActionEnd;

	public float GetClipValue(RuntimeNode<CameraDollyShotClip> item)
	{
		CameraDollyShotClip clip = item.clip;
		float value = item.time / clip.Length;
		value = Mathf.Clamp01(value);
		return clip.DollyShotCurve.Evaluate(value);
	}

	protected override void PostPipelineStageCallback(CinemachineVirtualCameraBase pVcam, CinemachineCore.Stage pStage, ref CameraState pState, float pDeltaTime)
	{
		if (pStage != CinemachineCore.Stage.Aim)
		{
			return;
		}
		float num = 0f;
		int num2 = int.MinValue;
		int num3 = 0;
		if (m_List != null)
		{
			for (int i = 0; i < m_List.Count; i++)
			{
				if (num2 < m_List[i].clip.priority)
				{
					num2 = m_List[i].clip.priority;
					num3 = 1;
					num = GetClipValue(m_List[i]);
					if (m_List[i].clip.SlowActionTime != 0f && slowActionTime != 0f)
					{
						slowActionTime = (slowActionTime + m_List[i].clip.SlowActionTime) / 2f;
					}
					else
					{
						slowActionTime = m_List[i].clip.SlowActionTime;
					}
					if (curHashCode == 0 && m_List[i].clip.GetHashCode() != 0)
					{
						curHashCode = m_List[i].clip.GetHashCode();
					}
					if (m_List[i].clip.GetHashCode() == 0 || curHashCode == m_List[i].clip.GetHashCode())
					{
						continue;
					}
					curHashCode = m_List[i].clip.GetHashCode();
					if (m_List[i].clip.StartSlowActionTime != 0f)
					{
						startSlowActionTime = (startSlowActionTime + m_List[i].clip.StartSlowActionTime) / 2f;
						curHashCode = m_List[i].clip.GetHashCode();
						if (!isOnStartSlow)
						{
							startSlowActionEnd = m_List[i].clip.DollyShotCurve.Evaluate(Mathf.Clamp01(startSlowActionTime / m_List[i].clip.Length));
						}
						isOnStartSlow = true;
					}
					else
					{
						startSlowActionTime = 0f;
						startSlowActionEnd = 0f;
						isOnStartSlow = false;
					}
				}
				else
				{
					if (num2 != m_List[i].clip.priority)
					{
						continue;
					}
					num += GetClipValue(m_List[i]);
					num3++;
					if (m_List[i].clip.SlowActionTime != 0f && slowActionTime != 0f)
					{
						slowActionTime = (slowActionTime + m_List[i].clip.SlowActionTime) / 2f;
					}
					else
					{
						slowActionTime = m_List[i].clip.SlowActionTime;
					}
					if (curHashCode == 0 && m_List[i].clip.GetHashCode() != 0)
					{
						curHashCode = m_List[i].clip.GetHashCode();
					}
					if (m_List[i].clip.GetHashCode() == 0 || curHashCode == m_List[i].clip.GetHashCode())
					{
						continue;
					}
					curHashCode = m_List[i].clip.GetHashCode();
					if (m_List[i].clip.StartSlowActionTime != 0f)
					{
						startSlowActionTime = (startSlowActionTime + m_List[i].clip.StartSlowActionTime) / 2f;
						if (!isOnStartSlow)
						{
							startSlowActionEnd += m_List[i].clip.DollyShotCurve.Evaluate(Mathf.Clamp01(startSlowActionTime / m_List[i].clip.Length));
						}
						isOnStartSlow = true;
					}
					else
					{
						startSlowActionTime = 0f;
						startSlowActionEnd = 0f;
						isOnStartSlow = false;
					}
				}
			}
		}
		if (num3 == 0)
		{
			num3 = 1;
			float initial = num - cur;
			cur += Damper.Damp(initial, slowActionTime, pDeltaTime);
			if (cur == 0f)
			{
				slowActionTime = 0f;
			}
		}
		else if (!isOnStartSlow)
		{
			cur = num / (float)num3;
		}
		if (isOnStartSlow)
		{
			float initial2 = startSlowActionEnd / (float)num3 - cur;
			cur += Damper.Damp(initial2, startSlowActionTime, pDeltaTime);
			if (cur == startSlowActionEnd)
			{
				startSlowActionTime = 0f;
				startSlowActionEnd = 0f;
				isOnStartSlow = false;
			}
		}
		Vector3 vector = cur * Vector3.forward;
		vector = pState.RawOrientation * vector;
		pState.PositionCorrection += vector;
	}
}
