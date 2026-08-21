using System;
using System.Collections.Generic;
using Pathfinding.Serialization;
using UnityEngine;

namespace Pathfinding;

public class GridNode : GridNodeBase
{
	private static GridGraph[] _gridGraphs = new GridGraph[0];

	private const int GridFlagsConnectionOffset = 0;

	private const int GridFlagsConnectionBit0 = 1;

	private const int GridFlagsConnectionMask = 255;

	private const int GridFlagsEdgeNodeOffset = 10;

	private const int GridFlagsEdgeNodeMask = 1024;

	internal ushort InternalGridFlags
	{
		get
		{
			return gridFlags;
		}
		set
		{
			gridFlags = value;
		}
	}

	public override bool HasConnectionsToAllEightNeighbours => (InternalGridFlags & 0xFF) == 255;

	public bool EdgeNode
	{
		get
		{
			return (gridFlags & 0x400) != 0;
		}
		set
		{
			gridFlags = (ushort)((gridFlags & -1025) | (value ? 1024 : 0));
		}
	}

	public GridNode(AstarPath astar)
		: base(astar)
	{
	}

	public static GridGraph GetGridGraph(uint graphIndex)
	{
		return _gridGraphs[graphIndex];
	}

	public static void SetGridGraph(int graphIndex, GridGraph graph)
	{
		if (_gridGraphs.Length <= graphIndex)
		{
			GridGraph[] array = new GridGraph[graphIndex + 1];
			for (int i = 0; i < _gridGraphs.Length; i++)
			{
				array[i] = _gridGraphs[i];
			}
			_gridGraphs = array;
		}
		_gridGraphs[graphIndex] = graph;
	}

	public bool HasConnectionInDirection(int dir)
	{
		return ((gridFlags >> dir) & 1) != 0;
	}

	[Obsolete("Use HasConnectionInDirection")]
	public bool GetConnectionInternal(int dir)
	{
		return HasConnectionInDirection(dir);
	}

	public void SetConnectionInternal(int dir, bool value)
	{
		gridFlags = (ushort)((uint)(gridFlags & ~(1 << dir)) | ((value ? 1u : 0u) << dir));
	}

	public void SetAllConnectionInternal(int connections)
	{
		gridFlags = (ushort)((gridFlags & -256) | connections);
	}

	public void ResetConnectionsInternal()
	{
		gridFlags = (ushort)(gridFlags & -256);
	}

	public override GridNodeBase GetNeighbourAlongDirection(int direction)
	{
		if (HasConnectionInDirection(direction))
		{
			GridGraph gridGraph = GetGridGraph(base.GraphIndex);
			return gridGraph.nodes[base.NodeInGridIndex + gridGraph.neighbourOffsets[direction]];
		}
		return null;
	}

	public override void ClearConnections(bool alsoReverse)
	{
		if (alsoReverse)
		{
			for (int i = 0; i < 8; i++)
			{
				if (GetNeighbourAlongDirection(i) is GridNode gridNode)
				{
					gridNode.SetConnectionInternal((i < 4) ? ((i + 2) % 4) : ((i - 2) % 4 + 4), value: false);
				}
			}
		}
		ResetConnectionsInternal();
		base.ClearConnections(alsoReverse);
	}

	public override void GetConnections(Action<GraphNode> action)
	{
		GridGraph gridGraph = GetGridGraph(base.GraphIndex);
		int[] neighbourOffsets = gridGraph.neighbourOffsets;
		GridNode[] nodes = gridGraph.nodes;
		for (int i = 0; i < 8; i++)
		{
			if (HasConnectionInDirection(i))
			{
				GridNode gridNode = nodes[base.NodeInGridIndex + neighbourOffsets[i]];
				if (gridNode != null)
				{
					action(gridNode);
				}
			}
		}
		base.GetConnections(action);
	}

	public Vector3 ClosestPointOnNode(Vector3 p)
	{
		//IL_0012: Unknown result type (might be due to invalid IL or missing references)
		//IL_0013: Unknown result type (might be due to invalid IL or missing references)
		//IL_0018: Unknown result type (might be due to invalid IL or missing references)
		//IL_0069: Unknown result type (might be due to invalid IL or missing references)
		//IL_006e: Unknown result type (might be due to invalid IL or missing references)
		//IL_00c3: Unknown result type (might be due to invalid IL or missing references)
		//IL_00c5: Unknown result type (might be due to invalid IL or missing references)
		GridGraph gridGraph = GetGridGraph(base.GraphIndex);
		p = gridGraph.transform.InverseTransform(p);
		float num = (float)position.x - 0.5f;
		float num2 = (float)position.z - 0.5f;
		int num3 = base.NodeInGridIndex % gridGraph.width;
		int num4 = base.NodeInGridIndex / gridGraph.width;
		float y = gridGraph.transform.InverseTransform((Vector3)position).y;
		Vector3 p2 = default(Vector3);
		((Vector3)(ref p2))._002Ector(Mathf.Clamp(num, (float)num3 - 0.5f, (float)num3 + 0.5f) + 0.5f, y, Mathf.Clamp(num2, (float)num4 - 0.5f, (float)num4 + 0.5f) + 0.5f);
		return gridGraph.transform.Transform(p2);
	}

	public override bool GetPortal(GraphNode other, List<Int3> left, List<Int3> right, bool backwards)
	{
		//IL_0068: Unknown result type (might be due to invalid IL or missing references)
		//IL_019b: Unknown result type (might be due to invalid IL or missing references)
		if (backwards)
		{
			return true;
		}
		GridGraph gridGraph = GetGridGraph(base.GraphIndex);
		int[] neighbourOffsets = gridGraph.neighbourOffsets;
		GridNode[] nodes = gridGraph.nodes;
		for (int i = 0; i < 4; i++)
		{
			if (HasConnectionInDirection(i) && other == nodes[base.NodeInGridIndex + neighbourOffsets[i]])
			{
				Int3 @int = (position + other.position) / 2f;
				Int3 int2 = Int3.Cross((Int3)gridGraph.collision.up, other.position - position);
				int2.Normalize();
				int2 *= gridGraph.nodeSize * 0.5f;
				left.Add(@int - int2);
				right.Add(@int + int2);
				return true;
			}
		}
		for (int j = 4; j < 8; j++)
		{
			if (!HasConnectionInDirection(j) || other != nodes[base.NodeInGridIndex + neighbourOffsets[j]])
			{
				continue;
			}
			bool flag = false;
			bool flag2 = false;
			if (HasConnectionInDirection(j - 4))
			{
				GridNode gridNode = nodes[base.NodeInGridIndex + neighbourOffsets[j - 4]];
				if (gridNode.Walkable && gridNode.HasConnectionInDirection((j - 4 + 1) % 4))
				{
					flag = true;
				}
			}
			if (HasConnectionInDirection((j - 4 + 1) % 4))
			{
				GridNode gridNode2 = nodes[base.NodeInGridIndex + neighbourOffsets[(j - 4 + 1) % 4]];
				if (gridNode2.Walkable && gridNode2.HasConnectionInDirection(j - 4))
				{
					flag2 = true;
				}
			}
			Int3 int3 = (position + other.position) / 2f;
			Int3 int4 = Int3.Cross((Int3)gridGraph.collision.up, other.position - position);
			int4.Normalize();
			int4 *= gridGraph.nodeSize * 1.4142f;
			left.Add(int3 - (flag2 ? int4 : Int3.zero));
			right.Add(int3 + (flag ? int4 : Int3.zero));
			return true;
		}
		return false;
	}

	public override void FloodFill(Stack<GraphNode> stack, uint region)
	{
		GridGraph gridGraph = GetGridGraph(base.GraphIndex);
		int[] neighbourOffsets = gridGraph.neighbourOffsets;
		GridNode[] nodes = gridGraph.nodes;
		int num = base.NodeInGridIndex;
		for (int i = 0; i < 8; i++)
		{
			if (HasConnectionInDirection(i))
			{
				GridNode gridNode = nodes[num + neighbourOffsets[i]];
				if (gridNode != null && gridNode.Area != region)
				{
					gridNode.Area = region;
					stack.Push(gridNode);
				}
			}
		}
		base.FloodFill(stack, region);
	}

	public override void UpdateRecursiveG(Path path, PathNode pathNode, PathHandler handler)
	{
		GridGraph gridGraph = GetGridGraph(base.GraphIndex);
		int[] neighbourOffsets = gridGraph.neighbourOffsets;
		GridNode[] nodes = gridGraph.nodes;
		UpdateG(path, pathNode);
		handler.heap.Add(pathNode);
		ushort pathID = handler.PathID;
		int num = base.NodeInGridIndex;
		for (int i = 0; i < 8; i++)
		{
			if (HasConnectionInDirection(i))
			{
				GridNode gridNode = nodes[num + neighbourOffsets[i]];
				PathNode pathNode2 = handler.GetPathNode(gridNode);
				if (pathNode2.parent == pathNode && pathNode2.pathID == pathID)
				{
					gridNode.UpdateRecursiveG(path, pathNode2, handler);
				}
			}
		}
		base.UpdateRecursiveG(path, pathNode, handler);
	}

	public override void Open(Path path, PathNode pathNode, PathHandler handler)
	{
		GridGraph gridGraph = GetGridGraph(base.GraphIndex);
		ushort pathID = handler.PathID;
		int[] neighbourOffsets = gridGraph.neighbourOffsets;
		uint[] neighbourCosts = gridGraph.neighbourCosts;
		GridNode[] nodes = gridGraph.nodes;
		int num = base.NodeInGridIndex;
		for (int i = 0; i < 8; i++)
		{
			if (!HasConnectionInDirection(i))
			{
				continue;
			}
			GridNode gridNode = nodes[num + neighbourOffsets[i]];
			if (path.CanTraverse(gridNode))
			{
				PathNode pathNode2 = handler.GetPathNode(gridNode);
				uint num2 = neighbourCosts[i];
				if (pathNode2.pathID != pathID)
				{
					pathNode2.parent = pathNode;
					pathNode2.pathID = pathID;
					pathNode2.cost = num2;
					pathNode2.H = path.CalculateHScore(gridNode);
					gridNode.UpdateG(path, pathNode2);
					handler.heap.Add(pathNode2);
				}
				else if (pathNode.G + num2 + path.GetTraversalCost(gridNode) < pathNode2.G)
				{
					pathNode2.cost = num2;
					pathNode2.parent = pathNode;
					gridNode.UpdateRecursiveG(path, pathNode2, handler);
				}
				else if (pathNode2.G + num2 + path.GetTraversalCost(this) < pathNode.G)
				{
					pathNode.parent = pathNode2;
					pathNode.cost = num2;
					UpdateRecursiveG(path, pathNode, handler);
				}
			}
		}
		base.Open(path, pathNode, handler);
	}

	public override void SerializeNode(GraphSerializationContext ctx)
	{
		base.SerializeNode(ctx);
		ctx.SerializeInt3(position);
		ctx.writer.Write(gridFlags);
	}

	public override void DeserializeNode(GraphSerializationContext ctx)
	{
		base.DeserializeNode(ctx);
		position = ctx.DeserializeInt3();
		gridFlags = ctx.reader.ReadUInt16();
	}
}
