using System;
using System.Threading;
using Cysharp.Threading.Tasks;
using UnityEngine;

namespace ACT.DialogueSystem;

public class EnterBlackScreenNodeProcessor : DialogueNodeProcessor<EnterBlackScreenNode>
{
	protected override async UniTask<DialogueNodeResult> OnExecute(DialogueFlowExecution execution, DialogueContext context, CancellationToken token)
	{
		LuminDialogueContext luminDialogueContext = (LuminDialogueContext)context;
		try
		{
			await luminDialogueContext.States.GetOrCreateState<BlackScreenState>().ChangeActive(b: true, TData.speed, luminDialogueContext.Skipping, token);
		}
		catch (Exception message)
		{
			Debug.LogError(message);
		}
		return DialogueNodeResult.Continue;
	}
}
