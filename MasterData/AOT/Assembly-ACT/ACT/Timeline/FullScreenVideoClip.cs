using System;
using UnityEngine;
using UnityEngine.Playables;

namespace ACT.Timeline;

[Serializable]
public class FullScreenVideoClip : PlayableAsset
{
	public string address;

	public double startTime;

	public bool showSkipButton = true;

	[Header("保留场景BGM")]
	public bool keepBgm;

	public override Playable CreatePlayable(PlayableGraph graph, GameObject owner)
	{
		FullScreenVideoBehaviour fullScreenVideoBehaviour = new FullScreenVideoBehaviour();
		fullScreenVideoBehaviour.address = address;
		fullScreenVideoBehaviour.startTime = startTime;
		fullScreenVideoBehaviour.showSkipButton = showSkipButton;
		fullScreenVideoBehaviour.keepBgm = keepBgm;
		return ScriptPlayable<FullScreenVideoBehaviour>.Create(graph, fullScreenVideoBehaviour);
	}
}
