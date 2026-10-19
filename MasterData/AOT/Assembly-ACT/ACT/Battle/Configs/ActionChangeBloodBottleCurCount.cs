namespace ACT.Battle.Configs;

[AbilityTypeMetadata("修改血瓶当前数量", "Action", new string[] { "change", "blood", "bottle", "cur", "count", "heal", "recover", "hp" })]
public class ActionChangeBloodBottleCurCount : ConfigAction
{
	public ConfigFunction<float> configFunction;

	public override void Do(ActionMemory memory)
	{
		configFunction.Return(memory);
	}
}
