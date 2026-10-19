using System;
using UnityEngine;
using UnityEngine.Playables;

namespace ACT.Timeline;

public class StopPlayerFsmClip : PlayableAsset
{
	[NonSerialized]
	public StopPlayerFsmBehaviour stopPlayerFsmBehaviour = new StopPlayerFsmBehaviour();

	public override Playable CreatePlayable(PlayableGraph graph, GameObject owner)
	{
		return ScriptPlayable<StopPlayerFsmBehaviour>.Create(graph, stopPlayerFsmBehaviour);
	}
}
