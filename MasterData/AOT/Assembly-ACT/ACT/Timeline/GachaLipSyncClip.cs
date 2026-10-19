using System;
using ACT.LipSync;
using UnityEngine;
using UnityEngine.Playables;
using UnityEngine.Timeline;

namespace ACT.Timeline;

[Serializable]
public sealed class GachaLipSyncClip : PlayableAsset, ITimelineClipAsset
{
	public ULipSyncBakeData bakedData;

	[Range(0f, 1f)]
	public float volume = 1f;

	[Range(-0.3f, 0.3f)]
	public float timeOffset;

	public GachaLipSyncBehaviour behaviour { get; private set; }

	public override double duration
	{
		get
		{
			if (!bakedData)
			{
				return 0.0;
			}
			return bakedData.duration;
		}
	}

	public ClipCaps clipCaps => ClipCaps.ClipIn | ClipCaps.SpeedMultiplier | ClipCaps.Blending;

	public override Playable CreatePlayable(PlayableGraph graph, GameObject go)
	{
		ScriptPlayable<GachaLipSyncBehaviour> scriptPlayable = ScriptPlayable<GachaLipSyncBehaviour>.Create(graph);
		behaviour = scriptPlayable.GetBehaviour();
		behaviour.asset = this;
		return scriptPlayable;
	}
}
