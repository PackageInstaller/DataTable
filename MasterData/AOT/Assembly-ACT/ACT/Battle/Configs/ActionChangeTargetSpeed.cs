using System;
using Bamboo.ECS;
using UnityEngine;

namespace ACT.Battle.Configs;

[AbilityTypeMetadata("修改目标速度", "Action", new string[] { "change", "target", "speed", "retarget", "aim" })]
public class ActionChangeTargetSpeed : ConfigAction
{
	[Tooltip("持续时间,变速的过渡时间,TimeScale的大小")]
	public SystemTime.ConfigChangeGlobalSpeed configChangeSpeed;

	public TimeType timeType;

	public bool open = true;

	protected override AbilityAuth defaultAuth => AbilityAuth.Both;

	public override void Do(ActionMemory memory)
	{
		if (open)
		{
			SystemTime timeSystem = GameManager.timeSystem;
			{
				foreach (TimeType value in Enum.GetValues(typeof(TimeType)))
				{
					if ((timeType & value) != 0)
					{
						TimeSpeedTimer timeSpeedTimer = timeSystem.timerPool.Get();
						timeSpeedTimer.InitTimer(configChangeSpeed);
						memory.target.entity.GetCompTime()?.AddSpeedTimer(value, timeSpeedTimer);
					}
				}
				return;
			}
		}
		foreach (TimeType value2 in Enum.GetValues(typeof(TimeType)))
		{
			if ((timeType & value2) != 0)
			{
				memory.target.entity.GetCompTime()?.ClearSpeedTimer(value2);
			}
		}
	}
}
