using System;

namespace Oath;

[Serializable]
public class OathInteractionFinishOath : OathInteractionNode
{
	public override void StartEvent()
	{
		LuaHelper.CallFunction("OathToLuaBridge.OathFinsh");
		base.IsFinish = true;
	}
}
