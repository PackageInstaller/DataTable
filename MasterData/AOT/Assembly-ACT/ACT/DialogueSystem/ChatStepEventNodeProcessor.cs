using System.Threading;
using Cysharp.Threading.Tasks;

namespace ACT.DialogueSystem;

public abstract class ChatStepEventNodeProcessor<T> : DialogueNodeProcessor<T>, IChatStepEventNode where T : DialogueNode
{
	public UniTask ExecuteStepEvent(ChatNodeProcessor chatNode, ChatStep chatStep, CancellationToken token)
	{
		return UniTask.CompletedTask;
	}

	public virtual UniTask ExecuteStepEvent(ChatStep chatStep, DialogueFlowExecution execution, DialogueContext context, CancellationToken token)
	{
		return UniTask.CompletedTask;
	}

	public ChatNodeProcessor GetChatNodeInParent()
	{
		for (DialogueNodeProcessor parent = Parent; parent != null; parent = parent.Parent)
		{
			if (parent is ChatNodeProcessor result)
			{
				return result;
			}
		}
		return null;
	}
}
