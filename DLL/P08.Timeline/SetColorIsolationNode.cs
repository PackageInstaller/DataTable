using System;
using System.ComponentModel;
using UnityEngine;
using UnityEngine.Playables;
using UnityEngine.Timeline;

[Serializable]
[DisplayName("色调分离")]
public class SetColorIsolationNode : PlayableAsset, ITimelineClipAsset
{
	public ExposedReference<Transform> maskTrs;

	public ExposedReference<Texture2D> mask;

	public SetColorIsolationBehaviour template;

	public ClipCaps clipCaps => ClipCaps.ClipIn;

	public override Playable CreatePlayable(PlayableGraph graph, GameObject owner)
	{
		IExposedPropertyTable resolver = graph.GetResolver();
		template.maskTrs = maskTrs.Resolve(resolver);
		template.mask = mask.Resolve(resolver);
		return ScriptPlayable<SetColorIsolationBehaviour>.Create(graph, template);
	}
}
