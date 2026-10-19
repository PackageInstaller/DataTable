using ACT.Sound;
using FMODUnity;
using UnityEngine;
using UnityEngine.Playables;

namespace ACT.Timeline;

public class ConversationBgmClip : PlayableAsset
{
	public EventReference eventReference;

	public AudioEventReference audioEventReference;

	public override double duration => 0.30000001192092896;

	public override Playable CreatePlayable(PlayableGraph graph, GameObject owner)
	{
		ConversationBgmBehaviour conversationBgmBehaviour = new ConversationBgmBehaviour();
		conversationBgmBehaviour.eventReference = eventReference;
		conversationBgmBehaviour.audioEventReference = audioEventReference;
		return ScriptPlayable<ConversationBgmBehaviour>.Create(graph, conversationBgmBehaviour);
	}
}
