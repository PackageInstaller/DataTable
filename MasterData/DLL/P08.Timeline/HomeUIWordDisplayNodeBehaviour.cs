using UnityEngine;
using UnityEngine.Playables;

public class HomeUIWordDisplayNodeBehaviour : PlayableBehaviour
{
	public int heroId;

	public int heroVoiceDescId;

	private bool start;

	public override void ProcessFrame(Playable playable, FrameData info, object playerData)
	{
		if (Application.isPlaying && !start)
		{
			start = true;
			LuaHelper.CallFunction("OnHomeVoiceStart", heroId, heroVoiceDescId);
		}
	}

	public override void OnBehaviourPause(Playable playable, FrameData info)
	{
		base.OnBehaviourPause(playable, info);
		if (start)
		{
			start = false;
			LuaHelper.CallFunction("OnHomeVoiceStop", heroId, heroVoiceDescId);
		}
	}
}
