using System.Threading;
using Cysharp.Threading.Tasks;

namespace ACT.DialogueSystem;

public interface IChatStepEventNode
{
	UniTask ExecuteStepEvent(ChatNodeProcessor chatNode, ChatStep chatStep, CancellationToken token);

	UniTask ExecuteStepEvent(ChatStep chatStep, DialogueFlowExecution execution, DialogueContext context, CancellationToken token);
}
