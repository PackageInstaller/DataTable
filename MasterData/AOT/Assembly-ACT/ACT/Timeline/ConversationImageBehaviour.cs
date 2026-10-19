using System;
using ACT.Drama;
using ACT.UI;
using Fundamental;
using UnityEngine.Playables;

namespace ACT.Timeline;

[Serializable]
public class ConversationImageBehaviour : PlayableBehaviour
{
	public int imageId;

	public override void OnBehaviourPlay(Playable playable, FrameData info)
	{
		MonoConversationView conversationView = Singleton<TimelineConversationManager>.instance.ConversationView;
		if ((bool)conversationView)
		{
			conversationView.ImageTask(imageId, 0f);
		}
	}

	public override void OnBehaviourPause(Playable playable, FrameData info)
	{
		MonoConversationView conversationView = Singleton<TimelineConversationManager>.instance.ConversationView;
		if ((bool)conversationView)
		{
			conversationView.ImageTask(-1, 0f);
		}
	}
}
