using System;
using System.Collections.Generic;
using System.Threading;
using ACT.Drama;
using ACT.EventTrack;
using Cysharp.Threading.Tasks;
using Fundamental;
using Sirenix.Serialization;
using UnityEngine.Playables;
using UnityEngine.Timeline;

namespace ACT.Timeline;

[Serializable]
public class ConversationBehaviour : PlayableBehaviour
{
	[NonSerialized]
	public TimelineClip clip;

	[OdinSerialize]
	public List<TimelineConversationData> datas = new List<TimelineConversationData>();

	private ConversationController m_Controller;

	private CancellationTokenSource m_TokenSource;

	private bool isPlayed;

	public override void OnGraphStart(Playable playable)
	{
		m_TokenSource = new CancellationTokenSource();
	}

	public override void OnGraphStop(Playable playable)
	{
		CancellationTokenSource tokenSource = m_TokenSource;
		if (tokenSource != null && !tokenSource.IsCancellationRequested)
		{
			m_TokenSource.Cancel();
		}
	}

	public override void OnBehaviourPlay(Playable playable, FrameData info)
	{
		CancellationTokenSource tokenSource = m_TokenSource;
		if (tokenSource != null && !tokenSource.IsCancellationRequested)
		{
			m_TokenSource.Cancel();
		}
		m_TokenSource = new CancellationTokenSource();
		PlayableDirector playableDirector = playable.GetGraph().GetResolver() as PlayableDirector;
		if (playableDirector != null && playableDirector.time - (double)info.deltaTime <= clip.start && playableDirector.time < clip.end)
		{
			m_Controller = info.output.GetUserData() as ConversationController;
			Singleton<TimelineConversationManager>.instance.ConversationClipCancelRegister(m_TokenSource);
			StartConversationDialogs(playable, info, m_TokenSource.Token).Forget();
		}
	}

	private async UniTask StartConversationDialogs(Playable playable, FrameData info, CancellationToken token)
	{
		foreach (TimelineConversationData data in datas)
		{
			long startTime = TimeManager.LocalTime.NowTimestamp;
			TimelineDialogue dialogue = Singleton<ConversationManager>.instance.PlayingDialogue as TimelineDialogue;
			bool startInSkip = Singleton<TimelineConversationManager>.instance.InSkip || token.IsCancellationRequested;
			if (token.IsCancellationRequested)
			{
				if (!startInSkip && dialogue != null)
				{
					TrackDramaEvt evt = EventTrackSolver.Instance.GetEvt<TrackDramaEvt>();
					evt.conversationId = dialogue.TimelineId;
					evt.subId = data.content;
					TrackDramaEvt trackDramaEvt = evt;
					trackDramaEvt.type = dialogue.TimelineType switch
					{
						TimelineType.Normal => 8, 
						TimelineType.DialogueStory => 1, 
						_ => throw new ArgumentOutOfRangeException(), 
					};
					evt.status = 2;
					evt.conversationDuration = TimeManager.GetTimeSpan(TimeManager.LocalTime.NowTimestamp - startTime).TotalSeconds;
					evt.isSkip = true;
					EventTrackSolver.Instance.Dispatch(evt);
				}
				continue;
			}
			await ConversationDialog(data, token);
			bool inSkip = Singleton<TimelineConversationManager>.instance.InSkip;
			if ((!startInSkip & inSkip) && dialogue != null)
			{
				TrackDramaEvt evt2 = EventTrackSolver.Instance.GetEvt<TrackDramaEvt>();
				evt2.conversationId = dialogue.TimelineId;
				evt2.subId = data.content;
				TrackDramaEvt trackDramaEvt = evt2;
				trackDramaEvt.type = dialogue.TimelineType switch
				{
					TimelineType.Normal => 8, 
					TimelineType.DialogueStory => 1, 
					_ => throw new ArgumentOutOfRangeException(), 
				};
				evt2.status = 2;
				evt2.conversationDuration = TimeManager.GetTimeSpan(TimeManager.LocalTime.NowTimestamp - startTime).TotalSeconds;
				evt2.isSkip = true;
				EventTrackSolver.Instance.Dispatch(evt2);
			}
		}
	}

	private async UniTask ConversationDialog(TimelineConversationData data, CancellationToken token)
	{
		_ = LuminApplication.LogEnabled;
		await Singleton<TimelineConversationManager>.instance.TimelineConversationDialog(data, clip.start, (int index) =>
		{
			_ = LuminApplication.LogEnabled;
			m_Controller.JumpToMarker(data.branchs[index].jumpMarker);
		}, token);
		if (!token.IsCancellationRequested && !data.hasBranch && !string.IsNullOrEmpty(data.jumpMarker))
		{
			m_Controller.JumpToMarker(data.jumpMarker);
		}
	}
}
