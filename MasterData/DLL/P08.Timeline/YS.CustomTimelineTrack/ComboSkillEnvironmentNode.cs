using System;
using UnityEngine;
using UnityEngine.Playables;

namespace YS.CustomTimelineTrack;

[Serializable]
public class ComboSkillEnvironmentNode : PlayableAsset
{
	public override Playable CreatePlayable(PlayableGraph graph, GameObject owner)
	{
		return Playable.Create(graph);
	}
}
