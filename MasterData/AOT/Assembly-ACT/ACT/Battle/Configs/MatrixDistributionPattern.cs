using System;
using System.Collections.Generic;
using Bamboo.ECS;
using UnityEngine;

namespace ACT.Battle.Configs;

[Serializable]
public class MatrixDistributionPattern : TransformsPattern
{
	public enum RowColNumType
	{
		OnlyOne,
		Multi
	}

	public ConfigFunction<Vector3> startPoint;

	public RowColNumType rowNumType;

	public ConfigFunction<float> rowDis;

	public ConfigFunction<float> rowNum;

	public RowColNumType colNumType;

	public ConfigFunction<float> colDis;

	public ConfigFunction<float> colNum;

	public override void GetPositionsAndRotation(ActionMemory memory, List<(Vector3, Vector3)> transforms)
	{
		transforms.Clear();
		if (startPoint == null)
		{
			return;
		}
		int num = ((colNumType == RowColNumType.OnlyOne) ? 1 : Mathf.Max(0, (int)colNum.Return(memory)));
		int num2 = ((rowNumType == RowColNumType.OnlyOne) ? 1 : Mathf.Max(0, (int)rowNum.Return(memory)));
		float num3 = ((rowDis == null) ? 0f : rowDis.Return(memory));
		float num4 = ((colDis == null) ? 0f : colDis.Return(memory));
		Vector3 vector = startPoint.Return(memory);
		Entity owner = memory.owner;
		Quaternion quaternion = Quaternion.identity;
		bool flag = false;
		if (owner.IsValid)
		{
			quaternion = owner.GetCompTransform().FaceRotation;
			flag = owner.IsFaceLeft();
		}
		Vector3 vector2 = quaternion * Vector3.forward;
		Vector3 vector3 = quaternion * Vector3.up;
		Vector3 vector4 = (flag ? (-vector2) : vector2);
		for (int i = 0; i < num2; i++)
		{
			for (int j = 0; j < num; j++)
			{
				Vector3 vector5 = vector + vector4 * ((float)j * num3) + vector3 * ((float)i * num4);
				transforms.Add((vector5, vector3));
				Debug.DrawRay(vector5, vector3, Color.green, 1f);
			}
		}
	}
}
