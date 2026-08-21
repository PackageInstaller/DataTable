using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("技能开始事件(奥义)(逻辑)", 0)]
[Category("Logic/事件/奥义")]
[Description("奥义开始执行的时候触发的,只有第一段奥义开始才会出发,用的是uniqueskill表的字段")]
public class UniqueSkillAbilityBeginEvent : LogicAbilityBeginEventBase
{
	protected override void AddCustomValueInput()
	{
	}

	protected override void AddCustomValueOutput()
	{
	}

	protected override bool ConditionFunc(SimEntity pSimEntity, int pOldAbilityID, int pNewAbilityID)
	{
		if (!CommonProcessor.IsInUniqueSkillABility(pSimEntity, pOldAbilityID))
		{
			return CommonProcessor.IsInUniqueSkillABility(pSimEntity, pNewAbilityID);
		}
		return false;
	}
}
