using System;
using UnityEngine.Playables;

namespace ACT.Timeline;

[Serializable]
public class ConversationBubbleHideBehaviour : PlayableBehaviour
{
	public ConversationBubbleTrackBehaviour track;

	private bool played;

	public override void OnBehaviourPlay(Playable playable, FrameData info)
	{
		if (!played)
		{
			played = true;
			track.bubble.Hide();
		}
	}
}
