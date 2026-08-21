using Ase;
using Ase.ECS;
using NodeCanvas.Framework;
using ParadoxNotion.Design;

[Name("获取技能的蓄力时间", 0)]
[Category("✫ DragonLost/Skill")]
[Description("通过指令获取到技能的蓄力时间")]
public class GetSkillPoisedTimeAction : ActionTaskBase
{
	[Name("指令类型", 0)]
	public BBParameter<HeroSkillTypeEnum> CommandType;

	[Name("技能的蓄力时间", 0)]
	public BBParameter<float> Time;

	protected override void OnExecute()
	{
		base.OnExecute();
		Time.value = ownerEntity.GetComponent<SkillComponent>().GetSkillPoisedTime(CommandType.value);
		if (LockstepData.Instance != null)
		{
			LockstepData.Instance.WriteAuthorityEntityId($"获取技能的蓄力时间 指令类型 : {CommandType.value} 技能的蓄力时间 : {Time.value}", ownerEntity);
		}
		EndAction();
	}
}
