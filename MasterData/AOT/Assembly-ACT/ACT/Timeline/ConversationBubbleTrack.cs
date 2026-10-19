using UnityEngine;
using UnityEngine.Playables;
using UnityEngine.Timeline;

namespace ACT.Timeline;

[TrackColor(0f, 1f, 0f)]
[TrackClipType(typeof(ConversationBubbleClip))]
[TrackClipType(typeof(ConversationBubbleHideClip))]
[TrackBindingType(typeof(GameObject), TrackBindingFlags.None)]
public class ConversationBubbleTrack : TrackAsset
{
	public Vector3 offset;

	protected override void OnCreateClip(TimelineClip clip)
	{
		base.OnCreateClip(clip);
		Object asset = clip.asset;
		if (!(asset is ConversationBubbleClip))
		{
			if (asset is ConversationBubbleHideClip)
			{
				clip.displayName = "气泡隐藏";
			}
		}
		else
		{
			clip.displayName = "气泡";
		}
	}

	public override Playable CreateTrackMixer(PlayableGraph graph, GameObject go, int inputCount)
	{
		ConversationBubbleTrackBehaviour conversationBubbleTrackBehaviour = new ConversationBubbleTrackBehaviour();
		conversationBubbleTrackBehaviour.offset = offset;
		return ScriptPlayable<ConversationBubbleTrackBehaviour>.Create(graph, conversationBubbleTrackBehaviour, inputCount);
	}
}
