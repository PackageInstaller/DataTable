using System;
using System.ComponentModel;
using P08.CriLipsEx;
using UnityEngine;
using UnityEngine.Playables;
using UnityEngine.Timeline;

namespace YS.CustomTimelineTrack;

[Serializable]
[DisplayName("测试功能/HomeUICriware")]
[TrackClipType(typeof(HomeUICriwareNode))]
public class HomeUICriwareTrack : TrackAsset
{
	public override Playable CreateTrackMixer(PlayableGraph graph, GameObject go, int inputCount)
	{
		ScriptPlayable<HomeUICriwareMixer> scriptPlayable = HomeUICriwareMixer.Create(graph, inputCount);
		scriptPlayable.GetBehaviour().m_criLipsExPlayer = go.GetComponentInChildren<CriLipsExPlayer>();
		return scriptPlayable;
	}

	protected override void OnCreateClip(TimelineClip clip)
	{
		base.OnCreateClip(clip);
	}
}
