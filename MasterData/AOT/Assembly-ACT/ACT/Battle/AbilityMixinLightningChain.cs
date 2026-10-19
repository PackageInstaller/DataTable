using System;
using System.Collections.Generic;
using ACT.Battle.Configs;
using Bamboo.ECS;
using Fundamental;
using UnityEngine;
using UnityEngine.ResourceManagement.AsyncOperations;

namespace ACT.Battle;

public class AbilityMixinLightningChain : BaseAbilityMixin
{
	private readonly ConfigMixinLightningChain m_Config;

	private int m_RemainingBounces;

	private Entity m_NextTarget;

	private bool m_LineEffectSetup;

	private float m_BounceTimer;

	private bool m_HasBounced;

	private static int s_PendingRemainingBounces = -1;

	private readonly Predicate<FindTargetResult> m_IsValidNextTarget;

	public int RemainingBounces => m_RemainingBounces;

	public AbilityMixinLightningChain(ConfigMixinLightningChain config, Ability ab, byte index)
		: base(ab, index)
	{
		m_Config = config;
		m_IsValidNextTarget = IsValidNextTarget;
	}

	internal override void OnAdd()
	{
		if (s_PendingRemainingBounces >= 0)
		{
			m_RemainingBounces = s_PendingRemainingBounces;
			s_PendingRemainingBounces = -1;
		}
		else
		{
			m_RemainingBounces = m_Config.maxBounceCount;
		}
		m_LineEffectSetup = false;
		m_HasBounced = false;
		m_BounceTimer = 0f;
		m_NextTarget = default;
		if (m_Config.bounceDelay <= 0f)
		{
			DoBounce();
		}
	}

	internal override void FixedUpdate()
	{
		if (!m_HasBounced && m_Config.bounceDelay > 0f)
		{
			m_BounceTimer += owner.GetCompTime().motionFixedDeltaTime;
			if (m_BounceTimer >= m_Config.bounceDelay)
			{
				DoBounce();
			}
		}
		if (m_NextTarget == null)
		{
			TryInitLineEffect();
		}
		else if (!m_LineEffectSetup)
		{
			TrySetupLineEffect();
		}
	}

	private void DoBounce()
	{
		if (m_HasBounced)
		{
			return;
		}
		m_HasBounced = true;
		if (m_RemainingBounces <= 0)
		{
			return;
		}
		m_NextTarget = FindNextTarget();
		if (!(m_NextTarget == null))
		{
			s_PendingRemainingBounces = m_RemainingBounces - 1;
			if (m_Config.onBounceActions != null && m_Config.onBounceActions.Length != 0)
			{
				DoActions(m_NextTarget, null, m_Config.onBounceActions);
			}
			s_PendingRemainingBounces = -1;
		}
	}

	private bool IsValidNextTarget(FindTargetResult result)
	{
		Entity entity = result.entity;
		if (entity.IsValid)
		{
			return entity != owner;
		}
		return false;
	}

	private Entity FindNextTarget()
	{
		List<FindTargetResult> list = ListPool<FindTargetResult>.Get();
		try
		{
			m_Config.findCondition.FindTargets(new ActionMemory(caster, owner, FindTargetResult.EntityOnly(owner), null, ability), list, m_IsValidNextTarget);
			if (list.Count == 0)
			{
				return default;
			}
			return list[0].entity;
		}
		finally
		{
			ListPool<FindTargetResult>.Release(list);
		}
	}

	private void TrySetupLineEffect()
	{
		if (!m_NextTarget.IsLogicAvailable())
		{
			m_LineEffectSetup = true;
			return;
		}
		Transform transform = m_NextTarget.GetMono()?.GetAttachPoint(BattleConsts.AIM_ATTACH_POINT);
		if (transform == null)
		{
			transform = m_NextTarget.GetRootTransform();
		}
		if (ApplyLineEffect(transform))
		{
			m_LineEffectSetup = true;
		}
	}

	private void TryInitLineEffect()
	{
		m_LineEffectSetup = false;
		ApplyLineEffect(null);
	}

	private bool ApplyLineEffect(Transform toTrans)
	{
		for (int i = 0; i < ability.attachEffects.Count; i++)
		{
			EffectRuntimeItem effectRuntimeItem = ability.attachEffects[i];
			if (effectRuntimeItem.status != AsyncOperationStatus.Succeeded)
			{
				continue;
			}
			MonoConnectEffect connectEffect = effectRuntimeItem.connectEffect;
			if (!(connectEffect == null))
			{
				Transform transform = owner.GetMono()?.GetAttachPoint(BattleConsts.AIM_ATTACH_POINT);
				if (transform == null)
				{
					transform = owner.GetRootTransform();
				}
				if (transform == null)
				{
					return false;
				}
				connectEffect.SetPos(toTrans ?? transform, transform);
				return true;
			}
		}
		return false;
	}

	internal override void OnRemove()
	{
		m_NextTarget = default;
	}

	internal override void OnSilentRemove()
	{
		OnRemove();
	}

	public static bool TryGetRemainingBounces(Ability ability, out int remaining)
	{
		remaining = 0;
		if (ability?.mixins == null)
		{
			return false;
		}
		for (int i = 0; i < ability.mixins.Length; i++)
		{
			if (ability.mixins[i] is AbilityMixinLightningChain abilityMixinLightningChain)
			{
				remaining = abilityMixinLightningChain.m_RemainingBounces;
				return true;
			}
		}
		return false;
	}
}
