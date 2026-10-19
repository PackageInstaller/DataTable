using System;
using System.Collections.Generic;
using Bamboo.ECS;
using UnityEngine;

namespace ACT.Battle.Configs;

[Serializable]
public class RandomAngleDistributionPattern : TransformsPattern
{
	public uint count;

	public ConfigFunction<float> functionCount;

	public ConfigFunction<Vector3> origin;

	public ConfigFunction<Vector3> aimPos;

	public ConfigFunction<float> radius;

	public bool unFollowOwnerRotation;

	public float angle;

	public float downDeviation;

	public float upDeviation;

	public Vector3 normalPlane = Vector3.right;

	public override void GetPositionsAndRotation(ActionMemory memory, List<(Vector3, Vector3)> transforms)
	{
		uint num = ((functionCount == null) ? count : ((uint)functionCount.Return(memory)));
		transforms.Clear();
		float num2 = angle - downDeviation;
		float num3 = angle + upDeviation;
		float num4 = (num2 + num3) / 2f;
		float num5 = UnityEngine.Random.Range(0f - num4, num4);
		float num6 = ((num % 2 == 0) ? (angle / 2f) : 0f);
		Vector3 vector = origin.Return(memory);
		Vector3 normalized = (aimPos.Return(memory) - vector).normalized;
		float num7 = radius.Return(memory);
		Debug.DrawRay(vector + normalized * num7, normalized, Color.red, 1f);
		float num8 = 0f - ((float)(num / 2) * num4 - num6) + num5;
		Quaternion quaternion = (unFollowOwnerRotation ? memory.owner.GetCompTransform().PathRotation : memory.owner.GetCompTransform().FaceRotation);
		float num9 = num8;
		Vector3 axis = quaternion * normalPlane;
		for (int i = 0; i < num; i++)
		{
			Vector3 vector2 = Quaternion.AngleAxis(num9, axis) * normalized;
			transforms.Add((vector + vector2 * num7, vector2));
			Debug.DrawRay(vector + vector2 * num7, vector2, Color.green, 1f);
			num9 += UnityEngine.Random.Range(num2, num3);
		}
	}
}
