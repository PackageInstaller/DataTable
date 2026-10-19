using System.Collections.Generic;
using ACT.Battle.ECS.System;
using Fundamental;

namespace ACT.Battle.Configs;

[AbilityTypeMetadata("绑定轨迹", "Action", new string[] { "bind", "trajectory" })]
public class ActionBindTrajectory : ConfigAction
{
	public ConfigTrajectoryObject configTrajectoryObject;

	public ConfigTrajectory configTrajectory;

	public override void CacheActionList(List<ConfigAction[]> list, ConfigAbility ab)
	{
		configTrajectoryObject?.configTrajectory?.CacheActionList(list, ab);
	}

	public override void Do(ActionMemory memory)
	{
		ConfigTrajectory configTrajectory = ((configTrajectoryObject != null && configTrajectoryObject.configTrajectory != null) ? configTrajectoryObject.configTrajectory : this.configTrajectory);
		SystemTrajectory systemTrajectory = Singleton<GameManager>.instance.ecsManager.systemTrajectory;
		if (configTrajectory is GeneralTrajectory)
		{
			systemTrajectory.BindTrajectory(memory.target.entity, configTrajectory.Create(memory.target.entity, memory.ability));
			return;
		}
		RuntimeTrajectory trajectory = configTrajectory.Create(memory.target.entity, memory.ability);
		systemTrajectory.BindTrajectory(memory.target.entity, trajectory);
	}
}
