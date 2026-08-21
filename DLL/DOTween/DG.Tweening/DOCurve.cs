using System.Collections.Generic;
using UnityEngine;

namespace DG.Tweening;

public static class DOCurve
{
	public static class CubicBezier
	{
		public static Vector3 GetPointOnSegment(Vector3 startPoint, Vector3 startControlPoint, Vector3 endPoint, Vector3 endControlPoint, float factor)
		{
			//IL_001b: Unknown result type (might be due to invalid IL or missing references)
			//IL_001c: Unknown result type (might be due to invalid IL or missing references)
			//IL_002b: Unknown result type (might be due to invalid IL or missing references)
			//IL_002c: Unknown result type (might be due to invalid IL or missing references)
			//IL_0031: Unknown result type (might be due to invalid IL or missing references)
			//IL_003f: Unknown result type (might be due to invalid IL or missing references)
			//IL_0040: Unknown result type (might be due to invalid IL or missing references)
			//IL_0045: Unknown result type (might be due to invalid IL or missing references)
			//IL_004b: Unknown result type (might be due to invalid IL or missing references)
			//IL_004c: Unknown result type (might be due to invalid IL or missing references)
			//IL_0051: Unknown result type (might be due to invalid IL or missing references)
			float num = 1f - factor;
			float num2 = factor * factor;
			float num3 = num * num;
			float num4 = num3 * num;
			float num5 = num2 * factor;
			return num4 * startPoint + 3f * num3 * factor * startControlPoint + 3f * num * num2 * endControlPoint + num5 * endPoint;
		}

		public static Vector3[] GetSegmentPointCloud(Vector3 startPoint, Vector3 startControlPoint, Vector3 endPoint, Vector3 endControlPoint, int resolution = 10)
		{
			//IL_0022: Unknown result type (might be due to invalid IL or missing references)
			//IL_0023: Unknown result type (might be due to invalid IL or missing references)
			//IL_0024: Unknown result type (might be due to invalid IL or missing references)
			//IL_0025: Unknown result type (might be due to invalid IL or missing references)
			//IL_002a: Unknown result type (might be due to invalid IL or missing references)
			//IL_002f: Unknown result type (might be due to invalid IL or missing references)
			if (resolution < 2)
			{
				resolution = 2;
			}
			Vector3[] array = (Vector3[])(object)new Vector3[resolution];
			float num = 1f / (float)(resolution - 1);
			for (int i = 0; i < resolution; i++)
			{
				array[i] = GetPointOnSegment(startPoint, startControlPoint, endPoint, endControlPoint, num * (float)i);
			}
			return array;
		}

		public static void GetSegmentPointCloud(List<Vector3> addToList, Vector3 startPoint, Vector3 startControlPoint, Vector3 endPoint, Vector3 endControlPoint, int resolution = 10)
		{
			//IL_0019: Unknown result type (might be due to invalid IL or missing references)
			//IL_001a: Unknown result type (might be due to invalid IL or missing references)
			//IL_001b: Unknown result type (might be due to invalid IL or missing references)
			//IL_001c: Unknown result type (might be due to invalid IL or missing references)
			//IL_0022: Unknown result type (might be due to invalid IL or missing references)
			if (resolution < 2)
			{
				resolution = 2;
			}
			float num = 1f / (float)(resolution - 1);
			for (int i = 0; i < resolution; i++)
			{
				addToList.Add(GetPointOnSegment(startPoint, startControlPoint, endPoint, endControlPoint, num * (float)i));
			}
		}
	}
}
