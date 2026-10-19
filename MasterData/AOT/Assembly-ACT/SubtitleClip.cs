using System;
using ACT.Timeline;
using UnityEngine;
using UnityEngine.Playables;

public class SubtitleClip : PlayableAsset
{
	public int content;

	[NonSerialized]
	public SubtitleBehaviour SubtitleBehaviour = new SubtitleBehaviour();

	public override Playable CreatePlayable(PlayableGraph graph, GameObject owner)
	{
		return ScriptPlayable<SubtitleBehaviour>.Create(graph, SubtitleBehaviour);
	}
}
