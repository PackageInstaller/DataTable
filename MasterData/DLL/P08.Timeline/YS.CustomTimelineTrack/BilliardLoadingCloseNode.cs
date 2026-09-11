using UnityEngine;
using UnityEngine.Playables;

namespace YS.CustomTimelineTrack;

public class BilliardLoadingCloseNode : PlayableAsset
{
	public override Playable CreatePlayable(PlayableGraph graph, GameObject owner)
	{
		return ScriptPlayable<BilliardLoadingCloseNodeBehaviour>.Create(graph);
	}
}
