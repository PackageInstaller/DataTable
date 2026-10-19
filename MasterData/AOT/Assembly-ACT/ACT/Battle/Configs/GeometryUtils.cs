using System;
using System.Collections.Generic;
using UnityEngine;

namespace ACT.Battle.Configs;

internal static class GeometryUtils
{
	public enum Direction
	{
		X,
		Y,
		Z
	}

	private const float AngleFactor = 0.0027777778f;

	public static void GenerateCapsule(float radius, float height, int latSegments, int lonSegments, Direction direction, List<Vector3> vertices, List<int> triangles)
	{
		GenerateCapsule(radius, height, latSegments, lonSegments, direction, vertices, triangles, Matrix4x4.identity);
	}

	public static void GenerateCapsule(float radius, float height, int latSegments, int lonSegments, Direction direction, List<Vector3> vertices, List<int> triangles, Matrix4x4 trs)
	{
		int num = (latSegments + 1) * lonSegments;
		int num2 = lonSegments + lonSegments;
		int num3 = 0;
		int num4 = num;
		int num5 = num + num2;
		float num6 = height * 0.5f;
		Vector3[] array = new Vector3[num + num2 + num];
		int[] array2 = new int[num * 12 + lonSegments * 6];
		int num7 = 0;
		float num8 = MathF.PI * 2f / (float)lonSegments;
		int num9 = 0;
		for (int i = 0; i <= latSegments; i++)
		{
			float f = MathF.PI / 2f * (float)i / (float)latSegments;
			float num10 = Mathf.Cos(f);
			float num11 = Mathf.Sin(f);
			for (int j = 0; j < lonSegments; j++)
			{
				num9 = i * lonSegments + j;
				float f2 = num8 * (float)j;
				float num12 = Mathf.Cos(f2);
				float num13 = Mathf.Sin(f2);
				array[num3 + num9] = TransformDirection(radius * num11 * num12, radius * num10 + num6, radius * num11 * num13, direction, ref trs);
				array[num5 + num9] = TransformDirection(radius * num11 * num12, (0f - radius) * num10 - num6, radius * num11 * num13, direction, ref trs);
				if (i == 0)
				{
					array[num4 + j * 2] = TransformDirection(radius * num12, height * 0.5f, radius * num13, direction, ref trs);
					array[num4 + j * 2 + 1] = TransformDirection(radius * Mathf.Cos(f2), (0f - height) * 0.5f, radius * num13, direction, ref trs);
					int num14;
					int num15;
					if (j == 0)
					{
						num14 = num4 + lonSegments * 2 - 2;
						num15 = num4 + lonSegments * 2 - 1;
					}
					else
					{
						num14 = num4 + j * 2 - 2;
						num15 = num4 + j * 2 - 1;
					}
					int num16 = num4 + j * 2;
					int num17 = num4 + j * 2 + 1;
					array2[num7++] = num14;
					array2[num7++] = num16;
					array2[num7++] = num15;
					array2[num7++] = num15;
					array2[num7++] = num16;
					array2[num7++] = num17;
				}
				if (i != latSegments)
				{
					int num14 = num3 + i * lonSegments + j;
					int num16 = num3 + i * lonSegments + (j + 1) % lonSegments;
					int num15 = num3 + (i + 1) * lonSegments + j;
					int num17 = num3 + (i + 1) * lonSegments + (j + 1) % lonSegments;
					array2[num7++] = num15;
					array2[num7++] = num14;
					array2[num7++] = num16;
					array2[num7++] = num15;
					array2[num7++] = num16;
					array2[num7++] = num17;
					num14 = num5 + i * lonSegments + j;
					num16 = num5 + i * lonSegments + (j + 1) % lonSegments;
					num15 = num5 + (i + 1) * lonSegments + j;
					num17 = num5 + (i + 1) * lonSegments + (j + 1) % lonSegments;
					array2[num7++] = num14;
					array2[num7++] = num15;
					array2[num7++] = num16;
					array2[num7++] = num16;
					array2[num7++] = num15;
					array2[num7++] = num17;
				}
			}
		}
		vertices.AddRange(array);
		triangles.AddRange(array2);
	}

	public static void GenerateSectorCylinder(int angle, float radius, float height, int latSegments, Direction direction, List<Vector3> vertices, List<int> triangles)
	{
		GenerateSectorCylinder(angle, radius, height, latSegments, direction, vertices, triangles, Matrix4x4.identity);
	}

	public static void GenerateSectorCylinder(int angle, float radius, float height, int latSegments, Direction direction, List<Vector3> vertices, List<int> triangles, Matrix4x4 trs)
	{
		if (angle <= 180)
		{
			GenerateSectorCylinder(0f, angle, radius, height, latSegments, direction, trs, vertices, triangles);
			return;
		}
		float num = (float)angle * 0.5f;
		float num2 = MathF.PI / 180f * num * 0.5f;
		GenerateSectorCylinder(num2, num, radius, height, latSegments, direction, trs, vertices, triangles);
		GenerateSectorCylinder(0f - num2, num, radius, height, latSegments, direction, trs, vertices, triangles);
	}

	private static void GenerateSectorCylinder(float radianOffset, float angle, float radius, float height, int latSegments, Direction direction, Matrix4x4 trs, List<Vector3> vertices, List<int> triangles)
	{
		int count = vertices.Count;
		int num = Mathf.CeilToInt((float)latSegments * angle * 0.0027777778f * 0.5f) * 2;
		float num2 = (0f - height) * 0.5f;
		float num3 = MathF.PI / 180f * angle / (float)num;
		Vector3[] array = new Vector3[num + 1];
		Vector3[] array2 = new Vector3[num + 1];
		int num4 = num + 2;
		float num5 = MathF.PI / 180f * angle * -0.5f;
		for (int i = 0; i <= num; i++)
		{
			float f = radianOffset + num5 + num3 * (float)i;
			float x = Mathf.Cos(f) * radius;
			float z = Mathf.Sin(f) * radius;
			array2[i] = TransformDirection(x, 0f - num2, z, direction, ref trs);
			array[i] = TransformDirection(x, num2, z, direction, ref trs);
			if (i > 0)
			{
				triangles.Add(count + num4 + i);
				triangles.Add(count + num4 + i + 1);
				triangles.Add(count + i);
				triangles.Add(count + i);
				triangles.Add(count + num4 + i + 1);
				triangles.Add(count + i + 1);
			}
			triangles.Add(count);
			triangles.Add(count + i);
			triangles.Add(count + i + 1);
			triangles.Add(count + num4);
			triangles.Add(count + num4 + i + 1);
			triangles.Add(count + num4 + i);
		}
		vertices.Add(TransformDirection(0f, 0f - num2, 0f, direction, ref trs));
		vertices.AddRange(array2);
		vertices.Add(TransformDirection(0f, num2, 0f, direction, ref trs));
		vertices.AddRange(array);
		int item = count;
		int item2 = count + 1;
		int item3 = count + num4 - 1;
		int item4 = count + num4;
		int item5 = count + num4 + 1;
		int item6 = vertices.Count - 1;
		if (angle > 0f && angle < 360f)
		{
			triangles.Add(item);
			triangles.Add(item4);
			triangles.Add(item2);
			triangles.Add(item2);
			triangles.Add(item4);
			triangles.Add(item5);
			triangles.Add(item6);
			triangles.Add(item4);
			triangles.Add(item);
			triangles.Add(item);
			triangles.Add(item3);
			triangles.Add(item6);
		}
	}

	private static Vector3 TransformDirection(float x, float y, float z, Direction direction, ref Matrix4x4 trs)
	{
		return direction switch
		{
			Direction.X => new Vector3(y, x, z), 
			Direction.Z => new Vector3(x, z, y), 
			_ => new Vector3(x, y, z), 
		};
	}
}
