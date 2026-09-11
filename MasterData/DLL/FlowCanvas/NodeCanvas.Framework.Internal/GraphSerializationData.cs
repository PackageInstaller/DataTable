using System;
using System.Collections.Generic;
using UnityEngine;

namespace NodeCanvas.Framework.Internal;

[Serializable]
public class GraphSerializationData
{
	public const float FRAMEWORK_VERSION = 2.9f;

	public float version;

	public Type type;

	public string name = string.Empty;

	public string category = string.Empty;

	public string comments = string.Empty;

	public Vector2 translation = new Vector2(-5000f, -5000f);

	public float zoomFactor = 1f;

	public List<Node> nodes = new List<Node>();

	public List<Connection> connections = new List<Connection>();

	public List<CanvasGroup> canvasGroups;

	public BlackboardSource localBlackboard;

	public object derivedData;

	public GraphSerializationData()
	{
	}

	public GraphSerializationData(Graph graph)
	{
		version = 2.9f;
		type = graph.GetType();
		category = graph.category;
		comments = graph.comments;
		translation = graph.translation;
		zoomFactor = graph.zoomFactor;
		nodes = graph.allNodes;
		canvasGroups = graph.canvasGroups;
		localBlackboard = graph.localBlackboard;
		List<Connection> list = new List<Connection>();
		for (int i = 0; i < nodes.Count; i++)
		{
			for (int j = 0; j < nodes[i].outConnections.Count; j++)
			{
				list.Add(nodes[i].outConnections[j]);
			}
		}
		connections = list;
		derivedData = graph.OnDerivedDataSerialization();
	}

	public void Reconstruct(Graph graph)
	{
		for (int i = 0; i < connections.Count; i++)
		{
			connections[i].sourceNode.outConnections.Add(connections[i]);
			connections[i].targetNode.inConnections.Add(connections[i]);
		}
		for (int j = 0; j < nodes.Count; j++)
		{
			nodes[j].graph = graph;
			nodes[j].ID = j;
		}
		graph.OnDerivedDataDeserialization(derivedData);
	}
}
