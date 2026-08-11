using Ase;
using Ase.ECS;
using NodeCanvas.Framework;
using ParadoxNotion.Design;

[Name("判断指令是否缓存", 0)]
[Category("✫ DragonLost/Skill")]
[Description("判断给定的指令以及对应的指令状态是否被缓存")]
public class CommandIsCacheCondition : ConditionTaskBase
{
	[Name("指令类型", 0)]
	[Description("指令类型")]
	public BBParameter<HeroSkillTypeEnum> SkillEnum;

	[Name("指令状态", 0)]
	[Description("指令状态 1 = 按下 3 = 抬起")]
	public BBParameter<int> SkillState;

	protected override bool OnCheck()
	{
		base.OnCheck();
		bool result = ownerEntity.GetComponent<SkillComponent>()?.CommandIsCache(SkillEnum.value, SkillState.value) ?? false;
		if (LockstepData.Instance != null)
		{
			LockstepData.Instance.WriteAuthorityEntityId($"判断指令是否缓存  指令类型 ： {SkillEnum.value}", ownerEntity);
		}
		return result;
	}
}
