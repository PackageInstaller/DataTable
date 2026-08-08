using System;
using Pathfinding.RVO.Sampled;
using UnityEngine;

namespace Pathfinding.RVO;

public class RVOQuadtree
{
	private struct Node
	{
		public int child00;

		public int child01;

		public int child10;

		public int child11;

		public Agent linkedList;

		public byte count;

		public Int maxSpeed;

		public void Add(Agent agent)
		{
			agent.next = linkedList;
			linkedList = agent;
		}

		public void Distribute(Node[] nodes, VRect r)
		{
			Int2 center = r.center;
			while (linkedList != null)
			{
				Agent next = linkedList.next;
				if (linkedList.position.x > center.x)
				{
					if (linkedList.position.y > center.y)
					{
						nodes[child11].Add(linkedList);
					}
					else
					{
						nodes[child10].Add(linkedList);
					}
				}
				else if (linkedList.position.y > center.y)
				{
					nodes[child01].Add(linkedList);
				}
				else
				{
					nodes[child00].Add(linkedList);
				}
				linkedList = next;
			}
			count = 0;
		}

		public Int CalculateMaxSpeed(Node[] nodes, int index)
		{
			if (child00 == index)
			{
				for (Agent next = linkedList; next != null; next = next.next)
				{
					maxSpeed = IntMath.Max(maxSpeed, next.CalculatedSpeed);
				}
			}
			else
			{
				maxSpeed = IntMath.Max(nodes[child00].CalculateMaxSpeed(nodes, child00), nodes[child01].CalculateMaxSpeed(nodes, child01));
				maxSpeed = IntMath.Max(maxSpeed, nodes[child10].CalculateMaxSpeed(nodes, child10));
				maxSpeed = IntMath.Max(maxSpeed, nodes[child11].CalculateMaxSpeed(nodes, child11));
			}
			return maxSpeed;
		}
	}

	private struct QuadtreeQuery
	{
		public Int2 p;

		public Int speed;

		public Int agentRadius;

		public Int maxRadius;

		public VFactor timeHorizon;

		public Agent agent;

		public Node[] nodes;

		public void QueryRec(int i, VRect r)
		{
			Int obj = IntMath.Min(IntMath.Max((nodes[i].maxSpeed + speed) * timeHorizon, agentRadius) + agentRadius, maxRadius);
			if (nodes[i].child00 == i)
			{
				for (Agent agent = nodes[i].linkedList; agent != null; agent = agent.next)
				{
					long num = this.agent.InsertAgentNeighbour(agent, obj.i * obj.i);
					if (num < maxRadius.i * maxRadius.i)
					{
						maxRadius = IntMath.Sqrt(num);
					}
				}
				return;
			}
			Int2 center = r.center;
			if (p.x - obj < center.x)
			{
				if (p.y - obj < center.y)
				{
					QueryRec(nodes[i].child00, VRect.MinMaxRect(r.xMin, r.yMin, center.x, center.y));
					obj = IntMath.Min(obj, maxRadius);
				}
				if (p.y + obj > center.y)
				{
					QueryRec(nodes[i].child01, VRect.MinMaxRect(r.xMin, center.y, center.x, r.yMax));
					obj = IntMath.Min(obj, maxRadius);
				}
			}
			if (p.x + obj > center.x)
			{
				if (p.y - obj < center.y)
				{
					QueryRec(nodes[i].child10, VRect.MinMaxRect(center.x, r.yMin, r.xMax, center.y));
					obj = IntMath.Min(obj, maxRadius);
				}
				if (p.y + obj > center.y)
				{
					QueryRec(nodes[i].child11, VRect.MinMaxRect(center.x, center.y, r.xMax, r.yMax));
				}
			}
		}
	}

	private const int LeafSize = 15;

	private long maxRadius;

	private Node[] nodes = new Node[42];

	private int filledNodes = 1;

	private VRect bounds;

	public void Clear()
	{
		nodes[0] = default(Node);
		filledNodes = 1;
		maxRadius = 0L;
	}

	public void SetBounds(VRect r)
	{
		bounds = r;
	}

	private int GetNodeIndex()
	{
		if (filledNodes == nodes.Length)
		{
			Node[] array = new Node[nodes.Length * 2];
			for (int i = 0; i < nodes.Length; i++)
			{
				array[i] = nodes[i];
			}
			nodes = array;
		}
		nodes[filledNodes] = default(Node);
		nodes[filledNodes].child00 = filledNodes;
		filledNodes++;
		return filledNodes - 1;
	}

	public void Insert(Agent agent)
	{
		int num = 0;
		VRect r = bounds;
		Int2 @int = new Int2(agent.position.x, agent.position.y);
		agent.next = null;
		maxRadius = Math.Max(agent.radius.i, maxRadius);
		int num2 = 0;
		while (true)
		{
			num2++;
			if (nodes[num].child00 == num)
			{
				if (nodes[num].count < 15 || num2 > 10)
				{
					break;
				}
				Node node = nodes[num];
				node.child00 = GetNodeIndex();
				node.child01 = GetNodeIndex();
				node.child10 = GetNodeIndex();
				node.child11 = GetNodeIndex();
				nodes[num] = node;
				nodes[num].Distribute(nodes, r);
			}
			if (nodes[num].child00 == num)
			{
				continue;
			}
			Int2 center = r.center;
			if (@int.x > center.x)
			{
				if (@int.y > center.y)
				{
					num = nodes[num].child11;
					r = VRect.MinMaxRect(center.x, center.y, r.xMax, r.yMax);
				}
				else
				{
					num = nodes[num].child10;
					r = VRect.MinMaxRect(center.x, r.yMin, r.xMax, center.y);
				}
			}
			else if (@int.y > center.y)
			{
				num = nodes[num].child01;
				r = VRect.MinMaxRect(r.xMin, center.y, center.x, r.yMax);
			}
			else
			{
				num = nodes[num].child00;
				r = VRect.MinMaxRect(r.xMin, r.yMin, center.x, center.y);
			}
		}
		nodes[num].Add(agent);
		nodes[num].count++;
	}

	public void CalculateSpeeds()
	{
		nodes[0].CalculateMaxSpeed(nodes, 0);
	}

	public void Query(Int2 p, Int speed, VFactor timeHorizon, Int agentRadius, Agent agent)
	{
		QuadtreeQuery quadtreeQuery = default(QuadtreeQuery);
		quadtreeQuery.p = p;
		quadtreeQuery.speed = speed;
		quadtreeQuery.timeHorizon = timeHorizon;
		quadtreeQuery.maxRadius = Int.MaxValue;
		quadtreeQuery.agentRadius = agentRadius;
		quadtreeQuery.agent = agent;
		quadtreeQuery.nodes = nodes;
		quadtreeQuery.QueryRec(0, bounds);
	}

	public void DebugDraw()
	{
		DebugDrawRec(0, bounds);
	}

	private void DebugDrawRec(int i, VRect r)
	{
		//IL_0021: Unknown result type (might be due to invalid IL or missing references)
		//IL_0047: Unknown result type (might be due to invalid IL or missing references)
		//IL_004c: Unknown result type (might be due to invalid IL or missing references)
		//IL_0077: Unknown result type (might be due to invalid IL or missing references)
		//IL_009d: Unknown result type (might be due to invalid IL or missing references)
		//IL_00a2: Unknown result type (might be due to invalid IL or missing references)
		//IL_00cd: Unknown result type (might be due to invalid IL or missing references)
		//IL_00f3: Unknown result type (might be due to invalid IL or missing references)
		//IL_00f8: Unknown result type (might be due to invalid IL or missing references)
		//IL_0123: Unknown result type (might be due to invalid IL or missing references)
		//IL_0149: Unknown result type (might be due to invalid IL or missing references)
		//IL_014e: Unknown result type (might be due to invalid IL or missing references)
		//IL_0290: Unknown result type (might be due to invalid IL or missing references)
		//IL_0295: Unknown result type (might be due to invalid IL or missing references)
		//IL_029a: Unknown result type (might be due to invalid IL or missing references)
		//IL_02bc: Unknown result type (might be due to invalid IL or missing references)
		//IL_02c1: Unknown result type (might be due to invalid IL or missing references)
		//IL_02c6: Unknown result type (might be due to invalid IL or missing references)
		//IL_02df: Unknown result type (might be due to invalid IL or missing references)
		Debug.DrawLine(new Vector3((float)r.xMin * 0.001f, 0f, (float)r.yMin * 0.001f), new Vector3((float)r.xMax * 0.001f, 0f, (float)r.yMin * 0.001f), Color.white);
		Debug.DrawLine(new Vector3((float)r.xMax * 0.001f, 0f, (float)r.yMin * 0.001f), new Vector3((float)r.xMax * 0.001f, 0f, (float)r.yMax * 0.001f), Color.white);
		Debug.DrawLine(new Vector3((float)r.xMax * 0.001f, 0f, (float)r.yMax * 0.001f), new Vector3((float)r.xMin * 0.001f, 0f, (float)r.yMax * 0.001f), Color.white);
		Debug.DrawLine(new Vector3((float)r.xMin * 0.001f, 0f, (float)r.yMax * 0.001f), new Vector3((float)r.xMin * 0.001f, 0f, (float)r.yMin * 0.001f), Color.white);
		if (nodes[i].child00 != i)
		{
			Int2 center = r.center;
			DebugDrawRec(nodes[i].child11, VRect.MinMaxRect(center.x, center.y, r.xMax, r.yMax));
			DebugDrawRec(nodes[i].child10, VRect.MinMaxRect(center.x, r.yMin, r.xMax, center.y));
			DebugDrawRec(nodes[i].child01, VRect.MinMaxRect(r.xMin, center.y, center.x, r.yMax));
			DebugDrawRec(nodes[i].child00, VRect.MinMaxRect(r.xMin, r.yMin, center.x, center.y));
		}
		for (Agent agent = nodes[i].linkedList; agent != null; agent = agent.next)
		{
			Int2 position = nodes[i].linkedList.position;
			Debug.DrawLine(new Vector3((float)position.x, 0f, (float)position.y) + Vector3.up, new Vector3((float)agent.position.x, 0f, (float)agent.position.y) + Vector3.up, new Color(1f, 1f, 0f, 0.5f));
		}
	}
}
