using UnityEngine;

namespace ACT.Battle.Configs;

[AbilityTypeMetadata("随机向量3中矩形", "Function", new string[] { "random", "vector3", "in", "rect", "value", "float", "int" })]
public class FunctionRandomVector3InRect : ConfigFunction<Vector3>
{
	public ConfigFunction<Bounds> bounds;

	protected override Vector3 Evaluate(ActionMemory memory)
	{
		Bounds bounds = this.bounds.Return(memory);
		return new Vector3(Random.Range(bounds.min.x, bounds.max.x), Random.Range(bounds.min.y, bounds.max.y), Random.Range(bounds.min.z, bounds.max.z));
	}
}
