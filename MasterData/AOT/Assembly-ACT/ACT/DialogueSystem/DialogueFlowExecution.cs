using System.Collections.Generic;
using System.Threading;
using Cysharp.Threading.Tasks;
using UnityEngine;
using UnityEngine.Pool;

namespace ACT.DialogueSystem;

public class DialogueFlowExecution
{
	private DialogueFlowProcessor m_Flow;

	private DialogueContext m_Context;

	private CancellationToken m_ExternalToken;

	public DialogueFlowExecution(DialogueFlowProcessor flow, DialogueContext context, CancellationToken token)
	{
		m_Flow = flow;
		m_Context = context;
		m_ExternalToken = token;
	}

	public async UniTask<bool> ExecuteRoot()
	{
		DialogueNodeResult dialogueNodeResult = await m_Flow.Root.Execute(this, m_Context, m_ExternalToken);
		if (dialogueNodeResult.Type == DialogueNodeResultType.Error)
		{
			Debug.LogError(dialogueNodeResult.Message);
			return false;
		}
		return true;
	}

	public async UniTask<DialogueNodeResult> JumpExecute(long startNodeId)
	{
		DialogueNodeProcessor node = m_Flow.GetNode(startNodeId);
		if (node == null)
		{
			return DialogueNodeResult.Error("目标节点为空");
		}
		List<long> list = CollectionPool<List<long>, long>.Get();
		try
		{
			for (DialogueNodeProcessor dialogueNodeProcessor = node; dialogueNodeProcessor != null; dialogueNodeProcessor = dialogueNodeProcessor.Parent)
			{
				list.Insert(0, dialogueNodeProcessor.Id);
			}
			DialogueStartRoute startRoute = new DialogueStartRoute(list, m_Flow, this);
			return await m_Flow.Root.Jump(startRoute, m_Context, m_ExternalToken);
		}
		finally
		{
			CollectionPool<List<long>, long>.Release(list);
		}
	}
}
