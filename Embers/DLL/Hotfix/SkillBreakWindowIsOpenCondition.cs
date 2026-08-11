using Ase;
using Ase.ECS;
using NodeCanvas.Framework;
using ParadoxNotion.Design;

[Name("指令的打断窗口是否打开", 0)]
[Category("✫ DragonLost/Skill")]
[Description("技能的打断窗口是否打开")]
public class SkillBreakWindowIsOpenCondition : ConditionTaskBase
{
	[Name("指令类型", 0)]
	[Description("指令类型")]
	public BBParameter<HeroSkillTypeEnum> SkillType;

	[Name("是否可以打断的指令", 0)]
	[Description("是否可以打断的指令")]
	public BBParameter<HeroSkillTypeEnum> BreakSkillType;

	protected override bool OnCheck()
	{
		base.OnCheck();
		bool result = ownerEntity.GetComponent<SkillComponent>()?.CommandBreakWindowIsOpen(SkillType.value, BreakSkillType.value) ?? false;
		if (LockstepData.Instance != null)
		{
			LockstepData.Instance.WriteAuthorityEntityId($"指令的打断窗口是否打开 指令类型 : {SkillType.value} 是否可以打断的指令 : {BreakSkillType.value}", ownerEntity);
		}
		return result;
	}
}
