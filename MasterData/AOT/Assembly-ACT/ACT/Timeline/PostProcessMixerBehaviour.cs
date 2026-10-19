using System;
using UnityEngine;
using UnityEngine.Playables;

namespace ACT.Timeline;

[Serializable]
public class PostProcessMixerBehaviour : PlayableBehaviour
{
	public override void ProcessFrame(Playable playable, FrameData info, object playerData)
	{
		int inputCount = playable.GetInputCount();
		for (int i = 0; i < inputCount; i++)
		{
			ScriptPlayable<PostProcessBehaviour> playable2 = (ScriptPlayable<PostProcessBehaviour>)playable.GetInput(i);
			PostProcessBehaviour behaviour = playable2.GetBehaviour();
			if (!Mathf.Approximately(playable.GetInputWeight(i), 0f))
			{
				float time = (float)(playable2.GetTime() / playable2.GetDuration());
				behaviour.ChangeWeight(time);
			}
		}
	}
}
