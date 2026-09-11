using System;
using System.Collections.Generic;
using Pathfinding.Serialization;
using UnityEngine;

namespace Pathfinding;

public abstract class GridNodeBase : GraphNode
{
	private const int GridFlagsWalkableErosionOffset = 8;

	private const int GridFlagsWalkableErosionMask = 256;

	private const int GridFlagsWalkableTmpOffset = 9;

	private const int GridFlagsWalkableTmpMask = 512;

	protected const int NodeInGridIndexLayerOffset = 24;

	protected const int NodeInGridIndexMask = 16777215;

	protected int nodeInGridIndex;

	protected ushort gridFlags;

	public Connection[] connections;

	private static readonly Version VERSION_3_8_3 = new Version(3, 8, 3);

	public int NodeInGridIndex
	{
		get
		{
			return nodeInGridIndex & 0xFFFFFF;
		}
		set
		{
			nodeInGridIndex = (nodeInGridIndex & -16777216) | value;
		}
	}

	public int XCoordinateInGrid => NodeInGridIndex % GridNode.GetGridGraph(base.GraphIndex).width;

	public int ZCoordinateInGrid => NodeInGridIndex / GridNode.GetGridGraph(base.GraphIndex).width;

	public bool WalkableErosion
	{
		get
		{
			return (gridFlags & 0x100) != 0;
		}
		set
		{
			gridFlags = (ushort)((gridFlags & -257) | (value ? 256 : 0));
		}
	}

	public bool TmpWalkable
	{
		get
		{
			return (gridFlags & 0x200) != 0;
		}
		set
		{
			gridFlags = (ushort)((gridFlags & -513) | (value ? 512 : 0));
		}
	}

	public abstract bool HasConnectionsToAllEightNeighbours { get; }

	protected GridNodeBase(AstarPath astar)
		: base(astar)
	{
	}

	public override float SurfaceArea()
	{
		GridGraph gridGraph = GridNode.GetGridGraph(base.GraphIndex);
		return gridGraph.nodeSize * gridGraph.nodeSize;
	}

	public override Vector3 RandomPointOnSurface()
	{
		//IL_0018: Unknown result type (might be due to invalid IL or missing references)
		//IL_001d: Unknown result type (might be due to invalid IL or missing references)
		//IL_0022: Unknown result type (might be due to invalid IL or missing references)
		//IL_0029: Unknown result type (might be due to invalid IL or missing references)
		//IL_0045: Unknown result type (might be due to invalid IL or missing references)
		//IL_004a: Unknown result type (might be due to invalid IL or missing references)
		//IL_004f: Unknown result type (might be due to invalid IL or missing references)
		GridGraph gridGraph = GridNode.GetGridGraph(base.GraphIndex);
		Vector3 val = gridGraph.transform.InverseTransform((Vector3)position);
		return gridGraph.transform.Transform(val + new Vector3(Random.value - 0.5f, 0f, Random.value - 0.5f));
	}

	public override int GetGizmoHashCode()
	{
		int num = base.GetGizmoHashCode();
		if (connections != null)
		{
			for (int i = 0; i < connections.Length; i++)
			{
				num ^= 17 * connections[i].GetHashCode();
			}
		}
		return num ^ (109 * gridFlags);
	}

	public abstract GridNodeBase GetNeighbourAlongDirection(int direction);

	public override bool ContainsConnection(GraphNode node)
	{
		if (connections != null)
		{
			for (int i = 0; i < connections.Length; i++)
			{
				if (connections[i].node == node)
				{
					return true;
				}
			}
		}
		for (int j = 0; j < 8; j++)
		{
			if (node == GetNeighbourAlongDirection(j))
			{
				return true;
			}
		}
		return false;
	}

	public override void FloodFill(Stack<GraphNode> stack, uint region)
	{
		if (connections == null)
		{
			return;
		}
		for (int i = 0; i < connections.Length; i++)
		{
			GraphNode node = connections[i].node;
			if (node.Area != region)
			{
				node.Area = region;
				stack.Push(node);
			}
		}
	}

	public void ClearCustomConnections(bool alsoReverse)
	{
		if (connections != null)
		{
			for (int i = 0; i < connections.Length; i++)
			{
				connections[i].node.RemoveConnection(this);
			}
		}
		connections = null;
	}

	public override void ClearConnections(bool alsoReverse)
	{
		ClearCustomConnections(alsoReverse);
	}

	public override void GetConnections(Action<GraphNode> action)
	{
		if (connections != null)
		{
			for (int i = 0; i < connections.Length; i++)
			{
				action(connections[i].node);
			}
		}
	}

	public override void UpdateRecursiveG(Path path, PathNode pathNode, PathHandler handler)
	{
		ushort pathID = handler.PathID;
		if (connections == null)
		{
			return;
		}
		for (int i = 0; i < connections.Length; i++)
		{
			GraphNode node = connections[i].node;
			PathNode pathNode2 = handler.GetPathNode(node);
			if (pathNode2.parent == pathNode && pathNode2.pathID == pathID)
			{
				node.UpdateRecursiveG(path, pathNode2, handler);
			}
		}
	}

	public override void Open(Path path, PathNode pathNode, PathHandler handler)
	{
		ushort pathID = handler.PathID;
		if (connections == null)
		{
			return;
		}
		for (int i = 0; i < connections.Length; i++)
		{
			GraphNode node = connections[i].node;
			if (path.CanTraverse(node))
			{
				PathNode pathNode2 = handler.GetPathNode(node);
				uint cost = connections[i].cost;
				if (pathNode2.pathID != pathID)
				{
					pathNode2.parent = pathNode;
					pathNode2.pathID = pathID;
					pathNode2.cost = cost;
					pathNode2.H = path.CalculateHScore(node);
					node.UpdateG(path, pathNode2);
					handler.heap.Add(pathNode2);
				}
				else if (pathNode.G + cost + path.GetTraversalCost(node) < pathNode2.G)
				{
					pathNode2.cost = cost;
					pathNode2.parent = pathNode;
					node.UpdateRecursiveG(path, pathNode2, handler);
				}
				else if (pathNode2.G + cost + path.GetTraversalCost(this) < pathNode.G && node.ContainsConnection(this))
				{
					pathNode.parent = pathNode2;
					pathNode.cost = cost;
					UpdateRecursiveG(path, pathNode, handler);
				}
			}
		}
	}

	public override void AddConnection(GraphNode node, uint cost)
	{
		if (node == null)
		{
			throw new ArgumentNullException();
		}
		if (connections != null)
		{
			for (int i = 0; i < connections.Length; i++)
			{
				if (connections[i].node == node)
				{
					connections[i].cost = cost;
					return;
				}
			}
		}
		int num = ((connections != null) ? connections.Length : 0);
		Connection[] array = new Connection[num + 1];
		for (int j = 0; j < num; j++)
		{
			array[j] = connections[j];
		}
		array[num] = new Connection
		{
			node = node,
			cost = cost
		};
		connections = array;
	}

	public override void RemoveConnection(GraphNode node)
	{
		if (connections == null)
		{
			return;
		}
		for (int i = 0; i < connections.Length; i++)
		{
			if (connections[i].node == node)
			{
				int num = connections.Length;
				Connection[] array = new Connection[num - 1];
				for (int j = 0; j < i; j++)
				{
					array[j] = connections[j];
				}
				for (int k = i + 1; k < num; k++)
				{
					array[k - 1] = connections[k];
				}
				connections = array;
				break;
			}
		}
	}

	public override void SerializeReferences(GraphSerializationContext ctx)
	{
		if (connections == null)
		{
			ctx.writer.Write(-1);
			return;
		}
		ctx.writer.Write(connections.Length);
		for (int i = 0; i < connections.Length; i++)
		{
			ctx.SerializeNodeReference(connections[i].node);
			ctx.writer.Write(connections[i].cost);
		}
	}

	public override void DeserializeReferences(GraphSerializationContext ctx)
	{
		if (ctx.meta.version < VERSION_3_8_3)
		{
			return;
		}
		int num = ctx.reader.ReadInt32();
		if (num == -1)
		{
			connections = null;
			return;
		}
		connections = new Connection[num];
		for (int i = 0; i < num; i++)
		{
			connections[i] = new Connection
			{
				node = ctx.DeserializeNodeReference(),
				cost = ctx.reader.ReadUInt32()
			};
		}
	}
}
