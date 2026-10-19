using System;
using UnityEngine;
using UnityEngine.Playables;
using UnityEngine.Timeline;

namespace ACT.Timeline;

[Serializable]
public class AssetAnimationClip : PlayableAsset, ITimelineClipAsset
{
	[Tooltip("AnimationClip to play on the loaded object")]
	[SerializeField]
	private AnimationClip m_AnimationClip;

	public AnimationClip animationClip => m_AnimationClip;

	public ClipCaps clipCaps => ClipCaps.None;

	public override Playable CreatePlayable(PlayableGraph graph, GameObject owner)
	{
		AssetAnimationBehaviour template = new AssetAnimationBehaviour
		{
			animationClip = m_AnimationClip
		};
		return ScriptPlayable<AssetAnimationBehaviour>.Create(graph, template);
	}
}
