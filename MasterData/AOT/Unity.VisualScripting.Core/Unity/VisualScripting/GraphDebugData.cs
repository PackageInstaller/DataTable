using System.Collections.Generic;

namespace Unity.VisualScripting;

public class GraphDebugData : IGraphDebugData
{
	protected Dictionary<IGraphElementWithDebugData, IGraphElementDebugData> elementsData { get; } = new Dictionary<IGraphElementWithDebugData, IGraphElementDebugData>();

	protected Dictionary<IGraphParentElement, IGraphDebugData> childrenGraphsData { get; } = new Dictionary<IGraphParentElement, IGraphDebugData>();

	IEnumerable<IGraphElementDebugData> IGraphDebugData.elementsData => elementsData.Values;

	public GraphDebugData(IGraph definition)
	{
	}

	public IGraphElementDebugData GetOrCreateElementData(IGraphElementWithDebugData element)
	{
		if (!elementsData.TryGetValue(element, out var value))
		{
			value = element.CreateDebugData();
			elementsData.Add(element, value);
		}
		return value;
	}

	public IGraphDebugData GetOrCreateChildGraphData(IGraphParentElement element)
	{
		if (!childrenGraphsData.TryGetValue(element, out var value))
		{
			value = new GraphDebugData(element.childGraph);
			childrenGraphsData.Add(element, value);
		}
		return value;
	}
}
