using System.Threading;
using Cysharp.Threading.Tasks;

namespace ACT.DialogueSystem;

public class CameraFocusStepEventNodeProcessor : ChatStepEventNodeProcessor<CameraFocusStepEventNode>
{
	protected override async UniTask<DialogueNodeResult> OnExecute(DialogueFlowExecution execution, DialogueContext context, CancellationToken token)
	{
		LuminDialogueContext luminContext = (LuminDialogueContext)context;
		if (!luminContext.Env)
		{
			return DialogueNodeResult.Continue;
		}
		await luminContext.States.GetOrCreateState<CameraFocusState>().Update(luminContext, TData.cameraFocusType, TData.key, token, luminContext.Skipping);
		if (!luminContext.Skipping)
		{
			await LuminDialogueUtility.WaitForSecondsOrForceNext(1f, token);
		}
		return DialogueNodeResult.Continue;
	}

	public override UniTask ExecuteStepEvent(ChatStep chatStep, DialogueFlowExecution execution, DialogueContext context, CancellationToken token)
	{
		if ((TData.step & chatStep) == 0)
		{
			return UniTask.CompletedTask;
		}
		return Execute(execution, context, token);
	}
}
