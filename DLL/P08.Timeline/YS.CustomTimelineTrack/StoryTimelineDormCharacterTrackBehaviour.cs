using UnityEngine.Playables;

namespace YS.CustomTimelineTrack;

public class StoryTimelineDormCharacterTrackBehaviour : PlayableBehaviour
{
	public override void PrepareFrame(Playable playable, FrameData info)
	{
		int inputCount = playable.GetInputCount();
		for (int i = 0; i < inputCount; i++)
		{
			Playable input = playable.GetInput(i);
			if (input.GetPlayableType() == typeof(StoryTimelineDormCharacterActiveNodeBehaviour))
			{
				((ScriptPlayable<StoryTimelineDormCharacterActiveNodeBehaviour>)input).GetBehaviour().SetWeight(playable.GetInputWeight(i));
			}
			else if (input.GetPlayableType() == typeof(StoryTimelineDormCharacterAnimNodeBehaviour))
			{
				((ScriptPlayable<StoryTimelineDormCharacterAnimNodeBehaviour>)input).GetBehaviour().SetWeight(playable.GetInputWeight(i));
			}
			else if (input.GetPlayableType() == typeof(StoryTimelineDormCharacterEmotionNodeBehaviour))
			{
				((ScriptPlayable<StoryTimelineDormCharacterEmotionNodeBehaviour>)input).GetBehaviour().SetWeight(playable.GetInputWeight(i));
			}
		}
	}
}
