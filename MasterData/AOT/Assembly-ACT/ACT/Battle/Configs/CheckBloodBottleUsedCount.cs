using ACT.Model;

namespace ACT.Battle.Configs;

[AbilityTypeMetadata("判断血瓶已使用数量", "Predicate", new string[] { "check", "blood", "bottle", "used", "count", "predicate", "condition" })]
public class CheckBloodBottleUsedCount : ConfigPredicate
{
	public enum CheckType
	{
		checkCount,
		checkMaxCount
	}

	public CheckType checkType;

	public int count;

	public override bool Check(ActionMemory memory)
	{
		bool result = false;
		switch (checkType)
		{
		case CheckType.checkCount:
			if (memory.evt is UseBloodBottle useBloodBottle)
			{
				result = useBloodBottle.canUseCount == count;
			}
			break;
		case CheckType.checkMaxCount:
		{
			BloodBottleData curTeamEquipBottle = Model<BloodBottleModel>.Interface.CurTeamEquipBottle;
			if (curTeamEquipBottle == null)
			{
				return result;
			}
			if (curTeamEquipBottle.maxUseCount - curTeamEquipBottle.alreadyUseCount == curTeamEquipBottle.maxUseCount)
			{
				result = true;
			}
			break;
		}
		}
		return result;
	}
}
