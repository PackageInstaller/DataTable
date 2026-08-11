using Ase;
using Ase.ECS;
using NodeCanvas.Framework;
using ParadoxNotion.Design;

[Name("获取指令绑定的技能ID", 0)]
[Category("✫ DragonLost/Skill")]
[Description("获取当前指令绑定的技能ID")]
public class GetCommandBindSKillIdAction : ActionTaskBase
{
	[Name("指令类型", 0)]
	[Description("指令类型")]
	public BBParameter<HeroSkillTypeEnum> CommandType;

	[Name("技能ID", 0)]
	[Description("技能ID")]
	public BBParameter<int> SkillId;

	[Name("是否是派生技能", 0)]
	[Description("获取的技能是否是个派生技能")]
	public BBParameter<bool> IsDeriveSkill;

	protected override void OnExecute()
	{
		base.OnExecute();
		HeroSkillData skillData = ownerEntity.GetComponent<SkillComponent>().GetSkillData(CommandType.value);
		if (skillData != null)
		{
			SkillId.value = skillData.Id;
			IsDeriveSkill.value = skillData.IsDeriveSkill;
		}
		if (LockstepData.Instance != null)
		{
			LockstepData.Instance.WriteAuthorityEntityId($"获取指令绑定的技能ID  指令类型 ： {CommandType.value} 技能ID : {SkillId.value}  是否是派生技能 : {IsDeriveSkill.value}", ownerEntity);
		}
		EndAction();
	}
}
