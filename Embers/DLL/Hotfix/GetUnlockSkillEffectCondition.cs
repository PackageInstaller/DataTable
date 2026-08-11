using Ase;
using Ase.ECS;
using ParadoxNotion.Design;

[Name("技能效果是否被解锁", 0)]
[Category("✫ DragonLost/Skill")]
[Description("判断改技能效果ID是否被解锁")]
public class GetUnlockSkillEffectCondition : ConditionTaskBase
{
	[Name("技能效果ID", 0)]
	public int SkillEffectID;

	protected override bool OnCheck()
	{
		base.OnCheck();
		return ownerEntity.GetComponent<SkillComponent>().CheckUnlockSkillEffect(SkillEffectID);
	}
}
