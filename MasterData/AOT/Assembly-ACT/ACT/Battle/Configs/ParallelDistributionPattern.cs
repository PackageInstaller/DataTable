using System;
using System.Collections.Generic;
using Bamboo.ECS;
using UnityEngine;

namespace ACT.Battle.Configs;

[Serializable]
public class ParallelDistributionPattern : TransformsPattern
{
	public uint count;

	public ConfigFunction<float> functionCount;

	public ConfigFunction<Vector3> origin;

	public ConfigFunction<Vector3> aimPos;

	public ConfigFunction<float> intervalDistance;

	public bool unFollowOwnerRotation;

	public Vector3 normalPlane = Vector3.right;

	public override void GetPositionsAndRotation(ActionMemory memory, List<(Vector3, Vector3)> transforms)
	{
		uint num = ((functionCount == null) ? count : ((uint)functionCount.Return(memory)));
		transforms.Clear();
		Vector3 vector = origin.Return(memory);
		Vector3 normalized = (aimPos.Return(memory) - vector).normalized;
		float num2 = intervalDistance.Return(memory);
		Vector3 normalized2 = Vector3.Cross((unFollowOwnerRotation ? memory.owner.GetCompTransform().PathRotation : memory.owner.GetCompTransform().FaceRotation) * normalPlane, normalized).normalized;
		for (int i = 0; i < num; i++)
		{
			Vector3 vector2 = ((float)i - (float)count / 2f) * num2 * normalized2;
			Vector3 vector3 = vector + vector2;
			transforms.Add((vector3, normalized));
			Debug.DrawRay(vector3, normalized, Color.green, 1f);
		}
	}
}
