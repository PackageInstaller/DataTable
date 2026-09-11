using Cinemachine.Utility;
using UnityEngine;

namespace Cinemachine;

public class CinemachineFieldOfViewExtension : CinemachineExtensionCustomBase<CameraFOVClip>
{
	public float cur;

	public float slowActionTime;

	public bool isOnStartSlow;

	public float startSlowActionTime;

	public int curHashCode;

	public float startSlowActionEnd;

	public const float originFOV = 55f;

	public float GetFOVFormNode(RuntimeNode<CameraFOVClip> item)
	{
		CameraFOVClip clip = item.clip;
		float value = item.time / clip.Length;
		value = Mathf.Clamp01(value);
		return clip.FOVCurve.Evaluate(value);
	}

	protected override void PostPipelineStageCallback(CinemachineVirtualCameraBase pVcam, CinemachineCore.Stage pStage, ref CameraState pState, float pDeltaTime)
	{
		if (pStage != CinemachineCore.Stage.Finalize)
		{
			return;
		}
		float num = 0f;
		int num2 = int.MinValue;
		int num3 = 0;
		if (startSlowActionEnd == 0f)
		{
			startSlowActionEnd = 55f;
		}
		if (m_List != null)
		{
			for (int i = 0; i < m_List.Count; i++)
			{
				if (num2 < m_List[i].clip.priority)
				{
					num2 = m_List[i].clip.priority;
					num3 = 1;
					num = GetFOVFormNode(m_List[i]);
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
							startSlowActionEnd = m_List[i].clip.FOVCurve.Evaluate(Mathf.Clamp01(startSlowActionTime / m_List[i].clip.Length));
						}
						isOnStartSlow = true;
					}
					else
					{
						startSlowActionTime = 0f;
						startSlowActionEnd = 55f;
						isOnStartSlow = false;
					}
				}
				else
				{
					if (num2 != m_List[i].clip.priority)
					{
						continue;
					}
					num += GetFOVFormNode(m_List[i]);
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
							startSlowActionEnd += m_List[i].clip.FOVCurve.Evaluate(Mathf.Clamp01(startSlowActionTime / m_List[i].clip.Length));
						}
						isOnStartSlow = true;
					}
					else
					{
						startSlowActionTime = 0f;
						startSlowActionEnd = 55f;
						isOnStartSlow = false;
					}
				}
			}
		}
		if (num3 == 0)
		{
			if (cur == 55f)
			{
				slowActionTime = 0f;
				return;
			}
			num3 = 1;
			num += 55f;
			float initial = num - cur;
			cur += Damper.Damp(initial, slowActionTime, pDeltaTime);
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
				startSlowActionEnd = 55f;
				isOnStartSlow = false;
			}
		}
		LensSettings lens = pState.Lens;
		lens.FieldOfView = cur;
		pState.Lens = lens;
	}
}
