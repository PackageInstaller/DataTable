using UnityEngine;
using UnityEngine.Playables;

namespace YS.T0WorldTrack;

public class T0WorldAniEndingNode : PlayableAsset
{
	public override Playable CreatePlayable(PlayableGraph graph, GameObject owner)
	{
		ScriptPlayable<T0WorldAniEndingNodeNodeBehaviour> scriptPlayable = ScriptPlayable<T0WorldAniEndingNodeNodeBehaviour>.Create(graph);
		scriptPlayable.GetBehaviour().owner = owner;
		return scriptPlayable;
	}
}
