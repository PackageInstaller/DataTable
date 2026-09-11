using System;
using UnityEngine;
using UnityEngine.Playables;

namespace Oath;

[Serializable]
public class OathInteractionDrag : OathInteractionNode
{
	public string dragAnimName;

	public string dragKey = "DragEvent";

	private float use_seconds;

	private PlayableDirector playable;

	public override bool MustNeedSDK => true;

	public override void StartEvent()
	{
		use_seconds = 0f;
		OathSceneLoader.Scene.context.interationManager.character.timelineBehavior.BindTargetDragTimeLine(dragAnimName, out playable);
		OathSceneLoader.Scene.context.interationManager.character.dragManager.AddRunDragEvent(dragKey, this);
		playable.time = 0.0;
		playable.Pause();
		LuaHelper.CallFunction("OathToLuaBridge.OathEmitterEvent", "OATH_SCENE_ENTER_DRAG", true);
	}

	public override void UpdateEvent()
	{
		use_seconds += Time.deltaTime;
	}

	public void OnDragValueChange(float progress)
	{
		if (!(playable == null))
		{
			progress = Mathf.Clamp01(progress);
			double time = playable.duration * (double)progress;
			playable.time = time;
			playable.Evaluate();
		}
	}

	public void OnDragFinish()
	{
		base.IsFinish = true;
	}

	public void OnDragEnd()
	{
		OnDragValueChange(0f);
	}

	public override void DisposeEvent()
	{
		playable = null;
		LuaHelper.CallFunction("OathToLuaBridge.OathEmitterEvent", "OATH_SCENE_ENTER_DRAG", false);
	}

	public override void FinishEvent()
	{
		playable = null;
		LuaHelper.CallFunction("OathToLuaBridge.OathEmitterEvent", "OATH_SCENE_ENTER_DRAG", false);
	}

	public override void SendSDK()
	{
		LuaHelper.CallFunction("OathToLuaBridge.OathRecordSDK", nodeID, null, use_seconds);
	}
}
