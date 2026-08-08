using UnityEngine;
using UnityEngine.Playables;

namespace YS.CustomTimelineTrack;

public class TimeDilationMixerBehaviour : PlayableBehaviour
{
	private readonly float defaultTimeScale = 1f;

	public override void ProcessFrame(Playable playable, FrameData info, object playerData)
	{
		int inputCount = playable.GetInputCount();
		float num = 0f;
		float num2 = 0f;
		int num3 = 0;
		for (int i = 0; i < inputCount; i++)
		{
			float inputWeight = playable.GetInputWeight(i);
			if (inputWeight > 0f)
			{
				num3++;
			}
			num2 += inputWeight;
			TimeDilationBehaviour behaviour = ((ScriptPlayable<TimeDilationBehaviour>)playable.GetInput(i)).GetBehaviour();
			num += inputWeight * behaviour.timeScale;
		}
		Time.timeScale = num + defaultTimeScale * (1f - num2);
		if (num3 == 0)
		{
			Time.timeScale = defaultTimeScale;
		}
	}

	public override void OnBehaviourPause(Playable playable, FrameData info)
	{
		Time.timeScale = defaultTimeScale;
	}

	public override void OnGraphStop(Playable playable)
	{
		Time.timeScale = defaultTimeScale;
	}

	public override void OnPlayableDestroy(Playable playable)
	{
		Time.timeScale = defaultTimeScale;
	}
}
