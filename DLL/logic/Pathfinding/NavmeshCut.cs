using System;
using System.Collections.Generic;
using Pathfinding.Util;
using UnityEngine;
using UnityEngine.Serialization;

namespace Pathfinding;

[HelpURL("http://arongranberg.com/astar/docs/class_pathfinding_1_1_navmesh_cut.php")]
public class NavmeshCut : NavmeshClipper
{
	public enum MeshType
	{
		Rectangle,
		Circle,
		CustomMesh
	}

	[Tooltip("Shape of the cut")]
	public MeshType type;

	[Tooltip("The contour(s) of the mesh will be extracted. This mesh should only be a 2D surface, not a volume (see documentation).")]
	public Mesh mesh;

	public Vector2 rectangleSize;

	public float circleRadius;

	public int circleResolution;

	public float height;

	[Tooltip("Scale of the custom mesh")]
	public float meshScale;

	public Vector3 center;

	public Vector3 foward;

	[Tooltip("Distance between positions to require an update of the navmesh\nA smaller distance gives better accuracy, but requires more updates when moving the object over time, so it is often slower.")]
	public float updateDistance;

	[Tooltip("Only makes a split in the navmesh, but does not remove the geometry to make a hole")]
	public bool isDual;

	public bool cutsAddedGeom;

	[Tooltip("How many degrees rotation that is required for an update to the navmesh. Should be between 0 and 180.")]
	public float updateRotationDistance;

	[Tooltip("Includes rotation in calculations. This is slower since a lot more matrix multiplications are needed but gives more flexibility.")]
	[FormerlySerializedAs("useRotation")]
	public bool useRotationAndScale;

	private Vector3[][] contours;

	protected Transform tr;

	private Mesh lastMesh;

	private Vector3 lastPosition;

	private Quaternion lastRotation;

	private static readonly Dictionary<Int2, int> edges;

	private static readonly Dictionary<int, int> pointers;

	public static readonly Color GizmoColor;

	public override void Initialize()
	{
		base.Initialize();
	}

	public override void Shutdown()
	{
		base.Shutdown();
	}

	public override void OnEnable()
	{
		//IL_0016: Unknown result type (might be due to invalid IL or missing references)
		//IL_001b: Unknown result type (might be due to invalid IL or missing references)
		//IL_0027: Unknown result type (might be due to invalid IL or missing references)
		//IL_002c: Unknown result type (might be due to invalid IL or missing references)
		base.OnEnable();
		lastPosition = new Vector3(float.PositiveInfinity, float.PositiveInfinity, float.PositiveInfinity);
		lastRotation = tr.rotation;
	}

	public override void ForceUpdate()
	{
		//IL_0010: Unknown result type (might be due to invalid IL or missing references)
		//IL_0015: Unknown result type (might be due to invalid IL or missing references)
		lastPosition = new Vector3(float.PositiveInfinity, float.PositiveInfinity, float.PositiveInfinity);
	}

	public override bool RequiresUpdate()
	{
		//IL_0006: Unknown result type (might be due to invalid IL or missing references)
		//IL_000c: Unknown result type (might be due to invalid IL or missing references)
		//IL_0011: Unknown result type (might be due to invalid IL or missing references)
		//IL_0016: Unknown result type (might be due to invalid IL or missing references)
		//IL_0036: Unknown result type (might be due to invalid IL or missing references)
		//IL_0041: Unknown result type (might be due to invalid IL or missing references)
		Vector3 val = tr.position - lastPosition;
		if (!(((Vector3)(ref val)).sqrMagnitude > updateDistance * updateDistance))
		{
			if (useRotationAndScale)
			{
				return Quaternion.Angle(lastRotation, tr.rotation) > updateRotationDistance;
			}
			return false;
		}
		return true;
	}

	public virtual void UsedForCut()
	{
	}

	internal override void NotifyUpdated()
	{
		//IL_0007: Unknown result type (might be due to invalid IL or missing references)
		//IL_000c: Unknown result type (might be due to invalid IL or missing references)
		//IL_0020: Unknown result type (might be due to invalid IL or missing references)
		//IL_0025: Unknown result type (might be due to invalid IL or missing references)
		lastPosition = tr.position;
		if (useRotationAndScale)
		{
			lastRotation = tr.rotation;
		}
	}

	private void CalculateMeshContour()
	{
		//IL_0048: Unknown result type (might be due to invalid IL or missing references)
		//IL_0054: Unknown result type (might be due to invalid IL or missing references)
		//IL_0060: Unknown result type (might be due to invalid IL or missing references)
		//IL_019c: Unknown result type (might be due to invalid IL or missing references)
		if ((Object)(object)mesh == (Object)null)
		{
			return;
		}
		edges.Clear();
		pointers.Clear();
		Vector3[] vertices = mesh.vertices;
		int[] triangles = mesh.triangles;
		for (int i = 0; i < triangles.Length; i += 3)
		{
			if (VectorMath.IsClockwiseXZ(vertices[triangles[i]], vertices[triangles[i + 1]], vertices[triangles[i + 2]]))
			{
				int num = triangles[i];
				triangles[i] = triangles[i + 2];
				triangles[i + 2] = num;
			}
			edges[new Int2(triangles[i], triangles[i + 1])] = i;
			edges[new Int2(triangles[i + 1], triangles[i + 2])] = i;
			edges[new Int2(triangles[i + 2], triangles[i])] = i;
		}
		for (int j = 0; j < triangles.Length; j += 3)
		{
			for (int k = 0; k < 3; k++)
			{
				if (!edges.ContainsKey(new Int2(triangles[j + (k + 1) % 3], triangles[j + k % 3])))
				{
					pointers[triangles[j + k % 3]] = triangles[j + (k + 1) % 3];
				}
			}
		}
		List<Vector3[]> list = new List<Vector3[]>();
		List<Vector3> list2 = ListPool<Vector3>.Claim();
		for (int l = 0; l < vertices.Length; l++)
		{
			if (!pointers.ContainsKey(l))
			{
				continue;
			}
			list2.Clear();
			int num2 = l;
			do
			{
				int num3 = pointers[num2];
				if (num3 == -1)
				{
					break;
				}
				pointers[num2] = -1;
				list2.Add(vertices[num2]);
				num2 = num3;
				if (num2 == -1)
				{
					Debug.LogError((object)("Invalid Mesh '" + ((Object)mesh).name));
					break;
				}
			}
			while (num2 != l);
			if (list2.Count > 0)
			{
				list.Add(list2.ToArray());
			}
		}
		ListPool<Vector3>.Release(list2);
		contours = list.ToArray();
	}

	internal override Rect GetBounds(GraphTransform inverseTranform)
	{
		//IL_000f: Unknown result type (might be due to invalid IL or missing references)
		//IL_00f2: Unknown result type (might be due to invalid IL or missing references)
		//IL_0030: Unknown result type (might be due to invalid IL or missing references)
		//IL_0035: Unknown result type (might be due to invalid IL or missing references)
		//IL_003a: Unknown result type (might be due to invalid IL or missing references)
		//IL_006a: Unknown result type (might be due to invalid IL or missing references)
		//IL_0084: Unknown result type (might be due to invalid IL or missing references)
		//IL_009e: Unknown result type (might be due to invalid IL or missing references)
		//IL_00b8: Unknown result type (might be due to invalid IL or missing references)
		//IL_0042: Unknown result type (might be due to invalid IL or missing references)
		//IL_0049: Unknown result type (might be due to invalid IL or missing references)
		List<List<Vector3>> list = ListPool<List<Vector3>>.Claim();
		GetContour(list);
		Rect result = default(Rect);
		for (int i = 0; i < list.Count; i++)
		{
			List<Vector3> list2 = list[i];
			for (int j = 0; j < list2.Count; j++)
			{
				Vector3 val = inverseTranform.InverseTransform(list2[j]);
				if (j == 0)
				{
					((Rect)(ref result))._002Ector(val.x, val.z, 0f, 0f);
					continue;
				}
				((Rect)(ref result)).xMax = Math.Max(((Rect)(ref result)).xMax, val.x);
				((Rect)(ref result)).yMax = Math.Max(((Rect)(ref result)).yMax, val.z);
				((Rect)(ref result)).xMin = Math.Min(((Rect)(ref result)).xMin, val.x);
				((Rect)(ref result)).yMin = Math.Min(((Rect)(ref result)).yMin, val.z);
			}
		}
		ListPool<List<Vector3>>.Release(list);
		return result;
	}

	public void GetContour(List<List<Vector3>> buffer)
	{
		//IL_004e: Unknown result type (might be due to invalid IL or missing references)
		//IL_0063: Unknown result type (might be due to invalid IL or missing references)
		//IL_006e: Unknown result type (might be due to invalid IL or missing references)
		//IL_007d: Unknown result type (might be due to invalid IL or missing references)
		//IL_00a4: Unknown result type (might be due to invalid IL or missing references)
		//IL_00b9: Unknown result type (might be due to invalid IL or missing references)
		//IL_00c4: Unknown result type (might be due to invalid IL or missing references)
		//IL_00d3: Unknown result type (might be due to invalid IL or missing references)
		//IL_00f9: Unknown result type (might be due to invalid IL or missing references)
		//IL_010e: Unknown result type (might be due to invalid IL or missing references)
		//IL_0119: Unknown result type (might be due to invalid IL or missing references)
		//IL_0128: Unknown result type (might be due to invalid IL or missing references)
		//IL_014f: Unknown result type (might be due to invalid IL or missing references)
		//IL_0164: Unknown result type (might be due to invalid IL or missing references)
		//IL_016f: Unknown result type (might be due to invalid IL or missing references)
		//IL_017e: Unknown result type (might be due to invalid IL or missing references)
		//IL_01d4: Unknown result type (might be due to invalid IL or missing references)
		//IL_01ea: Unknown result type (might be due to invalid IL or missing references)
		//IL_01f5: Unknown result type (might be due to invalid IL or missing references)
		//IL_0204: Unknown result type (might be due to invalid IL or missing references)
		//IL_028a: Unknown result type (might be due to invalid IL or missing references)
		//IL_0295: Unknown result type (might be due to invalid IL or missing references)
		if (circleResolution < 3)
		{
			circleResolution = 3;
		}
		switch (type)
		{
		case MeshType.Rectangle:
		{
			List<Vector3> list = ListPool<Vector3>.Claim();
			list.Add((Vector3)IntMath.Transform((Int3)new Vector3(0f - rectangleSize.x, 0f, 0f - rectangleSize.y) * 0.5f, (Int3)foward, (Int3)center));
			list.Add((Vector3)IntMath.Transform((Int3)new Vector3(rectangleSize.x, 0f, 0f - rectangleSize.y) * 0.5f, (Int3)foward, (Int3)center));
			list.Add((Vector3)IntMath.Transform((Int3)new Vector3(rectangleSize.x, 0f, rectangleSize.y) * 0.5f, (Int3)foward, (Int3)center));
			list.Add((Vector3)IntMath.Transform((Int3)new Vector3(0f - rectangleSize.x, 0f, rectangleSize.y) * 0.5f, (Int3)foward, (Int3)center));
			buffer.Add(list);
			break;
		}
		case MeshType.Circle:
		{
			List<Vector3> list = ListPool<Vector3>.Claim(circleResolution);
			for (int k = 0; k < circleResolution; k++)
			{
				list.Add((Vector3)IntMath.Transform((Int3)new Vector3(Mathf.Cos((float)(k * 2) * MathF.PI / (float)circleResolution), 0f, Mathf.Sin((float)(k * 2) * MathF.PI / (float)circleResolution)) * circleRadius, (Int3)foward, (Int3)center));
			}
			buffer.Add(list);
			break;
		}
		case MeshType.CustomMesh:
		{
			if ((Object)(object)mesh != (Object)(object)lastMesh || contours == null)
			{
				CalculateMeshContour();
				lastMesh = mesh;
			}
			if (contours == null)
			{
				break;
			}
			bool reverse = meshScale < 0f;
			for (int i = 0; i < contours.Length; i++)
			{
				Vector3[] array = contours[i];
				List<Vector3> list = ListPool<Vector3>.Claim(array.Length);
				for (int j = 0; j < array.Length; j++)
				{
					list.Add(array[j] * meshScale);
				}
				TransformBuffer(list, reverse);
				buffer.Add(list);
			}
			break;
		}
		}
	}

	private void TransformBuffer(List<Vector3> buffer, bool reverse)
	{
		//IL_0001: Unknown result type (might be due to invalid IL or missing references)
		//IL_0006: Unknown result type (might be due to invalid IL or missing references)
		//IL_0053: Unknown result type (might be due to invalid IL or missing references)
		//IL_005a: Unknown result type (might be due to invalid IL or missing references)
		//IL_005f: Unknown result type (might be due to invalid IL or missing references)
		//IL_0064: Unknown result type (might be due to invalid IL or missing references)
		//IL_0015: Unknown result type (might be due to invalid IL or missing references)
		//IL_001a: Unknown result type (might be due to invalid IL or missing references)
		//IL_0077: Unknown result type (might be due to invalid IL or missing references)
		//IL_007c: Unknown result type (might be due to invalid IL or missing references)
		//IL_007d: Unknown result type (might be due to invalid IL or missing references)
		//IL_0025: Unknown result type (might be due to invalid IL or missing references)
		//IL_002a: Unknown result type (might be due to invalid IL or missing references)
		//IL_002b: Unknown result type (might be due to invalid IL or missing references)
		//IL_0030: Unknown result type (might be due to invalid IL or missing references)
		//IL_0048: Unknown result type (might be due to invalid IL or missing references)
		Vector3 val = center;
		if (useRotationAndScale)
		{
			Matrix4x4 localToWorldMatrix = tr.localToWorldMatrix;
			for (int i = 0; i < buffer.Count; i++)
			{
				buffer[i] = ((Matrix4x4)(ref localToWorldMatrix)).MultiplyPoint3x4(buffer[i] + val);
			}
			reverse ^= VectorMath.ReversesFaceOrientationsXZ(localToWorldMatrix);
		}
		else
		{
			val += tr.position;
			for (int j = 0; j < buffer.Count; j++)
			{
				int index = j;
				buffer[index] += val;
			}
		}
		if (reverse)
		{
			buffer.Reverse();
		}
	}

	internal float GetY(GraphTransform transform)
	{
		//IL_0012: Unknown result type (might be due to invalid IL or missing references)
		//IL_000a: Unknown result type (might be due to invalid IL or missing references)
		//IL_0017: Unknown result type (might be due to invalid IL or missing references)
		return transform.InverseTransform(useRotationAndScale ? center : center).y;
	}

	public NavmeshCut()
	{
		//IL_000b: Unknown result type (might be due to invalid IL or missing references)
		//IL_0010: Unknown result type (might be due to invalid IL or missing references)
		rectangleSize = new Vector2(1f, 1f);
		circleRadius = 1f;
		circleResolution = 6;
		height = 1f;
		meshScale = 1f;
		updateDistance = 0.4f;
		cutsAddedGeom = true;
		updateRotationDistance = 10f;
		base._002Ector();
	}

	static NavmeshCut()
	{
		//IL_0023: Unknown result type (might be due to invalid IL or missing references)
		//IL_0028: Unknown result type (might be due to invalid IL or missing references)
		edges = new Dictionary<Int2, int>();
		pointers = new Dictionary<int, int>();
		GizmoColor = new Color(0.14509805f, 0.72156864f, 0.9372549f);
	}
}
