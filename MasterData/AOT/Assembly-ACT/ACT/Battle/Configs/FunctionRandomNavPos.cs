using UnityEngine;
using UnityEngine.AI;

namespace ACT.Battle.Configs;

[AbilityTypeMetadata("随机寻路位置", "Function", new string[] { "random", "nav", "pos", "value", "float", "int" })]
public class FunctionRandomNavPos : ConfigFunction<Vector3>
{
	public ConfigFunction<Vector3> center;

	public float radius;

	public int iterations = 10;

	protected override Vector3 Evaluate(ActionMemory memory)
	{
		Vector3 result = center.Return(memory);
		if (!RandomPoint(result, radius, out var result2))
		{
			return result;
		}
		return result2;
	}

	private bool RandomPoint(Vector3 center, float range, out Vector3 result)
	{
		for (int i = 0; i < iterations; i++)
		{
			if (NavMesh.SamplePosition(center + Vector3.right * Random.Range(-1f, 1f) * range, out var hit, 1f, -1))
			{
				result = hit.position;
				return true;
			}
		}
		result = Vector3.zero;
		return false;
	}
}
