using UnityEngine;
using UnityEngine.Playables;
using UnityEngine.Timeline;

namespace ACT.Timeline;

[TrackColor(0.2f, 0.8f, 1f)]
[TrackClipType(typeof(ConversationCGClip))]
public sealed class ConversationCGTrack : TrackAsset
{
	protected override void OnCreateClip(TimelineClip clip)
	{
		base.OnCreateClip(clip);
		if (clip.asset is ConversationCGClip conversationCGClip)
		{
			clip.displayName = ((conversationCGClip.cgId == 0) ? "CG（未配置）" : $"CG {conversationCGClip.cgId}");
		}
	}

	public override Playable CreateTrackMixer(PlayableGraph graph, GameObject go, int inputCount)
	{
		return ScriptPlayable<ConversationCGMixerBehaviour>.Create(graph, inputCount);
	}
}
