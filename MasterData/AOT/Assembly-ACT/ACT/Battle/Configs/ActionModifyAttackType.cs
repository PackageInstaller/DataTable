namespace ACT.Battle.Configs;

[AbilityTypeMetadata("修改攻击类型", "Action", new string[] { "modify", "attack", "type", "damage", "hit" })]
public class ActionModifyAttackType : ConfigAction
{
	public enum ModifyType
	{
		Adjust1 = 1,
		Adjust2,
		Both
	}

	public ModifyType modifyType;

	public Adjust1AttackTypeTag adjust1AttackType;

	public Adjust2AttackTypeTag adjust2AttackType;

	public override void Do(ActionMemory memory)
	{
		if (memory.evt is IGetAttackData getAttackData)
		{
			AttackData attackData = getAttackData.GetAttackData();
			switch (modifyType)
			{
			case ModifyType.Adjust1:
				attackData.adjust1AttackType = adjust1AttackType;
				break;
			case ModifyType.Adjust2:
				attackData.adjust2AttackType = adjust2AttackType;
				break;
			case ModifyType.Both:
				attackData.adjust1AttackType = adjust1AttackType;
				attackData.adjust2AttackType = adjust2AttackType;
				break;
			}
		}
	}
}
