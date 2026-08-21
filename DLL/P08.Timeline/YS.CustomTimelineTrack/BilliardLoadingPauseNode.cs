using UnityEngine;
using UnityEngine.Playables;

namespace YS.CustomTimelineTrack;

public class BilliardLoadingPauseNode : PlayableAsset
{
	public override Playable CreatePlayable(PlayableGraph graph, GameObject owner)
	{
		return ScriptPlayable<BilliardLoadingPauseNodeBehaviour>.Create(graph);
	}
}
