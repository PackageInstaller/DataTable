using NodeCanvas.Framework;
using ParadoxNotion.Design;

namespace Ase.Paradox;

[Name("还原技能绑定", 0)]
[Category("✫ DragonLost/Skill")]
[Description("还原指定实体的特定类型技能的绑定。")]
public class RestoreSkillBindAction : ActionTaskBase
{
	[Name("实体ID", 0)]
	[Description("要还原技能绑定的实体的ID。")]
	public BBParameter<int> EntityId;

	[Name("技能类型", 0)]
	[Description("要还原绑定的技能类型。")]
	public HeroSkillTypeEnum HeroSkillTypeEnum;

	protected override void OnExecute()
	{
		base.OnExecute();
		EndAction();
	}
}
