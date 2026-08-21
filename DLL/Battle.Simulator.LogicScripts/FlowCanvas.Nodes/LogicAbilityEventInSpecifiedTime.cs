using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("技能执行事件(技能ID+时间)", 0)]
[Category("Logic/Abilities")]
[Description("技能Update时调用的事件")]
public class LogicAbilityEventInSpecifiedTime : LogicAbilityEventBase
{
	private ValueInput<int> input;

	private ValueInput<int> executeTime;

	protected override void AddCustomValueInput()
	{
		input = AddValueInput<int>("abilityID");
		executeTime = AddValueInput<int>("executeTime");
	}

	protected override void AddCustionValueOutput()
	{
	}

	protected override bool ConditionFunc(SimEntity simEntity, int abilityID, int logicTime, int actionID)
	{
		if (logicTime >= executeTime.value && logicTime < executeTime.value + CommonProcessor.GetConfigInterval() && input.value == abilityID)
		{
			return true;
		}
		return false;
	}
}
