using System.Threading;
using Cysharp.Threading.Tasks;

namespace ACT.DialogueSystem;

public class TimelineProcessor : DialogueNodeProcessor<Timeline>
{
	private bool isJump;

	private CancellationTokenSource m_cts;

	protected override async UniTask<DialogueNodeResult> OnExecute(DialogueFlowExecution execution, DialogueContext context, CancellationToken token)
	{
		_ = (context as LuminDialogueContext).Skipping;
		return DialogueNodeResult.Continue;
	}
}
