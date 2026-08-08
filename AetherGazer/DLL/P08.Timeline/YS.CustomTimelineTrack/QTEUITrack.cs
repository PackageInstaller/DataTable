using System.ComponentModel;
using UnityEngine;
using UnityEngine.Playables;
using UnityEngine.Timeline;

namespace YS.CustomTimelineTrack;

[DisplayName("剧情Timeline/QTE/UI 轨道")]
[TrackColor(1f, 0.4745f, 0.76863f)]
[TrackClipType(typeof(QTEUINode_SingleClick))]
[TrackClipType(typeof(QTEUINode_Press))]
[TrackClipType(typeof(QTEUINode_FastClick))]
[TrackClipType(typeof(QTEUINode_Drag))]
public class QTEUITrack : TrackAsset
{
	public override Playable CreateTrackMixer(PlayableGraph graph, GameObject go, int inputCount)
	{
		return ScriptPlayable<QTEUIMixerBehaviour>.Create(graph, inputCount);
	}
}
