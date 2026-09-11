using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("技能结束事件(奥义)(逻辑)", 0)]
[Category("Logic/事件/奥义")]
[Description("当奥义结束事件时触发,被Ability中断也会触发;\n如果不是被技能中断,新的abilityID就输出0;\n如果技能被Hit中断,则会走【当技能被Hit打断时】")]
public class UniqueSkillAbilityEndEvent : LogicAbilityEndEventBase
{
	protected override void AddCustomValueInput()
	{
	}

	protected override void AddCustomValueOutput()
	{
	}

	protected override bool OnHitCheck(SimEntity pSimEntity, int pOldAbilityID, int pNewAbilityID)
	{
		if (CommonProcessor.IsInUniqueSkillABility(pSimEntity, pOldAbilityID))
		{
			return !CommonProcessor.IsInUniqueSkillABility(pSimEntity, pNewAbilityID);
		}
		return false;
	}

	protected override bool ConditionFunc(SimEntity pSimEntity, int pOldAbilityID, int pNewAbilityID)
	{
		if (CommonProcessor.IsInUniqueSkillABility(pSimEntity, pOldAbilityID))
		{
			return !CommonProcessor.IsInUniqueSkillABility(pSimEntity, pNewAbilityID);
		}
		return false;
	}
}
