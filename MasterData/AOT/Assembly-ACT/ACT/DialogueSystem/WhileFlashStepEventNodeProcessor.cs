using System;
using System.Threading;
using Cysharp.Threading.Tasks;

namespace ACT.DialogueSystem;

public class WhileFlashStepEventNodeProcessor : ChatStepEventNodeProcessor<WhileFlashStepEventNode>
{
	protected override async UniTask<DialogueNodeResult> OnExecute(DialogueFlowExecution execution, DialogueContext context, CancellationToken token)
	{
		if ((context as LuminDialogueContext).Skipping)
		{
			return DialogueNodeResult.Continue;
		}
		if ((bool)UIConversationScene.Instance)
		{
			UIConversationScene.Instance.WhiteFlash();
			await LuminDialogueUtility.DelayOrForceNext(TimeSpan.FromSeconds(0.5), token);
		}
		return DialogueNodeResult.Continue;
	}

	public override UniTask ExecuteStepEvent(ChatStep chatStep, DialogueFlowExecution execution, DialogueContext context, CancellationToken token)
	{
		if (chatStep != ChatStep.OnShowDialogue)
		{
			return UniTask.CompletedTask;
		}
		return Execute(execution, context, token);
	}
}
