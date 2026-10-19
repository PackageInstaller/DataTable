using UnityEngine;
using UnityEngine.Playables;
using UnityEngine.Timeline;

namespace ACT.Timeline;

public class ConversationBubbleHideClip : PlayableAsset, ITimelineClipAsset
{
	public ClipCaps clipCaps => ClipCaps.None;

	public override double duration => 0.20000000298023224;

	public override Playable CreatePlayable(PlayableGraph graph, GameObject owner)
	{
		return ScriptPlayable<ConversationBubbleHideBehaviour>.Create(graph, new ConversationBubbleHideBehaviour());
	}
}
