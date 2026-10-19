using System;
using UnityEngine;
using UnityEngine.Playables;

namespace ACT.Timeline;

[Serializable]
public class FullScreenVideoSubtitleClip : PlayableAsset
{
	[Tooltip("本地化表的条目ID，大于0时优先使用")]
	public int contentId;

	[NonSerialized]
	public FullScreenVideoSubtitleBehaviour behaviour = new FullScreenVideoSubtitleBehaviour();

	public override Playable CreatePlayable(PlayableGraph graph, GameObject owner)
	{
		behaviour.contentId = contentId;
		return ScriptPlayable<FullScreenVideoSubtitleBehaviour>.Create(graph, behaviour);
	}
}
