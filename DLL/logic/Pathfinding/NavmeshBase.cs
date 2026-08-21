using System;
using System.Collections.Generic;
using System.IO;
using Pathfinding.Serialization;
using Pathfinding.Util;
using UnityEngine;

namespace Pathfinding;

public abstract class NavmeshBase : NavGraph, INavmesh, INavmeshHolder, ITransformedGraph, IRaycastableGraph
{
	public const int VertexIndexMask = 4095;

	public const int TileIndexMask = 524287;

	public const int TileIndexOffset = 12;

	[JsonMember]
	public Vector3 forcedBoundsSize;

	[JsonMember]
	public bool showMeshOutline;

	[JsonMember]
	public bool showNodeConnections;

	[JsonMember]
	public bool showMeshSurface;

	public int tileXCount;

	public int tileZCount;

	protected NavmeshTile[] tiles;

	public TileHandler mTileHandler;

	[JsonMember]
	public bool nearestSearchOnlyXZ;

	private bool batchTileUpdate;

	private List<int> batchUpdatedTiles;

	public GraphTransform transform;

	public Action<NavmeshTile[]> OnRecalculatedTiles;

	private static readonly NNConstraint NNConstraintDistanceXZ = new NNConstraint
	{
		distanceXZ = true
	};

	public abstract float TileWorldSizeX { get; }

	public abstract float TileWorldSizeZ { get; }

	protected abstract float MaxTileConnectionEdgeDistance { get; }

	GraphTransform ITransformedGraph.transform => transform;

	public abstract GraphTransform CalculateTransform();

	public NavmeshTile GetTile(int x, int z)
	{
		return tiles[x + z * tileXCount];
	}

	public Int3 GetVertex(int index)
	{
		int num = (index >> 12) & 0x7FFFF;
		return tiles[num].GetVertex(index);
	}

	public Int3 GetVertexInGraphSpace(int index)
	{
		int num = (index >> 12) & 0x7FFFF;
		return tiles[num].GetVertexInGraphSpace(index);
	}

	public static int GetTileIndex(int index)
	{
		return (index >> 12) & 0x7FFFF;
	}

	public int GetVertexArrayIndex(int index)
	{
		return index & 0xFFF;
	}

	public void GetTileCoordinates(int tileIndex, out int x, out int z)
	{
		z = tileIndex / tileXCount;
		x = tileIndex - z * tileXCount;
	}

	public NavmeshTile[] GetTiles()
	{
		return tiles;
	}

	public Bounds GetTileBounds(IntRect rect)
	{
		//IL_001b: Unknown result type (might be due to invalid IL or missing references)
		return GetTileBounds(rect.xmin, rect.ymin, rect.Width, rect.Height);
	}

	public Bounds GetTileBounds(int x, int z, int width = 1, int depth = 1)
	{
		//IL_000c: Unknown result type (might be due to invalid IL or missing references)
		//IL_0011: Unknown result type (might be due to invalid IL or missing references)
		return transform.Transform(GetTileBoundsInGraphSpace(x, z, width, depth));
	}

	public Bounds GetTileBoundsInGraphSpace(IntRect rect)
	{
		//IL_001b: Unknown result type (might be due to invalid IL or missing references)
		return GetTileBoundsInGraphSpace(rect.xmin, rect.ymin, rect.Width, rect.Height);
	}

	public Bounds GetTileBoundsInGraphSpace(int x, int z, int width = 1, int depth = 1)
	{
		//IL_0002: Unknown result type (might be due to invalid IL or missing references)
		//IL_0021: Unknown result type (might be due to invalid IL or missing references)
		//IL_0048: Unknown result type (might be due to invalid IL or missing references)
		//IL_0052: Unknown result type (might be due to invalid IL or missing references)
		Bounds result = default(Bounds);
		((Bounds)(ref result)).SetMinMax(new Vector3((float)x * TileWorldSizeX, 0f, (float)z * TileWorldSizeZ), new Vector3((float)(x + width) * TileWorldSizeX, forcedBoundsSize.y, (float)(z + depth) * TileWorldSizeZ));
		return result;
	}

	public Int2 GetTileCoordinates(Int3 p)
	{
		p = transform.InverseTransform(p);
		p.x /= (int)Math.Round(TileWorldSizeX * 1000f);
		p.z /= (int)Math.Round(TileWorldSizeZ * 1000f);
		return new Int2(p.x, p.z);
	}

	public override void OnDestroy()
	{
		base.OnDestroy();
		TriangleMeshNode.SetNavmeshHolder(active.data.GetGraphIndex(this), null);
		if (tiles != null)
		{
			for (int i = 0; i < tiles.Length; i++)
			{
				ObjectPool<BBTree>.Release(ref tiles[i].bbTree);
			}
		}
	}

	public override void RelocateNodes(Matrix4x4 deltaMatrix)
	{
		//IL_0001: Unknown result type (might be due to invalid IL or missing references)
		RelocateNodes(deltaMatrix * transform);
	}

	public void RelocateNodes(GraphTransform newTransform)
	{
		transform = newTransform;
		if (tiles == null)
		{
			return;
		}
		for (int i = 0; i < tiles.Length; i++)
		{
			NavmeshTile navmeshTile = tiles[i];
			if (navmeshTile != null)
			{
				navmeshTile.vertsInGraphSpace.CopyTo(navmeshTile.verts, 0);
				transform.Transform(navmeshTile.verts);
				for (int j = 0; j < navmeshTile.nodes.Length; j++)
				{
					navmeshTile.nodes[j].UpdatePositionFromVertices();
				}
				navmeshTile.bbTree.RebuildFrom(navmeshTile.nodes);
			}
		}
	}

	protected static NavmeshTile NewEmptyTile(int x, int z)
	{
		NavmeshTile navmeshTile = new NavmeshTile();
		navmeshTile.x = x;
		navmeshTile.z = z;
		navmeshTile.w = 1;
		navmeshTile.d = 1;
		navmeshTile.verts = new Int3[0];
		navmeshTile.vertsInGraphSpace = new Int3[0];
		navmeshTile.tris = new int[0];
		navmeshTile.nodes = new TriangleMeshNode[0];
		navmeshTile.bbTree = ObjectPool<BBTree>.Claim();
		return navmeshTile;
	}

	public override void GetNodes(Action<GraphNode> action)
	{
		if (tiles == null)
		{
			return;
		}
		for (int i = 0; i < tiles.Length; i++)
		{
			if (tiles[i] == null || tiles[i].x + tiles[i].z * tileXCount != i)
			{
				continue;
			}
			TriangleMeshNode[] nodes = tiles[i].nodes;
			if (nodes != null)
			{
				for (int j = 0; j < nodes.Length; j++)
				{
					action(nodes[j]);
				}
			}
		}
	}

	public IntRect GetTouchingTiles(Bounds bounds)
	{
		//IL_0006: Unknown result type (might be due to invalid IL or missing references)
		//IL_0007: Unknown result type (might be due to invalid IL or missing references)
		//IL_000c: Unknown result type (might be due to invalid IL or missing references)
		//IL_0012: Unknown result type (might be due to invalid IL or missing references)
		//IL_002a: Unknown result type (might be due to invalid IL or missing references)
		//IL_0042: Unknown result type (might be due to invalid IL or missing references)
		//IL_005a: Unknown result type (might be due to invalid IL or missing references)
		bounds = transform.InverseTransform(bounds);
		IntRect a = new IntRect(Mathf.FloorToInt(((Bounds)(ref bounds)).min.x / TileWorldSizeX), Mathf.FloorToInt(((Bounds)(ref bounds)).min.z / TileWorldSizeZ), Mathf.FloorToInt(((Bounds)(ref bounds)).max.x / TileWorldSizeX), Mathf.FloorToInt(((Bounds)(ref bounds)).max.z / TileWorldSizeZ));
		return IntRect.Intersection(a, new IntRect(0, 0, tileXCount - 1, tileZCount - 1));
	}

	public IntRect GetTouchingTilesInGraphSpace(Rect rect)
	{
		IntRect a = new IntRect(Mathf.FloorToInt(((Rect)(ref rect)).xMin / TileWorldSizeX), Mathf.FloorToInt(((Rect)(ref rect)).yMin / TileWorldSizeZ), Mathf.FloorToInt(((Rect)(ref rect)).xMax / TileWorldSizeX), Mathf.FloorToInt(((Rect)(ref rect)).yMax / TileWorldSizeZ));
		return IntRect.Intersection(a, new IntRect(0, 0, tileXCount - 1, tileZCount - 1));
	}

	public IntRect GetTouchingTilesRound(Bounds bounds)
	{
		//IL_0006: Unknown result type (might be due to invalid IL or missing references)
		//IL_0007: Unknown result type (might be due to invalid IL or missing references)
		//IL_000c: Unknown result type (might be due to invalid IL or missing references)
		//IL_0012: Unknown result type (might be due to invalid IL or missing references)
		//IL_002a: Unknown result type (might be due to invalid IL or missing references)
		//IL_0042: Unknown result type (might be due to invalid IL or missing references)
		//IL_005c: Unknown result type (might be due to invalid IL or missing references)
		bounds = transform.InverseTransform(bounds);
		IntRect a = new IntRect(Mathf.RoundToInt(((Bounds)(ref bounds)).min.x / TileWorldSizeX), Mathf.RoundToInt(((Bounds)(ref bounds)).min.z / TileWorldSizeZ), Mathf.RoundToInt(((Bounds)(ref bounds)).max.x / TileWorldSizeX) - 1, Mathf.RoundToInt(((Bounds)(ref bounds)).max.z / TileWorldSizeZ) - 1);
		return IntRect.Intersection(a, new IntRect(0, 0, tileXCount - 1, tileZCount - 1));
	}

	protected void ConnectTileWithNeighbours(NavmeshTile tile, bool onlyUnflagged = false)
	{
		if (tile.w != 1 || tile.d != 1)
		{
			throw new ArgumentException("Tile widths or depths other than 1 are not supported. The fields exist mainly for possible future expansions.");
		}
		for (int i = -1; i <= 1; i++)
		{
			int num = tile.z + i;
			if (num < 0 || num >= tileZCount)
			{
				continue;
			}
			for (int j = -1; j <= 1; j++)
			{
				int num2 = tile.x + j;
				if (num2 >= 0 && num2 < tileXCount && j == 0 != (i == 0))
				{
					NavmeshTile navmeshTile = tiles[num2 + num * tileXCount];
					if (!onlyUnflagged || !navmeshTile.flag)
					{
						ConnectTiles(navmeshTile, tile);
					}
				}
			}
		}
	}

	protected void RemoveConnectionsFromTile(NavmeshTile tile)
	{
		if (tile.x > 0)
		{
			int num = tile.x - 1;
			for (int i = tile.z; i < tile.z + tile.d; i++)
			{
				RemoveConnectionsFromTo(tiles[num + i * tileXCount], tile);
			}
		}
		if (tile.x + tile.w < tileXCount)
		{
			int num2 = tile.x + tile.w;
			for (int j = tile.z; j < tile.z + tile.d; j++)
			{
				RemoveConnectionsFromTo(tiles[num2 + j * tileXCount], tile);
			}
		}
		if (tile.z > 0)
		{
			int num3 = tile.z - 1;
			for (int k = tile.x; k < tile.x + tile.w; k++)
			{
				RemoveConnectionsFromTo(tiles[k + num3 * tileXCount], tile);
			}
		}
		if (tile.z + tile.d < tileZCount)
		{
			int num4 = tile.z + tile.d;
			for (int l = tile.x; l < tile.x + tile.w; l++)
			{
				RemoveConnectionsFromTo(tiles[l + num4 * tileXCount], tile);
			}
		}
	}

	protected void RemoveConnectionsFromTo(NavmeshTile a, NavmeshTile b)
	{
		if (a == null || b == null || a == b)
		{
			return;
		}
		int num = b.x + b.z * tileXCount;
		for (int i = 0; i < a.nodes.Length; i++)
		{
			TriangleMeshNode triangleMeshNode = a.nodes[i];
			if (triangleMeshNode.connections == null)
			{
				continue;
			}
			for (int j = 0; j < triangleMeshNode.connections.Length; j++)
			{
				if (triangleMeshNode.connections[j].node is TriangleMeshNode triangleMeshNode2)
				{
					int vertexIndex = triangleMeshNode2.GetVertexIndex(0);
					vertexIndex = (vertexIndex >> 12) & 0x7FFFF;
					if (vertexIndex == num)
					{
						triangleMeshNode.RemoveConnection(triangleMeshNode.connections[j].node);
						j--;
					}
				}
			}
		}
	}

	public override NNInfoInternal GetNearest(Int3 position, NNConstraint constraint, GraphNode hint)
	{
		return GetNearestForce(position, (constraint != null && constraint.distanceXZ) ? NNConstraintDistanceXZ : null);
	}

	public override NNInfoInternal GetNearestForce(Int3 position, NNConstraint constraint)
	{
		if (tiles == null)
		{
			return default(NNInfoInternal);
		}
		Int2 tileCoordinates = GetTileCoordinates(position);
		tileCoordinates.x = Mathf.Clamp(tileCoordinates.x, 0, tileXCount - 1);
		tileCoordinates.y = Mathf.Clamp(tileCoordinates.y, 0, tileZCount - 1);
		int num = Math.Max(tileXCount, tileZCount);
		NNInfoInternal nNInfoInternal = default(NNInfoInternal);
		long distance = 2147483647L;
		bool flag = nearestSearchOnlyXZ || (constraint?.distanceXZ ?? false);
		for (int i = 0; i < num && !((float)distance < (float)(i - 2) * Math.Max(TileWorldSizeX, TileWorldSizeX)); i++)
		{
			int num2 = Math.Min(i + tileCoordinates.y + 1, tileZCount);
			for (int j = Math.Max(-i + tileCoordinates.y, 0); j < num2; j++)
			{
				int num3 = Math.Abs(i - Math.Abs(j - tileCoordinates.y));
				int num4 = num3;
				do
				{
					int num5 = -num4 + tileCoordinates.x;
					if (num5 >= 0 && num5 < tileXCount)
					{
						NavmeshTile navmeshTile = tiles[num5 + j * tileXCount];
						if (navmeshTile != null)
						{
							nNInfoInternal = ((!flag) ? navmeshTile.bbTree.QueryClosest(position, constraint, ref distance, nNInfoInternal) : navmeshTile.bbTree.QueryClosestXZ(position, constraint, ref distance, nNInfoInternal));
						}
					}
					num4 = -num4;
				}
				while (num4 != num3);
			}
		}
		nNInfoInternal.node = nNInfoInternal.constrainedNode;
		nNInfoInternal.constrainedNode = null;
		nNInfoInternal.clampedPosition = nNInfoInternal.constClampedPosition;
		return nNInfoInternal;
	}

	public GraphNode PointOnNavmesh(Int3 position, NNConstraint constraint)
	{
		if (tiles == null)
		{
			return null;
		}
		Int2 tileCoordinates = GetTileCoordinates(position);
		if (tileCoordinates.x < 0 || tileCoordinates.y < 0 || tileCoordinates.x >= tileXCount || tileCoordinates.y >= tileZCount)
		{
			return null;
		}
		return GetTile(tileCoordinates.x, tileCoordinates.y)?.bbTree.QueryInside(position, constraint);
	}

	protected void FillWithEmptyTiles()
	{
		for (int i = 0; i < tileZCount; i++)
		{
			for (int j = 0; j < tileXCount; j++)
			{
				tiles[i * tileXCount + j] = NewEmptyTile(j, i);
			}
		}
	}

	protected static void CreateNodeConnections(TriangleMeshNode[] nodes)
	{
		List<Connection> list = ListPool<Connection>.Claim();
		Dictionary<Int2, int> obj = ObjectPoolSimple<Dictionary<Int2, int>>.Claim();
		obj.Clear();
		for (int i = 0; i < nodes.Length; i++)
		{
			TriangleMeshNode triangleMeshNode = nodes[i];
			int vertexCount = triangleMeshNode.GetVertexCount();
			for (int j = 0; j < vertexCount; j++)
			{
				Int2 key = new Int2(triangleMeshNode.GetVertexIndex(j), triangleMeshNode.GetVertexIndex((j + 1) % vertexCount));
				if (!obj.ContainsKey(key))
				{
					obj.Add(key, i);
				}
			}
		}
		foreach (TriangleMeshNode triangleMeshNode2 in nodes)
		{
			list.Clear();
			int vertexCount2 = triangleMeshNode2.GetVertexCount();
			for (int l = 0; l < vertexCount2; l++)
			{
				int vertexIndex = triangleMeshNode2.GetVertexIndex(l);
				int vertexIndex2 = triangleMeshNode2.GetVertexIndex((l + 1) % vertexCount2);
				if (!obj.TryGetValue(new Int2(vertexIndex2, vertexIndex), out var value))
				{
					continue;
				}
				TriangleMeshNode triangleMeshNode3 = nodes[value];
				int vertexCount3 = triangleMeshNode3.GetVertexCount();
				for (int m = 0; m < vertexCount3; m++)
				{
					if (triangleMeshNode3.GetVertexIndex(m) == vertexIndex2 && triangleMeshNode3.GetVertexIndex((m + 1) % vertexCount3) == vertexIndex)
					{
						list.Add(new Connection
						{
							node = triangleMeshNode3,
							cost = (uint)(triangleMeshNode2.position - triangleMeshNode3.position).costMagnitude
						});
						break;
					}
				}
			}
			triangleMeshNode2.connections = list.ToArrayFromPool();
		}
		obj.Clear();
		ObjectPoolSimple<Dictionary<Int2, int>>.Release(ref obj);
		ListPool<Connection>.Release(list);
	}

	protected void ConnectTiles(NavmeshTile tile1, NavmeshTile tile2)
	{
		if (tile1 == null || tile2 == null)
		{
			return;
		}
		if (tile1.nodes == null)
		{
			throw new ArgumentException("tile1 does not contain any nodes");
		}
		if (tile2.nodes == null)
		{
			throw new ArgumentException("tile2 does not contain any nodes");
		}
		int num = Mathf.Clamp(tile2.x, tile1.x, tile1.x + tile1.w - 1);
		int num2 = Mathf.Clamp(tile1.x, tile2.x, tile2.x + tile2.w - 1);
		int num3 = Mathf.Clamp(tile2.z, tile1.z, tile1.z + tile1.d - 1);
		int num4 = Mathf.Clamp(tile1.z, tile2.z, tile2.z + tile2.d - 1);
		int i;
		int i2;
		int num5;
		int num6;
		float num7;
		if (num == num2)
		{
			i = 2;
			i2 = 0;
			num5 = num3;
			num6 = num4;
			num7 = TileWorldSizeZ;
		}
		else
		{
			if (num3 != num4)
			{
				throw new ArgumentException("Tiles are not adjacent (neither x or z coordinates match)");
			}
			i = 0;
			i2 = 2;
			num5 = num;
			num6 = num2;
			num7 = TileWorldSizeX;
		}
		if (Math.Abs(num5 - num6) != 1)
		{
			throw new ArgumentException("Tiles are not adjacent (tile coordinates must differ by exactly 1. Got '" + num5 + "' and '" + num6 + "')");
		}
		int num8 = (int)Math.Round((float)Math.Max(num5, num6) * num7 * 1000f);
		TriangleMeshNode[] nodes = tile1.nodes;
		TriangleMeshNode[] nodes2 = tile2.nodes;
		foreach (TriangleMeshNode triangleMeshNode in nodes)
		{
			int vertexCount = triangleMeshNode.GetVertexCount();
			for (int k = 0; k < vertexCount; k++)
			{
				Int3 vertexInGraphSpace = triangleMeshNode.GetVertexInGraphSpace(k);
				Int3 vertexInGraphSpace2 = triangleMeshNode.GetVertexInGraphSpace((k + 1) % vertexCount);
				if (Math.Abs(vertexInGraphSpace[i] - num8) >= 2 || Math.Abs(vertexInGraphSpace2[i] - num8) >= 2)
				{
					continue;
				}
				int num9 = Math.Min(vertexInGraphSpace[i2], vertexInGraphSpace2[i2]);
				int num10 = Math.Max(vertexInGraphSpace[i2], vertexInGraphSpace2[i2]);
				if (num9 == num10)
				{
					continue;
				}
				foreach (TriangleMeshNode triangleMeshNode2 in nodes2)
				{
					int vertexCount2 = triangleMeshNode2.GetVertexCount();
					for (int m = 0; m < vertexCount2; m++)
					{
						Int3 vertexInGraphSpace3 = triangleMeshNode2.GetVertexInGraphSpace(m);
						Int3 vertexInGraphSpace4 = triangleMeshNode2.GetVertexInGraphSpace((m + 1) % vertexCount);
						if (Math.Abs(vertexInGraphSpace3[i] - num8) < 2 && Math.Abs(vertexInGraphSpace4[i] - num8) < 2)
						{
							int num11 = Math.Min(vertexInGraphSpace3[i2], vertexInGraphSpace4[i2]);
							int num12 = Math.Max(vertexInGraphSpace3[i2], vertexInGraphSpace4[i2]);
							if (num11 != num12 && num10 > num11 && num9 < num12)
							{
								uint costMagnitude = (uint)(triangleMeshNode.position - triangleMeshNode2.position).costMagnitude;
								triangleMeshNode.AddConnection(triangleMeshNode2, costMagnitude);
								triangleMeshNode2.AddConnection(triangleMeshNode, costMagnitude);
							}
						}
					}
				}
			}
		}
	}

	public void StartBatchTileUpdate()
	{
		if (batchTileUpdate)
		{
			throw new InvalidOperationException("Calling StartBatchLoad when batching is already enabled");
		}
		batchTileUpdate = true;
	}

	public void EndBatchTileUpdate()
	{
		if (!batchTileUpdate)
		{
			throw new InvalidOperationException("Calling EndBatchLoad when batching not enabled");
		}
		batchTileUpdate = false;
		int num = tileXCount;
		int num2 = tileZCount;
		for (int i = 0; i < num2; i++)
		{
			for (int j = 0; j < num; j++)
			{
				tiles[j + i * tileXCount].flag = false;
			}
		}
		for (int k = 0; k < batchUpdatedTiles.Count; k++)
		{
			tiles[batchUpdatedTiles[k]].flag = true;
		}
		for (int l = 0; l < num2; l++)
		{
			for (int m = 0; m < num; m++)
			{
				if (m < num - 1 && (tiles[m + l * tileXCount].flag || tiles[m + 1 + l * tileXCount].flag) && tiles[m + l * tileXCount] != tiles[m + 1 + l * tileXCount])
				{
					ConnectTiles(tiles[m + l * tileXCount], tiles[m + 1 + l * tileXCount]);
				}
				if (l < num2 - 1 && (tiles[m + l * tileXCount].flag || tiles[m + (l + 1) * tileXCount].flag) && tiles[m + l * tileXCount] != tiles[m + (l + 1) * tileXCount])
				{
					ConnectTiles(tiles[m + l * tileXCount], tiles[m + (l + 1) * tileXCount]);
				}
			}
		}
		batchUpdatedTiles.Clear();
	}

	protected void ClearTiles(int x, int z, int w, int d)
	{
		for (int i = z; i < z + d; i++)
		{
			for (int j = x; j < x + w; j++)
			{
				int num = j + i * tileXCount;
				NavmeshTile navmeshTile = tiles[num];
				if (navmeshTile == null)
				{
					continue;
				}
				navmeshTile.Destroy();
				for (int k = navmeshTile.z; k < navmeshTile.z + navmeshTile.d; k++)
				{
					for (int l = navmeshTile.x; l < navmeshTile.x + navmeshTile.w; l++)
					{
						NavmeshTile navmeshTile2 = tiles[l + k * tileXCount];
						if (navmeshTile2 == null || navmeshTile2 != navmeshTile)
						{
							throw new Exception("This should not happen");
						}
						if (k < z || k >= z + d || l < x || l >= x + w)
						{
							tiles[l + k * tileXCount] = NewEmptyTile(l, k);
							if (batchTileUpdate)
							{
								batchUpdatedTiles.Add(l + k * tileXCount);
							}
						}
						else
						{
							tiles[l + k * tileXCount] = null;
						}
					}
				}
			}
		}
	}

	public void ReplaceTile(int x, int z, Int3[] verts, int[] tris)
	{
		ReplaceTile(x, z, 1, 1, verts, tris);
	}

	public void ReplaceTile(int x, int z, int w, int d, Int3[] verts, int[] tris)
	{
		//IL_01cd: Unknown result type (might be due to invalid IL or missing references)
		if (x + w > tileXCount || z + d > tileZCount || x < 0 || z < 0)
		{
			throw new ArgumentException("Tile is placed at an out of bounds position or extends out of the graph bounds (" + x + ", " + z + " [" + w + ", " + d + "] " + tileXCount + " " + tileZCount + ")");
		}
		if (w < 1 || d < 1)
		{
			throw new ArgumentException("width and depth must be greater or equal to 1. Was " + w + ", " + d);
		}
		if (tris.Length % 3 != 0)
		{
			throw new ArgumentException("Triangle array's length must be a multiple of 3 (tris)");
		}
		if (verts.Length > 65535)
		{
			throw new ArgumentException("Too many vertices per tile (more than 65535). Try using a smaller tile size.");
		}
		ClearTiles(x, z, w, d);
		NavmeshTile navmeshTile = new NavmeshTile
		{
			x = x,
			z = z,
			w = w,
			d = d,
			tris = tris,
			bbTree = ObjectPool<BBTree>.Claim()
		};
		if (!Mathf.Approximately((float)x * TileWorldSizeX * 1000f, (float)Math.Round((float)x * TileWorldSizeX * 1000f)))
		{
			Debug.LogWarning((object)"Possible numerical imprecision. Consider adjusting tileSize and/or cellSize");
		}
		if (!Mathf.Approximately((float)z * TileWorldSizeZ * 1000f, (float)Math.Round((float)z * TileWorldSizeZ * 1000f)))
		{
			Debug.LogWarning((object)"Possible numerical imprecision. Consider adjusting tileSize and/or cellSize");
		}
		Int3 @int = (Int3)new Vector3((float)x * TileWorldSizeX, 0f, (float)z * TileWorldSizeZ);
		for (int i = 0; i < verts.Length; i++)
		{
			verts[i] += @int;
		}
		navmeshTile.vertsInGraphSpace = verts;
		navmeshTile.verts = (Int3[])verts.Clone();
		transform.Transform(navmeshTile.verts);
		int num = AstarPath.active.data.graphs.Length;
		TriangleMeshNode.SetNavmeshHolder(num, navmeshTile);
		int num2 = x + z * tileXCount;
		num2 <<= 12;
		if (navmeshTile.verts.Length > 4095)
		{
			Debug.LogError((object)("Too many vertices in the tile (" + navmeshTile.verts.Length + " > " + 4095 + ")\nYou can enable ASTAR_RECAST_LARGER_TILES under the 'Optimizations' tab in the A* Inspector to raise this limit."));
			tiles[num2] = NewEmptyTile(x, z);
			return;
		}
		TriangleMeshNode[] array = (navmeshTile.nodes = CreateNodes(navmeshTile.tris, num2, (uint)num));
		navmeshTile.bbTree.RebuildFrom(array);
		CreateNodeConnections(navmeshTile.nodes);
		for (int j = z; j < z + d; j++)
		{
			for (int k = x; k < x + w; k++)
			{
				tiles[k + j * tileXCount] = navmeshTile;
			}
		}
		if (batchTileUpdate)
		{
			batchUpdatedTiles.Add(x + z * tileXCount);
		}
		else
		{
			ConnectTileWithNeighbours(navmeshTile);
		}
		TriangleMeshNode.SetNavmeshHolder(num, null);
		num = AstarPath.active.data.GetGraphIndex(this);
		for (int l = 0; l < array.Length; l++)
		{
			array[l].GraphIndex = (uint)num;
		}
	}

	protected TriangleMeshNode[] CreateNodes(int[] tris, int tileIndex, uint graphIndex)
	{
		TriangleMeshNode[] array = new TriangleMeshNode[tris.Length / 3];
		for (int i = 0; i < array.Length; i++)
		{
			TriangleMeshNode triangleMeshNode = (array[i] = new TriangleMeshNode(active));
			triangleMeshNode.GraphIndex = graphIndex;
			triangleMeshNode.v0 = tris[i * 3] | tileIndex;
			triangleMeshNode.v1 = tris[i * 3 + 1] | tileIndex;
			triangleMeshNode.v2 = tris[i * 3 + 2] | tileIndex;
			if (!VectorMath.IsClockwiseXZ(triangleMeshNode.GetVertexInGraphSpace(0), triangleMeshNode.GetVertexInGraphSpace(1), triangleMeshNode.GetVertexInGraphSpace(2)))
			{
				int v = triangleMeshNode.v0;
				triangleMeshNode.v0 = triangleMeshNode.v2;
				triangleMeshNode.v2 = v;
			}
			triangleMeshNode.Walkable = true;
			triangleMeshNode.Penalty = initialPenalty;
			triangleMeshNode.UpdatePositionFromVertices();
		}
		return array;
	}

	public bool Linecast(Int3 origin, Int3 end)
	{
		return Linecast(origin, end, GetNearest(origin, NNConstraint.None).node);
	}

	public bool Linecast(Int3 origin, Int3 end, GraphNode hint, out GraphHitInfo hit)
	{
		return Linecast(this, origin, end, hint, out hit, null);
	}

	public bool Linecast(Int3 origin, Int3 end, GraphNode hint)
	{
		GraphHitInfo hit;
		return Linecast(this, origin, end, hint, out hit, null);
	}

	public bool Linecast(Int3 origin, Int3 end, GraphNode hint, out GraphHitInfo hit, List<GraphNode> trace)
	{
		return Linecast(this, origin, end, hint, out hit, trace);
	}

	public static bool Linecast(INavmesh graph, Int3 tmp_origin, Int3 tmp_end, GraphNode hint, out GraphHitInfo hit)
	{
		return Linecast(graph, tmp_origin, tmp_end, hint, out hit, null);
	}

	public static bool Linecast(INavmesh graph, Int3 tmp_origin, Int3 tmp_end, GraphNode hint, out GraphHitInfo hit, List<GraphNode> trace)
	{
		Int3 @int = tmp_end;
		Int3 int2 = tmp_origin;
		hit = default(GraphHitInfo);
		if (float.IsNaN(tmp_origin.x + tmp_origin.y + tmp_origin.z))
		{
			throw new ArgumentException("origin is NaN");
		}
		if (float.IsNaN(tmp_end.x + tmp_end.y + tmp_end.z))
		{
			throw new ArgumentException("end is NaN");
		}
		TriangleMeshNode triangleMeshNode = hint as TriangleMeshNode;
		if (triangleMeshNode == null)
		{
			triangleMeshNode = (graph as NavGraph).GetNearest(tmp_origin, NNConstraint.None).node as TriangleMeshNode;
			if (triangleMeshNode == null)
			{
				Debug.LogError((object)"Could not find a valid node to start from");
				hit.point = tmp_origin;
				return true;
			}
		}
		if (int2 == @int)
		{
			hit.node = triangleMeshNode;
			return false;
		}
		int2 = (hit.origin = triangleMeshNode.ClosestPointOnNode(int2));
		if (!triangleMeshNode.Walkable)
		{
			hit.point = int2;
			hit.tangentOrigin = int2;
			return true;
		}
		List<Int3> list = ListPool<Int3>.Claim();
		List<Int3> list2 = ListPool<Int3>.Claim();
		int num = 0;
		while (true)
		{
			num++;
			if (num > 2000)
			{
				Debug.LogError((object)"Linecast was stuck in infinite loop. Breaking.");
				ListPool<Int3>.Release(list);
				ListPool<Int3>.Release(list2);
				return true;
			}
			TriangleMeshNode triangleMeshNode2 = null;
			trace?.Add(triangleMeshNode);
			if (triangleMeshNode.ContainsPoint(@int))
			{
				ListPool<Int3>.Release(list);
				ListPool<Int3>.Release(list2);
				return false;
			}
			for (int i = 0; i < triangleMeshNode.connections.Length; i++)
			{
				if (triangleMeshNode.connections[i].node.GraphIndex != triangleMeshNode.GraphIndex)
				{
					continue;
				}
				list.Clear();
				list2.Clear();
				if (triangleMeshNode.GetPortal(triangleMeshNode.connections[i].node, list, list2, backwards: false))
				{
					Int3 int3 = list[0];
					Int3 int4 = list2[0];
					if ((VectorMath.RightXZ(int3, int4, hit.origin) || !VectorMath.RightXZ(int3, int4, tmp_end)) && VectorMath.LineIntersectionFactorXZ(int3, int4, hit.origin, tmp_end, out var factor, out var factor2) && !(factor2 < 0L) && !(factor2 > 1L) && factor >= 0L && factor <= 1L)
					{
						triangleMeshNode2 = triangleMeshNode.connections[i].node as TriangleMeshNode;
						break;
					}
				}
			}
			if (triangleMeshNode2 == null)
			{
				break;
			}
			triangleMeshNode = triangleMeshNode2;
		}
		int vertexCount = triangleMeshNode.GetVertexCount();
		for (int j = 0; j < vertexCount; j++)
		{
			Int3 vertex = triangleMeshNode.GetVertex(j);
			Int3 vertex2 = triangleMeshNode.GetVertex((j + 1) % vertexCount);
			if ((VectorMath.RightXZ(vertex, vertex2, hit.origin) || !VectorMath.RightXZ(vertex, vertex2, tmp_end)) && VectorMath.LineIntersectionFactorXZ(vertex, vertex2, hit.origin, tmp_end, out var factor3, out var factor4) && !(factor4 < 0L) && !(factor4 > 1L) && factor3 >= 0L && factor3 <= 1L)
			{
				Int3 point = vertex + (vertex2 - vertex) * factor3;
				hit.point = point;
				hit.node = triangleMeshNode;
				hit.tangent = vertex2 - vertex;
				hit.tangentOrigin = vertex;
				ListPool<Int3>.Release(list);
				ListPool<Int3>.Release(list2);
				return true;
			}
		}
		Debug.LogWarning((object)"Linecast failing because point not inside node, and line does not hit any edges of it");
		ListPool<Int3>.Release(list);
		ListPool<Int3>.Release(list2);
		return false;
	}

	public override void OnDrawGizmos(RetainedGizmos gizmos, bool drawNodes)
	{
		//IL_0013: Unknown result type (might be due to invalid IL or missing references)
		//IL_001b: Unknown result type (might be due to invalid IL or missing references)
		//IL_0021: Unknown result type (might be due to invalid IL or missing references)
		//IL_0037: Unknown result type (might be due to invalid IL or missing references)
		//IL_0038: Unknown result type (might be due to invalid IL or missing references)
		if (!drawNodes)
		{
			return;
		}
		using (GraphGizmoHelper graphGizmoHelper = gizmos.GetSingleFrameGizmoHelper(active))
		{
			Bounds bounds = default(Bounds);
			((Bounds)(ref bounds)).SetMinMax(Vector3.zero, forcedBoundsSize);
			graphGizmoHelper.builder.DrawWireCube(CalculateTransform(), bounds, Color.white);
		}
		if (tiles != null)
		{
			for (int i = 0; i < tiles.Length; i++)
			{
				if (tiles[i] == null)
				{
					continue;
				}
				RetainedGizmos.Hasher hasher = new RetainedGizmos.Hasher(active);
				hasher.AddHash(showMeshOutline ? 1 : 0);
				hasher.AddHash(showMeshSurface ? 1 : 0);
				hasher.AddHash(showNodeConnections ? 1 : 0);
				TriangleMeshNode[] nodes = tiles[i].nodes;
				for (int j = 0; j < nodes.Length; j++)
				{
					hasher.HashNode(nodes[j]);
				}
				if (!gizmos.Draw(hasher))
				{
					using GraphGizmoHelper graphGizmoHelper2 = gizmos.GetGizmoHelper(active, hasher);
					if (showMeshSurface || showMeshOutline)
					{
						CreateNavmeshSurfaceVisualization(tiles[i], graphGizmoHelper2);
					}
					if (showMeshSurface || showMeshOutline)
					{
						CreateNavmeshOutlineVisualization(tiles[i], graphGizmoHelper2);
					}
					if (showNodeConnections)
					{
						for (int k = 0; k < nodes.Length; k++)
						{
							graphGizmoHelper2.DrawConnections(nodes[k]);
						}
					}
				}
				gizmos.Draw(hasher);
			}
		}
		if (active.showUnwalkableNodes)
		{
			DrawUnwalkableNodes(active.unwalkableNodeDebugSize);
		}
	}

	private void CreateNavmeshSurfaceVisualization(NavmeshTile tile, GraphGizmoHelper helper)
	{
		//IL_0042: Unknown result type (might be due to invalid IL or missing references)
		//IL_0047: Unknown result type (might be due to invalid IL or missing references)
		//IL_0054: Unknown result type (might be due to invalid IL or missing references)
		//IL_0059: Unknown result type (might be due to invalid IL or missing references)
		//IL_0066: Unknown result type (might be due to invalid IL or missing references)
		//IL_006b: Unknown result type (might be due to invalid IL or missing references)
		//IL_0072: Unknown result type (might be due to invalid IL or missing references)
		//IL_0077: Unknown result type (might be due to invalid IL or missing references)
		//IL_0089: Unknown result type (might be due to invalid IL or missing references)
		//IL_008b: Unknown result type (might be due to invalid IL or missing references)
		//IL_008c: Unknown result type (might be due to invalid IL or missing references)
		//IL_008e: Unknown result type (might be due to invalid IL or missing references)
		//IL_0093: Unknown result type (might be due to invalid IL or missing references)
		//IL_0095: Unknown result type (might be due to invalid IL or missing references)
		//IL_0096: Unknown result type (might be due to invalid IL or missing references)
		//IL_0098: Unknown result type (might be due to invalid IL or missing references)
		//IL_009d: Unknown result type (might be due to invalid IL or missing references)
		//IL_009f: Unknown result type (might be due to invalid IL or missing references)
		Vector3[] array = ArrayPool<Vector3>.Claim(tile.nodes.Length * 3);
		Color[] array2 = ArrayPool<Color>.Claim(tile.nodes.Length * 3);
		for (int i = 0; i < tile.nodes.Length; i++)
		{
			TriangleMeshNode triangleMeshNode = tile.nodes[i];
			triangleMeshNode.GetVertices(out var v, out var v2, out var v3);
			array[i * 3] = (Vector3)v;
			array[i * 3 + 1] = (Vector3)v2;
			array[i * 3 + 2] = (Vector3)v3;
			Color val = helper.NodeColor(triangleMeshNode);
			array2[i * 3] = (array2[i * 3 + 1] = (array2[i * 3 + 2] = val));
		}
		if (showMeshSurface)
		{
			helper.DrawTriangles(array, array2, tile.nodes.Length);
		}
		if (showMeshOutline)
		{
			helper.DrawWireTriangles(array, array2, tile.nodes.Length);
		}
		ArrayPool<Vector3>.Release(ref array);
		ArrayPool<Color>.Release(ref array2);
	}

	private static void CreateNavmeshOutlineVisualization(NavmeshTile tile, GraphGizmoHelper helper)
	{
		//IL_00ce: Unknown result type (might be due to invalid IL or missing references)
		//IL_00d3: Unknown result type (might be due to invalid IL or missing references)
		//IL_00ed: Unknown result type (might be due to invalid IL or missing references)
		//IL_00fe: Unknown result type (might be due to invalid IL or missing references)
		//IL_0103: Unknown result type (might be due to invalid IL or missing references)
		bool[] array = new bool[3];
		for (int i = 0; i < tile.nodes.Length; i++)
		{
			bool flag;
			array[1] = (flag = (array[2] = false));
			array[0] = flag;
			TriangleMeshNode triangleMeshNode = tile.nodes[i];
			for (int j = 0; j < triangleMeshNode.connections.Length; j++)
			{
				if (!(triangleMeshNode.connections[j].node is TriangleMeshNode triangleMeshNode2) || triangleMeshNode2.GraphIndex != triangleMeshNode.GraphIndex)
				{
					continue;
				}
				for (int k = 0; k < 3; k++)
				{
					for (int l = 0; l < 3; l++)
					{
						if (triangleMeshNode.GetVertexIndex(k) == triangleMeshNode2.GetVertexIndex((l + 1) % 3) && triangleMeshNode.GetVertexIndex((k + 1) % 3) == triangleMeshNode2.GetVertexIndex(l))
						{
							array[k] = true;
							k = 3;
							break;
						}
					}
				}
			}
			Color color = helper.NodeColor(triangleMeshNode);
			for (int m = 0; m < 3; m++)
			{
				if (!array[m])
				{
					helper.builder.DrawLine((Vector3)triangleMeshNode.GetVertex(m), (Vector3)triangleMeshNode.GetVertex((m + 1) % 3), color);
				}
			}
		}
	}

	public override void SerializeExtraInfo(GraphSerializationContext ctx)
	{
		BinaryWriter writer = ctx.writer;
		if (tiles == null)
		{
			writer.Write(-1);
			return;
		}
		writer.Write(tileXCount);
		writer.Write(tileZCount);
		for (int i = 0; i < tileZCount; i++)
		{
			for (int j = 0; j < tileXCount; j++)
			{
				NavmeshTile navmeshTile = tiles[j + i * tileXCount];
				if (navmeshTile == null)
				{
					throw new Exception("NULL Tile");
				}
				writer.Write(navmeshTile.x);
				writer.Write(navmeshTile.z);
				if (navmeshTile.x == j && navmeshTile.z == i)
				{
					writer.Write(navmeshTile.w);
					writer.Write(navmeshTile.d);
					writer.Write(navmeshTile.tris.Length);
					for (int k = 0; k < navmeshTile.tris.Length; k++)
					{
						writer.Write(navmeshTile.tris[k]);
					}
					writer.Write(navmeshTile.verts.Length);
					for (int l = 0; l < navmeshTile.verts.Length; l++)
					{
						ctx.SerializeInt3(navmeshTile.verts[l]);
					}
					writer.Write(navmeshTile.vertsInGraphSpace.Length);
					for (int m = 0; m < navmeshTile.vertsInGraphSpace.Length; m++)
					{
						ctx.SerializeInt3(navmeshTile.vertsInGraphSpace[m]);
					}
					writer.Write(navmeshTile.nodes.Length);
					for (int n = 0; n < navmeshTile.nodes.Length; n++)
					{
						navmeshTile.nodes[n].SerializeNode(ctx);
					}
				}
			}
		}
	}

	public override void DeserializeExtraInfo(GraphSerializationContext ctx)
	{
		BinaryReader reader = ctx.reader;
		tileXCount = reader.ReadInt32();
		if (tileXCount < 0)
		{
			return;
		}
		tileZCount = reader.ReadInt32();
		transform = CalculateTransform();
		tiles = new NavmeshTile[tileXCount * tileZCount];
		TriangleMeshNode.SetNavmeshHolder((int)ctx.graphIndex, this);
		for (int i = 0; i < tileZCount; i++)
		{
			for (int j = 0; j < tileXCount; j++)
			{
				int num = j + i * tileXCount;
				int num2 = reader.ReadInt32();
				if (num2 < 0)
				{
					throw new Exception("Invalid tile coordinates (x < 0)");
				}
				int num3 = reader.ReadInt32();
				if (num3 < 0)
				{
					throw new Exception("Invalid tile coordinates (z < 0)");
				}
				if (num2 != j || num3 != i)
				{
					tiles[num] = tiles[num3 * tileXCount + num2];
					continue;
				}
				NavmeshTile navmeshTile = new NavmeshTile();
				navmeshTile.x = num2;
				navmeshTile.z = num3;
				navmeshTile.w = reader.ReadInt32();
				navmeshTile.d = reader.ReadInt32();
				navmeshTile.bbTree = ObjectPool<BBTree>.Claim();
				tiles[num] = navmeshTile;
				int num4 = reader.ReadInt32();
				if (num4 % 3 != 0)
				{
					throw new Exception("Corrupt data. Triangle indices count must be divisable by 3. Got " + num4);
				}
				navmeshTile.tris = new int[num4];
				for (int k = 0; k < navmeshTile.tris.Length; k++)
				{
					navmeshTile.tris[k] = reader.ReadInt32();
				}
				navmeshTile.verts = new Int3[reader.ReadInt32()];
				for (int l = 0; l < navmeshTile.verts.Length; l++)
				{
					navmeshTile.verts[l] = ctx.DeserializeInt3();
				}
				if (ctx.meta.version.Major >= 4)
				{
					navmeshTile.vertsInGraphSpace = new Int3[reader.ReadInt32()];
					if (navmeshTile.vertsInGraphSpace.Length != navmeshTile.verts.Length)
					{
						throw new Exception("Corrupt data. Array lengths did not match");
					}
					for (int m = 0; m < navmeshTile.verts.Length; m++)
					{
						navmeshTile.vertsInGraphSpace[m] = ctx.DeserializeInt3();
					}
				}
				else
				{
					navmeshTile.vertsInGraphSpace = new Int3[navmeshTile.verts.Length];
					navmeshTile.verts.CopyTo(navmeshTile.vertsInGraphSpace, 0);
					transform.InverseTransform(navmeshTile.vertsInGraphSpace);
				}
				int num5 = reader.ReadInt32();
				navmeshTile.nodes = new TriangleMeshNode[num5];
				num <<= 12;
				for (int n = 0; n < navmeshTile.nodes.Length; n++)
				{
					TriangleMeshNode triangleMeshNode = new TriangleMeshNode(active);
					navmeshTile.nodes[n] = triangleMeshNode;
					triangleMeshNode.DeserializeNode(ctx);
					triangleMeshNode.v0 = navmeshTile.tris[n * 3] | num;
					triangleMeshNode.v1 = navmeshTile.tris[n * 3 + 1] | num;
					triangleMeshNode.v2 = navmeshTile.tris[n * 3 + 2] | num;
					triangleMeshNode.UpdatePositionFromVertices();
				}
				navmeshTile.bbTree.RebuildFrom(navmeshTile.nodes);
			}
		}
	}

	public override void PostDeserialization()
	{
		transform = CalculateTransform();
	}

	protected NavmeshBase()
	{
		//IL_0010: Unknown result type (might be due to invalid IL or missing references)
		//IL_0015: Unknown result type (might be due to invalid IL or missing references)
		//IL_002d: Unknown result type (might be due to invalid IL or missing references)
		forcedBoundsSize = new Vector3(100f, 40f, 100f);
		showMeshOutline = true;
		batchUpdatedTiles = new List<int>();
		transform = new GraphTransform(Matrix4x4.identity);
		base._002Ector();
	}
}
