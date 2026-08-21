using System;
using System.Collections.Generic;
using System.Runtime.CompilerServices;
using Pathfinding.Recast;
using Pathfinding.Serialization;
using Pathfinding.Util;
using Pathfinding.Voxels;
using UnityEngine;

namespace Pathfinding;

[JsonOptIn]
public class RecastGraph : NavmeshBase, IUpdatableGraph
{
	public enum RelevantGraphSurfaceMode
	{
		DoNotRequire,
		OnlyForCompletelyInsideTile,
		RequireForAll
	}

	[JsonMember]
	public float characterRadius;

	[JsonMember]
	public float contourMaxError;

	[JsonMember]
	public float cellSize;

	[JsonMember]
	public float walkableHeight;

	[JsonMember]
	public float walkableClimb;

	[JsonMember]
	public float maxSlope;

	[JsonMember]
	public float maxEdgeLength;

	[JsonMember]
	public float minRegionSize;

	[JsonMember]
	public int editorTileSize;

	[JsonMember]
	public int tileSizeX;

	[JsonMember]
	public int tileSizeZ;

	[JsonMember]
	public bool useTiles;

	public bool scanEmptyGraph;

	[JsonMember]
	public RelevantGraphSurfaceMode relevantGraphSurfaceMode;

	[JsonMember]
	public bool rasterizeColliders;

	[JsonMember]
	public bool rasterizeMeshes;

	[JsonMember]
	public bool rasterizeTerrain;

	[JsonMember]
	public bool rasterizeTrees;

	[JsonMember]
	public float colliderRasterizeDetail;

	[JsonMember]
	public LayerMask mask;

	[JsonMember]
	public List<string> tagMask;

	[JsonMember]
	public int terrainSampleSize;

	[JsonMember]
	public Vector3 rotation;

	[JsonMember]
	public Vector3 forcedBoundsCenter;

	private Voxelize globalVox;

	public const int BorderVertexMask = 1;

	public const int BorderVertexOffset = 31;

	private List<NavmeshTile> stagingTiles;

	public override float TileWorldSizeX => (float)tileSizeX * cellSize;

	public override float TileWorldSizeZ => (float)tileSizeZ * cellSize;

	protected override float MaxTileConnectionEdgeDistance => walkableClimb;

	[Obsolete("Obsolete since this is not accurate when the graph is rotated (rotation was not supported when this property was created)")]
	public Bounds forcedBounds
	{
		get
		{
			//IL_0001: Unknown result type (might be due to invalid IL or missing references)
			//IL_0007: Unknown result type (might be due to invalid IL or missing references)
			//IL_000c: Unknown result type (might be due to invalid IL or missing references)
			return new Bounds(forcedBoundsCenter, forcedBoundsSize);
		}
	}

	private float CellHeight => Mathf.Max(forcedBoundsSize.y / 64000f, 0.001f);

	private int CharacterRadiusInVoxels => Mathf.CeilToInt(characterRadius / cellSize - 0.1f);

	private int TileBorderSizeInVoxels => CharacterRadiusInVoxels + 3;

	private float TileBorderSizeInWorldUnits => (float)TileBorderSizeInVoxels * cellSize;

	[Obsolete("Use node.ClosestPointOnNode instead")]
	public Int3 ClosestPointOnNode(TriangleMeshNode node, Int3 pos)
	{
		return node.ClosestPointOnNode(pos);
	}

	[Obsolete("Use node.ContainsPoint instead")]
	public bool ContainsPoint(TriangleMeshNode node, Int3 pos)
	{
		return node.ContainsPoint(pos);
	}

	public void SnapForceBoundsToScene()
	{
		//IL_0001: Unknown result type (might be due to invalid IL or missing references)
		//IL_0015: Unknown result type (might be due to invalid IL or missing references)
		//IL_001a: Unknown result type (might be due to invalid IL or missing references)
		//IL_0035: Unknown result type (might be due to invalid IL or missing references)
		//IL_003a: Unknown result type (might be due to invalid IL or missing references)
		//IL_0048: Unknown result type (might be due to invalid IL or missing references)
		//IL_006e: Unknown result type (might be due to invalid IL or missing references)
		//IL_0073: Unknown result type (might be due to invalid IL or missing references)
		//IL_007b: Unknown result type (might be due to invalid IL or missing references)
		//IL_0080: Unknown result type (might be due to invalid IL or missing references)
		List<RasterizationMesh> list = CollectMeshes(new Bounds(Vector3.zero, new Vector3(float.PositiveInfinity, float.PositiveInfinity, float.PositiveInfinity)));
		if (list.Count != 0)
		{
			Bounds bounds = list[0].bounds;
			for (int i = 1; i < list.Count; i++)
			{
				((Bounds)(ref bounds)).Encapsulate(list[i].bounds);
				list[i].Pool();
			}
			forcedBoundsCenter = ((Bounds)(ref bounds)).center;
			forcedBoundsSize = ((Bounds)(ref bounds)).size;
		}
	}

	GraphUpdateThreading IUpdatableGraph.CanUpdateAsync(GraphUpdateObject o)
	{
		if (!o.updatePhysics)
		{
			return GraphUpdateThreading.SeparateThread;
		}
		return (GraphUpdateThreading)7;
	}

	void IUpdatableGraph.UpdateAreaInit(GraphUpdateObject o)
	{
		//IL_0010: Unknown result type (might be due to invalid IL or missing references)
		//IL_001d: Unknown result type (might be due to invalid IL or missing references)
		//IL_0022: Unknown result type (might be due to invalid IL or missing references)
		//IL_0034: Unknown result type (might be due to invalid IL or missing references)
		//IL_003f: Unknown result type (might be due to invalid IL or missing references)
		//IL_0049: Unknown result type (might be due to invalid IL or missing references)
		//IL_0054: Unknown result type (might be due to invalid IL or missing references)
		if (o.updatePhysics)
		{
			RelevantGraphSurface.UpdateAllPositions();
			IntRect touchingTiles = GetTouchingTiles(o.bounds);
			Bounds tileBounds = GetTileBounds(touchingTiles);
			((Bounds)(ref tileBounds)).Expand(new Vector3(1f, 0f, 1f) * TileBorderSizeInWorldUnits * 2f);
			List<RasterizationMesh> inputMeshes = CollectMeshes(tileBounds);
			if (globalVox == null)
			{
				globalVox = new Voxelize(CellHeight, cellSize, walkableClimb, walkableHeight, maxSlope, maxEdgeLength);
			}
			globalVox.inputMeshes = inputMeshes;
		}
	}

	void IUpdatableGraph.UpdateArea(GraphUpdateObject guo)
	{
		//IL_0002: Unknown result type (might be due to invalid IL or missing references)
		IntRect touchingTiles = GetTouchingTiles(guo.bounds);
		if (!guo.updatePhysics)
		{
			for (int i = touchingTiles.ymin; i <= touchingTiles.ymax; i++)
			{
				for (int j = touchingTiles.xmin; j <= touchingTiles.xmax; j++)
				{
					NavmeshTile graph = tiles[i * tileXCount + j];
					NavMeshGraph.UpdateArea(guo, graph);
				}
			}
			return;
		}
		Voxelize voxelize = globalVox;
		if (voxelize == null)
		{
			throw new InvalidOperationException("No Voxelizer object. UpdateAreaInit should have been called before this function.");
		}
		for (int k = touchingTiles.xmin; k <= touchingTiles.xmax; k++)
		{
			for (int l = touchingTiles.ymin; l <= touchingTiles.ymax; l++)
			{
				stagingTiles.Add(BuildTileMesh(voxelize, k, l));
			}
		}
		uint num = (uint)AstarPath.active.data.GetGraphIndex(this);
		for (int m = 0; m < stagingTiles.Count; m++)
		{
			NavmeshTile navmeshTile = stagingTiles[m];
			GraphNode[] nodes = navmeshTile.nodes;
			GraphNode[] array = nodes;
			for (int n = 0; n < array.Length; n++)
			{
				array[n].GraphIndex = num;
			}
		}
		for (int num2 = 0; num2 < voxelize.inputMeshes.Count; num2++)
		{
			voxelize.inputMeshes[num2].Pool();
		}
		ListPool<RasterizationMesh>.Release(voxelize.inputMeshes);
		voxelize.inputMeshes = null;
	}

	void IUpdatableGraph.UpdateAreaPost(GraphUpdateObject guo)
	{
		for (int i = 0; i < stagingTiles.Count; i++)
		{
			NavmeshTile navmeshTile = stagingTiles[i];
			int num = navmeshTile.x + navmeshTile.z * tileXCount;
			NavmeshTile navmeshTile2 = tiles[num];
			for (int j = 0; j < navmeshTile2.nodes.Length; j++)
			{
				navmeshTile2.nodes[j].Destroy();
			}
			tiles[num] = navmeshTile;
		}
		for (int k = 0; k < stagingTiles.Count; k++)
		{
			NavmeshTile tile = stagingTiles[k];
			ConnectTileWithNeighbours(tile);
		}
		if (OnRecalculatedTiles != null)
		{
			OnRecalculatedTiles(stagingTiles.ToArray());
		}
		stagingTiles.Clear();
	}

	public override IEnumerable<Progress> ScanInternal()
	{
		TriangleMeshNode.SetNavmeshHolder(AstarPath.active.data.GetGraphIndex(this), this);
		if (!Application.isPlaying)
		{
			RelevantGraphSurface.FindAllGraphSurfaces();
		}
		RelevantGraphSurface.UpdateAllPositions();
		foreach (Progress item in ScanAllTiles())
		{
			yield return item;
		}
	}

	public override GraphTransform CalculateTransform()
	{
		//IL_0001: Unknown result type (might be due to invalid IL or missing references)
		//IL_0007: Unknown result type (might be due to invalid IL or missing references)
		//IL_000c: Unknown result type (might be due to invalid IL or missing references)
		//IL_0011: Unknown result type (might be due to invalid IL or missing references)
		//IL_0016: Unknown result type (might be due to invalid IL or missing references)
		//IL_001c: Unknown result type (might be due to invalid IL or missing references)
		//IL_0021: Unknown result type (might be due to invalid IL or missing references)
		//IL_002b: Unknown result type (might be due to invalid IL or missing references)
		//IL_0030: Unknown result type (might be due to invalid IL or missing references)
		//IL_0035: Unknown result type (might be due to invalid IL or missing references)
		//IL_003a: Unknown result type (might be due to invalid IL or missing references)
		//IL_003f: Unknown result type (might be due to invalid IL or missing references)
		return new GraphTransform(Matrix4x4.TRS(forcedBoundsCenter, Quaternion.Euler(rotation), Vector3.one) * Matrix4x4.TRS(-forcedBoundsSize * 0.5f, Quaternion.identity, Vector3.one));
	}

	private void InitializeTileInfo()
	{
		int num = (int)(forcedBoundsSize.x / cellSize + 0.5f);
		int num2 = (int)(forcedBoundsSize.z / cellSize + 0.5f);
		if (!useTiles)
		{
			tileSizeX = num;
			tileSizeZ = num2;
		}
		else
		{
			tileSizeX = editorTileSize;
			tileSizeZ = editorTileSize;
		}
		tileXCount = (num + tileSizeX - 1) / tileSizeX;
		tileZCount = (num2 + tileSizeZ - 1) / tileSizeZ;
		if (tileXCount * tileZCount > 524288)
		{
			throw new Exception("Too many tiles (" + tileXCount * tileZCount + ") maximum is " + 524288 + "\nTry disabling ASTAR_RECAST_LARGER_TILES under the 'Optimizations' tab in the A* inspector.");
		}
		tiles = new NavmeshTile[tileXCount * tileZCount];
	}

	private List<RasterizationMesh>[] PutMeshesIntoTileBuckets(List<RasterizationMesh> meshes)
	{
		//IL_001d: Unknown result type (might be due to invalid IL or missing references)
		//IL_0028: Unknown result type (might be due to invalid IL or missing references)
		//IL_0032: Unknown result type (might be due to invalid IL or missing references)
		//IL_0037: Unknown result type (might be due to invalid IL or missing references)
		//IL_005d: Unknown result type (might be due to invalid IL or missing references)
		//IL_0062: Unknown result type (might be due to invalid IL or missing references)
		//IL_0066: Unknown result type (might be due to invalid IL or missing references)
		//IL_006d: Unknown result type (might be due to invalid IL or missing references)
		List<RasterizationMesh>[] array = new List<RasterizationMesh>[tiles.Length];
		Vector3 val = new Vector3(1f, 0f, 1f) * TileBorderSizeInWorldUnits * 2f;
		for (int i = 0; i < array.Length; i++)
		{
			array[i] = ListPool<RasterizationMesh>.Claim();
		}
		for (int j = 0; j < meshes.Count; j++)
		{
			RasterizationMesh rasterizationMesh = meshes[j];
			Bounds bounds = rasterizationMesh.bounds;
			((Bounds)(ref bounds)).Expand(val);
			IntRect touchingTiles = GetTouchingTiles(bounds);
			for (int k = touchingTiles.ymin; k <= touchingTiles.ymax; k++)
			{
				for (int l = touchingTiles.xmin; l <= touchingTiles.xmax; l++)
				{
					array[l + k * tileXCount].Add(rasterizationMesh);
				}
			}
		}
		return array;
	}

	protected IEnumerable<Progress> ScanAllTiles()
	{
		transform = CalculateTransform();
		InitializeTileInfo();
		if (scanEmptyGraph)
		{
			FillWithEmptyTiles();
			yield break;
		}
		walkableClimb = Mathf.Min(walkableClimb, walkableHeight);
		yield return new Progress(0f, "Finding Meshes");
		Bounds bounds = transform.Transform(new Bounds(forcedBoundsSize * 0.5f, forcedBoundsSize));
		List<RasterizationMesh> meshes = CollectMeshes(bounds);
		List<RasterizationMesh>[] buckets = PutMeshesIntoTileBuckets(meshes);
		Queue<Int2> tileQueue = new Queue<Int2>();
		for (int i = 0; i < tileZCount; i++)
		{
			for (int j = 0; j < tileXCount; j++)
			{
				tileQueue.Enqueue(new Int2(j, i));
			}
		}
		ParallelWorkQueue<Int2> parallelWorkQueue = new ParallelWorkQueue<Int2>(tileQueue);
		Voxelize[] voxelizers = new Voxelize[parallelWorkQueue.threadCount];
		for (int k = 0; k < voxelizers.Length; k++)
		{
			voxelizers[k] = new Voxelize(CellHeight, cellSize, walkableClimb, walkableHeight, maxSlope, maxEdgeLength);
		}
		parallelWorkQueue.action = delegate(Int2 tile, int threadIndex)
		{
			voxelizers[threadIndex].inputMeshes = buckets[tile.x + tile.y * tileXCount];
			tiles[tile.x + tile.y * tileXCount] = BuildTileMesh(voxelizers[threadIndex], tile.x, tile.y, threadIndex);
		};
		int timeoutMillis = (Application.isPlaying ? 1 : 200);
		foreach (int item in parallelWorkQueue.Run(timeoutMillis))
		{
			yield return new Progress(Mathf.Lerp(0.1f, 0.9f, (float)item / (float)tiles.Length), "Calculated Tiles: " + item + "/" + tiles.Length);
		}
		yield return new Progress(0.9f, "Assigning Graph Indices");
		uint graphIndex = (uint)AstarPath.active.data.GetGraphIndex(this);
		GetNodes(delegate(GraphNode node)
		{
			node.GraphIndex = graphIndex;
		});
		for (int coordinateSum = 0; coordinateSum <= 1; coordinateSum++)
		{
			int direction;
			for (direction = 0; direction <= 1; direction++)
			{
				for (int num = 0; num < tiles.Length; num++)
				{
					if ((tiles[num].x + tiles[num].z) % 2 == coordinateSum)
					{
						tileQueue.Enqueue(new Int2(tiles[num].x, tiles[num].z));
					}
				}
				parallelWorkQueue = new ParallelWorkQueue<Int2>(tileQueue);
				parallelWorkQueue.action = delegate(Int2 tile, int threadIndex)
				{
					if (direction == 0 && tile.x < tileXCount - 1)
					{
						ConnectTiles(tiles[tile.x + tile.y * tileXCount], tiles[tile.x + 1 + tile.y * tileXCount]);
					}
					if (direction == 1 && tile.y < tileZCount - 1)
					{
						ConnectTiles(tiles[tile.x + tile.y * tileXCount], tiles[tile.x + (tile.y + 1) * tileXCount]);
					}
				};
				int numTilesInQueue = tileQueue.Count;
				foreach (int item2 in parallelWorkQueue.Run(timeoutMillis))
				{
					yield return new Progress(0.95f, "Connected Tiles " + (numTilesInQueue - item2) + "/" + numTilesInQueue + " (Phase " + (direction + 1 + 2 * coordinateSum) + " of 4)");
				}
			}
		}
		for (int num2 = 0; num2 < meshes.Count; num2++)
		{
			meshes[num2].Pool();
		}
		ListPool<RasterizationMesh>.Release(meshes);
		if (OnRecalculatedTiles != null)
		{
			OnRecalculatedTiles(tiles.Clone() as NavmeshTile[]);
		}
	}

	private List<RasterizationMesh> CollectMeshes(Bounds bounds)
	{
		//IL_0006: Unknown result type (might be due to invalid IL or missing references)
		//IL_000e: Unknown result type (might be due to invalid IL or missing references)
		List<RasterizationMesh> list = ListPool<RasterizationMesh>.Claim();
		RecastMeshGatherer recastMeshGatherer = new RecastMeshGatherer(bounds, terrainSampleSize, mask, tagMask, colliderRasterizeDetail);
		if (rasterizeMeshes)
		{
			recastMeshGatherer.CollectSceneMeshes(list);
		}
		recastMeshGatherer.CollectRecastMeshObjs(list);
		if (rasterizeTerrain)
		{
			float desiredChunkSize = cellSize * (float)Math.Max(tileSizeX, tileSizeZ);
			recastMeshGatherer.CollectTerrainMeshes(rasterizeTrees, desiredChunkSize, list);
		}
		if (rasterizeColliders)
		{
			recastMeshGatherer.CollectColliderMeshes(list);
		}
		if (list.Count == 0)
		{
			Debug.LogWarning((object)("No MeshFilters were found contained in the layers specified by the 'mask' variables:" + ((object)System.Runtime.CompilerServices.Unsafe.As<LayerMask, LayerMask>(ref mask)/*cast due to constrained. prefix*/).ToString() + "," + tagMask));
		}
		return list;
	}

	private Bounds CalculateTileBoundsWithBorder(int x, int z)
	{
		//IL_0002: Unknown result type (might be due to invalid IL or missing references)
		//IL_0021: Unknown result type (might be due to invalid IL or missing references)
		//IL_0047: Unknown result type (might be due to invalid IL or missing references)
		//IL_0062: Unknown result type (might be due to invalid IL or missing references)
		//IL_006d: Unknown result type (might be due to invalid IL or missing references)
		//IL_0077: Unknown result type (might be due to invalid IL or missing references)
		//IL_0081: Unknown result type (might be due to invalid IL or missing references)
		Bounds result = default(Bounds);
		((Bounds)(ref result)).SetMinMax(new Vector3((float)x * TileWorldSizeX, 0f, (float)z * TileWorldSizeZ), new Vector3((float)(x + 1) * TileWorldSizeX, forcedBoundsSize.y, (float)(z + 1) * TileWorldSizeZ));
		((Bounds)(ref result)).Expand(new Vector3(1f, 0f, 1f) * TileBorderSizeInWorldUnits * 2f);
		return result;
	}

	protected NavmeshTile BuildTileMesh(Voxelize vox, int x, int z, int threadIndex = 0)
	{
		//IL_0010: Unknown result type (might be due to invalid IL or missing references)
		//IL_0015: Unknown result type (might be due to invalid IL or missing references)
		//IL_0099: Unknown result type (might be due to invalid IL or missing references)
		vox.borderSize = TileBorderSizeInVoxels;
		vox.forcedBounds = CalculateTileBoundsWithBorder(x, z);
		vox.width = tileSizeX + vox.borderSize * 2;
		vox.depth = tileSizeZ + vox.borderSize * 2;
		if (!useTiles && relevantGraphSurfaceMode == RelevantGraphSurfaceMode.OnlyForCompletelyInsideTile)
		{
			vox.relevantGraphSurfaceMode = RelevantGraphSurfaceMode.RequireForAll;
		}
		else
		{
			vox.relevantGraphSurfaceMode = relevantGraphSurfaceMode;
		}
		vox.minRegionSize = Mathf.RoundToInt(minRegionSize / (cellSize * cellSize));
		vox.Init();
		vox.VoxelizeInput(transform, CalculateTileBoundsWithBorder(x, z));
		vox.FilterLedges(vox.voxelWalkableHeight, vox.voxelWalkableClimb, vox.cellSize, vox.cellHeight);
		vox.FilterLowHeightSpans(vox.voxelWalkableHeight, vox.cellSize, vox.cellHeight);
		vox.BuildCompactField();
		vox.BuildVoxelConnections();
		vox.ErodeWalkableArea(CharacterRadiusInVoxels);
		vox.BuildDistanceField();
		vox.BuildRegions();
		VoxelContourSet cset = new VoxelContourSet();
		vox.BuildContours(contourMaxError, 1, cset, 5);
		vox.BuildPolyMesh(cset, 3, out var mesh);
		for (int i = 0; i < mesh.verts.Length; i++)
		{
			mesh.verts[i] *= 1000;
		}
		vox.transformVoxel2Graph.Transform(mesh.verts);
		return CreateTile(vox, mesh, x, z, threadIndex);
	}

	private NavmeshTile CreateTile(Voxelize vox, VoxelMesh mesh, int x, int z, int threadIndex)
	{
		if (mesh.tris == null)
		{
			throw new ArgumentNullException("mesh.tris");
		}
		if (mesh.verts == null)
		{
			throw new ArgumentNullException("mesh.verts");
		}
		if (mesh.tris.Length % 3 != 0)
		{
			throw new ArgumentException("Indices array's length must be a multiple of 3 (mesh.tris)");
		}
		if (mesh.verts.Length >= 4095)
		{
			if (tileXCount * tileZCount == 1)
			{
				throw new ArgumentException("Too many vertices per tile (more than " + 4095 + ").\n<b>Try enabling tiling in the recast graph settings.</b>\n");
			}
			throw new ArgumentException("Too many vertices per tile (more than " + 4095 + ").\n<b>Try reducing tile size or enabling ASTAR_RECAST_LARGER_TILES under the 'Optimizations' tab in the A* Inspector</b>");
		}
		NavmeshTile navmeshTile = new NavmeshTile
		{
			x = x,
			z = z,
			w = 1,
			d = 1,
			tris = mesh.tris,
			bbTree = new BBTree()
		};
		navmeshTile.vertsInGraphSpace = Utility.RemoveDuplicateVertices(mesh.verts, navmeshTile.tris);
		navmeshTile.verts = (Int3[])navmeshTile.vertsInGraphSpace.Clone();
		transform.Transform(navmeshTile.verts);
		uint num = (uint)(active.data.graphs.Length + threadIndex);
		if (num > 255)
		{
			throw new Exception("Graph limit reached. Multithreaded recast calculations cannot be done because a few scratch graph indices are required.");
		}
		int num2 = x + z * tileXCount;
		num2 <<= 12;
		TriangleMeshNode.SetNavmeshHolder((int)num, navmeshTile);
		lock (active)
		{
			navmeshTile.nodes = CreateNodes(navmeshTile.tris, num2, num);
		}
		navmeshTile.bbTree.RebuildFrom(navmeshTile.nodes);
		NavmeshBase.CreateNodeConnections(navmeshTile.nodes);
		TriangleMeshNode.SetNavmeshHolder((int)num, null);
		return navmeshTile;
	}

	public override void DeserializeSettingsCompatibility(GraphSerializationContext ctx)
	{
		//IL_0125: Unknown result type (might be due to invalid IL or missing references)
		//IL_012a: Unknown result type (might be due to invalid IL or missing references)
		//IL_0131: Unknown result type (might be due to invalid IL or missing references)
		//IL_0136: Unknown result type (might be due to invalid IL or missing references)
		//IL_0147: Unknown result type (might be due to invalid IL or missing references)
		//IL_014c: Unknown result type (might be due to invalid IL or missing references)
		base.DeserializeSettingsCompatibility(ctx);
		characterRadius = ctx.reader.ReadSingle();
		contourMaxError = ctx.reader.ReadSingle();
		cellSize = ctx.reader.ReadSingle();
		ctx.reader.ReadSingle();
		walkableHeight = ctx.reader.ReadSingle();
		maxSlope = ctx.reader.ReadSingle();
		maxEdgeLength = ctx.reader.ReadSingle();
		editorTileSize = ctx.reader.ReadInt32();
		tileSizeX = ctx.reader.ReadInt32();
		nearestSearchOnlyXZ = ctx.reader.ReadBoolean();
		useTiles = ctx.reader.ReadBoolean();
		relevantGraphSurfaceMode = (RelevantGraphSurfaceMode)ctx.reader.ReadInt32();
		rasterizeColliders = ctx.reader.ReadBoolean();
		rasterizeMeshes = ctx.reader.ReadBoolean();
		rasterizeTerrain = ctx.reader.ReadBoolean();
		rasterizeTrees = ctx.reader.ReadBoolean();
		colliderRasterizeDetail = ctx.reader.ReadSingle();
		forcedBoundsCenter = ctx.DeserializeVector3();
		forcedBoundsSize = ctx.DeserializeVector3();
		mask = LayerMask.op_Implicit(ctx.reader.ReadInt32());
		int num = ctx.reader.ReadInt32();
		tagMask = new List<string>(num);
		for (int i = 0; i < num; i++)
		{
			tagMask.Add(ctx.reader.ReadString());
		}
		showMeshOutline = ctx.reader.ReadBoolean();
		showNodeConnections = ctx.reader.ReadBoolean();
		terrainSampleSize = ctx.reader.ReadInt32();
		walkableClimb = ctx.DeserializeFloat(walkableClimb);
		minRegionSize = ctx.DeserializeFloat(minRegionSize);
		tileSizeZ = ctx.DeserializeInt(tileSizeX);
		showMeshSurface = ctx.reader.ReadBoolean();
	}

	public RecastGraph()
	{
		//IL_009b: Unknown result type (might be due to invalid IL or missing references)
		//IL_00a0: Unknown result type (might be due to invalid IL or missing references)
		characterRadius = 1.5f;
		contourMaxError = 2f;
		cellSize = 0.5f;
		walkableHeight = 2f;
		walkableClimb = 0.5f;
		maxSlope = 30f;
		maxEdgeLength = 20f;
		minRegionSize = 3f;
		editorTileSize = 128;
		tileSizeX = 128;
		tileSizeZ = 128;
		rasterizeMeshes = true;
		rasterizeTerrain = true;
		rasterizeTrees = true;
		colliderRasterizeDetail = 10f;
		mask = LayerMask.op_Implicit(-1);
		tagMask = new List<string>();
		terrainSampleSize = 3;
		stagingTiles = new List<NavmeshTile>();
		base._002Ector();
	}
}
