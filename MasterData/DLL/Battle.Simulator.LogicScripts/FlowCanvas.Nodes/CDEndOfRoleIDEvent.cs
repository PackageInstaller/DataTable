using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("CD结束事件(实体类型ID)(逻辑)", 0)]
[Category("Logic/事件")]
[Description("每次CD结束的时候会触发一次该事件")]
public class CDEndOfRoleIDEvent : CDEndEventBase
{
	private ValueInput<int> m_roleIDInput;

	protected override void AddCustomValueInput()
	{
		m_roleIDInput = AddValueInput<int>("实体类型ID", "roleID");
	}

	protected override void AddCustionValueOutput()
	{
	}

	protected override bool ConditionFunc(SimEntity simEntity, AbilityCD abilityCD)
	{
		return m_roleIDInput.GetValue() == m_roleID;
	}
}
