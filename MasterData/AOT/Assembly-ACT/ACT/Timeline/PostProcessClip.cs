using System;
using UnityEngine;
using UnityEngine.Playables;
using UnityEngine.Timeline;

namespace ACT.Timeline;

[Serializable]
public class PostProcessClip : PlayableAsset, ITimelineClipAsset
{
	public PostProcessBehaviour template = new PostProcessBehaviour();

	public ClipCaps clipCaps => ClipCaps.Extrapolation | ClipCaps.Blending;

	public override Playable CreatePlayable(PlayableGraph graph, GameObject owner)
	{
		ScriptPlayable<PostProcessBehaviour> scriptPlayable = ScriptPlayable<PostProcessBehaviour>.Create(graph, template);
		scriptPlayable.GetBehaviour();
		return scriptPlayable;
	}
}
