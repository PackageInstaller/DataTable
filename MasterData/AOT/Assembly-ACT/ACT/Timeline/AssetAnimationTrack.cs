using System;
using UnityEngine;
using UnityEngine.Playables;
using UnityEngine.Timeline;

namespace ACT.Timeline;

[Serializable]
[TrackColor(0.53f, 0.83f, 0.62f)]
[TrackClipType(typeof(AssetAnimationClip))]
public class AssetAnimationTrack : TrackAsset
{
	[Tooltip("The asset path / ID used to load the GameObject via AssetStationManager")]
	[SerializeField]
	private string m_AssetPath;

	public string assetPath
	{
		get
		{
			return m_AssetPath;
		}
		set
		{
			m_AssetPath = value;
		}
	}

	public override Playable CreateTrackMixer(PlayableGraph graph, GameObject go, int inputCount)
	{
		AssetAnimationMixerBehaviour template = new AssetAnimationMixerBehaviour
		{
			assetPath = m_AssetPath
		};
		return ScriptPlayable<AssetAnimationMixerBehaviour>.Create(graph, template, inputCount);
	}
}
