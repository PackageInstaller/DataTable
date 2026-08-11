using Ase.ECS;
using NodeCanvas.Framework;
using ParadoxNotion.Design;

namespace Ase.Paradox;

[Name("输出技能的第一个标签", 0)]
[Description("输出该技能在技能表上SkillLabelTypeEnum填的第一个标签")]
[Category("✫ Entity")]
public class OutputSkillLabelTypeEnumByInput : ActionTaskBase
{
	[Name("技能枚举", 0)]
	[Description("技能枚举")]
	public BBParameter<HeroSkillTypeEnum> SkillEnum;

	[Name("第一个标签", 0)]
	[Description("第一个标签")]
	public BBParameter<string> SkillTag;

	protected override void OnExecute()
	{
		base.OnExecute();
		HeroSkillData skillData = ownerEntity.GetComponent<SkillComponent>().GetSkillData(SkillEnum.value);
		if (skillData != null && skillData.GetSkillLabelList().Count > 0)
		{
			SkillTag.value = skillData.GetSkillLabelList()[0];
		}
		EndAction();
	}
}
