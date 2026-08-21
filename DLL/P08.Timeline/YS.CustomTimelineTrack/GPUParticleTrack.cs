using System;
using System.ComponentModel;
using UnityEngine;
using UnityEngine.Playables;
using UnityEngine.Timeline;

namespace YS.CustomTimelineTrack;

[Serializable]
[DisplayName("测试功能/GPU粒子控制(GPUParticle)(慎用)")]
[TrackClipType(typeof(GPUParticleNode))]
[TrackBindingType(typeof(GameObject))]
public class GPUParticleTrack : TrackAsset
{
	private GameObject GetBinding(PlayableDirector director)
	{
		if (director == null)
		{
			return null;
		}
		UnityEngine.Object key = this;
		if (base.isSubTrack)
		{
			key = base.parent;
		}
		UnityEngine.Object obj = null;
		if (director != null)
		{
			obj = director.GetGenericBinding(key);
		}
		return (GameObject)obj;
	}

	public override Playable CreateTrackMixer(PlayableGraph graph, GameObject go, int inputCount)
	{
		ScriptPlayable<GPUParticleMixer> scriptPlayable = GPUParticleMixer.Create(graph, inputCount);
		scriptPlayable.GetBehaviour().m_effect = GetBinding((go != null) ? go.GetComponent<PlayableDirector>() : null);
		return scriptPlayable;
	}
}
