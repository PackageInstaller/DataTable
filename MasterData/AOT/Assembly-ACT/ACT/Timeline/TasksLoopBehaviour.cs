using System;
using ACT.Drama;
using Fundamental;
using UnityEngine.Playables;

namespace ACT.Timeline;

[Serializable]
public class TasksLoopBehaviour : PlayableBehaviour, IDialogueInputHandler
{
	public double startTime;

	public double endTime;

	public double jumpTime;

	private bool watching;

	private bool completed;

	private bool nextClicked;

	private DialogueInputHandle inputHandle;

	private bool ShouldLoop
	{
		get
		{
			if (completed)
			{
				if (!nextClicked)
				{
					return !ConversationSettings.AutoPlay;
				}
				return false;
			}
			return true;
		}
	}

	public override void OnBehaviourPlay(Playable playable, FrameData info)
	{
		if (!watching)
		{
			watching = true;
			completed = false;
			(Singleton<ConversationManager>.instance.PlayingDialogue as TimelineDialogue).BeginWatchTasks();
			inputHandle = (Singleton<ConversationManager>.instance.PlayingDialogue as TimelineDialogue).RegisterInputHandler(this);
			WaitComplete();
		}
	}

	public bool TryNext()
	{
		nextClicked = true;
		return true;
	}

	public void ForceNext()
	{
		nextClicked = true;
		completed = true;
	}

	public override void OnBehaviourPause(Playable playable, FrameData info)
	{
		PlayableDirector playableDirector = playable.GetGraph().GetResolver() as PlayableDirector;
		if (ShouldLoop && playableDirector != null && playableDirector.state == PlayState.Playing && info.deltaTime > 0f && endTime < playableDirector.time && playableDirector.time - (double)info.deltaTime < endTime)
		{
			playableDirector.time = startTime;
			return;
		}
		watching = false;
		completed = false;
		nextClicked = false;
		(Singleton<ConversationManager>.instance.PlayingDialogue as TimelineDialogue).StopWatchTasks();
		inputHandle.Dispose();
		inputHandle = default;
	}

	private async void WaitComplete()
	{
		await (Singleton<ConversationManager>.instance.PlayingDialogue as TimelineDialogue).AwaitTasks();
		completed = true;
	}
}
