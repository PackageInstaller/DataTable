using BilliardGame.Runtime;

namespace BilliardGame.Spell;

public class BTAddActiveTurnNode : BActionNode
{
	public int turnNum;

	public override BTNodeStatus Run(BTEnv env)
	{
		EntityPlayer player = env.GetPlayer<BilliardGameEntityBase>("Caster") as EntityPlayer;
		BilliardGameLogicManager.Instance.AddPlayerActiveTurn(player, turnNum);
		return BTNodeStatus.Success;
	}
}
