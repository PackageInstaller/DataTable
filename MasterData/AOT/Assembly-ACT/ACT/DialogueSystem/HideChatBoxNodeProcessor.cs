using System.Threading;
using ACT.Drama;
using ACT.UI;
using Cysharp.Threading.Tasks;
using Fundamental;

namespace ACT.DialogueSystem;

public class HideChatBoxNodeProcessor : DialogueNodeProcessor<HideChatBoxNode>
{
	protected override UniTask<DialogueNodeResult> OnExecute(DialogueFlowExecution execution, DialogueContext context, CancellationToken token)
	{
		MonoConversationView conversationView = Singleton<ConversationManager>.instance.conversationView;
		if ((bool)conversationView)
		{
			conversationView.normalView.HideAndClearContent().Forget();
		}
		return base.OnExecute(execution, context, token);
	}
}
