using ACT.Battle.Configs;
using ACT.Utility;
using Bamboo.ECS;
using UnityEngine;

namespace ACT.Battle;

public class AbilityCMFollowTargetAppendVelocity : BaseAbilityMixin
{
	private CMFollowTargetAppendVelocity m_Config;

	private Entity m_Target;

	private bool m_Always;

	private float m_Speed;

	private float m_Time;

	private Vector3 m_dir;

	public AbilityCMFollowTargetAppendVelocity(CMFollowTargetAppendVelocity config, Ability ab, byte index)
		: base(ab, index)
	{
		m_Config = config;
	}

	internal override void RebindForPool(ConfigMixin config, Ability ab, byte newIndex)
	{
		base.RebindForPool(config, ab, newIndex);
		m_Config = (CMFollowTargetAppendVelocity)config;
	}

	internal override void ResetForPool()
	{
		m_Config = null;
		m_Target = default;
		m_Always = false;
		m_Speed = 0f;
		m_Time = 0f;
		m_dir = default;
		base.ResetForPool();
	}

	internal override void FixedUpdate()
	{
		if (m_Always)
		{
			if (m_Target.IsValid)
			{
				Vector3 vector = m_Target.GetCompTransform().physicsPosition + m_Config.offset;
				m_dir = vector - owner.GetRootTransform().position;
				if (m_Config.followMode == ConfigMixinFollowTarget.FollowMode.X)
				{
					m_dir.y = 0f;
				}
				CompPhysics component;
				if (m_dir.isZero())
				{
					m_dir = Vector3.zero;
				}
				else if (owner.TryGetCompPhysics(out component) && component.PredictMoveDisIfStopNow() + m_Config.followAppend > m_dir.magnitude)
				{
					m_dir = Vector3.zero;
				}
			}
			owner.GetCompInput().dir = m_dir;
		}
		m_Time += owner.GetCompTime().fixedDeltaTime;
		m_Speed = m_Config.acc * m_Time;
		owner.GetCompPhysics().compositeVelocity += (m_Config.init + Mathf.Min(m_Speed, m_Config.max)) * m_dir.normalized;
	}

	internal override void OnAdd()
	{
		m_Always = false;
		m_dir = m_Config.fallBackDir;
		Entity hatred = owner.GetCompHatred().GetHatred();
		if (hatred.IsValid)
		{
			m_Target = hatred;
			switch (m_Config.dirMode)
			{
			case CMFollowTargetAppendVelocity.DirMode.Once:
				m_dir = m_Target.GetCompTransform().physicsPosition + m_Config.offset - owner.GetRootTransform().position;
				if (m_Config.followMode == ConfigMixinFollowTarget.FollowMode.X)
				{
					m_dir.y = 0f;
				}
				if (m_dir.isZero())
				{
					m_dir = Vector3.zero;
				}
				owner.GetCompInput().dir = m_dir;
				break;
			case CMFollowTargetAppendVelocity.DirMode.Always:
				m_Always = true;
				break;
			}
		}
		else
		{
			if (m_Config.followMode == ConfigMixinFollowTarget.FollowMode.X)
			{
				m_Config.fallBackDir.y = 0f;
			}
			owner.GetCompInput().dir = m_Config.fallBackDir;
			if (LuminApplication.LogEnabled)
			{
				Debug.Log("找不到目标");
			}
		}
		m_Time = 0f;
	}

	internal override void OnRemove()
	{
	}
}
