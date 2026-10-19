using System;
using System.Collections.Generic;
using System.Threading;
using ACT.Timeline;
using Cysharp.Threading.Tasks;
using UnityEngine;
using UnityEngine.Playables;
using UnityEngine.Timeline;

namespace ACT.Drama;

public class TimelineDialogue : DialogueWrapper
{
	public readonly int TimelineId;

	public TimelineType TimelineType;

	public Func<CancellationToken, UniTask> PlayLogic;

	public Action StopLogic;

	public Action BeginSkipLogic;

	public bool inSkip;

	public bool canSkip = true;

	public double dialoguePlayTime;

	private int m_WatchingTasksCounter;

	private List<UniTask> m_WatchingTasks = new List<UniTask>();

	public GameObject TimelineInstance { get; private set; }

	public PlayableDirector PlayableDirector { get; private set; }

	public MonoTimelineConfig MonoTimelineConfig { get; private set; }

	public TimelineConfig TimelineConfig { get; private set; }

	public TimelineDialogue(int timelineId)
	{
		TimelineId = timelineId;
	}

	protected override async UniTask Play(CancellationToken token)
	{
		if (PlayLogic != null)
		{
			await PlayLogic(token);
		}
	}

	protected override void Stop()
	{
		StopLogic?.Invoke();
	}

	protected override void Skip()
	{
		if (!PlayableDirector || (TimelineConfig.timelineType == TimelineType.Normal && !canSkip))
		{
			return;
		}
		inSkip = true;
		try
		{
			BeginSkipLogic?.Invoke();
		}
		catch (Exception)
		{
			_ = LuminApplication.LogEnabled;
		}
		TimelineAsset timelineAsset = PlayableDirector.playableAsset as TimelineAsset;
		double num = PlayableDirector.duration;
		try
		{
			foreach (TrackAsset outputTrack in timelineAsset.GetOutputTracks())
			{
				if (!(outputTrack is ConversationTrack conversationTrack))
				{
					continue;
				}
				foreach (TimelineClip clip in conversationTrack.GetClips())
				{
					if (clip.start < dialoguePlayTime || !(clip.asset is ConversationClip conversationClip))
					{
						continue;
					}
					bool flag = true;
					foreach (TimelineConversationData data in conversationClip.ConversationBehaviour.datas)
					{
						if (!data.canSkip)
						{
							flag = false;
						}
					}
					if (!flag && num > clip.start)
					{
						num = clip.start;
					}
				}
			}
		}
		catch (Exception)
		{
			_ = LuminApplication.LogEnabled;
		}
		PlayableDirector.Pause();
		PlayableDirector.time = num;
		PlayableDirector.Play();
		_ = LuminApplication.LogEnabled;
	}

	public void SetTimelineInstance(GameObject timelineInstance)
	{
		TimelineInstance = timelineInstance;
		PlayableDirector = timelineInstance.GetComponent<PlayableDirector>();
		MonoTimelineConfig = timelineInstance.GetComponent<MonoTimelineConfig>();
		TimelineConfig = MonoTimelineConfig.timelineConfig;
	}

	public void BeginWatchTasks()
	{
		m_WatchingTasksCounter++;
	}

	public void StopWatchTasks()
	{
		m_WatchingTasksCounter = Mathf.Max(0, m_WatchingTasksCounter - 1);
		if (m_WatchingTasksCounter <= 0)
		{
			m_WatchingTasks.Clear();
		}
	}

	public UniTask AwaitTasks()
	{
		return UniTask.WhenAll(m_WatchingTasks);
	}
}
