using System.Collections.Generic;
using Ase.ECS;
using NodeCanvas.Framework;
using ParadoxNotion.Design;

namespace Ase.Paradox;

[Name("设置当前状态是否能释放的技能", 0)]
[Category("✫ DragonLost/Skill")]
[Description("设置指定类型的技能是否在当前状态状态可以释放")]
public class AbnormalStateCanReleaseSkill : ActionTaskBase
{
	[Name("指令类型", 0)]
	[Description("指令类型")]
	public BBParameter<List<HeroSkillTypeEnum>> skillIdList;

	[Name("是否可以释放", 0)]
	[Description("设置是否可以在当前状态释放技能")]
	public bool IsCanReleaseSkill;

	protected override void OnExecute()
	{
		base.OnExecute();
		ownerEntity.GetComponent<StateComponent>()?.UpdateSkillState(IsCanReleaseSkill, skillIdList.value);
		EndAction();
	}
}
