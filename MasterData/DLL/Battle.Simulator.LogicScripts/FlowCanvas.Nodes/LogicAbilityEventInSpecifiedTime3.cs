using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("技能执行事件(闪避+技能时间)", 0)]
[Category("Logic/Abilities/具体")]
[Description("技能Update时调用的事件")]
public class LogicAbilityEventInSpecifiedTime3 : LogicAbilityEventBase
{
	private ValueInput<int> m_roleIDVar;

	private ValueInput<int> executeTime;

	private int m_avoidForwardID;

	private int m_avoidBackID;

	protected override void AddCustionValueOutput()
	{
	}

	protected override void AddCustomValueInput()
	{
		m_roleIDVar = AddValueInput<int>("实体类型ID", "RoleID");
		executeTime = AddValueInput<int>("执行时间点(毫秒)", "executeTime");
	}

	protected override bool ConditionFunc(SimEntity simEntity, int abilityID, int logicTime, int actionID)
	{
		m_avoidForwardID = m_roleIDVar.GetValue() * 1000 + 305;
		m_avoidBackID = m_roleIDVar.GetValue() * 1000 + 306;
		if (logicTime >= executeTime.value && logicTime < executeTime.value + CommonProcessor.GetConfigInterval() && (m_avoidForwardID == abilityID || m_avoidBackID == abilityID))
		{
			return true;
		}
		return false;
	}
}
