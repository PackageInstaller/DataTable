using System;
using System.Collections.Generic;
using Pathfinding.Serialization;
using UnityEngine;

namespace Pathfinding;

[HelpURL("http://arongranberg.com/astar/docs/class_pathfinding_1_1_node_link2.php")]
[AddComponentMenu("Pathfinding/Link2")]
public class NodeLink2 : GraphModifier
{
	protected static Dictionary<GraphNode, NodeLink2> reference;

	public float costFactor = 1f;

	public bool oneWay;

	private GraphNode connectedNode1;

	private GraphNode connectedNode2;

	private Int3 clamped1;

	private Int3 clamped2;

	private bool postScanCalled;

	private static readonly Color GizmosColor;

	private static readonly Color GizmosColorSelected;

	public Int3 StartTransform { get; set; }

	public Int3 EndTransform { get; set; }

	public PointNode startNode { get; private set; }

	public PointNode endNode { get; private set; }

	[Obsolete("Use startNode instead (lowercase s)")]
	public GraphNode StartNode => startNode;

	[Obsolete("Use endNode instead (lowercase e)")]
	public GraphNode EndNode => endNode;

	public static NodeLink2 GetNodeLink(GraphNode node)
	{
		reference.TryGetValue(node, out var value);
		return value;
	}

	public override void OnPostScan()
	{
		InternalOnPostScan();
	}

	public void InternalOnPostScan()
	{
		if (EndTransform == null || StartTransform == null)
		{
			return;
		}
		throw new Exception("Point graph is not included. Check your A* optimization settings.");
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
		NNConstraint none = NNConstraint.None;
		int graphIndex = (int)startNode.GraphIndex;
		none.graphMask = ~(1 << graphIndex);
		startNode.SetPosition(StartTransform);
		endNode.SetPosition(EndTransform);
		RemoveConnections(startNode);
		RemoveConnections(endNode);
		uint cost = (uint)Mathf.RoundToInt((float)(StartTransform - EndTransform).costMagnitude * costFactor);
		startNode.AddConnection(endNode, cost);
		endNode.AddConnection(startNode, cost);
		if ((connectedNode1 == null) | forceNewCheck)
		{
			NNInfo nearest = AstarPath.active.GetNearest(StartTransform, none);
			connectedNode1 = nearest.node;
			clamped1 = nearest.position;
		}
		if ((connectedNode2 == null) | forceNewCheck)
		{
			NNInfo nearest2 = AstarPath.active.GetNearest(EndTransform, none);
			connectedNode2 = nearest2.node;
			clamped2 = nearest2.position;
		}
		if (connectedNode2 != null && connectedNode1 != null)
		{
			connectedNode1.AddConnection(startNode, (uint)Mathf.RoundToInt((float)(clamped1 - StartTransform).costMagnitude * costFactor));
			if (!oneWay)
			{
				connectedNode2.AddConnection(endNode, (uint)Mathf.RoundToInt((float)(clamped2 - EndTransform).costMagnitude * costFactor));
			}
			if (!oneWay)
			{
				startNode.AddConnection(connectedNode1, (uint)Mathf.RoundToInt((float)(clamped1 - StartTransform).costMagnitude * costFactor));
			}
			endNode.AddConnection(connectedNode2, (uint)Mathf.RoundToInt((float)(clamped2 - EndTransform).costMagnitude * costFactor));
		}
	}

	internal static void SerializeReferences(GraphSerializationContext ctx)
	{
		//IL_0070: Unknown result type (might be due to invalid IL or missing references)
		//IL_0081: Unknown result type (might be due to invalid IL or missing references)
		List<NodeLink2> modifiersOfType = GraphModifier.GetModifiersOfType<NodeLink2>();
		ctx.writer.Write(modifiersOfType.Count);
		foreach (NodeLink2 item in modifiersOfType)
		{
			ctx.writer.Write(item.uniqueID);
			ctx.SerializeNodeReference(item.startNode);
			ctx.SerializeNodeReference(item.endNode);
			ctx.SerializeNodeReference(item.connectedNode1);
			ctx.SerializeNodeReference(item.connectedNode2);
			ctx.SerializeVector3((Vector3)item.clamped1);
			ctx.SerializeVector3((Vector3)item.clamped2);
			ctx.writer.Write(item.postScanCalled);
		}
	}

	internal static void DeserializeReferences(GraphSerializationContext ctx)
	{
		//IL_003f: Unknown result type (might be due to invalid IL or missing references)
		//IL_0044: Unknown result type (might be due to invalid IL or missing references)
		//IL_0047: Unknown result type (might be due to invalid IL or missing references)
		//IL_004c: Unknown result type (might be due to invalid IL or missing references)
		//IL_010d: Unknown result type (might be due to invalid IL or missing references)
		//IL_011b: Unknown result type (might be due to invalid IL or missing references)
		int num = ctx.reader.ReadInt32();
		for (int i = 0; i < num; i++)
		{
			ulong key = ctx.reader.ReadUInt64();
			GraphNode graphNode = ctx.DeserializeNodeReference();
			GraphNode graphNode2 = ctx.DeserializeNodeReference();
			GraphNode graphNode3 = ctx.DeserializeNodeReference();
			GraphNode graphNode4 = ctx.DeserializeNodeReference();
			Vector3 val = ctx.DeserializeVector3();
			Vector3 val2 = ctx.DeserializeVector3();
			bool flag = ctx.reader.ReadBoolean();
			if (GraphModifier.usedIDs.TryGetValue(key, out var value))
			{
				if (value is NodeLink2 nodeLink)
				{
					if (graphNode != null)
					{
						reference[graphNode] = nodeLink;
					}
					if (graphNode2 != null)
					{
						reference[graphNode2] = nodeLink;
					}
					if (nodeLink.startNode != null)
					{
						reference.Remove(nodeLink.startNode);
					}
					if (nodeLink.endNode != null)
					{
						reference.Remove(nodeLink.endNode);
					}
					nodeLink.startNode = graphNode as PointNode;
					nodeLink.endNode = graphNode2 as PointNode;
					nodeLink.connectedNode1 = graphNode3;
					nodeLink.connectedNode2 = graphNode4;
					nodeLink.postScanCalled = flag;
					nodeLink.clamped1 = (Int3)val;
					nodeLink.clamped2 = (Int3)val2;
					continue;
				}
				throw new Exception("Tried to deserialize a NodeLink2 reference, but the link was not of the correct type or it has been destroyed.\nIf a NodeLink2 is included in serialized graph data, the same NodeLink2 component must be present in the scene when loading the graph data.");
			}
			throw new Exception("Tried to deserialize a NodeLink2 reference, but the link could not be found in the scene.\nIf a NodeLink2 is included in serialized graph data, the same NodeLink2 component must be present in the scene when loading the graph data.");
		}
	}

	static NodeLink2()
	{
		//IL_001e: Unknown result type (might be due to invalid IL or missing references)
		//IL_0023: Unknown result type (might be due to invalid IL or missing references)
		//IL_003c: Unknown result type (might be due to invalid IL or missing references)
		//IL_0041: Unknown result type (might be due to invalid IL or missing references)
		reference = new Dictionary<GraphNode, NodeLink2>();
		GizmosColor = new Color(0.80784315f, 8f / 15f, 16f / 85f, 0.5f);
		GizmosColorSelected = new Color(47f / 51f, 41f / 85f, 0.1254902f, 1f);
	}
}
