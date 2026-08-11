using Ase;
using NodeCanvas.Framework;
using ParadoxNotion.Design;

[Name("修改技能优先级", 0)]
[Category("✫ DragonLost/Skill")]
[Description("修改指定技能类型的优先级，并在需要时在行为树结束时恢复。")]
public class ChangeSkillPriorityAction : ActionTaskBase
{
	[RequiredField]
	[Name("技能类型", 0)]
	[Description("要修改优先级的技能类型")]
	public BBParameter<HeroSkillTypeEnum> skillType;

	[Name("修改的等级", 0)]
	[Description("要修改为的优先级值")]
	public int priority;

	[Name("行为树结束是否还原优先级", 0)]
	[Description("如果设置为true，在行为树结束时将优先级恢复到初始状态。")]
	public BBParameter<bool> isRestorePriority;

	protected override void OnExecute()
	{
		base.OnExecute();
		EndAction();
	}
}
