using System;

namespace T0World;

[Serializable]
public class T0InterationCheckCondition : T0InterationFunctionDataBase
{
	public T0InterationCheckConditionType checkType = T0InterationCheckConditionType.CONDITION;

	public int conditionVlaue;

	public override void StartEvent(T0WorldInteractionBehavior behaviour)
	{
		object[] array = LuaHelper.CallFunction("T0WorldCheckConditionMeet", (int)checkType, conditionVlaue);
		if (array != null && array.Length != 0 && (bool)array[0])
		{
			base.IsFinish = true;
		}
	}
}
