using UnityEngine;

namespace ACT.Battle.Configs;

[AbilityTypeMetadata("计算两个位置距离", "Function", new string[] { "get", "distance", "by", "two", "pos", "vector", "position", "rotation", "quaternion" })]
public class GetDistanceByTwoPos : ConfigFunction<float>
{
	public ConfigFunction<Vector3> pos1;

	public ConfigFunction<Vector3> pos2;

	protected override float Evaluate(ActionMemory memory)
	{
		return (pos2.Return(memory) - pos1.Return(memory)).magnitude;
	}
}
