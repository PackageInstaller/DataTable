using System;
using UnityEngine;
using UnityEngine.Playables;

namespace ACT.Timeline;

public class BlackScreenTextClip : PlayableAsset
{
	public int contentId;

	[NonSerialized]
	public BlackScreenTextBehaviour blackScreenTextBehaviour = new BlackScreenTextBehaviour();

	public override Playable CreatePlayable(PlayableGraph graph, GameObject owner)
	{
		return ScriptPlayable<BlackScreenTextBehaviour>.Create(graph, blackScreenTextBehaviour);
	}
}
