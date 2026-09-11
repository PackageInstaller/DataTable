using System;
using System.Collections.Generic;

namespace Pathfinding;

public class NodeLink3Node : PointNode
{
	public NodeLink3 link;

	public Int3 portalA;

	public Int3 portalB;

	public NodeLink3Node(AstarPath active)
		: base(active)
	{
	}

	public override bool GetPortal(GraphNode other, List<Int3> left, List<Int3> right, bool backwards)
	{
		if (connections.Length < 2)
		{
			return false;
		}
		if (connections.Length != 2)
		{
			throw new Exception("Invalid NodeLink3Node. Expected 2 connections, found " + connections.Length);
		}
		if (left != null)
		{
			left.Add(portalA);
			right.Add(portalB);
		}
		return true;
	}

	public GraphNode GetOther(GraphNode a)
	{
		if (connections.Length < 2)
		{
			return null;
		}
		if (connections.Length != 2)
		{
			throw new Exception("Invalid NodeLink3Node. Expected 2 connections, found " + connections.Length);
		}
		if (a != connections[0].node)
		{
			return (connections[0].node as NodeLink3Node).GetOtherInternal(this);
		}
		return (connections[1].node as NodeLink3Node).GetOtherInternal(this);
	}

	private GraphNode GetOtherInternal(GraphNode a)
	{
		if (connections.Length < 2)
		{
			return null;
		}
		if (a != connections[0].node)
		{
			return connections[0].node;
		}
		return connections[1].node;
	}
}
