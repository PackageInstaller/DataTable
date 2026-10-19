using ACT.Model;

namespace ACT.Battle.Configs;

[AbilityTypeMetadata("获取当前瓶使用数量", "Function", new string[] { "get", "cur", "bottle", "use", "count", "value", "float", "int" })]
public class GetCurBottleUseCount : ConfigFunction<float>
{
	protected override float Evaluate(ActionMemory memory)
	{
		BloodBottleData curTeamEquipBottle = Model<BloodBottleModel>.Interface.CurTeamEquipBottle;
		if (curTeamEquipBottle == null)
		{
			return 0f;
		}
		return curTeamEquipBottle.maxUseCount - curTeamEquipBottle.alreadyUseCount;
	}
}
