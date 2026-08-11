using NodeCanvas.Framework;
using ParadoxNotion.Design;

namespace Ase.Paradox;

[Name("获取技能优先级", 0)]
[Category("✫ DragonLost/Skill")]
[Description("获取指定技能类型的技能优先级")]
public class AcquireSkillPriorityAction : ActionTaskBase
{
	[RequiredField]
	[Name("技能类型", 0)]
	[Description("要获取优先级的技能类型")]
	public BBParameter<HeroSkillTypeEnum> skillType;

	[Name("返回的技能优先级", 0)]
	[Description("获取到的技能优先级")]
	public BBParameter<int> priority;

	[Name("是否是原始优先级", 0)]
	[Description("是否获取原始优先级")]
	public bool isOriginalData;

	protected override void OnExecute()
	{
		base.OnExecute();
		EndAction();
	}
}
