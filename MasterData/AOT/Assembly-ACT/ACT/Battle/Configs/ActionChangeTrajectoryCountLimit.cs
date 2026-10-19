using Fundamental;

namespace ACT.Battle.Configs;

[AbilityTypeMetadata("修改轨迹数量限制", "Action", new string[] { "change", "trajectory", "count", "limit" })]
public class ActionChangeTrajectoryCountLimit : ConfigAction
{
	public AbilityEntityType abilityEntityType;

	public ConfigFunction<float> value;

	public override void Do(ActionMemory memory)
	{
		Singleton<GameManager>.instance.ecsManager.systemProduct.productEntityCountLimit[abilityEntityType] = (int)value.Return(memory);
	}
}
