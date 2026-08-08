using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("CD结束事件(实体类型ID&后三位)(逻辑)", 0)]
[Category("Logic/事件")]
[Description("每次CD结束的时候会触发一次该事件")]
public class CDEndOfRoleIDAndActionIDEvent : CDEndEventBase
{
	private ValueInput<int> m_roleIDInput;

	private ValueInput<int> m_actionIDInput;

	protected override void AddCustomValueInput()
	{
		m_roleIDInput = AddValueInput<int>("实体类型ID", "roleID");
		m_actionIDInput = AddValueInput<int>("后三位", "actionID");
	}

	protected override void AddCustionValueOutput()
	{
	}

	protected override bool ConditionFunc(SimEntity simEntity, AbilityCD abilityCD)
	{
		if (m_roleIDInput.GetValue() == m_roleID)
		{
			return m_actionIDInput.GetValue() == m_actionID;
		}
		return false;
	}
}
