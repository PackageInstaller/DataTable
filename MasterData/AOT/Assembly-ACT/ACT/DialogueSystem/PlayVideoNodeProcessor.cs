using System.Threading;
using ACT.UI;
using Cysharp.Threading.Tasks;
using Fundamental;

namespace ACT.DialogueSystem;

public class PlayVideoNodeProcessor : DialogueNodeProcessor<PlayVideoNode>
{
	protected override async UniTask<DialogueNodeResult> OnExecute(DialogueFlowExecution execution, DialogueContext context, CancellationToken token)
	{
		if (((LuminDialogueContext)context).Skipping)
		{
			return DialogueNodeResult.Continue;
		}
		bool finished = false;
		UIOpenResult openUIResult = Singleton<NewUIManager>.instance.OpenUI(UI_TYPE.UI_FULLSCREENVIDEO, new FullScreenVideoViewData());
		await Singleton<NewUIManager>.instance.WaitUIOpenAsync(openUIResult);
		FullScreenVideoView videoView = Singleton<NewUIManager>.instance.FindUIViewByUIType(UI_TYPE.UI_FULLSCREENVIDEO) as FullScreenVideoView;
		if (videoView == null)
		{
			return DialogueNodeResult.Continue;
		}
		videoView.PlayVideo(TData.videoId, () =>
		{
			finished = true;
		}, new FullScreenVideoView.PlayVideoArgument
		{
			showSkipButton = true
		});
		await LuminDialogueUtility.WaitUntilOrForceNext(() => finished, token, () =>
		{
			if (videoView.IsPlaying)
			{
				videoView.StopVideo();
			}
			finished = true;
		});
		return DialogueNodeResult.Continue;
	}
}
