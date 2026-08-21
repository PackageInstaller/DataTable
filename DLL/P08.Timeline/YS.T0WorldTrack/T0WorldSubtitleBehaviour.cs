using System;
using UnityEngine;
using UnityEngine.Playables;

namespace YS.T0WorldTrack;

[Serializable]
public class T0WorldSubtitleBehaviour : PlayableBehaviour
{
	public T0WorldLuaBridge.T0SubtitleData data { get; private set; }

	private static void PushSubtitle(T0WorldLuaBridge.T0SubtitleData data)
	{
		if (LuaHelper.IsLuaClientInited())
		{
			LuaHelper.GetFunc("T0WorldPushSubtitle").Call(data);
		}
	}

	public override void OnPlayableCreate(Playable playable)
	{
		base.OnPlayableCreate(playable);
		data = new T0WorldLuaBridge.T0SubtitleData();
	}

	public override void OnGraphStart(Playable playable)
	{
		data.wait = true;
		data.show = false;
		if (Application.isPlaying && LuaHelper.IsLuaClientInited())
		{
			PushSubtitle(data);
		}
	}

	public override void OnGraphStop(Playable playable)
	{
		data.wait = false;
		data.show = false;
	}

	public override void OnBehaviourPlay(Playable playable, FrameData info)
	{
		base.OnBehaviourPlay(playable, info);
		data.wait = false;
		data.show = true;
	}

	public override void OnBehaviourPause(Playable playable, FrameData info)
	{
		base.OnBehaviourPause(playable, info);
		data.show = false;
	}

	internal void SetData(int formID, string file)
	{
		data.formID = formID;
		data.file = file;
	}
}
