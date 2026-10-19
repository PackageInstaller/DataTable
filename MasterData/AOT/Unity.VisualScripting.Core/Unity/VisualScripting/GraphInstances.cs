using System;
using System.Collections.Generic;
using UnityEngine;

namespace Unity.VisualScripting;

public static class GraphInstances
{
	private static readonly object @lock = new object();

	private static readonly Dictionary<IGraph, HashSet<GraphReference>> byGraph = new Dictionary<IGraph, HashSet<GraphReference>>();

	private static readonly Dictionary<IGraphParent, HashSet<GraphReference>> byParent = new Dictionary<IGraphParent, HashSet<GraphReference>>();

	public static void Instantiate(GraphReference instance)
	{
		lock (@lock)
		{
			Ensure.That("instance").IsNotNull(instance);
			instance.CreateGraphData();
			instance.graph.Instantiate(instance);
			if (!byGraph.TryGetValue(instance.graph, out var value))
			{
				value = new HashSet<GraphReference>();
				byGraph.Add(instance.graph, value);
			}
			if (!value.Add(instance))
			{
				Debug.LogWarning($"Attempting to add duplicate graph instance mapping:\n{instance.graph} => {instance}");
			}
			if (!byParent.TryGetValue(instance.parent, out var value2))
			{
				value2 = new HashSet<GraphReference>();
				byParent.Add(instance.parent, value2);
			}
			if (!value2.Add(instance))
			{
				Debug.LogWarning($"Attempting to add duplicate parent instance mapping:\n{instance.parent.ToSafeString()} => {instance}");
			}
		}
	}

	public static void Uninstantiate(GraphReference instance)
	{
		lock (@lock)
		{
			instance.graph.Uninstantiate(instance);
			if (!byGraph.TryGetValue(instance.graph, out var value))
			{
				throw new InvalidOperationException("Graph instance not found via graph.");
			}
			if (value.Remove(instance))
			{
				if (value.Count == 0)
				{
					byGraph.Remove(instance.graph);
				}
			}
			else
			{
				Debug.LogWarning($"Could not find graph instance mapping to remove:\n{instance.graph} => {instance}");
			}
			if (!byParent.TryGetValue(instance.parent, out var value2))
			{
				throw new InvalidOperationException("Graph instance not found via parent.");
			}
			if (value2.Remove(instance))
			{
				if (value2.Count == 0)
				{
					byParent.Remove(instance.parent);
				}
			}
			else
			{
				Debug.LogWarning($"Could not find parent instance mapping to remove:\n{instance.parent.ToSafeString()} => {instance}");
			}
			instance.FreeGraphData();
		}
	}

	public static HashSet<GraphReference> OfPooled(IGraph graph)
	{
		Ensure.That("graph").IsNotNull(graph);
		lock (@lock)
		{
			if (byGraph.TryGetValue(graph, out var value))
			{
				return value.ToHashSetPooled();
			}
			return HashSetPool<GraphReference>.New();
		}
	}

	public static HashSet<GraphReference> ChildrenOfPooled(IGraphParent parent)
	{
		Ensure.That("parent").IsNotNull(parent);
		lock (@lock)
		{
			if (byParent.TryGetValue(parent, out var value))
			{
				return value.ToHashSetPooled();
			}
			return HashSetPool<GraphReference>.New();
		}
	}
}
