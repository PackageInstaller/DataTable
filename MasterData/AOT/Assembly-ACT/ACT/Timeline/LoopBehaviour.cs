using System;
using UnityEngine.Playables;

namespace ACT.Timeline;

[Serializable]
public class LoopBehaviour : PlayableBehaviour
{
	public double startTime;

	public double endTime;

	public override void OnBehaviourPause(Playable playable, FrameData info)
	{
		PlayableDirector playableDirector = playable.GetGraph().GetResolver() as PlayableDirector;
		if (playableDirector != null && playableDirector.state == PlayState.Playing && info.deltaTime > 0f && endTime < playableDirector.time && playableDirector.time - (double)info.deltaTime < endTime)
		{
			playableDirector.time = startTime;
		}
	}
}
