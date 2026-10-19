using System.Collections.Generic;

namespace ACT.DialogueSystem;

public struct DialogueStartRoute(List<long> startNodes, DialogueFlowProcessor flow, DialogueFlowExecution execution)
{
	public readonly DialogueFlowProcessor Flow = flow;

	public readonly DialogueFlowExecution Execution = execution;

	private readonly List<long> m_StartNodes = startNodes;

	private int m_CurrentIndex = -1;

	public bool IsLast => m_CurrentIndex == m_StartNodes.Count - 1;

	public long ChildId => m_StartNodes[m_CurrentIndex + 1];

	public DialogueStartRoute MoveNext()
	{
		if (IsLast)
		{
			return default;
		}
		DialogueStartRoute dialogueStartRoute = new DialogueStartRoute(m_StartNodes, Flow, Execution);
		dialogueStartRoute.m_CurrentIndex = m_CurrentIndex + 1;
		DialogueStartRoute result = dialogueStartRoute;
		result.m_CurrentIndex = m_CurrentIndex + 1;
		return result;
	}
}
