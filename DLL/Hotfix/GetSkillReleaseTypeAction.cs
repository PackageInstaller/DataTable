using Ase;
using Ase.ECS;
using NodeCanvas.Framework;
using ParadoxNotion.Design;

[Name("获取技能释放类型", 0)]
[Category("✫ DragonLost/Skill")]
[Description("通过指令获取到技能释放类型")]
public class GetSkillReleaseTypeAction : ActionTaskBase
{
	[Name("指令类型", 0)]
	public BBParameter<HeroSkillTypeEnum> CommandType;

	[Name("技能的释放类型", 0)]
	public BBParameter<int> ReleaseType;

	protected override void OnExecute()
	{
		base.OnExecute();
		ReleaseType.value = ownerEntity.GetComponent<SkillComponent>().GetSkillReleaseType(CommandType.value);
		EndAction();
	}
}
