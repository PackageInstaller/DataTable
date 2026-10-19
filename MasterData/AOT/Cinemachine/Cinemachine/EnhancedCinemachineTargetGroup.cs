using UnityEngine;

namespace Cinemachine;

[AddComponentMenu("Cinemachine/Enhanced Target Group (Main Radius Scale)")]
[ExecuteAlways]
public class EnhancedCinemachineTargetGroup : CinemachineTargetGroup
{
	public enum MainTargetMode
	{
		FirstMember,
		HighestWeight,
		Manual
	}

	[Header("主目标配置")]
	public MainTargetMode m_MainTargetMode;

	public Transform m_ManualMainTarget;

	[Header("半径放大设置")]
	[Tooltip("队友在这个距离内，主目标保持原始半径")]
	public float m_InnerDeadZone = 5f;

	[Tooltip("队友在这个距离外，主目标的半径达到最大值")]
	public float m_OuterLimitZone = 15f;

	[Tooltip("主目标半径的最大放大倍数（例如 5 表示队友跑远时，主角半径变为 5 倍）")]
	public float m_MaxRadiusMultiplier = 3f;

	private float m_OriginalMainRadius = -1f;

	private Transform m_LastMainTarget;

	public override void DoUpdate()
	{
		UpdateMainTargetRadius();
		base.DoUpdate();
	}

	private void UpdateMainTargetRadius()
	{
		Transform currentMainTarget = GetCurrentMainTarget();
		if (currentMainTarget == null || m_Targets == null)
		{
			return;
		}
		int num = FindMember(currentMainTarget);
		if (num == -1)
		{
			return;
		}
		if (m_LastMainTarget != currentMainTarget)
		{
			m_OriginalMainRadius = m_Targets[num].radius;
			m_LastMainTarget = currentMainTarget;
		}
		float num2 = 0f;
		for (int i = 0; i < m_Targets.Length; i++)
		{
			if (!(m_Targets[i].target == null) && !(m_Targets[i].target == currentMainTarget) && !(m_Targets[i].weight <= 0.0001f))
			{
				float num3 = Vector3.Distance(currentMainTarget.position, m_Targets[i].target.position);
				if (num3 > num2)
				{
					num2 = num3;
				}
			}
		}
		float t = Mathf.Clamp01((num2 - m_InnerDeadZone) / (m_OuterLimitZone - m_InnerDeadZone));
		float radius = m_OriginalMainRadius * Mathf.Lerp(1f, m_MaxRadiusMultiplier, t);
		m_Targets[num].radius = radius;
	}

	private Transform GetCurrentMainTarget()
	{
		if (m_MainTargetMode == MainTargetMode.Manual)
		{
			return m_ManualMainTarget;
		}
		if (m_Targets == null || m_Targets.Length == 0)
		{
			return null;
		}
		if (m_MainTargetMode == MainTargetMode.FirstMember)
		{
			return m_Targets[0].target;
		}
		Transform result = null;
		float num = -1f;
		Target[] targets = m_Targets;
		for (int i = 0; i < targets.Length; i++)
		{
			Target target = targets[i];
			if (target.target != null && target.weight > num)
			{
				num = target.weight;
				result = target.target;
			}
		}
		return result;
	}
}
