using UnityEngine;
using UnityEngine.Playables;

namespace ACT.Timeline;

public class BlackScreenClip : PlayableAsset
{
	public bool IsEndBlackScreen;

	public bool AutoHideBlackScreenOnEnd = true;

	public float MaxDelayTime = 3f;

	public override Playable CreatePlayable(PlayableGraph graph, GameObject owner)
	{
		BlackScreenBehaviour blackScreenBehaviour = new BlackScreenBehaviour();
		blackScreenBehaviour.autoHideBlackScreenOnEnd = AutoHideBlackScreenOnEnd;
		blackScreenBehaviour.isEndBS = IsEndBlackScreen;
		blackScreenBehaviour.MaxDelayTime = MaxDelayTime;
		return ScriptPlayable<BlackScreenBehaviour>.Create(graph, blackScreenBehaviour);
	}
}
