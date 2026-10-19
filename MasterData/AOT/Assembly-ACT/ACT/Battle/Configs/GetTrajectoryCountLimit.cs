using Fundamental;

namespace ACT.Battle.Configs;

[AbilityTypeMetadata("获取轨迹数量限制", "Function", new string[] { "get", "trajectory", "count", "limit", "value", "float", "int" })]
public class GetTrajectoryCountLimit : ConfigFunction<float>
{
	public AbilityEntityType abilityEntityType;

	protected override float Evaluate(ActionMemory memory)
	{
		return Singleton<GameManager>.instance.ecsManager.systemProduct.productEntityCountLimit[abilityEntityType];
	}
}
