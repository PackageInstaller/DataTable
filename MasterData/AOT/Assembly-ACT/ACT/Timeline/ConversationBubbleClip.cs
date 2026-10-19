using UnityEngine;
using UnityEngine.Playables;
using UnityEngine.Serialization;
using UnityEngine.Timeline;

namespace ACT.Timeline;

public class ConversationBubbleClip : PlayableAsset, ITimelineClipAsset
{
	[FormerlySerializedAs("dialogueId")]
	public int contentId;

	public ClipCaps clipCaps => ClipCaps.None;

	public override double duration => 0.20000000298023224;

	public override Playable CreatePlayable(PlayableGraph graph, GameObject owner)
	{
		ConversationBubbleBehaviour conversationBubbleBehaviour = new ConversationBubbleBehaviour();
		conversationBubbleBehaviour.contentId = contentId;
		return ScriptPlayable<ConversationBubbleBehaviour>.Create(graph, conversationBubbleBehaviour);
	}
}
