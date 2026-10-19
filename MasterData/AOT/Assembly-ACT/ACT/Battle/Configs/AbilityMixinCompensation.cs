using ACT.Utility;
using Bamboo.ECS;
using UnityEngine;

namespace ACT.Battle.Configs;

public class AbilityMixinCompensation : BaseAbilityMixin
{
	private ConfigMixinCompensation m_config;

	private Vector3 offset;

	public AbilityMixinCompensation(ConfigMixinCompensation config, Ability ab, byte index)
		: base(ab, index)
	{
		m_config = config;
	}

	internal override void RebindForPool(ConfigMixin config, Ability ab, byte newIndex)
	{
		base.RebindForPool(config, ab, newIndex);
		m_config = (ConfigMixinCompensation)config;
	}

	internal override void ResetForPool()
	{
		m_config = null;
		offset = default;
		base.ResetForPool();
	}

	internal override void OnAdd()
	{
		ActionMemory memory = new ActionMemory(owner, owner, owner);
		offset = ((m_config.offset != null) ? m_config.offset.Return(memory) : Vector3.zero);
		if (m_config.config.useYCompensation)
		{
			owner.GetCompPhysics().characterMovement.constrainToGround = false;
		}
	}

	internal override void Update()
	{
	}

	internal override void FixedUpdate()
	{
		ActionMemory memory = new ActionMemory(owner, owner, owner);
		Vector3 vector = m_config.pos.Return(memory);
		float durationTime = ability.config.fDuration.GetFloat(ability) - ability.time;
		m_config.config.DoCompensation(vector - owner.GetCompTransform().physicsPosition + VectorUtility.HorizontalDirection(owner.IsFaceLeft(), offset), owner, durationTime);
	}

	internal override void OnRemove()
	{
		if (owner.IsValid && m_config != null && m_config.config != null)
		{
			m_config.config.DoCompensation(Vector3.zero, owner, 0f);
			if (m_config.config.useYCompensation && owner.TryGetCompPhysics(out CompPhysics component) && component.characterMovement != null)
			{
				component.characterMovement.constrainToGround = true;
			}
		}
	}

	internal override void OnSilentRemove()
	{
	}
}
