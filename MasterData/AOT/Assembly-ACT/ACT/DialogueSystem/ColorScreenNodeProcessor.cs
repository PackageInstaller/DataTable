using System;
using System.Threading;
using Cysharp.Threading.Tasks;
using UnityEngine;

namespace ACT.DialogueSystem;

public class ColorScreenNodeProcessor : DialogueNodeProcessor<ColorScreenNode>
{
	protected override async UniTask<DialogueNodeResult> OnExecute(DialogueFlowExecution execution, DialogueContext context, CancellationToken token)
	{
		LuminDialogueContext luminDialogueContext = (LuminDialogueContext)context;
		try
		{
			await luminDialogueContext.States.GetOrCreateState<ColorScreenState>().Update(TData.active, TData.color, TData.speed, token, luminDialogueContext.Skipping);
		}
		catch (Exception message)
		{
			Debug.LogError(message);
		}
		return DialogueNodeResult.Continue;
	}
}
