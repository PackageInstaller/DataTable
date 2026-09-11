using System;
using System.Collections.Generic;
using System.Runtime.CompilerServices;
using Pathfinding.ClipperLib;
using Pathfinding.Poly2Tri;
using Pathfinding.Voxels;
using UnityEngine;

namespace Pathfinding.Util;

public class TileHandler
{
	public class TileType
	{
		private Int3[] verts;

		private int[] tris;

		private Int3 offset;

		private int lastYOffset;

		private int lastRotation;

		private int width;

		private int depth;

		private static readonly int[] Rotations;

		public int Width => width;

		public int Depth => depth;

		public TileType(Int3[] sourceVerts, int[] sourceTris, Int3 tileSize, Int3 centerOffset, int width = 1, int depth = 1)
		{
			if (sourceVerts == null)
			{
				throw new ArgumentNullException("sourceVerts");
			}
			if (sourceTris == null)
			{
				throw new ArgumentNullException("sourceTris");
			}
			tris = new int[sourceTris.Length];
			for (int i = 0; i < tris.Length; i++)
			{
				tris[i] = sourceTris[i];
			}
			verts = new Int3[sourceVerts.Length];
			for (int j = 0; j < sourceVerts.Length; j++)
			{
				verts[j] = sourceVerts[j] + centerOffset;
			}
			offset = tileSize / 2f;
			offset.x *= width;
			offset.z *= depth;
			offset.y = 0;
			for (int k = 0; k < sourceVerts.Length; k++)
			{
				verts[k] += offset;
			}
			lastRotation = 0;
			lastYOffset = 0;
			this.width = width;
			this.depth = depth;
		}

		public TileType(Mesh source, Int3 tileSize, Int3 centerOffset, int width = 1, int depth = 1)
		{
			//IL_0048: Unknown result type (might be due to invalid IL or missing references)
			base._002Ector();
			if ((Object)(object)source == (Object)null)
			{
				throw new ArgumentNullException("source");
			}
			Vector3[] vertices = source.vertices;
			tris = source.triangles;
			verts = new Int3[vertices.Length];
			for (int i = 0; i < vertices.Length; i++)
			{
				verts[i] = (Int3)vertices[i] + centerOffset;
			}
			offset = tileSize / 2f;
			offset.x *= width;
			offset.z *= depth;
			offset.y = 0;
			for (int j = 0; j < vertices.Length; j++)
			{
				verts[j] += offset;
			}
			lastRotation = 0;
			lastYOffset = 0;
			this.width = width;
			this.depth = depth;
		}

		public void Load(out Int3[] verts, out int[] tris, int rotation, int yoffset)
		{
			rotation = (rotation % 4 + 4) % 4;
			int num = rotation;
			rotation = (rotation - lastRotation % 4 + 4) % 4;
			lastRotation = num;
			verts = this.verts;
			int num2 = yoffset - lastYOffset;
			lastYOffset = yoffset;
			if (rotation != 0 || num2 != 0)
			{
				for (int i = 0; i < verts.Length; i++)
				{
					Int3 @int = verts[i] - offset;
					Int3 int2 = @int;
					int2.y += num2;
					int2.x = @int.x * Rotations[rotation * 4] + @int.z * Rotations[rotation * 4 + 1];
					int2.z = @int.x * Rotations[rotation * 4 + 2] + @int.z * Rotations[rotation * 4 + 3];
					verts[i] = int2 + offset;
				}
			}
			tris = this.tris;
		}

		static TileType()
		{
			//IL_000d: Field data (rva=0xe38) could not be found in any section!
			//IL_000d: Field data (rva=0xe38) could not be found in any section!
			int[] array = new int[16];
			RuntimeHelpers.InitializeArray(array, (RuntimeFieldHandle)/*OpCode not supported: LdMemberToken*/);
			Rotations = array;
		}
	}

	[Flags]
	public enum CutMode
	{
		CutAll = 1,
		CutDual = 2,
		CutExtra = 4
	}

	private class Cut
	{
		public IntRect bounds;

		public Int2 boundsY;

		public bool isDual;

		public bool cutsAddedGeom;

		public List<IntPoint> contour;
	}

	private struct CuttingResult
	{
		public Int3[] verts;

		public int[] tris;
	}

	public readonly NavmeshBase graph;

	private readonly int tileXCount;

	private readonly int tileZCount;

	private readonly Clipper clipper = new Clipper();

	private readonly Dictionary<Int2, int> cached_Int2_int_dict = new Dictionary<Int2, int>();

	private readonly TileType[] activeTileTypes;

	private readonly int[] activeTileRotations;

	private readonly int[] activeTileOffsets;

	private readonly bool[] reloadedInBatch;

	public readonly GridLookup<NavmeshClipper> cuts;

	private bool isBatching;

	private readonly VoxelPolygonClipper simpleClipper;

	public bool isValid
	{
		get
		{
			if (graph != null && graph.exists && tileXCount == graph.tileXCount)
			{
				return tileZCount == graph.tileZCount;
			}
			return false;
		}
	}

	public TileHandler(NavmeshBase graph)
	{
		if (graph == null)
		{
			throw new ArgumentNullException("graph");
		}
		if (graph.GetTiles() == null)
		{
			Debug.LogWarning((object)"Creating a TileHandler for a graph with no tiles. Please scan the graph before creating a TileHandler");
		}
		tileXCount = graph.tileXCount;
		tileZCount = graph.tileZCount;
		activeTileTypes = new TileType[tileXCount * tileZCount];
		activeTileRotations = new int[activeTileTypes.Length];
		activeTileOffsets = new int[activeTileTypes.Length];
		reloadedInBatch = new bool[activeTileTypes.Length];
		cuts = new GridLookup<NavmeshClipper>(new Int2(tileXCount, tileZCount));
		this.graph = graph;
	}

	public void OnRecalculatedTiles(NavmeshTile[] recalculatedTiles)
	{
		for (int i = 0; i < recalculatedTiles.Length; i++)
		{
			UpdateTileType(recalculatedTiles[i]);
		}
		bool flag = StartBatchLoad();
		for (int j = 0; j < recalculatedTiles.Length; j++)
		{
			ReloadTile(recalculatedTiles[j].x, recalculatedTiles[j].z);
		}
		if (flag)
		{
			EndBatchLoad();
		}
	}

	public int GetActiveRotation(Int2 p)
	{
		return activeTileRotations[p.x + p.y * tileXCount];
	}

	[Obsolete("Use the result from RegisterTileType instead")]
	public TileType GetTileType(int index)
	{
		throw new Exception("This method has been deprecated. Use the result from RegisterTileType instead.");
	}

	[Obsolete("Use the result from RegisterTileType instead")]
	public int GetTileTypeCount()
	{
		throw new Exception("This method has been deprecated. Use the result from RegisterTileType instead.");
	}

	public TileType RegisterTileType(Mesh source, Int3 centerOffset, int width = 1, int depth = 1)
	{
		//IL_001c: Unknown result type (might be due to invalid IL or missing references)
		return new TileType(source, (Int3)new Vector3(graph.TileWorldSizeX, 0f, graph.TileWorldSizeZ), centerOffset, width, depth);
	}

	public void CreateTileTypesFromGraph()
	{
		NavmeshTile[] tiles = graph.GetTiles();
		if (tiles == null)
		{
			return;
		}
		if (!isValid)
		{
			throw new InvalidOperationException("Graph tiles are invalid (number of tiles is not equal to width*depth of the graph). You need to create a new tile handler if you have changed the graph.");
		}
		for (int i = 0; i < tileZCount; i++)
		{
			for (int j = 0; j < tileXCount; j++)
			{
				NavmeshTile tile = tiles[j + i * tileXCount];
				UpdateTileType(tile);
			}
		}
	}

	private void UpdateTileType(NavmeshTile tile)
	{
		//IL_0029: Unknown result type (might be due to invalid IL or missing references)
		//IL_003e: Unknown result type (might be due to invalid IL or missing references)
		//IL_0043: Unknown result type (might be due to invalid IL or missing references)
		//IL_0046: Unknown result type (might be due to invalid IL or missing references)
		int x = tile.x;
		int z = tile.z;
		Int3 tileSize = (Int3)new Vector3(graph.TileWorldSizeX, 0f, graph.TileWorldSizeZ);
		Bounds tileBoundsInGraphSpace = graph.GetTileBoundsInGraphSpace(x, z);
		Int3 centerOffset = -((Int3)((Bounds)(ref tileBoundsInGraphSpace)).min + new Int3(tileSize.x * tile.w / 2, 0, tileSize.z * tile.d / 2));
		TileType tileType = new TileType(tile.vertsInGraphSpace, tile.tris, tileSize, centerOffset, tile.w, tile.d);
		int num = x + z * tileXCount;
		activeTileTypes[num] = tileType;
		activeTileRotations[num] = 0;
		activeTileOffsets[num] = 0;
	}

	public bool StartBatchLoad()
	{
		if (isBatching)
		{
			return false;
		}
		isBatching = true;
		AstarPath.active.AddWorkItem(new AstarWorkItem((Func<bool, bool>)delegate
		{
			graph.StartBatchTileUpdate();
			return true;
		}));
		return true;
	}

	public void EndBatchLoad()
	{
		if (!isBatching)
		{
			throw new Exception("Ending batching when batching has not been started");
		}
		for (int i = 0; i < reloadedInBatch.Length; i++)
		{
			reloadedInBatch[i] = false;
		}
		isBatching = false;
		AstarPath.active.AddWorkItem(new AstarWorkItem((Func<bool, bool>)delegate
		{
			graph.EndBatchTileUpdate();
			return true;
		}));
	}

	private CuttingResult CutPoly(Int3[] verts, int[] tris, Int3[] extraShape, GraphTransform graphTransform, IntRect tiles, CutMode mode = CutMode.CutAll | CutMode.CutDual, int perturbate = -1)
	{
		//IL_0076: Unknown result type (might be due to invalid IL or missing references)
		//IL_007b: Unknown result type (might be due to invalid IL or missing references)
		//IL_007e: Unknown result type (might be due to invalid IL or missing references)
		//IL_0083: Unknown result type (might be due to invalid IL or missing references)
		//IL_0086: Unknown result type (might be due to invalid IL or missing references)
		//IL_0087: Unknown result type (might be due to invalid IL or missing references)
		//IL_008c: Unknown result type (might be due to invalid IL or missing references)
		//IL_0091: Unknown result type (might be due to invalid IL or missing references)
		//IL_00a0: Unknown result type (might be due to invalid IL or missing references)
		//IL_00ac: Unknown result type (might be due to invalid IL or missing references)
		//IL_0273: Unknown result type (might be due to invalid IL or missing references)
		//IL_0275: Unknown result type (might be due to invalid IL or missing references)
		//IL_0284: Unknown result type (might be due to invalid IL or missing references)
		//IL_0286: Unknown result type (might be due to invalid IL or missing references)
		if (verts.Length == 0 || tris.Length == 0)
		{
			return new CuttingResult
			{
				verts = ArrayPool<Int3>.Claim(0),
				tris = ArrayPool<int>.Claim(0)
			};
		}
		if (perturbate > 10)
		{
			Debug.LogError((object)"Too many perturbations aborting.\nThis may cause a tile in the navmesh to become empty. Try to see see if any of your NavmeshCut or NavmeshAdd components use invalid custom meshes.");
			return new CuttingResult
			{
				verts = verts,
				tris = tris
			};
		}
		List<IntPoint> list = null;
		if (extraShape == null && (mode & CutMode.CutExtra) != 0)
		{
			throw new Exception("extraShape is null and the CutMode specifies that it should be used. Cannot use null shape.");
		}
		Bounds tileBoundsInGraphSpace = graph.GetTileBoundsInGraphSpace(tiles);
		Vector3 min = ((Bounds)(ref tileBoundsInGraphSpace)).min;
		GraphTransform graphTransform2 = graphTransform * Matrix4x4.TRS(min, Quaternion.identity, Vector3.one);
		Vector2 val = default(Vector2);
		((Vector2)(ref val))._002Ector(((Bounds)(ref tileBoundsInGraphSpace)).size.x, ((Bounds)(ref tileBoundsInGraphSpace)).size.z);
		if ((mode & CutMode.CutExtra) != 0)
		{
			list = ListPool<IntPoint>.Claim(extraShape.Length);
			for (int i = 0; i < extraShape.Length; i++)
			{
				Int3 @int = graphTransform2.InverseTransform(extraShape[i]);
				list.Add(new IntPoint(@int.x, @int.z));
			}
		}
		IntRect cutSpaceBounds = new IntRect(verts[0].x, verts[0].z, verts[0].x, verts[0].z);
		for (int j = 0; j < verts.Length; j++)
		{
			cutSpaceBounds = cutSpaceBounds.ExpandToContain(verts[j].x, verts[j].z);
		}
		List<NavmeshCut> list2 = ((mode != CutMode.CutExtra) ? cuts.QueryRect<NavmeshCut>(tiles) : ListPool<NavmeshCut>.Claim());
		List<NavmeshAdd> list3 = cuts.QueryRect<NavmeshAdd>(tiles);
		List<int> list4 = ListPool<int>.Claim();
		List<Cut> list5 = PrepareNavmeshCutsForCutting(list2, graphTransform2, cutSpaceBounds, perturbate, list3.Count > 0);
		List<Int3> list6 = ListPool<Int3>.Claim(verts.Length * 2);
		List<int> list7 = ListPool<int>.Claim(tris.Length);
		if (list2.Count == 0 && list3.Count == 0 && (mode & ~(CutMode.CutAll | CutMode.CutDual)) == 0 && (mode & CutMode.CutAll) != 0)
		{
			CopyMesh(verts, tris, list6, list7);
		}
		else
		{
			List<IntPoint> list8 = ListPool<IntPoint>.Claim();
			Dictionary<TriangulationPoint, int> dictionary = new Dictionary<TriangulationPoint, int>();
			List<PolygonPoint> list9 = ListPool<PolygonPoint>.Claim();
			PolyTree polyTree = new PolyTree();
			List<List<IntPoint>> list10 = ListPool<List<IntPoint>>.Claim();
			Stack<Pathfinding.Poly2Tri.Polygon> stack = StackPool<Pathfinding.Poly2Tri.Polygon>.Claim();
			clipper.StrictlySimple = perturbate > -1;
			clipper.ReverseSolution = true;
			Int3[] array = null;
			Int3[] clipOut = null;
			Int2 size = default(Int2);
			if (list3.Count > 0)
			{
				array = new Int3[7];
				clipOut = new Int3[7];
				size = new Int2(((Int3)Vector2.op_Implicit(val)).x, ((Int3)Vector2.op_Implicit(val)).y);
			}
			Int3[] vbuffer = null;
			for (int k = -1; k < list3.Count; k++)
			{
				Int3[] array2;
				int[] tbuffer;
				if (k == -1)
				{
					array2 = verts;
					tbuffer = tris;
				}
				else
				{
					list3[k].GetMesh(ref vbuffer, out tbuffer, graphTransform2);
					array2 = vbuffer;
				}
				for (int l = 0; l < tbuffer.Length; l += 3)
				{
					Int3 int2 = array2[tbuffer[l]];
					Int3 int3 = array2[tbuffer[l + 1]];
					Int3 int4 = array2[tbuffer[l + 2]];
					if (VectorMath.IsColinearXZ(int2, int3, int4))
					{
						Debug.LogWarning((object)"Skipping degenerate triangle.");
						continue;
					}
					IntRect a = new IntRect(int2.x, int2.z, int2.x, int2.z).ExpandToContain(int3.x, int3.z).ExpandToContain(int4.x, int4.z);
					int num = Math.Min(int2.y, Math.Min(int3.y, int4.y));
					int num2 = Math.Max(int2.y, Math.Max(int3.y, int4.y));
					list4.Clear();
					bool flag = false;
					for (int m = 0; m < list5.Count; m++)
					{
						int x = list5[m].boundsY.x;
						int y = list5[m].boundsY.y;
						if (IntRect.Intersects(a, list5[m].bounds) && y >= num && x <= num2 && (list5[m].cutsAddedGeom || k == -1))
						{
							Int3 int5 = int2;
							int5.y = x;
							Int3 int6 = int2;
							int6.y = y;
							list4.Add(m);
							flag |= list5[m].isDual;
						}
					}
					if (list4.Count == 0 && (mode & CutMode.CutExtra) == 0 && (mode & CutMode.CutAll) != 0 && k == -1)
					{
						list7.Add(list6.Count);
						list7.Add(list6.Count + 1);
						list7.Add(list6.Count + 2);
						list6.Add(int2);
						list6.Add(int3);
						list6.Add(int4);
						continue;
					}
					list8.Clear();
					if (k == -1)
					{
						list8.Add(new IntPoint(int2.x, int2.z));
						list8.Add(new IntPoint(int3.x, int3.z));
						list8.Add(new IntPoint(int4.x, int4.z));
					}
					else
					{
						array[0] = int2;
						array[1] = int3;
						array[2] = int4;
						int num3 = ClipAgainstRectangle(array, clipOut, size);
						if (num3 == 0)
						{
							continue;
						}
						for (int n = 0; n < num3; n++)
						{
							list8.Add(new IntPoint(array[n].x, array[n].z));
						}
					}
					dictionary.Clear();
					for (int num4 = 0; num4 < 16; num4++)
					{
						if ((((int)mode >> num4) & 1) == 0)
						{
							continue;
						}
						if (1 << num4 == 1)
						{
							CutAll(list8, list4, list5, polyTree);
						}
						else if (1 << num4 == 2)
						{
							if (!flag)
							{
								continue;
							}
							CutDual(list8, list4, list5, flag, list10, polyTree);
						}
						else if (1 << num4 == 4)
						{
							CutExtra(list8, list, polyTree);
						}
						for (int num5 = 0; num5 < polyTree.ChildCount; num5++)
						{
							PolyNode polyNode = polyTree.Childs[num5];
							List<IntPoint> contour = polyNode.Contour;
							List<PolyNode> childs = polyNode.Childs;
							if (childs.Count == 0 && contour.Count == 3 && k == -1)
							{
								for (int num6 = 0; num6 < 3; num6++)
								{
									Int3 int7 = new Int3((int)contour[num6].X, 0, (int)contour[num6].Y);
									int7.y = SampleYCoordinateInTriangle(int2, int3, int4, int7);
									list7.Add(list6.Count);
									list6.Add(int7);
								}
								continue;
							}
							Pathfinding.Poly2Tri.Polygon polygon = null;
							int num7 = -1;
							for (List<IntPoint> list11 = contour; list11 != null; list11 = ((num7 < childs.Count) ? childs[num7].Contour : null))
							{
								list9.Clear();
								for (int num8 = 0; num8 < list11.Count; num8++)
								{
									PolygonPoint polygonPoint = new PolygonPoint(list11[num8].X, list11[num8].Y);
									list9.Add(polygonPoint);
									Int3 int8 = new Int3((int)list11[num8].X, 0, (int)list11[num8].Y);
									int8.y = SampleYCoordinateInTriangle(int2, int3, int4, int8);
									dictionary[polygonPoint] = list6.Count;
									list6.Add(int8);
								}
								Pathfinding.Poly2Tri.Polygon polygon2 = null;
								if (stack.Count > 0)
								{
									polygon2 = stack.Pop();
									polygon2.AddPoints(list9);
								}
								else
								{
									polygon2 = new Pathfinding.Poly2Tri.Polygon(list9);
								}
								if (num7 == -1)
								{
									polygon = polygon2;
								}
								else
								{
									polygon.AddHole(polygon2);
								}
								num7++;
							}
							try
							{
								P2T.Triangulate(polygon);
							}
							catch (PointOnEdgeException)
							{
								Debug.LogWarning((object)"PointOnEdgeException, perturbating vertices slightly.\nThis is usually fine. It happens sometimes because of rounding errors. Cutting will be retried a few more times.");
								return CutPoly(verts, tris, extraShape, graphTransform, tiles, mode, perturbate + 1);
							}
							try
							{
								for (int num9 = 0; num9 < polygon.Triangles.Count; num9++)
								{
									DelaunayTriangle delaunayTriangle = polygon.Triangles[num9];
									list7.Add(dictionary[delaunayTriangle.Points._0]);
									list7.Add(dictionary[delaunayTriangle.Points._1]);
									list7.Add(dictionary[delaunayTriangle.Points._2]);
								}
							}
							catch (KeyNotFoundException)
							{
								Debug.LogWarning((object)"KeyNotFoundException, perturbating vertices slightly.\nThis is usually fine. It happens sometimes because of rounding errors. Cutting will be retried a few more times.");
								return CutPoly(verts, tris, extraShape, graphTransform, tiles, mode, perturbate + 1);
							}
							PoolPolygon(polygon, stack);
						}
					}
				}
			}
			if (vbuffer != null)
			{
				ArrayPool<Int3>.Release(ref vbuffer);
			}
			StackPool<Pathfinding.Poly2Tri.Polygon>.Release(stack);
			ListPool<List<IntPoint>>.Release(list10);
			ListPool<IntPoint>.Release(list8);
			ListPool<PolygonPoint>.Release(list9);
		}
		CuttingResult result = default(CuttingResult);
		Polygon.CompressMesh(list6, list7, out result.verts, out result.tris);
		for (int num10 = 0; num10 < list2.Count; num10++)
		{
			list2[num10].UsedForCut();
		}
		ListPool<Int3>.Release(list6);
		ListPool<int>.Release(list7);
		ListPool<int>.Release(list4);
		for (int num11 = 0; num11 < list5.Count; num11++)
		{
			ListPool<IntPoint>.Release(list5[num11].contour);
		}
		ListPool<Cut>.Release(list5);
		ListPool<NavmeshCut>.Release(list2);
		return result;
	}

	private static List<Cut> PrepareNavmeshCutsForCutting(List<NavmeshCut> navmeshCuts, GraphTransform transform, IntRect cutSpaceBounds, int perturbate, bool anyNavmeshAdds)
	{
		//IL_00ed: Unknown result type (might be due to invalid IL or missing references)
		//IL_00f2: Unknown result type (might be due to invalid IL or missing references)
		Random random = null;
		if (perturbate > 0)
		{
			random = new Random();
		}
		List<List<Vector3>> list = ListPool<List<Vector3>>.Claim();
		List<Cut> list2 = ListPool<Cut>.Claim();
		for (int i = 0; i < navmeshCuts.Count; i++)
		{
			Int2 @int = new Int2(0, 0);
			if (perturbate > 0)
			{
				@int.x = random.Next() % 6 * perturbate - 3 * perturbate;
				if (@int.x >= 0)
				{
					@int.x++;
				}
				@int.y = random.Next() % 6 * perturbate - 3 * perturbate;
				if (@int.y >= 0)
				{
					@int.y++;
				}
			}
			list.Clear();
			navmeshCuts[i].GetContour(list);
			int num = (int)(navmeshCuts[i].GetY(transform) * 1000f);
			for (int j = 0; j < list.Count; j++)
			{
				List<Vector3> list3 = list[j];
				if (list3.Count == 0)
				{
					Debug.LogError((object)"A NavmeshCut component had a zero length contour. Ignoring that contour.");
					continue;
				}
				List<IntPoint> list4 = ListPool<IntPoint>.Claim(list3.Count);
				for (int k = 0; k < list3.Count; k++)
				{
					Int3 int2 = (Int3)transform.InverseTransform(list3[k]);
					if (perturbate > 0)
					{
						int2.x += @int.x;
						int2.z += @int.y;
					}
					list4.Add(new IntPoint(int2.x, int2.z));
				}
				IntRect bounds = new IntRect((int)list4[0].X, (int)list4[0].Y, (int)list4[0].X, (int)list4[0].Y);
				for (int l = 0; l < list4.Count; l++)
				{
					IntPoint intPoint = list4[l];
					bounds = bounds.ExpandToContain((int)intPoint.X, (int)intPoint.Y);
				}
				Cut cut = new Cut();
				int num2 = (int)(navmeshCuts[i].height * 0.5f * 1000f);
				cut.boundsY = new Int2(num - num2, num + num2);
				cut.bounds = bounds;
				cut.isDual = navmeshCuts[i].isDual;
				cut.cutsAddedGeom = navmeshCuts[i].cutsAddedGeom;
				cut.contour = list4;
				list2.Add(cut);
			}
		}
		ListPool<List<Vector3>>.Release(list);
		return list2;
	}

	private static void PoolPolygon(Pathfinding.Poly2Tri.Polygon polygon, Stack<Pathfinding.Poly2Tri.Polygon> pool)
	{
		if (polygon.Holes != null)
		{
			for (int i = 0; i < polygon.Holes.Count; i++)
			{
				polygon.Holes[i].Points.Clear();
				polygon.Holes[i].ClearTriangles();
				if (polygon.Holes[i].Holes != null)
				{
					polygon.Holes[i].Holes.Clear();
				}
				pool.Push(polygon.Holes[i]);
			}
		}
		polygon.ClearTriangles();
		if (polygon.Holes != null)
		{
			polygon.Holes.Clear();
		}
		polygon.Points.Clear();
		pool.Push(polygon);
	}

	private static int SampleYCoordinateInTriangle(Int3 p1, Int3 p2, Int3 p3, Int3 p)
	{
		double num = (double)(p2.z - p3.z) * (double)(p1.x - p3.x) + (double)(p3.x - p2.x) * (double)(p1.z - p3.z);
		double num2 = ((double)(p2.z - p3.z) * (double)(p.x - p3.x) + (double)(p3.x - p2.x) * (double)(p.z - p3.z)) / num;
		double num3 = ((double)(p3.z - p1.z) * (double)(p.x - p3.x) + (double)(p1.x - p3.x) * (double)(p.z - p3.z)) / num;
		return (int)Math.Round(num2 * (double)p1.y + num3 * (double)p2.y + (1.0 - num2 - num3) * (double)p3.y);
	}

	private void CutAll(List<IntPoint> poly, List<int> intersectingCutIndices, List<Cut> cuts, PolyTree result)
	{
		clipper.Clear();
		clipper.AddPolygon(poly, PolyType.ptSubject);
		for (int i = 0; i < intersectingCutIndices.Count; i++)
		{
			clipper.AddPolygon(cuts[intersectingCutIndices[i]].contour, PolyType.ptClip);
		}
		result.Clear();
		clipper.Execute(ClipType.ctDifference, result, PolyFillType.pftNonZero, PolyFillType.pftNonZero);
	}

	private void CutDual(List<IntPoint> poly, List<int> tmpIntersectingCuts, List<Cut> cuts, bool hasDual, List<List<IntPoint>> intermediateResult, PolyTree result)
	{
		clipper.Clear();
		clipper.AddPolygon(poly, PolyType.ptSubject);
		for (int i = 0; i < tmpIntersectingCuts.Count; i++)
		{
			if (cuts[tmpIntersectingCuts[i]].isDual)
			{
				clipper.AddPolygon(cuts[tmpIntersectingCuts[i]].contour, PolyType.ptClip);
			}
		}
		clipper.Execute(ClipType.ctIntersection, intermediateResult, PolyFillType.pftEvenOdd, PolyFillType.pftNonZero);
		clipper.Clear();
		if (intermediateResult != null)
		{
			for (int j = 0; j < intermediateResult.Count; j++)
			{
				clipper.AddPolygon(intermediateResult[j], Clipper.Orientation(intermediateResult[j]) ? PolyType.ptClip : PolyType.ptSubject);
			}
		}
		for (int k = 0; k < tmpIntersectingCuts.Count; k++)
		{
			if (!cuts[tmpIntersectingCuts[k]].isDual)
			{
				clipper.AddPolygon(cuts[tmpIntersectingCuts[k]].contour, PolyType.ptClip);
			}
		}
		result.Clear();
		clipper.Execute(ClipType.ctDifference, result, PolyFillType.pftEvenOdd, PolyFillType.pftNonZero);
	}

	private void CutExtra(List<IntPoint> poly, List<IntPoint> extraClipShape, PolyTree result)
	{
		clipper.Clear();
		clipper.AddPolygon(poly, PolyType.ptSubject);
		clipper.AddPolygon(extraClipShape, PolyType.ptClip);
		result.Clear();
		clipper.Execute(ClipType.ctIntersection, result, PolyFillType.pftEvenOdd, PolyFillType.pftNonZero);
	}

	private int ClipAgainstRectangle(Int3[] clipIn, Int3[] clipOut, Int2 size)
	{
		int num = simpleClipper.ClipPolygon(clipIn, 3, clipOut, 1, 0, 0);
		if (num == 0)
		{
			return num;
		}
		num = simpleClipper.ClipPolygon(clipOut, num, clipIn, -1, size.x, 0);
		if (num == 0)
		{
			return num;
		}
		num = simpleClipper.ClipPolygon(clipIn, num, clipOut, 1, 0, 2);
		if (num == 0)
		{
			return num;
		}
		return simpleClipper.ClipPolygon(clipOut, num, clipIn, -1, size.y, 2);
	}

	private static void CopyMesh(Int3[] vertices, int[] triangles, List<Int3> outVertices, List<int> outTriangles)
	{
		outTriangles.Capacity = Math.Max(outTriangles.Capacity, triangles.Length);
		outVertices.Capacity = Math.Max(outVertices.Capacity, vertices.Length);
		for (int i = 0; i < vertices.Length; i++)
		{
			outVertices.Add(vertices[i]);
		}
		for (int j = 0; j < triangles.Length; j++)
		{
			outTriangles.Add(triangles[j]);
		}
	}

	private void DelaunayRefinement(Int3[] verts, int[] tris, ref int tCount, bool delaunay, bool colinear)
	{
		if (tCount % 3 != 0)
		{
			throw new ArgumentException("Triangle array length must be a multiple of 3");
		}
		Dictionary<Int2, int> dictionary = cached_Int2_int_dict;
		dictionary.Clear();
		for (int i = 0; i < tCount; i += 3)
		{
			if (!VectorMath.IsClockwiseXZ(verts[tris[i]], verts[tris[i + 1]], verts[tris[i + 2]]))
			{
				int num = tris[i];
				tris[i] = tris[i + 2];
				tris[i + 2] = num;
			}
			dictionary[new Int2(tris[i], tris[i + 1])] = i + 2;
			dictionary[new Int2(tris[i + 1], tris[i + 2])] = i;
			dictionary[new Int2(tris[i + 2], tris[i])] = i + 1;
		}
		for (int j = 0; j < tCount; j += 3)
		{
			for (int k = 0; k < 3; k++)
			{
				if (!dictionary.TryGetValue(new Int2(tris[j + (k + 1) % 3], tris[j + k % 3]), out var value))
				{
					continue;
				}
				Int3 @int = verts[tris[j + (k + 2) % 3]];
				Int3 int2 = verts[tris[j + (k + 1) % 3]];
				Int3 int3 = verts[tris[j + (k + 3) % 3]];
				Int3 int4 = verts[tris[value]];
				@int.y = 0;
				int2.y = 0;
				int3.y = 0;
				int4.y = 0;
				bool flag = false;
				if (!VectorMath.RightOrColinearXZ(@int, int3, int4) || VectorMath.RightXZ(@int, int2, int4))
				{
					if (!colinear)
					{
						continue;
					}
					flag = true;
				}
				if (colinear && VectorMath.SqrDistancePointSegmentApproximate(@int, int4, int2) < 9f && !dictionary.ContainsKey(new Int2(tris[j + (k + 2) % 3], tris[j + (k + 1) % 3])) && !dictionary.ContainsKey(new Int2(tris[j + (k + 1) % 3], tris[value])))
				{
					tCount -= 3;
					int num2 = value / 3 * 3;
					tris[j + (k + 1) % 3] = tris[value];
					if (num2 != tCount)
					{
						tris[num2] = tris[tCount];
						tris[num2 + 1] = tris[tCount + 1];
						tris[num2 + 2] = tris[tCount + 2];
						dictionary[new Int2(tris[num2], tris[num2 + 1])] = num2 + 2;
						dictionary[new Int2(tris[num2 + 1], tris[num2 + 2])] = num2;
						dictionary[new Int2(tris[num2 + 2], tris[num2])] = num2 + 1;
						tris[tCount] = 0;
						tris[tCount + 1] = 0;
						tris[tCount + 2] = 0;
					}
					else
					{
						tCount += 3;
					}
					dictionary[new Int2(tris[j], tris[j + 1])] = j + 2;
					dictionary[new Int2(tris[j + 1], tris[j + 2])] = j;
					dictionary[new Int2(tris[j + 2], tris[j])] = j + 1;
				}
				else if (delaunay && !flag)
				{
					float num3 = Int3.Angle(int2 - @int, int3 - @int);
					float num4 = Int3.Angle(int2 - int4, int3 - int4);
					if (num4 > MathF.PI * 2f - 2f * num3)
					{
						tris[j + (k + 1) % 3] = tris[value];
						int num5 = value / 3 * 3;
						int num6 = value - num5;
						tris[num5 + (num6 - 1 + 3) % 3] = tris[j + (k + 2) % 3];
						dictionary[new Int2(tris[j], tris[j + 1])] = j + 2;
						dictionary[new Int2(tris[j + 1], tris[j + 2])] = j;
						dictionary[new Int2(tris[j + 2], tris[j])] = j + 1;
						dictionary[new Int2(tris[num5], tris[num5 + 1])] = num5 + 2;
						dictionary[new Int2(tris[num5 + 1], tris[num5 + 2])] = num5;
						dictionary[new Int2(tris[num5 + 2], tris[num5])] = num5 + 1;
					}
				}
			}
		}
	}

	public void ClearTile(int x, int z)
	{
		if (AstarPath.active != null && x >= 0 && z >= 0 && x < tileXCount && z < tileZCount)
		{
			AstarPath.active.AddWorkItem(new AstarWorkItem(delegate(IWorkItemContext context, bool force)
			{
				graph.ReplaceTile(x, z, new Int3[0], new int[0]);
				activeTileTypes[x + z * tileXCount] = null;
				GraphModifier.TriggerEvent(GraphModifier.EventType.PostUpdate);
				context.QueueFloodFill();
				return true;
			}));
		}
	}

	public void ReloadInBounds(Bounds bounds)
	{
		//IL_0007: Unknown result type (might be due to invalid IL or missing references)
		ReloadInBounds(graph.GetTouchingTiles(bounds));
	}

	public void ReloadInBounds(IntRect tiles)
	{
		tiles = IntRect.Intersection(tiles, new IntRect(0, 0, tileXCount - 1, tileZCount - 1));
		if (!tiles.IsValid())
		{
			return;
		}
		for (int i = tiles.ymin; i <= tiles.ymax; i++)
		{
			for (int j = tiles.xmin; j <= tiles.xmax; j++)
			{
				ReloadTile(j, i);
			}
		}
	}

	public void ReloadTile(int x, int z)
	{
		if (x >= 0 && z >= 0 && x < tileXCount && z < tileZCount)
		{
			int num = x + z * tileXCount;
			if (activeTileTypes[num] != null)
			{
				LoadTile(activeTileTypes[num], x, z, activeTileRotations[num], activeTileOffsets[num]);
			}
		}
	}

	public void LoadTile(TileType tile, int x, int z, int rotation, int yoffset)
	{
		if (tile == null)
		{
			throw new ArgumentNullException("tile");
		}
		if (AstarPath.active == null)
		{
			return;
		}
		int index = x + z * tileXCount;
		rotation %= 4;
		if (isBatching && reloadedInBatch[index] && activeTileOffsets[index] == yoffset && activeTileRotations[index] == rotation && activeTileTypes[index] == tile)
		{
			return;
		}
		reloadedInBatch[index] |= isBatching;
		activeTileOffsets[index] = yoffset;
		activeTileRotations[index] = rotation;
		activeTileTypes[index] = tile;
		AstarPath.active.AddWorkItem(new AstarWorkItem(delegate(IWorkItemContext context, bool force)
		{
			if (activeTileOffsets[index] != yoffset || activeTileRotations[index] != rotation || activeTileTypes[index] != tile)
			{
				return true;
			}
			GraphModifier.TriggerEvent(GraphModifier.EventType.PreUpdate);
			tile.Load(out var verts, out var tris, rotation, yoffset);
			CuttingResult cuttingResult = CutPoly(verts, tris, null, graph.transform, new IntRect(x, z, x + tile.Width - 1, z + tile.Depth - 1));
			int tCount = cuttingResult.tris.Length;
			DelaunayRefinement(cuttingResult.verts, cuttingResult.tris, ref tCount, delaunay: true, colinear: false);
			if (tCount != cuttingResult.tris.Length)
			{
				cuttingResult.tris = Memory.ShrinkArray(cuttingResult.tris, tCount);
			}
			int w = ((rotation % 2 == 0) ? tile.Width : tile.Depth);
			int d = ((rotation % 2 == 0) ? tile.Depth : tile.Width);
			graph.ReplaceTile(x, z, w, d, cuttingResult.verts, cuttingResult.tris);
			GraphModifier.TriggerEvent(GraphModifier.EventType.PostUpdate);
			context.QueueFloodFill();
			return true;
		}));
	}
}
