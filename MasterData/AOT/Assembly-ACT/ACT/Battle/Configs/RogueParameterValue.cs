namespace ACT.Battle.Configs;

[AbilityTypeMetadata("获取Rogue参数值", "Function", new string[] { "rogue", "parameter", "value" })]
public class RogueParameterValue : ConfigFunction<float>
{
	public string name;

	protected override float Evaluate(ActionMemory memory)
	{
		if (GameManager.rogueSystem.TryGetRogueParameter(name, out var value))
		{
			return value;
		}
		return 0f;
	}
}
