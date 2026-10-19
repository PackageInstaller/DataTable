using System;
using System.Threading;
using Cysharp.Threading.Tasks;
using UnityEngine;

namespace ACT.DialogueSystem;

public class IfNodeProcessor : DialogueNodeProcessor<IfNode>
{
	protected override async UniTask<DialogueNodeResult> OnExecute(DialogueFlowExecution execution, DialogueContext context, CancellationToken token)
	{
		if (Check() && ChildrenCount > 0)
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
		return DialogueNodeResult.Continue;
	}

	protected override async UniTask<DialogueNodeResult> OnJumpChild(DialogueStartRoute startRoute, DialogueContext context, CancellationToken token)
	{
		DialogueNodeProcessor c = GetChildById(startRoute.ChildId);
		for (int i = c.Index; i < ChildrenCount; i++)
		{
			DialogueNodeProcessor child = GetChild(i);
			try
			{
				_ = DialogueNodeResult.Continue;
				DialogueNodeResult result = ((child != c) ? (await child.Execute(startRoute.Execution, context, token)) : (await child.Jump(startRoute, context, token)));
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
