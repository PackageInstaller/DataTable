namespace ACT.Battle.Configs;

[AbilityTypeMetadata("获取Rogue消耗金币", "Function", new string[] { "rogue", "cost", "coin" })]
public class FunctionRogueCostCoin : ConfigFunction<float>
{
	protected override float Evaluate(ActionMemory memory)
	{
		return 0f;
	}
}
