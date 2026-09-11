using System;
using Pathfinding.Util;
using UnityEngine;
using UnityEngine.Serialization;

namespace Pathfinding;

[HelpURL("http://arongranberg.com/astar/docs/class_pathfinding_1_1_navmesh_add.php")]
public class NavmeshAdd : NavmeshClipper
{
	public enum MeshType
	{
		Rectangle,
		CustomMesh
	}

	public MeshType type;

	public Mesh mesh;

	private Vector3[] verts;

	private int[] tris;

	public Vector2 rectangleSize;

	public VFactor meshScale;

	public Int3 center;

	[FormerlySerializedAs("useRotation")]
	public bool useRotationAndScale;

	[Tooltip("Distance between positions to require an update of the navmesh\nA smaller distance gives better accuracy, but requires more updates when moving the object over time, so it is often slower.")]
	public float updateDistance;

	[Tooltip("How many degrees rotation that is required for an update to the navmesh. Should be between 0 and 180.")]
	public float updateRotationDistance;

	protected SimTransform tr;

	private Int3 lastPosition;

	private Quaternion lastRotation;

	public Int3 Center
	{
		get
		{
			//IL_0027: Unknown result type (might be due to invalid IL or missing references)
			//IL_002c: Unknown result type (might be due to invalid IL or missing references)
			return tr.position + (useRotationAndScale ? ((Int3)tr.TransformPoint((Vector3)center)) : center);
		}
	}

	public override bool RequiresUpdate()
	{
		//IL_0036: Unknown result type (might be due to invalid IL or missing references)
		//IL_0041: Unknown result type (might be due to invalid IL or missing references)
		if (!((tr.position - lastPosition).sqrMagnitude > updateDistance * updateDistance))
		{
			if (useRotationAndScale)
			{
				return Quaternion.Angle(lastRotation, tr.rotation) > updateRotationDistance;
			}
			return false;
		}
		return true;
	}

	public override void ForceUpdate()
	{
		lastPosition = new Int3(int.MaxValue, int.MaxValue, int.MaxValue);
	}

	internal override void NotifyUpdated()
	{
		//IL_0020: Unknown result type (might be due to invalid IL or missing references)
		//IL_0025: Unknown result type (might be due to invalid IL or missing references)
		lastPosition = tr.position;
		if (useRotationAndScale)
		{
			lastRotation = tr.rotation;
		}
	}

	[ContextMenu("Rebuild Mesh")]
	public void RebuildMesh()
	{
		//IL_00ed: Unknown result type (might be due to invalid IL or missing references)
		//IL_00f2: Unknown result type (might be due to invalid IL or missing references)
		//IL_0126: Unknown result type (might be due to invalid IL or missing references)
		//IL_012b: Unknown result type (might be due to invalid IL or missing references)
		//IL_015e: Unknown result type (might be due to invalid IL or missing references)
		//IL_0163: Unknown result type (might be due to invalid IL or missing references)
		//IL_0197: Unknown result type (might be due to invalid IL or missing references)
		//IL_019c: Unknown result type (might be due to invalid IL or missing references)
		if (type == MeshType.CustomMesh)
		{
			if ((Object)(object)mesh == (Object)null)
			{
				verts = null;
				tris = null;
			}
			else
			{
				verts = mesh.vertices;
				tris = mesh.triangles;
			}
			return;
		}
		if (verts == null || verts.Length != 4 || tris == null || tris.Length != 6)
		{
			verts = (Vector3[])(object)new Vector3[4];
			tris = new int[6];
		}
		tris[0] = 0;
		tris[1] = 1;
		tris[2] = 2;
		tris[3] = 0;
		tris[4] = 2;
		tris[5] = 3;
		verts[0] = new Vector3((0f - rectangleSize.x) * 0.5f, 0f, (0f - rectangleSize.y) * 0.5f);
		verts[1] = new Vector3(rectangleSize.x * 0.5f, 0f, (0f - rectangleSize.y) * 0.5f);
		verts[2] = new Vector3(rectangleSize.x * 0.5f, 0f, rectangleSize.y * 0.5f);
		verts[3] = new Vector3((0f - rectangleSize.x) * 0.5f, 0f, rectangleSize.y * 0.5f);
	}

	internal override Rect GetBounds(GraphTransform inverseTransform)
	{
		//IL_0034: Unknown result type (might be due to invalid IL or missing references)
		//IL_004a: Unknown result type (might be due to invalid IL or missing references)
		//IL_004f: Unknown result type (might be due to invalid IL or missing references)
		//IL_00f2: Unknown result type (might be due to invalid IL or missing references)
		//IL_007e: Unknown result type (might be due to invalid IL or missing references)
		//IL_0098: Unknown result type (might be due to invalid IL or missing references)
		//IL_00b2: Unknown result type (might be due to invalid IL or missing references)
		//IL_00cc: Unknown result type (might be due to invalid IL or missing references)
		//IL_0056: Unknown result type (might be due to invalid IL or missing references)
		//IL_005d: Unknown result type (might be due to invalid IL or missing references)
		if (verts == null)
		{
			RebuildMesh();
		}
		Int3[] vbuffer = ArrayPool<Int3>.Claim((verts != null) ? verts.Length : 0);
		GetMesh(ref vbuffer, out var tbuffer, inverseTransform);
		Rect result = default(Rect);
		for (int i = 0; i < tbuffer.Length; i++)
		{
			Vector3 val = (Vector3)vbuffer[tbuffer[i]];
			if (i == 0)
			{
				((Rect)(ref result))._002Ector(val.x, val.z, 0f, 0f);
				continue;
			}
			((Rect)(ref result)).xMax = Math.Max(((Rect)(ref result)).xMax, val.x);
			((Rect)(ref result)).yMax = Math.Max(((Rect)(ref result)).yMax, val.z);
			((Rect)(ref result)).xMin = Math.Min(((Rect)(ref result)).xMin, val.x);
			((Rect)(ref result)).yMin = Math.Min(((Rect)(ref result)).yMin, val.z);
		}
		ArrayPool<Int3>.Release(ref vbuffer);
		return result;
	}

	public void GetMesh(ref Int3[] vbuffer, out int[] tbuffer, GraphTransform inverseTransform = null)
	{
		//IL_0074: Unknown result type (might be due to invalid IL or missing references)
		//IL_007f: Unknown result type (might be due to invalid IL or missing references)
		//IL_009a: Unknown result type (might be due to invalid IL or missing references)
		//IL_009f: Unknown result type (might be due to invalid IL or missing references)
		//IL_00a4: Unknown result type (might be due to invalid IL or missing references)
		//IL_010b: Unknown result type (might be due to invalid IL or missing references)
		//IL_00b2: Unknown result type (might be due to invalid IL or missing references)
		//IL_00b7: Unknown result type (might be due to invalid IL or missing references)
		//IL_00bc: Unknown result type (might be due to invalid IL or missing references)
		//IL_00cb: Unknown result type (might be due to invalid IL or missing references)
		//IL_00c1: Unknown result type (might be due to invalid IL or missing references)
		//IL_00c2: Unknown result type (might be due to invalid IL or missing references)
		//IL_00c7: Unknown result type (might be due to invalid IL or missing references)
		if (verts == null)
		{
			RebuildMesh();
		}
		if (verts == null)
		{
			tbuffer = ArrayPool<int>.Claim(0);
			return;
		}
		if (vbuffer == null || vbuffer.Length < verts.Length)
		{
			if (vbuffer != null)
			{
				ArrayPool<Int3>.Release(ref vbuffer);
			}
			vbuffer = ArrayPool<Int3>.Claim(verts.Length);
		}
		tbuffer = tris;
		if (useRotationAndScale)
		{
			Matrix4x4 val = Matrix4x4.TRS((Vector3)(tr.position + center), tr.rotation, (Vector3)(tr.localScale * meshScale));
			for (int i = 0; i < verts.Length; i++)
			{
				Vector3 val2 = ((Matrix4x4)(ref val)).MultiplyPoint3x4(verts[i]);
				if (inverseTransform != null)
				{
					val2 = inverseTransform.InverseTransform(val2);
				}
				vbuffer[i] = (Int3)val2;
			}
			return;
		}
		Int3 @int = tr.position + center;
		for (int j = 0; j < verts.Length; j++)
		{
			Int3 int2 = @int + (Int3)verts[j] * meshScale;
			if (inverseTransform != null)
			{
				int2 = inverseTransform.InverseTransform(int2);
			}
			vbuffer[j] = int2;
		}
	}

	public NavmeshAdd()
	{
		//IL_000b: Unknown result type (might be due to invalid IL or missing references)
		//IL_0010: Unknown result type (might be due to invalid IL or missing references)
		rectangleSize = new Vector2(1f, 1f);
		meshScale = new VFactor(1L, 1L);
		updateDistance = 0.4f;
		updateRotationDistance = 10f;
		base._002Ector();
	}
}
