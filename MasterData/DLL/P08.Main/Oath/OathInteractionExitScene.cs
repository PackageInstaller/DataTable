using System;

namespace Oath;

[Serializable]
public class OathInteractionExitScene : OathInteractionNode
{
	public override void StartEvent()
	{
		LuaHelper.CallFunction("OathToLuaBridge.OathExitScene");
	}
}
