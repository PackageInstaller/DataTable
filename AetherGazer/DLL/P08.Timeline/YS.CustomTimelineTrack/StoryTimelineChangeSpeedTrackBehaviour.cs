using UnityEngine.Playables;

namespace YS.CustomTimelineTrack;

public class StoryTimelineChangeSpeedTrackBehaviour : PlayableBehaviour
{
	public override void ProcessFrame(Playable playable, FrameData info, object playerData)
	{
		int inputCount = playable.GetInputCount();
		for (int i = 0; i < inputCount; i++)
		{
			((ScriptPlayable<StoryTimelineChangeSpeedNodeBehaviour>)playable.GetInput(i)).GetBehaviour().SetWeight(playable.GetInputWeight(i));
		}
	}
}
