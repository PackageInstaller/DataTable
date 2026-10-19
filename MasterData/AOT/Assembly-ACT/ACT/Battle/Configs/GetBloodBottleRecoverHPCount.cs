using ACT.Core;
using ACT.Model;
using ACT.Utility;
using Bamboo.ECS;

namespace ACT.Battle.Configs;

[AbilityTypeMetadata("获取血瓶生命值数量", "Function", new string[] { "get", "blood", "bottle", "recover", "hp", "count", "value", "float", "int" })]
public class GetBloodBottleRecoverHPCount : ConfigFunction<float>
{
	public bool GetActuallyCount;

	protected override float Evaluate(ActionMemory memory)
	{
		if (Model<BloodBottleModel>.Interface.CurTeamEquipBottle == null)
		{
			return 0f;
		}
		BloodBottleData curTeamEquipBottle = Model<BloodBottleModel>.Interface.CurTeamEquipBottle;
		float bottleBaseRecoverCount = GameUtility.GetBottleBaseRecoverCount(CoreUtils.GetData(curTeamEquipBottle.uid, RuntimeConfigs.data.potionDatas).healSkillId, curTeamEquipBottle.curLevel, memory.target.entity);
		CompAbility compAbility = memory.target.entity.GetCompAbility();
		if (!GameUtility.BloodBottleRecoverMax)
		{
			if (!GetActuallyCount)
			{
				return bottleBaseRecoverCount;
			}
			return GameUtility.GetBottleActuallyRecoverCount(bottleBaseRecoverCount, memory.target.entity);
		}
		return compAbility.maxHP - compAbility.hp;
	}
}
