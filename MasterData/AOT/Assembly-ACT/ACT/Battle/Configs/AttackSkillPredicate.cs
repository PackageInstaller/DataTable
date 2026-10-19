namespace ACT.Battle.Configs;

[AbilityTypeMetadata("判断攻击技能", "Predicate", new string[] { "attack", "skill", "predicate", "check", "condition", "ability", "cd" })]
public class AttackSkillPredicate : ConfigPredicate
{
	public int skillID;

	public override bool Check(ActionMemory memory)
	{
		if (memory.evt is IGetAttackData)
		{
			return (memory.evt as IGetAttackData).GetAttackData().skillID == skillID;
		}
		return false;
	}
}
