using NodeCanvas.Framework;
using ParadoxNotion.Design;

namespace Ase.Paradox;

[Name("修改按键的技能绑定", 0)]
[Category("✫ DragonLost/Skill")]
[Description("修改指定实体的按键技能绑定，并在需要时在行为树结束时恢复。")]
public class ChangeSkillBindAction : ActionTaskBase
{
	[RequiredField]
	[Name("实体ID", 0)]
	[Description("要修改技能绑定的实体的ID")]
	public BBParameter<int> EntityId;

	[Name("技能类型", 0)]
	[Description("要修改绑定的技能类型")]
	public HeroSkillTypeEnum HeroSkillTypeEnum;

	[Name("技能ID", 0)]
	[Description("要绑定到指定类型的技能的ID")]
	public BBParameter<int> SkillId;

	[Name("跟随行为树结束还原", 0)]
	[Description("如果设置为true，在行为树结束时将技能绑定恢复到初始状态。")]
	public bool FollowTreeEndRestore;

	[ShowIf("FollowTreeEndRestore", 1)]
	[Name("还原技能ID", 0)]
	[Description("如果跟随行为树结束还原被启用，将技能绑定恢复到的技能ID")]
	public BBParameter<int> RefreshSkillId;

	protected override void OnExecute()
	{
		base.OnExecute();
		EndAction();
	}

	protected override void OnGraphStop()
	{
		base.OnGraphStop();
	}
}
