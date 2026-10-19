using UnityEngine;
using UnityEngine.Playables;

namespace ACT.Timeline;

public class ConversationImageClip : PlayableAsset
{
	public ConversationImageBehaviour conversationImageBehaviour = new ConversationImageBehaviour();

	public override Playable CreatePlayable(PlayableGraph graph, GameObject owner)
	{
		return ScriptPlayable<ConversationImageBehaviour>.Create(graph, conversationImageBehaviour);
	}
}
