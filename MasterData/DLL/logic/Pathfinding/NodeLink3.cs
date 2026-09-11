using System;
using System.Collections.Generic;
using UnityEngine;

namespace Pathfinding;

[HelpURL("http://arongranberg.com/astar/docs/class_pathfinding_1_1_node_link3.php")]
[AddComponentMenu("Pathfinding/Link3")]
public class NodeLink3 : GraphModifier
{
	protected static Dictionary<GraphNode, NodeLink3> reference = new Dictionary<GraphNode, NodeLink3>();

	public Transform end;

	public float costFactor = 1f;

	public bool oneWay;

	public Int3 StartTransform;

	public Int3 EndTransform;

	private NodeLink3Node startNode;

	private NodeLink3Node endNode;

	private MeshNode connectedNode1;

	private MeshNode connectedNode2;

	private Int3 clamped1;

	private Int3 clamped2;

	private bool postScanCalled;

	public GraphNode StartNode => startNode;

	public GraphNode EndNode => endNode;

	public static NodeLink3 GetNodeLink(GraphNode node)
	{
		reference.TryGetValue(node, out var value);
		return value;
	}

	public override void OnPostScan()
	{
		if (AstarPath.active.isScanning)
		{
			InternalOnPostScan();
			return;
		}
		AstarPath.active.AddWorkItem(new AstarWorkItem((Func<bool, bool>)delegate
		{
			InternalOnPostScan();
			return true;
		}));
	}

	public void InternalOnPostScan()
	{
		throw new Exception("Point graphs are not included. Check your A* Optimization settings.");
	}

	public override void OnGraphsPostUpdate()
	{
		if (!AstarPath.active.isScanning)
		{
			if (connectedNode1 != null && connectedNode1.Destroyed)
			{
				connectedNode1 = null;
			}
			if (connectedNode2 != null && connectedNode2.Destroyed)
			{
				connectedNode2 = null;
			}
			if (!postScanCalled)
			{
				OnPostScan();
			}
			else
			{
				Apply(forceNewCheck: false);
			}
		}
	}

	public override void Initialize()
	{
		base.Initialize();
	}

	public override void Shutdown()
	{
		base.Shutdown();
		postScanCalled = false;
		if (startNode != null)
		{
			reference.Remove(startNode);
		}
		if (endNode != null)
		{
			reference.Remove(endNode);
		}
		if (startNode != null && endNode != null)
		{
			startNode.RemoveConnection(endNode);
			endNode.RemoveConnection(startNode);
			if (connectedNode1 != null && connectedNode2 != null)
			{
				startNode.RemoveConnection(connectedNode1);
				connectedNode1.RemoveConnection(startNode);
				endNode.RemoveConnection(connectedNode2);
				connectedNode2.RemoveConnection(endNode);
			}
		}
	}

	private void RemoveConnections(GraphNode node)
	{
		node.ClearConnections(alsoReverse: true);
	}

	[ContextMenu("Recalculate neighbours")]
	private void ContextApplyForce()
	{
		if (Application.isPlaying)
		{
			Apply(forceNewCheck: true);
			if (AstarPath.active != null)
			{
				AstarPath.active.FloodFill();
			}
		}
	}

	public void Apply(bool forceNewCheck)
	{
		//IL_008c: Unknown result type (might be due to invalid IL or missing references)
		//IL_0091: Unknown result type (might be due to invalid IL or missing references)
		//IL_009b: Unknown result type (might be due to invalid IL or missing references)
		//IL_00a0: Unknown result type (might be due to invalid IL or missing references)
		//IL_010e: Unknown result type (might be due to invalid IL or missing references)
		//IL_0113: Unknown result type (might be due to invalid IL or missing references)
		//IL_011d: Unknown result type (might be due to invalid IL or missing references)
		//IL_0122: Unknown result type (might be due to invalid IL or missing references)
		NNConstraint none = NNConstraint.None;
		none.distanceXZ = true;
		int graphIndex = (int)startNode.GraphIndex;
		none.graphMask = ~(1 << graphIndex);
		bool flag = true;
		NNInfo nearest = AstarPath.active.GetNearest(StartTransform, none);
		flag &= nearest.node == connectedNode1 && nearest.node != null;
		connectedNode1 = nearest.node as MeshNode;
		clamped1 = nearest.position;
		if (connectedNode1 != null)
		{
			Debug.DrawRay((Vector3)connectedNode1.position, Vector3.up * 5f, Color.red);
		}
		NNInfo nearest2 = AstarPath.active.GetNearest(EndTransform, none);
		flag &= nearest2.node == connectedNode2 && nearest2.node != null;
		connectedNode2 = nearest2.node as MeshNode;
		clamped2 = nearest2.position;
		if (connectedNode2 != null)
		{
			Debug.DrawRay((Vector3)connectedNode2.position, Vector3.up * 5f, Color.cyan);
		}
		if (connectedNode2 == null || connectedNode1 == null)
		{
			return;
		}
		startNode.SetPosition(StartTransform);
		endNode.SetPosition(EndTransform);
		if (flag && !forceNewCheck)
		{
			return;
		}
		RemoveConnections(startNode);
		RemoveConnections(endNode);
		uint cost = (uint)Mathf.RoundToInt((float)(StartTransform - EndTransform).costMagnitude * costFactor);
		startNode.AddConnection(endNode, cost);
		endNode.AddConnection(startNode, cost);
		Int3 rhs = connectedNode2.position - connectedNode1.position;
		for (int i = 0; i < connectedNode1.GetVertexCount(); i++)
		{
			Int3 vertex = connectedNode1.GetVertex(i);
			Int3 vertex2 = connectedNode1.GetVertex((i + 1) % connectedNode1.GetVertexCount());
			if (Int3.DotLong((vertex2 - vertex).Normal2D(), rhs) > 0)
			{
				continue;
			}
			for (int j = 0; j < connectedNode2.GetVertexCount(); j++)
			{
				Int3 vertex3 = connectedNode2.GetVertex(j);
				Int3 vertex4 = connectedNode2.GetVertex((j + 1) % connectedNode2.GetVertexCount());
				if (Int3.DotLong((vertex4 - vertex3).Normal2D(), rhs) >= 0 && (double)Int3.Angle(vertex4 - vertex3, vertex2 - vertex) > 2.967059810956319)
				{
					VFactor zero = VFactor.zero;
					VFactor one = VFactor.one;
					one = VFactor.Min(one, VectorMath.ClosestPointOnLineFactor(vertex, vertex2, vertex3));
					zero = VFactor.Max(zero, VectorMath.ClosestPointOnLineFactor(vertex, vertex2, vertex4));
					if (!(one < zero))
					{
						Int3 @int = (vertex2 - vertex) * zero + vertex;
						Int3 int2 = (vertex2 - vertex) * one + vertex;
						startNode.portalA = @int;
						startNode.portalB = int2;
						endNode.portalA = int2;
						endNode.portalB = @int;
						connectedNode1.AddConnection(startNode, (uint)Mathf.RoundToInt((float)(clamped1 - StartTransform).costMagnitude * costFactor));
						connectedNode2.AddConnection(endNode, (uint)Mathf.RoundToInt((float)(clamped2 - EndTransform).costMagnitude * costFactor));
						startNode.AddConnection(connectedNode1, (uint)Mathf.RoundToInt((float)(clamped1 - StartTransform).costMagnitude * costFactor));
						endNode.AddConnection(connectedNode2, (uint)Mathf.RoundToInt((float)(clamped2 - EndTransform).costMagnitude * costFactor));
						return;
					}
					string[] obj = new string[13]
					{
						"Something went wrong! ", null, null, null, null, null, null, null, null, null,
						null, null, null
					};
					VFactor vFactor = zero;
					obj[1] = vFactor.ToString();
					obj[2] = " ";
					vFactor = one;
					obj[3] = vFactor.ToString();
					obj[4] = " ";
					obj[5] = vertex;
					obj[6] = " ";
					obj[7] = vertex2;
					obj[8] = " ";
					obj[9] = vertex3;
					obj[10] = " ";
					obj[11] = vertex4;
					obj[12] = "\nTODO, how can this happen?";
					Debug.LogError((object)string.Concat(obj));
				}
			}
		}
	}
}
