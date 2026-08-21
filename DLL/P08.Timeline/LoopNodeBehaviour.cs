using System;
using UnityEngine.Playables;

public class LoopNodeBehaviour : PlayableBehaviour
{
	public override void OnBehaviourPause(Playable playable, FrameData info)
	{
		float num = (float)playable.GetTime();
		float num2 = (float)playable.GetDuration();
		if (Math.Abs(num2 - num) <= 0.1f)
		{
			PlayableDirector playableDirector = playable.GetGraph().GetResolver() as PlayableDirector;
			if (playableDirector != null)
			{
				playableDirector.time -= num2;
			}
		}
	}
}
