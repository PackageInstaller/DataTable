using System;
using ACT.Battle;
using UnityEngine;
using UnityEngine.Playables;
using UnityEngine.Timeline;

namespace ACT.Timeline;

[Serializable]
public class AniPartClip : PlayableAsset, ITimelineClipAsset
{
	public AniPartControl.PartType partType;

	public bool isReverse;

	public ClipCaps clipCaps => ClipCaps.None;

	public override Playable CreatePlayable(PlayableGraph graph, GameObject owner)
	{
		ScriptPlayable<AniPartBehaviour> scriptPlayable = ScriptPlayable<AniPartBehaviour>.Create(graph);
		AniPartBehaviour behaviour = scriptPlayable.GetBehaviour();
		behaviour.partType = partType;
		behaviour.isReverse = isReverse;
		return scriptPlayable;
	}
}
