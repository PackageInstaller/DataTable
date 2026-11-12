using UnityEngine;
using UnityEngine.Playables;
using UnityEngine.Timeline;

public sealed class SDFacialBlinkClip : PlayableAsset, ITimelineClipAsset
{
	[Range(0f, 1f)]
	[Tooltip("闭眼BlendShape权重比例，1=完全闭眼")]
	public float closedWeight = 1f;

	public ClipCaps clipCaps => ClipCaps.Blending;

	public override Playable CreatePlayable(PlayableGraph graph, GameObject go)
	{
		ScriptPlayable<SDFacialBlinkBehaviour> scriptPlayable = ScriptPlayable<SDFacialBlinkBehaviour>.Create(graph);
		scriptPlayable.GetBehaviour().closedWeight = closedWeight;
		return scriptPlayable;
	}
}
