using System;
using Pathfinding.Serialization;
using UnityEngine;

namespace Pathfinding;

public class PointNode : GraphNode
{
	public Connection[] connections;

	public GameObject gameObject;

	public void SetPosition(Int3 value)
	{
		position = value;
	}

	public PointNode(AstarPath astar)
		: base(astar)
	{
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

	public override void ClearConnections(bool alsoReverse)
	{
		if (alsoReverse && connections != null)
		{
			for (int i = 0; i < connections.Length; i++)
			{
				connections[i].node.RemoveConnection(this);
			}
		}
		connections = null;
	}

	public override void UpdateRecursiveG(Path path, PathNode pathNode, PathHandler handler)
	{
		UpdateG(path, pathNode);
		handler.heap.Add(pathNode);
		for (int i = 0; i < connections.Length; i++)
		{
			GraphNode node = connections[i].node;
			PathNode pathNode2 = handler.GetPathNode(node);
			if (pathNode2.parent == pathNode && pathNode2.pathID == handler.PathID)
			{
				node.UpdateRecursiveG(path, pathNode2, handler);
			}
		}
	}

	public override bool ContainsConnection(GraphNode node)
	{
		for (int i = 0; i < connections.Length; i++)
		{
			if (connections[i].node == node)
			{
				return true;
			}
		}
		return false;
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

	public override void Open(Path path, PathNode pathNode, PathHandler handler)
	{
		if (connections == null)
		{
			return;
		}
		for (int i = 0; i < connections.Length; i++)
		{
			GraphNode node = connections[i].node;
			if (!path.CanTraverse(node))
			{
				continue;
			}
			PathNode pathNode2 = handler.GetPathNode(node);
			if (pathNode2.pathID != handler.PathID)
			{
				pathNode2.parent = pathNode;
				pathNode2.pathID = handler.PathID;
				pathNode2.cost = connections[i].cost;
				pathNode2.H = path.CalculateHScore(node);
				node.UpdateG(path, pathNode2);
				handler.heap.Add(pathNode2);
				continue;
			}
			uint cost = connections[i].cost;
			if (pathNode.G + cost + path.GetTraversalCost(node) < pathNode2.G)
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
		return num;
	}

	public override void SerializeNode(GraphSerializationContext ctx)
	{
		base.SerializeNode(ctx);
		ctx.SerializeInt3(position);
	}

	public override void DeserializeNode(GraphSerializationContext ctx)
	{
		base.DeserializeNode(ctx);
		position = ctx.DeserializeInt3();
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
