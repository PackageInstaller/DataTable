using System.Collections.Generic;

namespace Unity.VisualScripting;

public interface IGraphDebugData
{
	IEnumerable<IGraphElementDebugData> elementsData { get; }

	IGraphElementDebugData GetOrCreateElementData(IGraphElementWithDebugData element);

	IGraphDebugData GetOrCreateChildGraphData(IGraphParentElement element);
}
