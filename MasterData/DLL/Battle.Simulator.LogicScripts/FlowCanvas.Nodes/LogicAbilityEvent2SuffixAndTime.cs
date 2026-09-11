using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("技能执行事件(技能后三位ID 时间)", 0)]
[Category("Logic/事件")]
[Description("技能Update时调用的事件")]
public class LogicAbilityEvent2SuffixAndTime : LogicAbilityEventBase
{
	private ValueInput<int> _abilityIDInput;

	private ValueInput<int> _timeInput;

	protected override void AddCustomValueInput()
	{
		_abilityIDInput = AddValueInput<int>("abilityID(后三位)");
		_timeInput = AddValueInput<int>("执行时间");
	}

	protected override void AddCustionValueOutput()
	{
	}

	protected override bool ConditionFunc(SimEntity simEntity, int abilityID, int logicTime, int actionID)
	{
		if (_abilityIDInput.value == abilityID % 1000 && logicTime >= _timeInput.value)
		{
			return logicTime < _timeInput.value + CommonProcessor.GetConfigInterval();
		}
		return false;
	}
}
