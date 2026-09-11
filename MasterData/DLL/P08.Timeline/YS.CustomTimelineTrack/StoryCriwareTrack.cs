using System;
using System.ComponentModel;
using P08.CriLipsEx;
using UnityEngine;
using UnityEngine.Playables;
using UnityEngine.Timeline;

namespace YS.CustomTimelineTrack;

[Serializable]
[DisplayName("剧情Timeline/声音/声音(StoryCriware)")]
[TrackClipType(typeof(StoryCriwareNode))]
[TrackBindingType(typeof(CriLipsExPlayer))]
public class StoryCriwareTrack : TrackAsset
{
	private CriLipsExPlayer GetBinding(PlayableDirector director)
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
		return (CriLipsExPlayer)obj;
	}

	public override Playable CreateTrackMixer(PlayableGraph graph, GameObject go, int inputCount)
	{
		ScriptPlayable<StoryCriwareMixer> scriptPlayable = StoryCriwareMixer.Create(graph, inputCount);
		scriptPlayable.GetBehaviour().m_criLipsExPlayer = GetBinding((go != null) ? go.GetComponent<PlayableDirector>() : null);
		return scriptPlayable;
	}
}
