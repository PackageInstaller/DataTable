using System;

namespace Oath;

[Serializable]
public class OathInteractionCheckOathMeet : OathInteractionNode
{
	public bool isMeet;

	public override void StartEvent()
	{
		object[] array = LuaHelper.CallFunction("OathToLuaBridge.OathCheckConditionMeet", 1);
		bool flag = array != null && array.Length != 0 && (bool)array[0];
		if (isMeet == flag)
		{
			base.IsFinish = true;
		}
	}
}
