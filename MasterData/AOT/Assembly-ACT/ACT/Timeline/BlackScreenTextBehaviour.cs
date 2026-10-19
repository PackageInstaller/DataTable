using System;
using ACT.Core;
using ACT.Drama;
using ACT.EventTrack;
using ACT.UI;
using Fundamental;
using UnityEngine;
using UnityEngine.Playables;

namespace ACT.Timeline;

[Serializable]
public class BlackScreenTextBehaviour : PlayableBehaviour
{
	public double endTime;

	public int contentId;

	private int finalId;

	private FrameworkBlackScreen blackScreenView;

	private long m_StartTime;

	private bool startInSkip;

	public override void OnGraphStart(Playable playable)
	{
		if (contentId == 0)
		{
			if (LuminApplication.LogEnabled)
			{
				Debug.LogError("TimelineBlackScreenTextBehaviour.contentId为0  查一下~)");
			}
		}
		else
		{
			finalId = RuntimeConfigs.data.dramaDialogDatas[contentId].content;
		}
	}

	public override void OnBehaviourPlay(Playable playable, FrameData info)
	{
		base.OnBehaviourPlay(playable, info);
		startInSkip = Singleton<TimelineConversationManager>.instance.InSkip;
		m_StartTime = TimeManager.LocalTime.NowTimestamp;
	}

	public override void OnBehaviourPause(Playable playable, FrameData info)
	{
		base.OnBehaviourPause(playable, info);
		bool inSkip = Singleton<TimelineConversationManager>.instance.InSkip;
		if ((!startInSkip & inSkip) && contentId > 0 && Singleton<ConversationManager>.instance.PlayingDialogue is TimelineDialogue timelineDialogue)
		{
			TrackDramaEvt evt = EventTrackSolver.Instance.GetEvt<TrackDramaEvt>();
			evt.conversationId = timelineDialogue.TimelineId;
			evt.subId = contentId;
			TrackDramaEvt trackDramaEvt = evt;
			trackDramaEvt.type = timelineDialogue.TimelineType switch
			{
				TimelineType.Normal => 8, 
				TimelineType.DialogueStory => 1, 
				_ => throw new ArgumentOutOfRangeException(), 
			};
			evt.status = 2;
			evt.conversationDuration = TimeManager.GetTimeSpan(TimeManager.LocalTime.NowTimestamp - m_StartTime).TotalSeconds;
			evt.isSkip = true;
			EventTrackSolver.Instance.Dispatch(evt);
		}
	}

	public override void PrepareFrame(Playable playable, FrameData info)
	{
		if (blackScreenView == null)
		{
			blackScreenView = Singleton<NewUIManager>.instance.BlackScreen;
		}
		PlayableDirector playableDirector = playable.GetGraph().GetResolver() as PlayableDirector;
		if (playableDirector != null && playableDirector.state == PlayState.Playing && info.deltaTime > 0f && playableDirector.time + (double)info.deltaTime > endTime)
		{
			blackScreenView.SetBlackScreenText(0, 0f);
		}
		else if (playableDirector != null && playableDirector.state == PlayState.Playing)
		{
			blackScreenView.SetBlackScreenText((info.weight != 0f) ? finalId : 0, info.weight);
		}
	}
}
