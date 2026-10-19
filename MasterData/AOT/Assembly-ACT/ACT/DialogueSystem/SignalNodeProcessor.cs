using System;
using System.Threading;
using Cysharp.Threading.Tasks;
using UnityEngine;

namespace ACT.DialogueSystem;

public class SignalNodeProcessor : DialogueNodeProcessor<SignalNode>, ISignalEmitter
{
	protected override UniTask<DialogueNodeResult> OnExecute(DialogueFlowExecution execution, DialogueContext context, CancellationToken token)
	{
		LuminDialogueContext luminDialogueContext = context as LuminDialogueContext;
		foreach (SignalAction action in TData.actions)
		{
			try
			{
				if (!luminDialogueContext.Skipping || TData.mustDo || !action.CanSkip)
				{
					action?.Invoke(this);
				}
			}
			catch (Exception message)
			{
				if (LuminApplication.LogEnabled)
				{
					Debug.LogError(message);
				}
			}
		}
		return UniTask.FromResult(DialogueNodeResult.Continue);
	}
}
