using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("技能执行事件(实体类型ID&后三位)", 0)]
[Category("Logic/事件")]
[Description("技能Update时调用的事件")]
public class LogicAbilityEventWithRoleIDAndActionID : LogicAbilityEventBase
{
	private ValueInput<int> m_roleIDInput;

	private ValueInput<int> m_actionIDInput;

	protected override void AddCustomValueInput()
	{
		m_roleIDInput = AddValueInput<int>("实体类型ID", "roleIDInput");
		m_actionIDInput = AddValueInput<int>("后三位", "actionIDInput");
	}

	protected override void AddCustionValueOutput()
	{
	}

	protected override bool ConditionFunc(SimEntity simEntity, int abilityID, int logicTime, int actionID)
	{
		int num = m_roleIDInput.GetValue() * 1000 + m_actionIDInput.GetValue();
		return abilityID == num;
	}
}
