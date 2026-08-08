using UnityEngine;
using UnityEngine.Playables;

public class LoopNode : PlayableAsset
{
	public override Playable CreatePlayable(PlayableGraph graph, GameObject owner)
	{
		return ScriptPlayable<LoopNodeBehaviour>.Create(graph);
	}
}
