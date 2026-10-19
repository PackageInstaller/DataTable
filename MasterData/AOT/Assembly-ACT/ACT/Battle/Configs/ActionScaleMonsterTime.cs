using System;
using Bamboo.ECS;
using UnityEngine;

namespace ACT.Battle.Configs;

[Obsolete]
[AbilityTypeMetadata("缩放怪物时间", "Action", new string[] { "scale", "monster", "time" })]
public class ActionScaleMonsterTime : ConfigAction
{
	[Tooltip("持续时长，秒数,如果小于0.1秒则默认没有需要添加")]
	public float time;

	public float scale = 0.5f;

	[Tooltip("持续时间,变速的过渡时间,TimeScale的大小")]
	public SystemTime.ConfigChangeGlobalSpeed configChangeSpeed;

	public TimeType timeType;

	protected override AbilityAuth defaultAuth => AbilityAuth.Owner;

	public override void Do(ActionMemory memory)
	{
		foreach (Entity allEntity in GameManager.entities.GetAllEntities())
		{
			if (allEntity.GetCompAlliance().alliance != Alliance.Enemy && allEntity.GetEntityType() != EntityType.Trajectory)
			{
				continue;
			}
			SystemTime timeSystem = GameManager.timeSystem;
			foreach (TimeType value in Enum.GetValues(typeof(TimeType)))
			{
				if ((timeType & value) != 0)
				{
					TimeSpeedTimer timeSpeedTimer = timeSystem.timerPool.Get();
					timeSpeedTimer.InitTimer(configChangeSpeed);
					allEntity.GetCompTime().AddSpeedTimer(value, timeSpeedTimer);
				}
			}
		}
	}
}
