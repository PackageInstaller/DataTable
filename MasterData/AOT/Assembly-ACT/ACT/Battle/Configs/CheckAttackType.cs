namespace ACT.Battle.Configs;

[AbilityTypeMetadata("判断攻击类型", "Predicate", new string[] { "check", "attack", "type", "predicate", "condition" })]
public class CheckAttackType : ConfigPredicate
{
	public enum CheckType
	{
		Adjust1 = 1,
		Adjust2,
		Both
	}

	public CheckType checkType;

	public Adjust1AttackTypeTag adjust1AttackType;

	public Adjust2AttackTypeTag adjust2AttackType;

	public override bool Check(ActionMemory memory)
	{
		if (memory.evt is IGetAttackData getAttackData)
		{
			AttackData attackData = getAttackData.GetAttackData();
			switch (checkType)
			{
			case CheckType.Adjust1:
				return attackData.adjust1AttackType == adjust1AttackType;
			case CheckType.Adjust2:
				return (attackData.adjust2AttackType & adjust2AttackType) != 0;
			case CheckType.Both:
				if (attackData.adjust1AttackType == adjust1AttackType)
				{
					return (attackData.adjust2AttackType & adjust2AttackType) != 0;
				}
				return false;
			}
		}
		return false;
	}
}
