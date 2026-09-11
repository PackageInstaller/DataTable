using UnityEngine;
using UnityEngine.Playables;

namespace YS.T0WorldTrack;

public class T0WorldIKControlNode : PlayableAsset
{
	public override Playable CreatePlayable(PlayableGraph graph, GameObject owner)
	{
		ScriptPlayable<T0WorldIKControlNodeBehaviour> scriptPlayable = ScriptPlayable<T0WorldIKControlNodeBehaviour>.Create(graph);
		scriptPlayable.GetBehaviour().owner = owner;
		return scriptPlayable;
	}
}
