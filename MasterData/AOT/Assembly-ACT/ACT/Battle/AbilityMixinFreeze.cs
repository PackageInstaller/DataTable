using System;
using System.Collections.Generic;
using ACT.Battle.Configs;
using Bamboo.ECS;
using UnityEngine;

namespace ACT.Battle;

public class AbilityMixinFreeze : BaseAbilityMixin
{
	private ConfigMixinFreeze m_Config;

	private float m_Scale;

	private bool m_IsFly;

	private List<TimeSpeedTimer> _timers = new List<TimeSpeedTimer>();

	public AbilityMixinFreeze(ConfigMixinFreeze config, Ability ab, byte index)
		: base(ab, index)
	{
		m_Config = config;
	}

	internal override void RebindForPool(ConfigMixin config, Ability ab, byte newIndex)
	{
		base.RebindForPool(config, ab, newIndex);
		m_Config = (ConfigMixinFreeze)config;
	}

	internal override void ResetForPool()
	{
		_timers.Clear();
		m_Config = null;
		m_Scale = 0f;
		m_IsFly = false;
		base.ResetForPool();
	}

	internal override void OnAdd()
	{
		TimeType timeType = TimeType.Motion;
		_timers.Clear();
		SystemTime timeSystem = GameManager.timeSystem;
		CompTime compTime = owner.GetCompTime();
		foreach (TimeType value in Enum.GetValues(typeof(TimeType)))
		{
			if ((timeType & value) != 0)
			{
				TimeSpeedTimer timeSpeedTimer = timeSystem.timerPool.Get();
				timeSpeedTimer.InitTimer(m_Scale, -1f);
				timeSpeedTimer.Type = value;
				compTime.AddSpeedTimer(value, timeSpeedTimer);
				_timers.Add(timeSpeedTimer);
			}
		}
		owner.SetBool("Freeze", value: true);
		CompPhysics compPhysics = owner.GetCompPhysics();
		if (owner.IsBattleBehaveNotCharacter() && compPhysics.motion == MotionType.Air)
		{
			compPhysics.motion = MotionType.Ground;
			m_IsFly = true;
		}
		if (compPhysics != null)
		{
			compPhysics.isBeControled = true;
			owner.GetCompBehave().SetOverrideHitMaterial(HitMaterial.Ice);
		}
	}

	internal override void FixedUpdate()
	{
		if (!owner.TryGetCompPhysics(out CompPhysics component))
		{
			if (owner.IsAlive())
			{
				component.ForbidDir = true;
				return;
			}
			component.ForbidDir = false;
			m_IsFly = false;
			component.motion = MotionType.Air;
		}
	}

	internal override void OnRemove()
	{
		RemoveSpeedTimers();
		if (!owner.IsValid)
		{
			m_IsFly = false;
			return;
		}
		if (!owner.TryGetCompPhysics(out CompPhysics component))
		{
			m_IsFly = false;
			return;
		}
		component.ForbidDir = false;
		owner.SetBool("Freeze", value: false);
		if (m_IsFly)
		{
			m_IsFly = false;
			owner.Teleport(owner.GetCompTransform().physicsPosition + new Vector3(0f, 0.25f, 0f));
			component.motion = MotionType.Air;
		}
		component.isBeControled = false;
		owner.ResetOverrideHitMaterial();
	}

	internal override void OnSilentRemove()
	{
		OnRemove();
	}

	private void RemoveSpeedTimers()
	{
		if (owner.TryGetCompTime(out CompTime component))
		{
			for (int i = 0; i < _timers.Count; i++)
			{
				TimeSpeedTimer timeSpeedTimer = _timers[i];
				component.RemoveSpeedTimer(timeSpeedTimer.Type, timeSpeedTimer);
			}
		}
		_timers.Clear();
	}
}
