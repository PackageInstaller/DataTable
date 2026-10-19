using System;
using System.Collections.Generic;
using ACT.Core;
using Bamboo.Collections;
using UnityEngine;
using UnityEngine.Pool;

namespace ACT.Battle.ECS.System;

public class RuntimeRogueCard
{
	public static ObjectPool<RuntimeRogueCard> Pool = new ObjectPool<RuntimeRogueCard>(() => new RuntimeRogueCard(), null, (RuntimeRogueCard c) =>
	{
		c.Reset();
	});

	public int trigger;

	public BSet<int> effects;

	private RuntimeScopeEffect m_RogueTriggerEffect;

	private BSet<RuntimeScopeEffect> m_RogueEffects;

	public Scope Scope => m_RogueTriggerEffect.Scope;

	public void Init(int trigger, List<int> effects)
	{
		this.trigger = trigger;
		this.effects = BSetPool<int>.Default.Get();
		foreach (int effect in effects)
		{
			this.effects.Add(effect);
		}
		m_RogueEffects = BSetPool<RuntimeScopeEffect>.Default.Get();
		InitTrigger();
		InitEffects(effects);
	}

	public void AddEffect(List<int> effects)
	{
		foreach (int effect in effects)
		{
			this.effects.Add(effect);
		}
		InitEffects(effects);
	}

	protected void InitTrigger()
	{
		if (RuntimeConfigs.data.rogueTriggerCards.TryGetValue(trigger, out var value))
		{
			m_RogueTriggerEffect = RuntimeScopeEffect.Pool.Get();
			m_RogueTriggerEffect.Init(trigger, (Scope)value.scope, value.ability, EffectSource.Trigger, value.skillid);
			m_RogueTriggerEffect.Active = true;
			return;
		}
		throw new ArgumentException("wrong rogue Trigger Id !!!");
	}

	protected void InitEffects(List<int> effects)
	{
		foreach (int effect in effects)
		{
			if (RuntimeConfigs.data.rogueEffectCards.TryGetValue(effect, out var value))
			{
				RuntimeScopeEffect runtimeScopeEffect = RuntimeScopeEffect.Pool.Get();
				runtimeScopeEffect.Init(trigger, (Scope)value.scope, value.ability, EffectSource.Card, value.skillid);
				runtimeScopeEffect.Active = true;
				m_RogueEffects.Add(runtimeScopeEffect);
			}
			else if (LuminApplication.LogEnabled)
			{
				Debug.LogError($"错误的 CardEffect id ： {effect}");
			}
		}
	}

	private void Reset()
	{
		RuntimeScopeEffect.Pool.Release(m_RogueTriggerEffect);
		foreach (RuntimeScopeEffect rogueEffect in m_RogueEffects)
		{
			RuntimeScopeEffect.Pool.Release(rogueEffect);
		}
		BSetPool<int>.Default.Recycle(effects);
		trigger = 0;
		effects = null;
		m_RogueEffects = null;
		m_RogueTriggerEffect = null;
	}
}
