using System;
using ACT.Battle.Configs;
using Bamboo.ECS;
using Fundamental;

namespace ACT.Battle;

public class AbilityMixinMovementRestrict : BaseAbilityMixin
{
	private ConfigMixinMovementRestrict m_Config;

	public bool toRemove;

	private bool m_haveSet;

	public AbilityMixinMovementRestrict(ConfigMixinMovementRestrict config, Ability ab, byte index)
		: base(ab, index)
	{
		m_Config = config;
	}

	internal override void RebindForPool(ConfigMixin config, Ability ab, byte newIndex)
	{
		base.RebindForPool(config, ab, newIndex);
		m_Config = (ConfigMixinMovementRestrict)config;
	}

	internal override void ResetForPool()
	{
		m_Config = null;
		toRemove = false;
		m_haveSet = false;
		base.ResetForPool();
	}

	internal override void FixedUpdate()
	{
		if (toRemove)
		{
			return;
		}
		CompPhysics compPhysics = owner.GetCompPhysics();
		if (compPhysics.state != ACTMovementMode.Falling && !m_haveSet)
		{
			compPhysics.pauseVelocity = true;
			m_haveSet = true;
		}
		CompMotion compMotion = owner.GetCompMotion();
		MotionState[] removeMotion = m_Config.removeMotion;
		foreach (MotionState motionState in removeMotion)
		{
			if (compMotion.curMotionState == motionState)
			{
				toRemove = true;
				ability.RemoveStack(ability.stack);
			}
		}
	}

	internal override void OnAdd()
	{
		owner.GetCompAbility().onDie += new Action<Entity>(KeyAction);
		if (owner.IsCharacter())
		{
			GameInputActionManager instance = Singleton<GameInputActionManager>.instance;
			MotionInputKey[] disabledMotionKeys = m_Config.disabledMotionKeys;
			foreach (MotionInputKey key in disabledMotionKeys)
			{
				instance.SetInputActive(key, value: false);
			}
		}
	}

	internal override void OnRemove()
	{
		if (owner.TryGetCompPhysics(out CompPhysics component))
		{
			component.pauseVelocity = false;
		}
		m_haveSet = false;
		if (owner.TryGetCompAbility(out CompAbility component2))
		{
			component2.onDie -= new Action<Entity>(KeyAction);
		}
		if (owner.IsValid)
		{
			KeyAction(owner);
		}
	}

	public void KeyAction(Entity behave)
	{
		if (behave.IsCharacter())
		{
			GameInputActionManager instance = Singleton<GameInputActionManager>.instance;
			MotionInputKey[] disabledMotionKeys = m_Config.disabledMotionKeys;
			foreach (MotionInputKey key in disabledMotionKeys)
			{
				instance.SetInputActive(key, value: true);
			}
		}
	}
}
