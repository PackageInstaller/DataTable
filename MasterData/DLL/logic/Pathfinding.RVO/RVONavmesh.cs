using System;
using System.Collections.Generic;
using Pathfinding.Util;
using UnityEngine;

namespace Pathfinding.RVO;

[AddComponentMenu("Pathfinding/Local Avoidance/RVO Navmesh")]
[HelpURL("http://arongranberg.com/astar/docs/class_pathfinding_1_1_r_v_o_1_1_r_v_o_navmesh.php")]
public class RVONavmesh : GraphModifier
{
	public Int wallHeight = 10000;

	private readonly List<ObstacleVertex> obstacles = new List<ObstacleVertex>();

	private Simulator lastSim;

	public override void OnPostCacheLoad()
	{
		OnLatePostScan();
	}

	public override void OnGraphsPostUpdate()
	{
		OnLatePostScan();
	}

	public override void OnLatePostScan()
	{
		RemoveObstacles();
		NavGraph[] graphs = AstarPath.active.graphs;
		lastSim = SimRVOSystem.RVOSimulator;
		for (int i = 0; i < graphs.Length; i++)
		{
			RecastGraph recastGraph = graphs[i] as RecastGraph;
			INavmesh navmesh = graphs[i] as INavmesh;
			GridGraph gridGraph = graphs[i] as GridGraph;
			if (recastGraph != null)
			{
				NavmeshTile[] tiles = recastGraph.GetTiles();
				foreach (NavmeshTile ng in tiles)
				{
					AddGraphObstacles(lastSim, ng);
				}
			}
			else if (navmesh != null)
			{
				AddGraphObstacles(lastSim, navmesh);
			}
			else if (gridGraph != null)
			{
				AddGraphObstacles(lastSim, gridGraph);
			}
		}
	}

	public void RemoveObstacles()
	{
		if (lastSim != null)
		{
			for (int i = 0; i < obstacles.Count; i++)
			{
				lastSim.RemoveObstacle(obstacles[i]);
			}
			lastSim = null;
		}
		obstacles.Clear();
	}

	private void AddGraphObstacles(Simulator sim, GridGraph grid)
	{
		FindAllContours(grid, delegate(Int3[] vertices, bool cycle)
		{
			obstacles.Add(sim.AddObstacle(vertices, wallHeight));
		});
	}

	private static void FindAllContours(GridGraph grid, Action<Int3[], bool> callback, GridNodeBase[] nodes = null)
	{
		//IL_016b: Unknown result type (might be due to invalid IL or missing references)
		//IL_0170: Unknown result type (might be due to invalid IL or missing references)
		//IL_0185: Unknown result type (might be due to invalid IL or missing references)
		//IL_0187: Unknown result type (might be due to invalid IL or missing references)
		//IL_0188: Unknown result type (might be due to invalid IL or missing references)
		//IL_018a: Unknown result type (might be due to invalid IL or missing references)
		//IL_01d8: Unknown result type (might be due to invalid IL or missing references)
		//IL_01e1: Unknown result type (might be due to invalid IL or missing references)
		if (grid is LayerGridGraph)
		{
			nodes = nodes ?? (grid as LayerGridGraph).nodes;
		}
		nodes = nodes ?? grid.nodes;
		int[] neighbourXOffsets = grid.neighbourXOffsets;
		int[] neighbourZOffsets = grid.neighbourZOffsets;
		int[] array = ((grid.neighbours == NumNeighbours.Six) ? GridGraph.hexagonNeighbourIndices : new int[4] { -9985, -9984, -9983, -9982 });
		float num = ((grid.neighbours == NumNeighbours.Six) ? 0.3f : 0.5f);
		if (nodes == null)
		{
			return;
		}
		Dictionary<Int3, int> dictionary = new Dictionary<Int3, int>();
		Dictionary<int, int> dictionary2 = new Dictionary<int, int>();
		HashSet<int> hashSet = new HashSet<int>();
		List<Int3> vertices = ListPool<Int3>.Claim();
		Vector3 val = default(Vector3);
		foreach (GridNodeBase gridNodeBase in nodes)
		{
			if (gridNodeBase == null || !gridNodeBase.Walkable || gridNodeBase.HasConnectionsToAllEightNeighbours)
			{
				continue;
			}
			for (int j = 0; j < array.Length; j++)
			{
				int num2 = array[j];
				if (gridNodeBase.GetNeighbourAlongDirection(num2) == null)
				{
					int num3 = array[(j - 1 + array.Length) % array.Length];
					int num4 = array[(j + 1) % array.Length];
					((Vector3)(ref val))._002Ector((float)gridNodeBase.XCoordinateInGrid + 0.5f, 0f, (float)gridNodeBase.ZCoordinateInGrid + 0.5f);
					val.x += (float)neighbourXOffsets[num2] * num;
					val.z += (float)neighbourZOffsets[num2] * num;
					val.y = ((Int3)grid.transform.InverseTransform((Vector3)gridNodeBase.position)).y;
					Vector3 val3;
					Vector3 val2 = (val3 = val);
					val2.x += (float)neighbourXOffsets[num3] * num;
					val2.z += (float)neighbourZOffsets[num3] * num;
					val3.x += (float)neighbourXOffsets[num4] * num;
					val3.z += (float)neighbourZOffsets[num4] * num;
					Int3 @int = (Int3)val2;
					Int3 int2 = (Int3)val3;
					if (dictionary.TryGetValue(@int, out var value))
					{
						dictionary.Remove(@int);
					}
					else
					{
						int num5 = (dictionary[@int] = vertices.Count);
						value = num5;
						vertices.Add(@int);
					}
					if (dictionary.TryGetValue(int2, out var value2))
					{
						dictionary.Remove(int2);
					}
					else
					{
						int num5 = (dictionary[int2] = vertices.Count);
						value2 = num5;
						vertices.Add(int2);
					}
					dictionary2.Add(value, value2);
					hashSet.Add(value2);
				}
			}
		}
		GraphTransform transform = grid.transform;
		List<Int3> vertexBuffer = ListPool<Int3>.Claim();
		CompressContour(dictionary2, hashSet, delegate(List<int> chain, bool cycle)
		{
			vertexBuffer.Clear();
			Int3 int3 = vertices[chain[0]];
			vertexBuffer.Add(int3);
			for (int k = 1; k < chain.Count - 1; k++)
			{
				Int3 int4 = vertices[chain[k]];
				Int3 int5 = int4 - int3;
				Int3 int6 = vertices[chain[k + 1]] - int3;
				if ((((float)Mathf.Abs(int5.x) > 0.01f || (float)Mathf.Abs(int6.x) > 0.01f) && ((float)Mathf.Abs(int5.z) > 0.01f || (float)Mathf.Abs(int6.z) > 0.01f)) || (float)Mathf.Abs(int5.y) > 0.01f || (float)Mathf.Abs(int6.y) > 0.01f)
				{
					vertexBuffer.Add(int4);
				}
				int3 = int4;
			}
			vertexBuffer.Add(vertices[chain[chain.Count - 1]]);
			Int3[] array2 = vertexBuffer.ToArray();
			transform.Transform(array2);
			callback(array2, cycle);
		});
		ListPool<Int3>.Release(vertexBuffer);
		ListPool<Int3>.Release(vertices);
	}

	private void AddGraphObstacles(Simulator sim, INavmesh ng)
	{
		int[] uses = new int[3];
		Dictionary<int, int> outline = new Dictionary<int, int>();
		Dictionary<int, Int3> vertexPositions = new Dictionary<int, Int3>();
		HashSet<int> hasInEdge = new HashSet<int>();
		ng.GetNodes(delegate(GraphNode _node)
		{
			TriangleMeshNode triangleMeshNode = _node as TriangleMeshNode;
			uses[0] = (uses[1] = (uses[2] = 0));
			if (triangleMeshNode != null)
			{
				for (int i = 0; i < triangleMeshNode.connections.Length; i++)
				{
					if (triangleMeshNode.connections[i].node is TriangleMeshNode other)
					{
						int num = triangleMeshNode.SharedEdge(other);
						if (num != -1)
						{
							uses[num] = 1;
						}
					}
				}
				for (int j = 0; j < 3; j++)
				{
					if (uses[j] == 0)
					{
						int i2 = j;
						int i3 = (j + 1) % triangleMeshNode.GetVertexCount();
						outline[triangleMeshNode.GetVertexIndex(i2)] = triangleMeshNode.GetVertexIndex(i3);
						hasInEdge.Add(triangleMeshNode.GetVertexIndex(i3));
						vertexPositions[triangleMeshNode.GetVertexIndex(i2)] = triangleMeshNode.GetVertex(i2);
						vertexPositions[triangleMeshNode.GetVertexIndex(i3)] = triangleMeshNode.GetVertex(i3);
					}
				}
			}
		});
		List<Int3> vertices = ListPool<Int3>.Claim();
		CompressContour(outline, hasInEdge, delegate(List<int> chain, bool cycle)
		{
			for (int i = 0; i < chain.Count; i++)
			{
				vertices.Add(vertexPositions[chain[i]]);
			}
			obstacles.Add(sim.AddObstacle(vertices.ToArray(), wallHeight, cycle));
			vertices.Clear();
		});
		ListPool<Int3>.Release(vertices);
	}

	private static void CompressContour(Dictionary<int, int> outline, HashSet<int> hasInEdge, Action<List<int>, bool> results)
	{
		List<int> list = ListPool<int>.Claim();
		List<int> list2 = ListPool<int>.Claim();
		list2.AddRange(outline.Keys);
		for (int i = 0; i <= 1; i++)
		{
			bool flag = i == 1;
			for (int j = 0; j < list2.Count; j++)
			{
				int num = list2[j];
				if (!flag && hasInEdge.Contains(num))
				{
					continue;
				}
				int num2 = num;
				list.Clear();
				list.Add(num2);
				while (outline.ContainsKey(num2))
				{
					int num3 = outline[num2];
					outline.Remove(num2);
					list.Add(num3);
					if (num3 == num)
					{
						break;
					}
					num2 = num3;
				}
				if (list.Count > 1)
				{
					results(list, flag);
				}
			}
		}
		ListPool<int>.Release(list2);
		ListPool<int>.Release(list);
	}
}
