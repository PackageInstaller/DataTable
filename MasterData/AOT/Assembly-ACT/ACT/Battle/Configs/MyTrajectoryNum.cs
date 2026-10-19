using System.Collections.Generic;
using Bamboo.ECS;
using Fundamental;

namespace ACT.Battle.Configs;

[AbilityTypeMetadata("获取自身轨迹数量", "Function", new string[] { "my", "trajectory", "num", "value", "float", "int" })]
public class MyTrajectoryNum : ConfigFunction<float>
{
	public AbilityEntityType type;

	private static List<Entity> _findAllCache;

	protected override float Evaluate(ActionMemory memory)
	{
		int num = 0;
		switch (type)
		{
		case AbilityEntityType.Normal:
		case AbilityEntityType.FloatingGun:
			num = Singleton<GameManager>.instance.ecsManager.systemAbility.MajorFilter.FindAll((Entity e) => e.GetCompProduct().AbilityEntityType == type && e.GetCaster() == memory.target.entity, _findAllCache).Count;
			break;
		case AbilityEntityType.Tear:
		case AbilityEntityType.Gravity:
		case AbilityEntityType.Shadow:
			num = Singleton<GameManager>.instance.ecsManager.systemAbility.MajorFilter.FindAll((Entity e) => e.GetCompProduct().AbilityEntityType == type, _findAllCache).Count;
			break;
		}
		return num;
	}
}
