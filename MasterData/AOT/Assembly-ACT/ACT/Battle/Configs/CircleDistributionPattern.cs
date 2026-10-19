using System;
using System.Collections.Generic;
using Bamboo.ECS;
using UnityEngine;

namespace ACT.Battle.Configs;

[Serializable]
public class CircleDistributionPattern : TransformsPattern
{
	public uint count;

	public ConfigFunction<float> functionCount;

	public ConfigFunction<Vector3> origin;

	public ConfigFunction<Vector3> aimPos;

	public ConfigFunction<float> radius;

	public float angle;

	public bool unFollowOwnerRotation;

	public Vector3 normalPlane = Vector3.right;

	public override void GetPositionsAndRotation(ActionMemory memory, List<(Vector3, Vector3)> transforms)
	{
		uint num = ((functionCount == null) ? count : ((uint)functionCount.Return(memory)));
		transforms.Clear();
		float num2 = ((num % 2 == 0) ? (angle / 2f) : 0f);
		Vector3 vector = origin.Return(memory);
		Vector3 normalized = (aimPos.Return(memory) - vector).normalized;
		float num3 = radius.Return(memory);
		Debug.DrawRay(vector + normalized * num3, normalized, Color.red, 1f);
		float num4 = 0f - ((float)(num / 2) * angle - num2);
		Vector3 axis = (unFollowOwnerRotation ? memory.owner.GetCompTransform().PathRotation : memory.owner.GetCompTransform().FaceRotation) * normalPlane;
		for (int i = 0; i < num; i++)
		{
			Vector3 vector2 = Quaternion.AngleAxis(num4 + (float)i * angle, axis) * normalized;
			transforms.Add((vector + vector2 * num3, vector2));
			Debug.DrawRay(vector + vector2 * num3, vector2, Color.green, 1f);
		}
	}
}
