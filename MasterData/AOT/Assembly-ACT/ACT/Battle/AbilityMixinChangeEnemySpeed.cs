using System;
using System.Collections.Generic;
using ACT.Battle.Configs;
using Bamboo.ECS;
using Fundamental;

namespace ACT.Battle;

[Obsolete]
public class AbilityMixinChangeEnemySpeed : BaseAbilityMixin
{
	private ConfigMixinChangeTargetSpeed m_Config;

	protected Alliance targetA;

	protected float realSpeed;

	private Dictionary<Entity, TimeSpeedTimer> _entityTimerMap = new Dictionary<Entity, TimeSpeedTimer>();

	public AbilityMixinChangeEnemySpeed(ConfigMixinChangeTargetSpeed config, Ability ab, byte index)
		: base(ab, index)
	{
		m_Config = config;
		if (owner.GetAlliance() == Alliance.Enemy)
		{
			targetA = Alliance.Character;
		}
		else
		{
			targetA = Alliance.Enemy;
		}
	}

	internal override void OnAdd()
	{
		ActionMemory memory = new ActionMemory(owner, owner, owner);
		realSpeed = m_Config.speed.Return(memory);
		_entityTimerMap.Clear();
		SystemTime timeSys = GameManager.timeSystem;
		Singleton<GameManager>.instance.ecsManager.ForEachEntities((Entity e) =>
		{
			if (e.GetAlliance() != targetA || !e.TryGetCompTime(out CompTime component))
			{
				return;
			}
			TimeType timeType = m_Config.timeType;
			foreach (TimeType value in Enum.GetValues(typeof(TimeType)))
			{
				if ((timeType & value) != 0)
				{
					TimeSpeedTimer timeSpeedTimer = timeSys.timerPool.Get();
					timeSpeedTimer.InitTimer(realSpeed, -1f);
					timeSpeedTimer.Type = value;
					component.AddSpeedTimer(value, timeSpeedTimer);
					_entityTimerMap[e] = timeSpeedTimer;
				}
			}
		});
	}

	internal override void OnRemove()
	{
		foreach (KeyValuePair<Entity, TimeSpeedTimer> item in _entityTimerMap)
		{
			Entity key = item.Key;
			TimeSpeedTimer value = item.Value;
			if (key.TryGetCompTime(out CompTime component))
			{
				component.RemoveSpeedTimer(value.Type, value);
			}
		}
		_entityTimerMap.Clear();
	}
}
