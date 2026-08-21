using System;

namespace Oath;

[Serializable]
public class OathInteractcionSkip : OathInteractionNode
{
	public bool showSkipBtn = true;

	private const string skip_show_event = "OATH_SCENE_SHOW_SKIP";

	public override void StartEvent()
	{
		LuaHelper.CallFunction("OathToLuaBridge.OathEmitterEvent", "OATH_SCENE_SHOW_SKIP", showSkipBtn);
	}
}
