using System;
using System.Collections.Generic;
using UnityEngine;

namespace ACT.Battle.Configs;

[Serializable]
public class SecondHandPattern : TransformsPattern
{
	public enum SecondHandPatternType
	{
		Circle,
		Sector
	}

	public enum SecondHandDirType
	{
		Clockwise,
		Counterclockwise
	}

	public ConfigFunction<Vector3> origin;

	public ConfigFunction<float> radius;

	public SecondHandPatternType secondHandPatternType;

	public SecondHandDirType secondHandDirType;

	public ConfigFunction<Vector3> startDirection;

	public ConfigFunction<float> angle;

	public ConfigFunction<float> intervalAngle;

	public ConfigFunction<float> fireBulletNum;

	public int moveNum = 1;

	public bool needChangesecondHandDirType;

	public override void GetPositionsAndRotation(ActionMemory memory, List<(Vector3, Vector3)> transforms)
	{
		transforms.Clear();
		if (startDirection == null || origin == null)
		{
			return;
		}
		Vector3 vector = origin.Return(memory);
		Vector3 normalized = startDirection.Return(memory).normalized;
		float f = ((angle == null) ? 0f : angle.Return(memory));
		float num = ((intervalAngle == null) ? 0f : intervalAngle.Return(memory));
		float num2 = Mathf.Max(0.0001f, Mathf.Abs(num));
		int num3 = ((fireBulletNum == null) ? 1 : Mathf.Max(1, (int)fireBulletNum.Return(memory)));
		int num4 = Mathf.Max(1, moveNum);
		float num5 = ((radius == null) ? 0f : radius.Return(memory));
		int num6 = ((secondHandDirType != SecondHandDirType.Clockwise) ? 1 : (-1));
		Vector3 axis = Vector3.Cross(Vector3.up, normalized);
		if (axis.sqrMagnitude < 1E-06f)
		{
			axis = Vector3.right;
		}
		else
		{
			axis.Normalize();
		}
		if (secondHandPatternType == SecondHandPatternType.Circle)
		{
			int num7 = ((!(num > 0f)) ? 1 : Mathf.Max(1, Mathf.FloorToInt(360f / num2)));
			float num8 = ((num7 % 2 == 0) ? (num2 / 2f) : 0f);
			float num9 = 0f - ((float)num7 / 2f * num2 - num8);
			for (int i = 0; i < num4; i++)
			{
				Vector3 vector2 = Quaternion.AngleAxis(num2 * (float)i * (float)num6, axis) * normalized;
				for (int j = 0; j < num7; j++)
				{
					Vector3 vector3 = Quaternion.AngleAxis((num9 + (float)j * num2) * (float)num6, axis) * vector2;
					Vector3 vector4 = vector + vector3 * num5;
					for (int k = 0; k < num3; k++)
					{
						transforms.Add((vector4, vector3));
					}
					Debug.DrawRay(vector4, vector3, Color.green, 1f);
				}
			}
			return;
		}
		float num10 = Mathf.Max(0f, Mathf.Abs(f));
		int num11 = ((!(num2 > 0f)) ? 1 : Mathf.Max(1, Mathf.FloorToInt(num10 / num2) + 1));
		float num12 = ((num11 > 1) ? (num10 / (float)(num11 - 1)) : 0f);
		for (int l = 0; l < num4; l++)
		{
			float num13 = num2 * (float)l * (float)num6;
			for (int m = 0; m < num11; m++)
			{
				float num14 = num12 * (float)m;
				Vector3 vector5 = Quaternion.AngleAxis(num13 + num14 * (float)num6, axis) * normalized;
				Vector3 vector6 = vector + vector5 * num5;
				for (int n = 0; n < num3; n++)
				{
					transforms.Add((vector6, vector5));
				}
				Debug.DrawRay(vector6, vector5, Color.green, 1f);
			}
		}
		if (needChangesecondHandDirType)
		{
			for (int num15 = transforms.Count - 1; num15 >= 0; num15--)
			{
				Vector3 item = transforms[num15].Item1;
				Vector3 item2 = transforms[num15].Item2;
				transforms.Add((item, item2));
				Debug.DrawRay(item, item2, Color.cyan, 1f);
			}
		}
	}
}
