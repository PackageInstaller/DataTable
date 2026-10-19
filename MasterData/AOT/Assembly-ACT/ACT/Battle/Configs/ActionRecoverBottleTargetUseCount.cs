using ACT.Model;
using ACT.UI;
using Fundamental;

namespace ACT.Battle.Configs;

[AbilityTypeMetadata("恢复瓶目标使用数量", "Action", new string[] { "recover", "bottle", "target", "use", "count", "retarget", "aim" })]
public class ActionRecoverBottleTargetUseCount : ConfigAction
{
	public ConfigFunction<float> configFunction;

	public ConfigFunction<float> recoverCountConfigFunction;

	public override void Do(ActionMemory memory)
	{
		int num = (int)configFunction.Return(memory);
		float cd = 60f;
		BloodBottleData curTeamEquipBottle = Model<BloodBottleModel>.Interface.CurTeamEquipBottle;
		if (curTeamEquipBottle != null && curTeamEquipBottle.maxUseCount >= num)
		{
			Singleton<BloodBottleHandler>.instance.RecoverBottleUseCount(num, cd);
		}
	}
}
