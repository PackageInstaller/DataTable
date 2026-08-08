using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("技能执行事件(奥义)(指定时间)(逻辑)", 0)]
[Category("Logic/事件/奥义")]
[Description("在指定时间触发的奥义执行事件")]
public class UniqueSkillAbilityEventWithSpecifiedTime : LogicAbilityEventBase
{
	private ValueInput<int> _ExecuteTime;

	protected override void AddCustomValueInput()
	{
		_ExecuteTime = AddValueInput<int>("时间点", "ExecuteTime");
	}

	protected override void AddCustionValueOutput()
	{
	}

	protected override bool ConditionFunc(SimEntity simEntity, int abilityID, int logicTime, int actionID)
	{
		if (!CommonProcessor.IsInUniqueSkillABility(simEntity, abilityID))
		{
			return false;
		}
		int value = _ExecuteTime.GetValue();
		if (logicTime < value || logicTime >= value + CommonProcessor.GetConfigInterval())
		{
			return false;
		}
		return true;
	}
}
