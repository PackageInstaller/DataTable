using System;
using System.Collections.Generic;
using Pathfinding.Serialization;
using Pathfinding.Util;

namespace Pathfinding;

public abstract class MeshNode : GraphNode
{
	public Connection[] connections;

	protected MeshNode(AstarPath astar)
		: base(astar)
	{
	}

	public abstract Int3 GetVertex(int i);

	public abstract int GetVertexCount();

	public abstract Int3 ClosestPointOnNode(Int3 p);

	public abstract Int3 ClosestPointOnNodeXZ(Int3 p);

	public override void ClearConnections(bool alsoReverse)
	{
		if (alsoReverse && connections != null)
		{
			for (int i = 0; i < connections.Length; i++)
			{
				if (connections[i].node != null)
				{
					connections[i].node.RemoveConnection(this);
				}
			}
		}
		ArrayPool<Connection>.Release(ref connections, allowNonPowerOfTwo: true);
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
		Connection[] array = ArrayPool<Connection>.ClaimWithExactLength(num + 1);
		for (int j = 0; j < num; j++)
		{
			array[j] = connections[j];
		}
		array[num] = new Connection
		{
			node = node,
			cost = cost
		};
		if (connections != null)
		{
			ArrayPool<Connection>.Release(ref connections, allowNonPowerOfTwo: true);
		}
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
				Connection[] array = ArrayPool<Connection>.ClaimWithExactLength(num - 1);
				for (int j = 0; j < i; j++)
				{
					array[j] = connections[j];
				}
				for (int k = i + 1; k < num; k++)
				{
					array[k - 1] = connections[k];
				}
				if (connections != null)
				{
					ArrayPool<Connection>.Release(ref connections, allowNonPowerOfTwo: true);
				}
				connections = array;
				break;
			}
		}
	}

	public virtual bool ContainsPoint(Int3 p)
	{
		bool flag = false;
		int vertexCount = GetVertexCount();
		int num = 0;
		int i = vertexCount - 1;
		while (num < vertexCount)
		{
			if (((GetVertex(num).z <= p.z && p.z < GetVertex(i).z) || (GetVertex(i).z <= p.z && p.z < GetVertex(num).z)) && p.x < (GetVertex(i).x - GetVertex(num).x) * (p.z - GetVertex(num).z) / (GetVertex(i).z - GetVertex(num).z) + GetVertex(num).x)
			{
				flag = !flag;
			}
			i = num++;
		}
		return flag;
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
		connections = ArrayPool<Connection>.ClaimWithExactLength(num);
		for (int i = 0; i < num; i++)
		{
			connections[i] = new Connection(ctx.DeserializeNodeReference(), ctx.reader.ReadUInt32(), (ctx.meta.version < AstarSerializer.V4_1_0) ? byte.MaxValue : ctx.reader.ReadByte());
		}
	}
}
