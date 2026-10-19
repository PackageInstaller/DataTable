namespace ACT.Battle.Configs;

[AbilityTypeMetadata("参数 ID 常量", "Function", new string[] { "const", "param", "id" })]
public class ConstParamId : ConfigFunction<float>
{
	public int paramId;

	public static string[] ParamIdNames = new string[20]
	{
		"param1", "param2", "param3", "param4", "param5", "param6", "param7", "param8", "param9", "param10",
		"param11", "param12", "param13", "param14", "param15", "param16", "param17", "param18", "param19", "param20"
	};

	protected override float Evaluate(ActionMemory memory)
	{
		if (paramId > 0)
		{
			return DynamicFloat.GetTableKeyParamValue(memory.ability, ParamIdNames[paramId - 1]);
		}
		return 1f;
	}
}
