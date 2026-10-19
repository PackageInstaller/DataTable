using System.Threading;
using Cysharp.Threading.Tasks;
using Lumin.LoungeSystem.UI;

namespace ACT.DialogueSystem;

public class LoungeRoleAnimStepEventNodeProcessor : ChatStepEventNodeProcessor<LoungeRoleAnimStepEventNode>
{
	protected override UniTask<DialogueNodeResult> OnExecute(DialogueFlowExecution execution, DialogueContext context, CancellationToken token)
	{
		LoungeUIScene.instance?.SetCharacterAnimState(TData.characterId, TData.stateName);
		return UniTask.FromResult(DialogueNodeResult.Continue);
	}

	public override UniTask ExecuteStepEvent(ChatStep chatStep, DialogueFlowExecution execution, DialogueContext context, CancellationToken token)
	{
		if (chatStep != ChatStep.OnEnter)
		{
			return UniTask.CompletedTask;
		}
		return Execute(execution, context, token);
	}
}
