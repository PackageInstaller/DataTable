using Config;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("普攻执行事件", 0)]
[Category("Logic/事件")]
[Description("全部的普攻执行触发事件")]
public class LogicAbilityEventOfAttack : LogicAbilityEventBase
{
	protected override void AddCustomValueInput()
	{
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
		return ConfigHelper.GetInstance().GetConfig<RoleConfig>(simEntity.ENTITY_CONFIG_ID).Melees.Contains(abilityID);
	}
}
