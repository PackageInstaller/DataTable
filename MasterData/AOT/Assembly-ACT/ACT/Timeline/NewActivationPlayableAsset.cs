using UnityEngine;
using UnityEngine.Playables;
using UnityEngine.Timeline;

namespace ACT.Timeline;

public class NewActivationPlayableAsset : PlayableAsset, ITimelineClipAsset
{
	public ClipCaps clipCaps => ClipCaps.None;

	public override Playable CreatePlayable(PlayableGraph graph, GameObject go)
	{
		return Playable.Create(graph);
	}
}
