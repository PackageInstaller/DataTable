using System;
using UnityEngine;
using UnityEngine.Playables;

namespace YS.CustomTimelineTrack;

[Serializable]
public class SimplePlayerNode : PlayableAsset
{
	public override Playable CreatePlayable(PlayableGraph graph, GameObject owner)
	{
		return ScriptPlayable<SimplePlayerBehaviour>.Create(graph);
	}
}
