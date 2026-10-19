using System.Collections.Generic;
using System.Threading;
using Cysharp.Threading.Tasks;

namespace ACT.DialogueSystem;

public class EnterCenterTextNodeProcessor : DialogueNodeProcessor<EnterCenterTextNode>
{
	protected override UniTask<DialogueNodeResult> OnExecute(DialogueFlowExecution execution, DialogueContext context, CancellationToken token)
	{
		LuminDialogueFlowProcessor luminDialogueFlowProcessor = (LuminDialogueFlowProcessor)Flow;
		LuminDialogueContext luminDialogueContext = (LuminDialogueContext)context;
		List<CenterTextInfo> list = new List<CenterTextInfo>();
		for (int i = 0; i < ChildrenCount; i++)
		{
			TextProviderNodeProcessor textProviderNodeProcessor = GetChild(i) as TextProviderNodeProcessor;
			list.Add(new CenterTextInfo
			{
				dialogueId = textProviderNodeProcessor.TData.key,
				contentId = luminDialogueFlowProcessor.GetContentId(textProviderNodeProcessor.TData.key)
			});
		}
		luminDialogueContext.States.GetOrCreateState<CenterTextState>().Begin(list, luminDialogueContext.Skipping);
		return UniTask.FromResult(DialogueNodeResult.Continue);
	}
}
