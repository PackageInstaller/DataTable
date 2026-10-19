using System;
using System.Threading;
using Cysharp.Threading.Tasks;
using UnityEngine;

namespace ACT.DialogueSystem;

public class ChatOptionNodeProcessor : DialogueNodeProcessor<ChatOptionNode>
{
	protected override async UniTask<DialogueNodeResult> OnExecute(DialogueFlowExecution execution, DialogueContext context, CancellationToken token)
	{
		if (ChildrenCount > 0)
		{
			for (int i = 0; i < ChildrenCount; i++)
			{
				DialogueNodeProcessor child = GetChild(i);
				try
				{
					DialogueNodeResult result = await child.Execute(execution, context, token);
					if (result.Type > DialogueNodeResultType.Continue)
					{
						return result;
					}
				}
				catch (Exception ex)
				{
					Debug.LogError(ex);
					return DialogueNodeResult.Error(ex.Message);
				}
				if (token.IsCancellationRequested)
				{
					break;
				}
			}
		}
		else if (TData.OnSelectCallback != null)
		{
			await TData.OnSelectCallback();
		}
		return DialogueNodeResult.Continue;
	}

	public bool Check()
	{
		foreach (BaseCondition condition in TData.conditions)
		{
			if (!condition.Check())
			{
				return false;
			}
		}
		return true;
	}
}
