using UnityEngine;

namespace ACT.Battle.Configs;

[AbilityTypeMetadata("获取当前时间", "Function", new string[] { "get", "cur", "time" })]
public class GetCurTime : ConfigFunction<float>
{
	protected override float Evaluate(ActionMemory memory)
	{
		return Time.time;
	}
}
