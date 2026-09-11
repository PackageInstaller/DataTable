using Cinemachine.Utility;
using UnityEngine;

namespace Cinemachine;

public class CinemachineRotateExtension : CinemachineExtensionCustomBase<CameraRotateClip>
{
	public Vector3 cur;

	public float slowActionTime;

	public bool isOnStartSlow;

	public float startSlowActionTime;

	public int curHashCode;

	public Vector3 startSlowActionEnd;

	public Vector3 GetClipValue(RuntimeNode<CameraRotateClip> item)
	{
		CameraRotateClip clip = item.clip;
		float value = item.time / clip.Length;
		value = Mathf.Clamp01(value);
		return new Vector3(clip.curveX.Evaluate(value), clip.curveY.Evaluate(value), clip.curveZ.Evaluate(value));
	}

	protected override void PostPipelineStageCallback(CinemachineVirtualCameraBase vcam, CinemachineCore.Stage stage, ref CameraState state, float deltaTime)
	{
		if (stage != CinemachineCore.Stage.Finalize)
		{
			return;
		}
		Vector3 vector = Vector3.zero;
		int num = int.MinValue;
		int num2 = 0;
		if (m_List != null)
		{
			for (int i = 0; i < m_List.Count; i++)
			{
				if (num < m_List[i].clip.priority)
				{
					num = m_List[i].clip.priority;
					num2 = 1;
					vector = GetClipValue(m_List[i]);
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
							startSlowActionEnd.x = m_List[i].clip.curveX.Evaluate(Mathf.Clamp01(startSlowActionTime / m_List[i].clip.Length));
							startSlowActionEnd.y = m_List[i].clip.curveY.Evaluate(Mathf.Clamp01(startSlowActionTime / m_List[i].clip.Length));
							startSlowActionEnd.z = m_List[i].clip.curveZ.Evaluate(Mathf.Clamp01(startSlowActionTime / m_List[i].clip.Length));
						}
						isOnStartSlow = true;
					}
					else
					{
						isOnStartSlow = false;
						startSlowActionTime = 0f;
						startSlowActionEnd = Vector3.zero;
					}
				}
				else
				{
					if (num != m_List[i].clip.priority)
					{
						continue;
					}
					vector += GetClipValue(m_List[i]);
					num2++;
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
							startSlowActionEnd.x += m_List[i].clip.curveX.Evaluate(Mathf.Clamp01(startSlowActionTime / m_List[i].clip.Length));
							startSlowActionEnd.y += m_List[i].clip.curveY.Evaluate(Mathf.Clamp01(startSlowActionTime / m_List[i].clip.Length));
							startSlowActionEnd.z += m_List[i].clip.curveZ.Evaluate(Mathf.Clamp01(startSlowActionTime / m_List[i].clip.Length));
						}
						isOnStartSlow = true;
					}
					else
					{
						isOnStartSlow = false;
						startSlowActionTime = 0f;
						startSlowActionEnd = Vector3.zero;
					}
				}
			}
		}
		if (num2 == 0)
		{
			num2 = 1;
			Vector3 initial = vector - cur;
			cur += Damper.Damp(initial, slowActionTime, deltaTime);
			if (cur == Vector3.zero)
			{
				slowActionTime = 0f;
			}
		}
		else if (!isOnStartSlow)
		{
			cur = vector / num2;
		}
		if (isOnStartSlow)
		{
			Vector3 initial2 = startSlowActionEnd / num2 - cur;
			cur += Damper.Damp(initial2, startSlowActionTime, deltaTime);
			if (cur == startSlowActionEnd)
			{
				startSlowActionTime = 0f;
				startSlowActionEnd = Vector3.zero;
				isOnStartSlow = false;
			}
		}
		Vector3 eulerAngles = state.OrientationCorrection.eulerAngles;
		eulerAngles += cur;
		state.OrientationCorrection = Quaternion.Euler(eulerAngles);
	}
}
