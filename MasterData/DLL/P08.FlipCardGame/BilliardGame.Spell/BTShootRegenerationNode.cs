using BilliardGame.Runtime;

namespace BilliardGame.Spell;

public class BTShootRegenerationNode : BActionNode
{
	public int hpRatio;

	public override BTNodeStatus Run(BTEnv env)
	{
		EntityEnemy player = env.GetPlayer<EntityEnemy>("shootOwner");
		player.TakeRegeneration(player.maxHP * (hpRatio / 100));
		return BTNodeStatus.Success;
	}
}
