using UnityEngine.Playables;

namespace YS.CustomTimelineTrack;

public class StoryTimelineUITalkTrackBehaviour : PlayableBehaviour
{
	public override void PrepareFrame(Playable playable, FrameData info)
	{
		int inputCount = playable.GetInputCount();
		for (int i = 0; i < inputCount; i++)
		{
			((ScriptPlayable<StoryTimelineUITalkNodeBehaviour>)playable.GetInput(i)).GetBehaviour().SetWeight(playable.GetInputWeight(i));
		}
	}
}
