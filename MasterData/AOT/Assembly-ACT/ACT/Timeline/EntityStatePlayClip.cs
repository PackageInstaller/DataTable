using UnityEngine;
using UnityEngine.Playables;
using UnityEngine.Timeline;

namespace ACT.Timeline;

public class EntityStatePlayClip : PlayableAsset, ITimelineClipAsset
{
	public EntityStatePlayBehaviour template = new EntityStatePlayBehaviour();

	public ClipCaps clipCaps => ClipCaps.Extrapolation | ClipCaps.Blending;

	public override Playable CreatePlayable(PlayableGraph graph, GameObject owner)
	{
		return ScriptPlayable<EntityStatePlayBehaviour>.Create(graph, template);
	}
}
