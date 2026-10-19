using System;
using System.Collections.Generic;
using ACT.Battle.Configs;
using UnityEngine;

namespace ACT.DebugGUI;

public class DebugGizmoSectorCylinder : DebugGizmoCube
{
	private Mesh _mesh;

	private Vector3 _physicsCenter;

	private Vector3 _physicsSize;

	private Quaternion _physicsQuaternion;

	protected readonly List<Vector3> vertices = new List<Vector3>();

	protected readonly List<int> triangles = new List<int>();

	protected List<Vector3> wireOutlineVertices = new List<Vector3>();

	private Vector3[] _debugVertices;

	private const int NormalizedSegmentCount = 64;

	private const float angleFactor = 0.0027777778f;

	private const float SegmentSectorPI = MathF.PI / 4f;

	public override void Draw()
	{
		Gizmos.color = color;
		Gizmos.matrix = Matrix4x4.TRS(bounds.center, quaternion, Vector3.one);
		Gizmos.DrawMesh(_mesh);
		Gizmos.matrix = Matrix4x4.TRS(_physicsCenter, _physicsQuaternion, Vector3.one);
		Gizmos.color = Color.cyan;
		Gizmos.DrawWireCube(Vector3.zero, _physicsSize);
		if (_debugVertices != null)
		{
			Gizmos.matrix = Matrix4x4.identity;
			Gizmos.color = Color.red;
			for (int i = 0; i < _debugVertices.Length; i += 3)
			{
				Vector3 vector = _debugVertices[i];
				Vector3 vector2 = _debugVertices[i + 1];
				Vector3 vector3 = _debugVertices[i + 2];
				Gizmos.DrawLine(vector, vector2);
				Gizmos.DrawLine(vector2, vector3);
				Gizmos.DrawLine(vector3, vector);
			}
		}
	}

	public void UpdateGizmoMesh(TargetSectorBounds sectorBounds)
	{
		_debugVertices = sectorBounds.debugGeometryPoints?.ToArray();
		_physicsCenter = sectorBounds.physicBoundCenter;
		_physicsSize = sectorBounds.physicBoundSize;
		_physicsQuaternion = sectorBounds.physicBoundRotation;
		int sectorAngle = sectorBounds.sectorAngle;
		float diameter = Mathf.Min(bounds.size.y, bounds.size.z);
		float x = bounds.size.x;
		GenerateGizmoMesh(sectorAngle, diameter, x, vertices, triangles, wireOutlineVertices);
		_mesh = new Mesh();
		_mesh.SetVertices(vertices);
		_mesh.SetIndices(triangles, MeshTopology.Triangles, 0);
		_mesh.RecalculateNormals();
		_mesh.RecalculateBounds();
	}

	private static void GenerateGizmoMesh(int angle, float diameter, float length, List<Vector3> vertices, List<int> triangles, List<Vector3> outlinePoints)
	{
		while (angle < 0)
		{
			angle += 360;
		}
		angle %= 360;
		if (angle == 0)
		{
			angle = 360;
		}
		int num = Mathf.CeilToInt(diameter * 64f * (float)angle * 0.0027777778f * 0.5f) * 2;
		float num2 = (0f - length) * 0.5f;
		float num3 = MathF.PI / 180f * (float)angle;
		float num4 = num3 / (float)num;
		float num5 = num3 * -0.5f;
		float num6 = diameter * 0.5f;
		Vector3[] array = new Vector3[num + 1];
		Vector3[] array2 = new Vector3[num + 1];
		int num7 = num + 2;
		outlinePoints.Clear();
		vertices.Clear();
		triangles.Clear();
		float num8 = num5;
		float num9 = num3 / (float)Mathf.CeilToInt(num3 / (MathF.PI / 4f));
		float num10 = num9;
		for (int i = 0; i <= num; i++)
		{
			float num11 = num5 + num4 * (float)i;
			float y = Mathf.Cos(num11) * num6;
			float z = Mathf.Sin(num11) * num6;
			array2[i] = new Vector3(0f - num2, y, z);
			array[i] = new Vector3(num2, y, z);
			if (num11 - num8 >= num10)
			{
				outlinePoints.Add(array2[i]);
				outlinePoints.Add(array[i]);
				num10 += num9;
			}
			triangles.Add(num7 + i);
			triangles.Add(num7 + i + 1);
			triangles.Add(i);
			triangles.Add(i);
			triangles.Add(num7 + i + 1);
			triangles.Add(i + 1);
			if (i > 0)
			{
				triangles.Add(0);
				triangles.Add(i);
				triangles.Add(i + 1);
				triangles.Add(num7);
				triangles.Add(num7 + i + 1);
				triangles.Add(num7 + i);
				outlinePoints.Add(array2[i - 1]);
				outlinePoints.Add(array2[i]);
				outlinePoints.Add(array[i - 1]);
				outlinePoints.Add(array[i]);
			}
		}
		vertices.Add(new Vector3(0f - num2, 0f, 0f));
		vertices.AddRange(array2);
		vertices.Add(new Vector3(num2, 0f, 0f));
		vertices.AddRange(array);
		int num12 = 0;
		int num13 = 1;
		int num14 = num7 - 1;
		int num15 = num7;
		int num16 = num7 + 1;
		int num17 = vertices.Count - 1;
		if (angle > 1 && angle < 360)
		{
			triangles.Add(num12);
			triangles.Add(num15);
			triangles.Add(num13);
			triangles.Add(num13);
			triangles.Add(num15);
			triangles.Add(num16);
			triangles.Add(num17);
			triangles.Add(num15);
			triangles.Add(num12);
			triangles.Add(num12);
			triangles.Add(num14);
			triangles.Add(num17);
			outlinePoints.Add(vertices[num15]);
			outlinePoints.Add(vertices[num17]);
			outlinePoints.Add(vertices[num17]);
			outlinePoints.Add(vertices[num14]);
			outlinePoints.Add(vertices[num14]);
			outlinePoints.Add(vertices[num12]);
			outlinePoints.Add(vertices[num12]);
			outlinePoints.Add(vertices[num13]);
			outlinePoints.Add(vertices[num13]);
			outlinePoints.Add(vertices[num16]);
			outlinePoints.Add(vertices[num16]);
			outlinePoints.Add(vertices[num15]);
		}
	}
}
