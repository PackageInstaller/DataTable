using System.Threading;
using ACT.Drama;
using Cysharp.Threading.Tasks;
using Fundamental;

namespace ACT.DialogueSystem;

public class WakeFxStepEventNodeProcessor : ChatStepEventNodeProcessor<WakeFxStepEventNode>
{
	protected override UniTask<DialogueNodeResult> OnExecute(DialogueFlowExecution execution, DialogueContext context, CancellationToken token)
	{
		if (!(context as LuminDialogueContext).Skipping)
		{
			Singleton<ConversationManager>.instance.conversationView.FinishWakeFx();
		}
		return UniTask.FromResult(DialogueNodeResult.Continue);
	}

	public override async UniTask ExecuteStepEvent(ChatStep chatStep, DialogueFlowExecution execution, DialogueContext context, CancellationToken token)
	{
		if (chatStep != ChatStep.None && !(context as LuminDialogueContext).Skipping)
		{
			switch (chatStep)
			{
			case ChatStep.OnAfterUpdateScene:
				await Singleton<ConversationManager>.instance.conversationView.WakeFxTask();
				break;
			case ChatStep.OnShowDialogue:
				await Execute(execution, context, token);
				break;
			}
		}
	}
}
