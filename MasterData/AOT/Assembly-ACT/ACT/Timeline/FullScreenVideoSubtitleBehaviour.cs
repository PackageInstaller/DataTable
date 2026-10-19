using System;
using ACT.UI;
using Fundamental;
using UnityEngine.Playables;

namespace ACT.Timeline;

[Serializable]
public class FullScreenVideoSubtitleBehaviour : PlayableBehaviour
{
	[NonSerialized]
	public int contentId;

	[NonSerialized]
	public double endTime;

	private FullScreenVideoView _view;

	private bool _isShowing;

	public override void OnBehaviourPlay(Playable playable, FrameData info)
	{
		EnsureView();
		if (!(_view == null))
		{
			if (contentId > 0)
			{
				_view.SetSubtitle(contentId);
			}
			_isShowing = true;
		}
	}

	public override void OnBehaviourPause(Playable playable, FrameData info)
	{
		if (_isShowing)
		{
			PlayableDirector playableDirector = playable.GetGraph().GetResolver() as PlayableDirector;
			if (playableDirector != null && playableDirector.state == PlayState.Playing && info.deltaTime > 0f && endTime < playableDirector.time && playableDirector.time - (double)info.deltaTime < endTime)
			{
				HideSubtitle();
			}
			else if (info.effectivePlayState == PlayState.Paused)
			{
				HideSubtitle();
			}
		}
	}

	public override void OnPlayableDestroy(Playable playable)
	{
		HideSubtitle();
	}

	public override void OnGraphStop(Playable playable)
	{
		HideSubtitle();
	}

	private void HideSubtitle()
	{
		if (_isShowing && _view != null)
		{
			_view.ClearSubtitle();
			_isShowing = false;
		}
	}

	private void EnsureView()
	{
		if (_view == null)
		{
			_view = Singleton<NewUIManager>.instance?.FindUIViewByUIType(UI_TYPE.UI_FULLSCREENVIDEO) as FullScreenVideoView;
		}
	}
}
