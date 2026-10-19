using System;
using UnityEngine;
using UnityEngine.Playables;
using UnityEngine.Timeline;

namespace ACT.Timeline;

public class ConversationClip : PlayableAsset
{
	public ConversationBehaviour ConversationBehaviour = new ConversationBehaviour();

	[NonSerialized]
	public TimelineClip clipPassthrough;

	public override Playable CreatePlayable(PlayableGraph graph, GameObject owner)
	{
		ConversationBehaviour.clip = clipPassthrough;
		return ScriptPlayable<ConversationBehaviour>.Create(graph, ConversationBehaviour);
	}
}
