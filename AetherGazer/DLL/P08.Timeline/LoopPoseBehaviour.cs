using System;
using UnityEngine;
using UnityEngine.Playables;

public class LoopPoseBehaviour : PlayableBehaviour
{
	private HeroUITimelineBrain brain;

	public double startTime;

	public double endTime;

	public override void OnBehaviourPlay(Playable playable, FrameData info)
	{
		base.OnBehaviourPlay(playable, info);
		UnityEngine.Object userData = info.output.GetUserData();
		brain = userData as HeroUITimelineBrain;
		if (brain == null)
		{
			Debug.LogError("LoopPoseBehaviour could not get HeroUITimelineBrain");
		}
	}

	public override void OnBehaviourPause(Playable playable, FrameData info)
	{
		if (!(brain == null))
		{
			TryReplay(playable);
		}
	}

	public override void PrepareFrame(Playable playable, FrameData info)
	{
		base.PrepareFrame(playable, info);
	}

	public override void ProcessFrame(Playable playable, FrameData info, object playerData)
	{
		base.ProcessFrame(playable, info, playerData);
		if (!(brain == null))
		{
			TryReplay(playable);
		}
	}

	private void TryReplay(Playable playable)
	{
		if (brain.isPoseLooping)
		{
			PlayableDirector playableDirector = playable.GetGraph().GetResolver() as PlayableDirector;
			if (playableDirector != null && Math.Abs(endTime - playableDirector.time) <= 0.10000000149011612)
			{
				playableDirector.time = startTime;
			}
		}
	}
}
