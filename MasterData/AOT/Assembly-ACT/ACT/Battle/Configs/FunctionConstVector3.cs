using UnityEngine;

namespace ACT.Battle.Configs;

[AbilityTypeMetadata("向量3常量", "Function", new string[] { "const", "vector3" })]
public class FunctionConstVector3 : ConfigFunction<Vector3>
{
	[Tooltip("朝着V3发射子弹")]
	public Vector3 value;

	protected override Vector3 Evaluate(ActionMemory memory)
	{
		return value;
	}
}
