using UnityEngine.Playables;

namespace YS.CustomTimelineTrack;

public class StoryTimelineDormUITrackBehaviour : PlayableBehaviour
{
	public override void PrepareFrame(Playable playable, FrameData info)
	{
		int inputCount = playable.GetInputCount();
		for (int i = 0; i < inputCount; i++)
		{
			Playable input = playable.GetInput(i);
			if (input.GetPlayableType() == typeof(StoryTimelineDormBubbleUINodeBehaviour))
			{
				((ScriptPlayable<StoryTimelineDormBubbleUINodeBehaviour>)playable.GetInput(i)).GetBehaviour().SetWeight(playable.GetInputWeight(i));
			}
			else if (input.GetPlayableType() == typeof(StoryTimelineDormDialogUINodeBehaviour))
			{
				((ScriptPlayable<StoryTimelineDormDialogUINodeBehaviour>)playable.GetInput(i)).GetBehaviour().SetWeight(playable.GetInputWeight(i));
			}
			else if (input.GetPlayableType() == typeof(StoryTimelineDormMaskUINodeBehaviour))
			{
				((ScriptPlayable<StoryTimelineDormMaskUINodeBehaviour>)playable.GetInput(i)).GetBehaviour().SetWeight(playable.GetInputWeight(i));
			}
		}
	}
}
