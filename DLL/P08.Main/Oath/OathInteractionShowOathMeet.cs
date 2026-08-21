using System;

namespace Oath;

[Serializable]
public class OathInteractionShowOathMeet : OathInteractionNode
{
	public float countDownTime = 5f;

	public override void StartEvent()
	{
		Action callback = delegate
		{
			base.IsFinish = true;
			callback = null;
		};
		LuaHelper.CallFunction("OathToLuaBridge.OathEmitterEvent", "OATH_SCENE_SHOW_OATH_CONDITION", callback, true, countDownTime);
	}

	public override void DisposeEvent()
	{
		LuaHelper.CallFunction("OathToLuaBridge.OathEmitterEvent", "OATH_SCENE_SHOW_OATH_CONDITION", null, false);
	}
}
