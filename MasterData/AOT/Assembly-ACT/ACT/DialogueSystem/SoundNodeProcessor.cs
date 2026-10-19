using System.Threading;
using ACT.Core;
using Cysharp.Threading.Tasks;
using Fundamental;

namespace ACT.DialogueSystem;

public class SoundNodeProcessor : DialogueNodeProcessor<SoundNode>
{
	protected override UniTask<DialogueNodeResult> OnExecute(DialogueFlowExecution execution, DialogueContext context, CancellationToken token)
	{
		if (!(context as LuminDialogueContext).Skipping && RuntimeConfigs.data.dialogueSFXDatas.TryGetValue(TData.soundId, out var value))
		{
			Singleton<GameManager>.instance.audioManager.PlaySound(value.key);
		}
		return UniTask.FromResult(DialogueNodeResult.Continue);
	}
}
