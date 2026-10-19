using System.Threading;
using ACT.Game;
using Cysharp.Threading.Tasks;

namespace ACT.DialogueSystem;

public class LoadBgNodeProcessor : DialogueNodeProcessor<LoadBgNode>
{
	private int m_Bg;

	protected override void OnInit()
	{
		m_Bg = ((G.detailUserInfo.Brief.Gender == 1) ? TData.bgId_male : TData.bgId);
	}

	protected override async UniTask<DialogueNodeResult> OnExecute(DialogueFlowExecution execution, DialogueContext context, CancellationToken token)
	{
		if (m_Bg == -1)
		{
			return DialogueNodeResult.Continue;
		}
		LuminDialogueContext luminDialogueContext = (LuminDialogueContext)context;
		await luminDialogueContext.States.GetOrCreateState<BGState>().AddBg(m_Bg, TData.initScale, TData.initOffset, luminDialogueContext.Skipping).SuppressCancellationThrow();
		return DialogueNodeResult.Continue;
	}
}
