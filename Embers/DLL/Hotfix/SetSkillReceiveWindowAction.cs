using System.Collections.Generic;
using Ase;
using Ase.ECS;
using NodeCanvas.Framework;
using ParadoxNotion.Design;

[Name("设置指令的可接受窗口", 0)]
[Category("✫ DragonLost/Skill")]
[Description("关闭可接受窗口,行为树将不会接受到该指令...")]
public class SetSkillReceiveWindowAction : ActionTaskBase
{
	[Name("指令类型", 0)]
	[Description("指令类型")]
	public BBParameter<List<HeroSkillTypeEnum>> HeroSkillEnum;

	[Name("开关", 0)]
	[Description("开关")]
	public bool Open;

	protected override void OnExecute()
	{
		base.OnExecute();
		ownerEntity.GetComponent<SkillComponent>().OpenCommandReceiveWindow(HeroSkillEnum.value, Open);
		EndAction();
	}
}
