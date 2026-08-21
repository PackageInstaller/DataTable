using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("技能执行事件(奥义)(逻辑)", 0)]
[Category("Logic/事件/奥义")]
[Description("奥义执行事件,用的是uniqueskill表的字段")]
public class UniqueSkillAbilityEvent : LogicAbilityEventBase
{
	protected override void AddCustomValueInput()
	{
	}

	protected override void AddCustionValueOutput()
	{
	}

	protected override bool ConditionFunc(SimEntity simEntity, int abilityID, int logicTime, int actionID)
	{
		if (simEntity == null)
		{
			return false;
		}
		if (CommonProcessor.IsInUniqueSkillABility(simEntity, abilityID))
		{
			return true;
		}
		return false;
	}
}
