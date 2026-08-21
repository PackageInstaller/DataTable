using UnityEngine;
using UnityEngine.Playables;

public class GPUParticleNode : PlayableAsset
{
	public override Playable CreatePlayable(PlayableGraph graph, GameObject owner)
	{
		return ScriptPlayable<GPUParticleNodeBehaviour>.Create(graph);
	}
}
