using System;
using ACT.Core;
using ACT.UI;
using Cysharp.Threading.Tasks;
using Fundamental;
using UnityEngine.Playables;

namespace ACT.Timeline;

[Serializable]
public class SubtitleBehaviour : PlayableBehaviour
{
	public int txtId;

	public int Content;

	private SubtitleView _subtitleView;

	public double endTime;

	public override void OnGraphStart(Playable playable)
	{
		OpenAndGetView().Forget();
	}

	public override void OnBehaviourPlay(Playable playable, FrameData info)
	{
		UpdateSubtitleContentId().Forget();
	}

	private async UniTaskVoid OpenAndGetView()
	{
		Singleton<NewUIManager>.instance.OpenUI(UI_TYPE.UI_SUBTITLE);
		await UniTask.WaitUntil(() => Singleton<NewUIManager>.instance.GetFirstUIState(UI_TYPE.UI_SUBTITLE) == UIState.Opened);
		_subtitleView = Singleton<NewUIManager>.instance.FindUIViewByUIType(UI_TYPE.UI_SUBTITLE) as SubtitleView;
	}

	private async UniTaskVoid UpdateSubtitleContentId()
	{
		await UniTask.WaitUntil(() => _subtitleView != null);
		txtId = RuntimeConfigs.data.dramaDialogDatas[Content].content;
		_subtitleView.contentId = txtId;
		_subtitleView.UpdateSubtitleWords();
		_subtitleView.SetViewShowMode(1f);
	}

	public override void OnBehaviourPause(Playable playable, FrameData info)
	{
		PlayableDirector playableDirector = playable.GetGraph().GetResolver() as PlayableDirector;
		if (playableDirector != null && playableDirector.state == PlayState.Playing && info.deltaTime > 0f && endTime < playableDirector.time && playableDirector.time - (double)info.deltaTime < endTime)
		{
			_subtitleView.SetViewShowMode(0f);
		}
	}

	public override void OnPlayableDestroy(Playable playable)
	{
		Singleton<NewUIManager>.instance.CloseUI(UI_TYPE.UI_SUBTITLE);
	}
}
