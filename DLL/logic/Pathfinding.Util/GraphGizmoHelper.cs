using System;
using System.Collections.Generic;
using UnityEngine;

namespace Pathfinding.Util;

public class GraphGizmoHelper : IAstarPooledObject, IDisposable
{
	private RetainedGizmos gizmos;

	private PathHandler debugData;

	private ushort debugPathID;

	private GraphDebugMode debugMode;

	private bool showSearchTree;

	private float debugFloor;

	private float debugRoof;

	private Vector3 drawConnectionStart;

	private Color drawConnectionColor;

	private readonly Action<GraphNode> drawConnection;

	public RetainedGizmos.Hasher hasher { get; private set; }

	public RetainedGizmos.Builder builder { get; private set; }

	public GraphGizmoHelper()
	{
		drawConnection = DrawConnection;
	}

	public void Init(AstarPath active, RetainedGizmos.Hasher hasher, RetainedGizmos gizmos)
	{
		debugData = active.debugPathData;
		debugPathID = active.debugPathID;
		debugMode = active.debugMode;
		debugFloor = active.debugFloor;
		debugRoof = active.debugRoof;
		this.gizmos = gizmos;
		this.hasher = hasher;
		builder = ObjectPool<RetainedGizmos.Builder>.Claim();
		showSearchTree = active.showSearchTree && debugData != null;
	}

	public void OnEnterPool()
	{
		RetainedGizmos.Builder obj = builder;
		ObjectPool<RetainedGizmos.Builder>.Release(ref obj);
		builder = null;
		debugData = null;
	}

	public void DrawConnections(GraphNode node)
	{
		//IL_0072: Unknown result type (might be due to invalid IL or missing references)
		//IL_0077: Unknown result type (might be due to invalid IL or missing references)
		//IL_0083: Unknown result type (might be due to invalid IL or missing references)
		//IL_0088: Unknown result type (might be due to invalid IL or missing references)
		//IL_003d: Unknown result type (might be due to invalid IL or missing references)
		//IL_005d: Unknown result type (might be due to invalid IL or missing references)
		//IL_0064: Unknown result type (might be due to invalid IL or missing references)
		if (showSearchTree)
		{
			if (InSearchTree(node, debugData, debugPathID))
			{
				PathNode pathNode = debugData.GetPathNode(node);
				if (pathNode.parent != null)
				{
					builder.DrawLine((Vector3)node.position, (Vector3)debugData.GetPathNode(node).parent.node.position, NodeColor(node));
				}
			}
		}
		else
		{
			drawConnectionColor = NodeColor(node);
			drawConnectionStart = (Vector3)node.position;
			node.GetConnections(drawConnection);
		}
	}

	private void DrawConnection(GraphNode other)
	{
		//IL_0007: Unknown result type (might be due to invalid IL or missing references)
		//IL_0012: Unknown result type (might be due to invalid IL or missing references)
		//IL_0018: Unknown result type (might be due to invalid IL or missing references)
		//IL_0022: Unknown result type (might be due to invalid IL or missing references)
		//IL_0028: Unknown result type (might be due to invalid IL or missing references)
		builder.DrawLine(drawConnectionStart, Vector3.Lerp((Vector3)other.position, drawConnectionStart, 0.5f), drawConnectionColor);
	}

	public Color NodeColor(GraphNode node)
	{
		//IL_012a: Unknown result type (might be due to invalid IL or missing references)
		//IL_012f: Unknown result type (might be due to invalid IL or missing references)
		//IL_001c: Unknown result type (might be due to invalid IL or missing references)
		//IL_0130: Unknown result type (might be due to invalid IL or missing references)
		//IL_005e: Unknown result type (might be due to invalid IL or missing references)
		//IL_0063: Unknown result type (might be due to invalid IL or missing references)
		//IL_0069: Unknown result type (might be due to invalid IL or missing references)
		//IL_006e: Unknown result type (might be due to invalid IL or missing references)
		//IL_0090: Unknown result type (might be due to invalid IL or missing references)
		//IL_0095: Unknown result type (might be due to invalid IL or missing references)
		//IL_00ac: Unknown result type (might be due to invalid IL or missing references)
		//IL_00b1: Unknown result type (might be due to invalid IL or missing references)
		//IL_00a1: Unknown result type (might be due to invalid IL or missing references)
		//IL_00a6: Unknown result type (might be due to invalid IL or missing references)
		//IL_00bc: Unknown result type (might be due to invalid IL or missing references)
		//IL_00c1: Unknown result type (might be due to invalid IL or missing references)
		//IL_0102: Unknown result type (might be due to invalid IL or missing references)
		//IL_0107: Unknown result type (might be due to invalid IL or missing references)
		//IL_0122: Unknown result type (might be due to invalid IL or missing references)
		//IL_0127: Unknown result type (might be due to invalid IL or missing references)
		if (showSearchTree && !InSearchTree(node, debugData, debugPathID))
		{
			return Color.clear;
		}
		if (node.Walkable)
		{
			switch (debugMode)
			{
			case GraphDebugMode.Areas:
				return AstarColor.GetAreaColor(node.Area);
			case GraphDebugMode.Penalty:
				return Color.Lerp(AstarColor.ConnectionLowLerp, AstarColor.ConnectionHighLerp, ((float)node.Penalty - debugFloor) / (debugRoof - debugFloor));
			case GraphDebugMode.Tags:
				return AstarColor.GetAreaColor(node.Tag);
			case GraphDebugMode.Connections:
				return AstarColor.NodeConnection;
			default:
			{
				if (debugData == null)
				{
					return AstarColor.NodeConnection;
				}
				PathNode pathNode = debugData.GetPathNode(node);
				float num = ((debugMode == GraphDebugMode.G) ? ((float)pathNode.G) : ((debugMode != GraphDebugMode.H) ? ((float)pathNode.F) : ((float)pathNode.H)));
				return Color.Lerp(AstarColor.ConnectionLowLerp, AstarColor.ConnectionHighLerp, (num - debugFloor) / (debugRoof - debugFloor));
			}
			}
		}
		return AstarColor.UnwalkableNode;
	}

	public static bool InSearchTree(GraphNode node, PathHandler handler, ushort pathID)
	{
		return handler.GetPathNode(node).pathID == pathID;
	}

	public void DrawWireTriangle(Vector3 a, Vector3 b, Vector3 c, Color color)
	{
		//IL_0006: Unknown result type (might be due to invalid IL or missing references)
		//IL_0007: Unknown result type (might be due to invalid IL or missing references)
		//IL_0008: Unknown result type (might be due to invalid IL or missing references)
		//IL_0015: Unknown result type (might be due to invalid IL or missing references)
		//IL_0016: Unknown result type (might be due to invalid IL or missing references)
		//IL_0017: Unknown result type (might be due to invalid IL or missing references)
		//IL_0024: Unknown result type (might be due to invalid IL or missing references)
		//IL_0025: Unknown result type (might be due to invalid IL or missing references)
		//IL_0026: Unknown result type (might be due to invalid IL or missing references)
		builder.DrawLine(a, b, color);
		builder.DrawLine(b, c, color);
		builder.DrawLine(c, a, color);
	}

	public void DrawTriangles(Vector3[] vertices, Color[] colors, int numTriangles)
	{
		List<int> list = ListPool<int>.Claim(numTriangles);
		for (int i = 0; i < numTriangles * 3; i++)
		{
			list.Add(i);
		}
		builder.DrawMesh(gizmos, vertices, list, colors);
		ListPool<int>.Release(list);
	}

	public void DrawWireTriangles(Vector3[] vertices, Color[] colors, int numTriangles)
	{
		//IL_0009: Unknown result type (might be due to invalid IL or missing references)
		//IL_0014: Unknown result type (might be due to invalid IL or missing references)
		//IL_001f: Unknown result type (might be due to invalid IL or missing references)
		//IL_0028: Unknown result type (might be due to invalid IL or missing references)
		for (int i = 0; i < numTriangles; i++)
		{
			DrawWireTriangle(vertices[i * 3], vertices[i * 3 + 1], vertices[i * 3 + 2], colors[i * 3]);
		}
	}

	public void Submit()
	{
		builder.Submit(gizmos, hasher);
	}

	void IDisposable.Dispose()
	{
		GraphGizmoHelper obj = this;
		Submit();
		ObjectPool<GraphGizmoHelper>.Release(ref obj);
	}
}
