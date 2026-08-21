using System.Collections.Generic;
using UnityEngine;

namespace NodeCanvas.Framework.Internal;

public struct GraphLoadData
{
	public GraphSource source;

	public string json;

	public GraphByteData graphByteData;

	public List<Object> references;

	public Component agent;

	public IBlackboard parentBlackboard;

	public bool preInitializeSubGraphs;

	public static GraphLoadData Creat(Graph graph, GraphOwner graphOwner, bool preInitializeSubGraphs)
	{
		return new GraphLoadData
		{
			source = graph.GetGraphSource(),
			json = graph.GetSerializedJsonData(),
			graphByteData = graph.GetSerializedByteData(),
			references = graph.GetSerializedReferencesData(),
			agent = graphOwner,
			parentBlackboard = graphOwner.blackboard,
			preInitializeSubGraphs = preInitializeSubGraphs
		};
	}
}
