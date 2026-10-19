using System.Collections.Generic;
using ACT.Utility;
using Bamboo.ECS;
using UnityEngine;

namespace ACT.Battle.Configs;

[AbilityTypeMetadata("获取一个点之间点", "Function", new string[] { "get", "one", "point", "between", "vector", "position", "rotation", "quaternion" })]
public class FunctionGetOnePointBetweenPoint : ConfigFunction<Vector3>
{
	public enum GetPointType
	{
		Closed,
		Farthest
	}

	public ConfigFunction<Vector3>[] a;

	public GetPointType getPointType;

	protected override Vector3 Evaluate(ActionMemory memory)
	{
		List<Vector3> list = new List<Vector3>();
		if (a != null || a.Length >= 0)
		{
			for (int i = 0; i < a.Length; i++)
			{
				list.Add(a[i].Return(memory));
			}
			Vector3 vector = Vector3.zero;
			Vector3 physicsPosition = memory.target.entity.GetCompTransform().physicsPosition;
			switch (getPointType)
			{
			case GetPointType.Closed:
			{
				vector = list[0];
				for (int k = 1; k < list.Count; k++)
				{
					vector = VectorUtility.GetClosestPoint(physicsPosition, list[k], vector);
				}
				break;
			}
			case GetPointType.Farthest:
			{
				vector = list[0];
				for (int j = 1; j < list.Count; j++)
				{
					vector = VectorUtility.GetFarthestPoint(physicsPosition, list[j], vector);
				}
				break;
			}
			}
			return vector;
		}
		if (LuminApplication.LogEnabled)
		{
			Debug.LogError($"{memory.ability} {memory.owner}执行FunctionGetOnePointBetweenPoint时 ConfigFunction<Vector3>[]为空");
		}
		return Vector3.zero;
	}
}
