using System;

namespace Oath;

[Serializable]
public class OathInteractionShowCost : OathInteractionNode
{
	public bool isNeedShowConst = true;

	public override void StartEvent()
	{
		if (isNeedShowConst)
		{
			LuaHelper.CallFunction("OathToLuaBridge.OathEmitterEvent", "OATH_SCENE_SHOW_COST", true);
			return;
		}
		Action callback = delegate
		{
			base.IsFinish = true;
			callback = null;
		};
		LuaHelper.CallFunction("OathToLuaBridge.OathEmitterEvent", "OATH_SCENE_SHOW_COST", false, callback);
	}

	public override void DisposeEvent()
	{
	}
}
