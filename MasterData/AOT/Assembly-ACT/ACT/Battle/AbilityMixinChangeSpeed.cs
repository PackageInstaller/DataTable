using System;
using System.Collections.Generic;
using ACT.Battle.Configs;
using Bamboo.ECS;

namespace ACT.Battle;

public class AbilityMixinChangeSpeed : BaseAbilityMixin
{
	private ConfigMixinChangeSpeed m_Config;

	private List<TimeSpeedTimer> _timers = new List<TimeSpeedTimer>();

	public AbilityMixinChangeSpeed(ConfigMixinChangeSpeed config, Ability ab, byte index)
		: base(ab, index)
	{
		m_Config = config;
	}

	internal override void RebindForPool(ConfigMixin config, Ability ab, byte newIndex)
	{
		base.RebindForPool(config, ab, newIndex);
		m_Config = (ConfigMixinChangeSpeed)config;
	}

	internal override void ResetForPool()
	{
		_timers.Clear();
		m_Config = null;
		base.ResetForPool();
	}

	internal override void OnAdd()
	{
		TimeType timeType = m_Config.timeType;
		float speed = m_Config.speed;
		_timers.Clear();
		SystemTime timeSystem = GameManager.timeSystem;
		CompTime compTime = owner.GetCompTime();
		foreach (TimeType value in Enum.GetValues(typeof(TimeType)))
		{
			if ((timeType & value) != 0)
			{
				TimeSpeedTimer timeSpeedTimer = timeSystem.timerPool.Get();
				timeSpeedTimer.InitTimer(speed, -1f);
				timeSpeedTimer.Type = value;
				compTime.AddSpeedTimer(value, timeSpeedTimer);
				_timers.Add(timeSpeedTimer);
			}
		}
	}

	internal override void FixedUpdate()
	{
	}

	internal override void OnRemove()
	{
		RemoveTimers();
	}

	private void RemoveTimers()
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
