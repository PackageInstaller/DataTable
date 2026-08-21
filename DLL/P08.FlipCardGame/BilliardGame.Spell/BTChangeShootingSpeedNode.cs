using BilliardGame.Runtime;

namespace BilliardGame.Spell;

public class BTChangeShootingSpeedNode : BActionNode
{
	public float speedRatio;

	public override BTNodeStatus Run(BTEnv env)
	{
		BilliardGameEntityBase player = env.GetPlayer<BilliardGameEntityBase>("TargetEntity");
		if (!(player is EntityPlayer))
		{
			return BTNodeStatus.Failure;
		}
		EntityPlayer entityPlayer = player as EntityPlayer;
		if (!entityPlayer.logic.isShooting)
		{
			return BTNodeStatus.Failure;
		}
		entityPlayer.logic.ChangeVelocity(speedRatio);
		return BTNodeStatus.Success;
	}
}
