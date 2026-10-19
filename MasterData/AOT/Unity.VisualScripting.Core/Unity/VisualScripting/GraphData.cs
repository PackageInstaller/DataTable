using System;
using System.Collections.Generic;
using UnityEngine;

namespace Unity.VisualScripting;

public class GraphData<TGraph> : IGraphData where TGraph : class, IGraph
{
	protected TGraph definition { get; }

	protected Dictionary<IGraphElementWithData, IGraphElementData> elementsData { get; } = new Dictionary<IGraphElementWithData, IGraphElementData>();

	protected Dictionary<IGraphParentElement, IGraphData> childrenGraphsData { get; } = new Dictionary<IGraphParentElement, IGraphData>();

	protected Dictionary<Guid, IGraphElementData> phantomElementsData { get; } = new Dictionary<Guid, IGraphElementData>();

	protected Dictionary<Guid, IGraphData> phantomChildrenGraphsData { get; } = new Dictionary<Guid, IGraphData>();

	public GraphData(TGraph definition)
	{
		this.definition = definition;
	}

	public bool TryGetElementData(IGraphElementWithData element, out IGraphElementData data)
	{
		return elementsData.TryGetValue(element, out data);
	}

	public bool TryGetChildGraphData(IGraphParentElement element, out IGraphData data)
	{
		return childrenGraphsData.TryGetValue(element, out data);
	}

	public IGraphElementData CreateElementData(IGraphElementWithData element)
	{
		if (elementsData.ContainsKey(element))
		{
			throw new InvalidOperationException($"Graph data already contains element data for {element}.");
		}
		if (phantomElementsData.TryGetValue(element.guid, out var value))
		{
			phantomElementsData.Remove(element.guid);
		}
		else
		{
			value = element.CreateData();
		}
		elementsData.Add(element, value);
		return value;
	}

	public void FreeElementData(IGraphElementWithData element)
	{
		if (elementsData.TryGetValue(element, out var value))
		{
			elementsData.Remove(element);
			phantomElementsData.Add(element.guid, value);
		}
		else
		{
			Debug.LogWarning($"Graph data does not contain element data to free for {element}.");
		}
	}

	public IGraphData CreateChildGraphData(IGraphParentElement element)
	{
		if (childrenGraphsData.ContainsKey(element))
		{
			throw new InvalidOperationException($"Graph data already contains child graph data for {element}.");
		}
		if (phantomChildrenGraphsData.TryGetValue(element.guid, out var value))
		{
			phantomChildrenGraphsData.Remove(element.guid);
		}
		else
		{
			value = element.childGraph.CreateData();
		}
		childrenGraphsData.Add(element, value);
		return value;
	}

	public void FreeChildGraphData(IGraphParentElement element)
	{
		if (childrenGraphsData.TryGetValue(element, out var value))
		{
			childrenGraphsData.Remove(element);
			phantomChildrenGraphsData.Add(element.guid, value);
		}
		else
		{
			Debug.LogWarning($"Graph data does not contain child graph data to free for {element}.");
		}
	}
}
