using System;
using System.Collections.Generic;

namespace FlowCanvas.Core;

[Serializable]
public class fsCategory
{
	public List<string> logicGraphs = new List<string>();

	public List<string> renderGraphs = new List<string>();

	[NonSerialized]
	private HashSet<string> m_logicGraphs = new HashSet<string>();

	[NonSerialized]
	private HashSet<string> m_renderGraphs = new HashSet<string>();

	public void Init()
	{
		m_logicGraphs = new HashSet<string>(logicGraphs);
		m_renderGraphs = new HashSet<string>(renderGraphs);
	}

	public void Clear()
	{
		logicGraphs.Clear();
		renderGraphs.Clear();
	}

	public bool IsLogic(string graph)
	{
		return m_logicGraphs.Contains(graph);
	}

	public bool IsRender(string graph)
	{
		return m_renderGraphs.Contains(graph);
	}
}
