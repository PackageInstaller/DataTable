using UnityEngine;
using UnityEngine.Playables;
using UnityEngine.Timeline;

public sealed class SDFacialExpressionClip : PlayableAsset, ITimelineClipAsset
{
	public SDFacialExpression expression = SDFacialExpression.Normal;

	public ClipCaps clipCaps => ClipCaps.Extrapolation | ClipCaps.Blending;

	public override Playable CreatePlayable(PlayableGraph graph, GameObject go)
	{
		ScriptPlayable<SDFacialExpressionBehaviour> scriptPlayable = ScriptPlayable<SDFacialExpressionBehaviour>.Create(graph);
		scriptPlayable.GetBehaviour().expression = expression;
		return scriptPlayable;
	}
}
