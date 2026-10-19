using UnityEngine;

namespace ACT.Battle.Configs;

[AbilityTypeMetadata("获取四元数实体到世界", "Function", new string[] { "quaternion", "entity", "to", "world", "vector", "position", "rotation" })]
public class FunctionQuaternionEntityToWorld : ConfigFunction<Quaternion>
{
	public ConfigFunction<Quaternion> config;

	protected override Quaternion Evaluate(ActionMemory memory)
	{
		return config.Return(memory) * Quaternion.Euler(0f, -90f, 0f);
	}
}
