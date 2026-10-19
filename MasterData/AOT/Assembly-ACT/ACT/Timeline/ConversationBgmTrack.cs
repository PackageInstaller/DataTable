using UnityEngine.Timeline;

namespace ACT.Timeline;

[TrackColor(0f, 1f, 0f)]
[TrackClipType(typeof(ConversationBgmClip))]
public class ConversationBgmTrack : TrackAsset
{
	protected override void OnCreateClip(TimelineClip clip)
	{
		base.OnCreateClip(clip);
		clip.displayName = "BGM";
	}
}
