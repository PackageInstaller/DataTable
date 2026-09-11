using System;
using UnityEngine;
using UnityEngine.Playables;

[Serializable]
public class TransformProxyNode : PlayableAsset
{
	public DynamicTimelineController controller;

	public string transTag;

	public string heroId;

	public override Playable CreatePlayable(PlayableGraph graph, GameObject owner)
	{
		ScriptPlayable<TransformProxyBehaviour> scriptPlayable = ScriptPlayable<TransformProxyBehaviour>.Create(graph);
		scriptPlayable.GetBehaviour().transTag = transTag;
		scriptPlayable.GetBehaviour().heroId = heroId;
		scriptPlayable.GetBehaviour().controller = controller;
		return scriptPlayable;
	}
}
