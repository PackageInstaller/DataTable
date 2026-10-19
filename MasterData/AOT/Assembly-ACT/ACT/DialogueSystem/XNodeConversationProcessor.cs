using System.Threading;
using ACT.Drama;
using Cysharp.Threading.Tasks;
using Fundamental;

namespace ACT.DialogueSystem;

public class XNodeConversationProcessor : DialogueNodeProcessor<XNodeConversation>
{
	private bool isJump;

	private CancellationTokenSource m_cts;

	protected override async UniTask<DialogueNodeResult> OnExecute(DialogueFlowExecution execution, DialogueContext context, CancellationToken token)
	{
		if ((context as LuminDialogueContext).Skipping)
		{
			return DialogueNodeResult.Continue;
		}
		Singleton<ConversationManager>.instance.ConversationStart(TData.conversationId);
		await UniTask.WaitUntil(() => Singleton<ConversationManager>.instance.isOver, PlayerLoopTiming.Update, token);
		return DialogueNodeResult.Continue;
	}
}
