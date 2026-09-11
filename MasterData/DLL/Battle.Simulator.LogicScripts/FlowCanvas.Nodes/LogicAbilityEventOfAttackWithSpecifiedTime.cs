using Config;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("普攻执行事件(时间)", 0)]
[Category("Logic/事件")]
[Description("全部的普攻执行到指定时间触发事件")]
public class LogicAbilityEventOfAttackWithSpecifiedTime : LogicAbilityEventBase
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
		if (simEntity == null || !simEntity.hasEntityConfig)
		{
			return false;
		}
		if (!ConfigHelper.GetInstance().GetConfig<RoleConfig>(simEntity.ENTITY_CONFIG_ID).Melees.Contains(abilityID))
		{
			return false;
		}
		if (logicTime >= m_executeTime.value && logicTime < m_executeTime.value + CommonProcessor.GetConfigInterval())
		{
			return true;
		}
		return false;
	}
}
