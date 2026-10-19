using ACT.Utility;

namespace ACT.Battle.Configs;

[AbilityTypeMetadata("更新瓶最大", "Action", new string[] { "update", "bottle", "recover", "max", "heal", "hp" })]
public class ActionUpdateBottleRecoverMax : ConfigAction
{
	public override void Do(ActionMemory memory)
	{
		if (memory.evt is BloodBottleRecoverMax bloodBottleRecoverMax)
		{
			GameUtility.UpdateRecoverMaxHPState(bloodBottleRecoverMax.bloodbottleRecoverMax);
		}
	}
}
