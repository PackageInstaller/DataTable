using System;
using System.ComponentModel;
using UnityEngine;
using UnityEngine.Playables;
using UnityEngine.Timeline;

[Serializable]
[DisplayName("UI.Timeline/显示武器轨道")]
[TrackClipType(typeof(ShowWeaponNode))]
[TrackBindingType(typeof(Animator))]
public class ShowWeaponTrack : TrackAsset
{
	protected override Playable CreatePlayable(PlayableGraph graph, GameObject gameObject, TimelineClip clip)
	{
		_ = clip.asset is ShowWeaponNode;
		return base.CreatePlayable(graph, gameObject, clip);
	}
}
