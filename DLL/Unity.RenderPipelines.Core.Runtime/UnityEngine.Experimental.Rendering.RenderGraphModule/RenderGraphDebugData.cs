using System.Collections.Generic;
using System.Diagnostics;

namespace UnityEngine.Experimental.Rendering.RenderGraphModule;

internal class RenderGraphDebugData
{
	[DebuggerDisplay("PassDebug: {name}")]
	public struct PassDebugData
	{
		public string name;

		public List<int>[] resourceReadLists;

		public List<int>[] resourceWriteLists;

		public bool culled;

		public bool generateDebugData;
	}

	[DebuggerDisplay("ResourceDebug: {name} [{creationPassIndex}:{releasePassIndex}]")]
	public struct ResourceDebugData
	{
		public string name;

		public bool imported;

		public int creationPassIndex;

		public int releasePassIndex;

		public List<int> consumerList;

		public List<int> producerList;
	}

	public List<PassDebugData> passList = new List<PassDebugData>();

	public List<ResourceDebugData>[] resourceLists = new List<ResourceDebugData>[2];

	public void Clear()
	{
		passList.Clear();
		if (resourceLists[0] == null)
		{
			for (int i = 0; i < 2; i++)
			{
				resourceLists[i] = new List<ResourceDebugData>();
			}
		}
		for (int j = 0; j < 2; j++)
		{
			resourceLists[j].Clear();
		}
	}
}
