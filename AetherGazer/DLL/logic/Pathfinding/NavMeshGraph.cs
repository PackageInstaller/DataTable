using System;
using System.Collections.Generic;
using Pathfinding.Serialization;
using Pathfinding.Util;
using UnityEngine;

namespace Pathfinding;

[JsonOptIn]
public class NavMeshGraph : NavmeshBase, IUpdatableGraph
{
	[JsonMember]
	public Mesh sourceMesh;

	[JsonMember]
	public Vector3 offset;

	[JsonMember]
	public Vector3 rotation;

	[JsonMember]
	public float scale = 1f;

	public override float TileWorldSizeX => forcedBoundsSize.x;

	public override float TileWorldSizeZ => forcedBoundsSize.z;

	protected override float MaxTileConnectionEdgeDistance => 0f;

	public override GraphTransform CalculateTransform()
	{
		//IL_0001: Unknown result type (might be due to invalid IL or missing references)
		//IL_0007: Unknown result type (might be due to invalid IL or missing references)
		//IL_000c: Unknown result type (might be due to invalid IL or missing references)
		//IL_0011: Unknown result type (might be due to invalid IL or missing references)
		//IL_0016: Unknown result type (might be due to invalid IL or missing references)
		//IL_0036: Unknown result type (might be due to invalid IL or missing references)
		//IL_003b: Unknown result type (might be due to invalid IL or missing references)
		//IL_003e: Unknown result type (might be due to invalid IL or missing references)
		//IL_0049: Unknown result type (might be due to invalid IL or missing references)
		//IL_0029: Unknown result type (might be due to invalid IL or missing references)
		//IL_004e: Unknown result type (might be due to invalid IL or missing references)
		//IL_0053: Unknown result type (might be due to invalid IL or missing references)
		//IL_0058: Unknown result type (might be due to invalid IL or missing references)
		//IL_005d: Unknown result type (might be due to invalid IL or missing references)
		Matrix4x4 val = Matrix4x4.TRS(offset, Quaternion.Euler(rotation), Vector3.one);
		Vector3 val2;
		if (!((Object)(object)sourceMesh != (Object)null))
		{
			val2 = Vector3.zero;
		}
		else
		{
			Bounds bounds = sourceMesh.bounds;
			val2 = ((Bounds)(ref bounds)).min * scale;
		}
		return new GraphTransform(val * Matrix4x4.TRS(val2, Quaternion.identity, Vector3.one));
	}

	public GraphUpdateThreading CanUpdateAsync(GraphUpdateObject o)
	{
		return GraphUpdateThreading.UnityThread;
	}

	public void UpdateAreaInit(GraphUpdateObject o)
	{
	}

	public void UpdateAreaPost(GraphUpdateObject o)
	{
	}

	public void UpdateArea(GraphUpdateObject o)
	{
		UpdateArea(o, this);
	}

	public static void UpdateArea(GraphUpdateObject o, INavmesh graph)
	{
		//IL_0013: Unknown result type (might be due to invalid IL or missing references)
		//IL_0018: Unknown result type (might be due to invalid IL or missing references)
		//IL_001c: Unknown result type (might be due to invalid IL or missing references)
		//IL_0028: Unknown result type (might be due to invalid IL or missing references)
		//IL_0034: Unknown result type (might be due to invalid IL or missing references)
		//IL_0040: Unknown result type (might be due to invalid IL or missing references)
		//IL_004a: Unknown result type (might be due to invalid IL or missing references)
		//IL_004f: Unknown result type (might be due to invalid IL or missing references)
		//IL_0057: Unknown result type (might be due to invalid IL or missing references)
		//IL_006e: Unknown result type (might be due to invalid IL or missing references)
		//IL_0085: Unknown result type (might be due to invalid IL or missing references)
		//IL_009c: Unknown result type (might be due to invalid IL or missing references)
		//IL_0146: Unknown result type (might be due to invalid IL or missing references)
		//IL_015d: Unknown result type (might be due to invalid IL or missing references)
		Bounds bounds = o.bounds;
		Rect rect = Rect.MinMaxRect(((Bounds)(ref bounds)).min.x, ((Bounds)(ref bounds)).min.z, ((Bounds)(ref bounds)).max.x, ((Bounds)(ref bounds)).max.z);
		IntRect irect = new IntRect(Mathf.FloorToInt(((Bounds)(ref bounds)).min.x * 1000f), Mathf.FloorToInt(((Bounds)(ref bounds)).min.z * 1000f), Mathf.FloorToInt(((Bounds)(ref bounds)).max.x * 1000f), Mathf.FloorToInt(((Bounds)(ref bounds)).max.z * 1000f));
		Int3 a = new Int3(irect.xmin, 0, irect.ymin);
		Int3 b = new Int3(irect.xmin, 0, irect.ymax);
		Int3 c = new Int3(irect.xmax, 0, irect.ymin);
		Int3 d = new Int3(irect.xmax, 0, irect.ymax);
		int ymin = ((Int3)((Bounds)(ref bounds)).min).y;
		int ymax = ((Int3)((Bounds)(ref bounds)).max).y;
		graph.GetNodes(delegate(GraphNode _node)
		{
			//IL_0027: Unknown result type (might be due to invalid IL or missing references)
			//IL_002c: Unknown result type (might be due to invalid IL or missing references)
			//IL_004d: Unknown result type (might be due to invalid IL or missing references)
			//IL_0065: Unknown result type (might be due to invalid IL or missing references)
			//IL_007d: Unknown result type (might be due to invalid IL or missing references)
			//IL_0097: Unknown result type (might be due to invalid IL or missing references)
			TriangleMeshNode triangleMeshNode = _node as TriangleMeshNode;
			bool flag = false;
			int num = 0;
			int num2 = 0;
			int num3 = 0;
			int num4 = 0;
			for (int i = 0; i < 3; i++)
			{
				Int3 vertex = triangleMeshNode.GetVertex(i);
				Vector3 val = (Vector3)vertex;
				if (irect.Contains(vertex.x, vertex.z))
				{
					flag = true;
					break;
				}
				if (val.x < ((Rect)(ref rect)).xMin)
				{
					num++;
				}
				if (val.x > ((Rect)(ref rect)).xMax)
				{
					num2++;
				}
				if (val.z < ((Rect)(ref rect)).yMin)
				{
					num3++;
				}
				if (val.z > ((Rect)(ref rect)).yMax)
				{
					num4++;
				}
			}
			if (flag || (num != 3 && num2 != 3 && num3 != 3 && num4 != 3))
			{
				for (int j = 0; j < 3; j++)
				{
					int i2 = ((j <= 1) ? (j + 1) : 0);
					Int3 vertex2 = triangleMeshNode.GetVertex(j);
					Int3 vertex3 = triangleMeshNode.GetVertex(i2);
					if (VectorMath.SegmentsIntersectXZ(a, b, vertex2, vertex3))
					{
						flag = true;
						break;
					}
					if (VectorMath.SegmentsIntersectXZ(a, c, vertex2, vertex3))
					{
						flag = true;
						break;
					}
					if (VectorMath.SegmentsIntersectXZ(c, d, vertex2, vertex3))
					{
						flag = true;
						break;
					}
					if (VectorMath.SegmentsIntersectXZ(d, b, vertex2, vertex3))
					{
						flag = true;
						break;
					}
				}
				if (flag || triangleMeshNode.ContainsPoint(a) || triangleMeshNode.ContainsPoint(b) || triangleMeshNode.ContainsPoint(c) || triangleMeshNode.ContainsPoint(d))
				{
					flag = true;
				}
				if (flag)
				{
					int num5 = 0;
					int num6 = 0;
					for (int k = 0; k < 3; k++)
					{
						Int3 vertex4 = triangleMeshNode.GetVertex(k);
						if (vertex4.y < ymin)
						{
							num6++;
						}
						if (vertex4.y > ymax)
						{
							num5++;
						}
					}
					if (num6 != 3 && num5 != 3)
					{
						o.WillUpdateNode(triangleMeshNode);
						o.Apply(triangleMeshNode);
					}
				}
			}
		});
	}

	[Obsolete("Set the mesh to ObjImporter.ImportFile(...) and scan the graph the normal way instead")]
	public void ScanInternal(string objMeshPath)
	{
		Mesh val = ObjImporter.ImportFile(objMeshPath);
		if ((Object)(object)val == (Object)null)
		{
			Debug.LogError((object)("Couldn't read .obj file at '" + objMeshPath + "'"));
			return;
		}
		sourceMesh = val;
		IEnumerator<Progress> enumerator = ScanInternal().GetEnumerator();
		while (enumerator.MoveNext())
		{
		}
	}

	public override IEnumerable<Progress> ScanInternal()
	{
		transform = CalculateTransform();
		NavMeshGraph navMeshGraph = this;
		NavMeshGraph navMeshGraph2 = this;
		int num = 1;
		navMeshGraph2.tileXCount = 1;
		navMeshGraph.tileZCount = num;
		tiles = new NavmeshTile[tileZCount * tileXCount];
		TriangleMeshNode.SetNavmeshHolder(AstarPath.active.data.GetGraphIndex(this), this);
		if ((Object)(object)sourceMesh == (Object)null)
		{
			FillWithEmptyTiles();
			yield break;
		}
		yield return new Progress(0f, "Transforming Vertices");
		NavMeshGraph navMeshGraph3 = this;
		Bounds bounds = sourceMesh.bounds;
		navMeshGraph3.forcedBoundsSize = ((Bounds)(ref bounds)).size * scale;
		Vector3[] vertices = sourceMesh.vertices;
		List<Int3> intVertices = ListPool<Int3>.Claim(vertices.Length);
		bounds = sourceMesh.bounds;
		Matrix4x4 val = Matrix4x4.TRS(-((Bounds)(ref bounds)).min * scale, Quaternion.identity, Vector3.one * scale);
		for (int i = 0; i < vertices.Length; i++)
		{
			intVertices.Add((Int3)((Matrix4x4)(ref val)).MultiplyPoint3x4(vertices[i]));
		}
		yield return new Progress(0.1f, "Compressing Vertices");
		Int3[] compressedVertices = null;
		int[] compressedTriangles = null;
		Polygon.CompressMesh(intVertices, new List<int>(sourceMesh.triangles), out compressedVertices, out compressedTriangles);
		ListPool<Int3>.Release(intVertices);
		yield return new Progress(0.2f, "Building Nodes");
		ReplaceTile(0, 0, compressedVertices, compressedTriangles);
		if (OnRecalculatedTiles != null)
		{
			OnRecalculatedTiles(tiles.Clone() as NavmeshTile[]);
		}
	}

	public override void DeserializeSettingsCompatibility(GraphSerializationContext ctx)
	{
		//IL_001a: Unknown result type (might be due to invalid IL or missing references)
		//IL_001f: Unknown result type (might be due to invalid IL or missing references)
		//IL_0026: Unknown result type (might be due to invalid IL or missing references)
		//IL_002b: Unknown result type (might be due to invalid IL or missing references)
		base.DeserializeSettingsCompatibility(ctx);
		Object obj = ctx.DeserializeUnityObject();
		sourceMesh = (Mesh)(object)((obj is Mesh) ? obj : null);
		offset = ctx.DeserializeVector3();
		rotation = ctx.DeserializeVector3();
		scale = ctx.reader.ReadSingle();
		nearestSearchOnlyXZ = !ctx.reader.ReadBoolean();
	}
}
