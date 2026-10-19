using System.Linq;
using UnityEngine;
using UnityEngine.Playables;
using UnityEngine.Timeline;
using uLipSync;

namespace ACT.Timeline;

[TrackColor(0.95f, 0.35f, 0.2f)]
[TrackClipType(typeof(GachaLipSyncClip))]
[TrackBindingType(typeof(uLipSyncAnimator))]
public sealed class GachaLipSyncTrack : TrackAsset
{
	public override Playable CreateTrackMixer(PlayableGraph graph, GameObject go, int inputCount)
	{
		ScriptPlayable<GachaLipSyncMixer> scriptPlayable = ScriptPlayable<GachaLipSyncMixer>.Create(graph, inputCount);
		scriptPlayable.GetBehaviour().clips = GetClips().ToArray();
		return scriptPlayable;
	}
}
