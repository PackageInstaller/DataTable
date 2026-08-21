using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("技能执行事件(时间)", 0)]
[Category("Logic/Abilities")]
[Description("技能Update时调用的事件")]
public class LogicAbilityEventWithSpecifiedTime : LogicAbilityEventBase
{
	private ValueInput<int> m_executeTime;

	protected override void AddCustomValueInput()
	{
		m_executeTime = AddValueInput<int>("时间点", "executeTime");
	}

	protected override void AddCustionValueOutput()
	{
	}

	protected override bool ConditionFunc(SimEntity simEntity, int abilityID, int logicTime, int actionID)
	{
		if (logicTime >= m_executeTime.value && logicTime < m_executeTime.value + CommonProcessor.GetConfigInterval())
		{
			return true;
		}
		return false;
	}
}
