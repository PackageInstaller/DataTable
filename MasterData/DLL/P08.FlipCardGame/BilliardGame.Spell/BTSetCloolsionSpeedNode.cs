using BilliardGame.Runtime;

namespace BilliardGame.Spell;

public class BTSetCloolsionSpeedNode : BActionNode
{
	public enum SpeedType
	{
		ratio,
		num
	}

	public SpeedType type;

	public float speed;

	public CollisionType collisionType;

	public override BTNodeStatus Run(BTEnv env)
	{
		EntityPlayer entityPlayer;
		if (collisionType == CollisionType.Other)
		{
			if (!env.ContainKey("TargetEntity"))
			{
				return BTNodeStatus.Failure;
			}
			BilliardGameEntityBase player = env.GetPlayer<BilliardGameEntityBase>("TargetEntity");
			if (!(player is EntityPlayer))
			{
				return BTNodeStatus.Failure;
			}
			entityPlayer = player as EntityPlayer;
		}
		else
		{
			BilliardGameEntityBase player2 = env.GetPlayer<BilliardGameEntityBase>("Caster");
			if (!(player2 is EntityPlayer))
			{
				return BTNodeStatus.Failure;
			}
			entityPlayer = player2 as EntityPlayer;
		}
		if (type == SpeedType.ratio)
		{
			entityPlayer.logic.ChangeVelocity(speed);
		}
		else
		{
			entityPlayer.logic.ChangeVelocityNum(speed);
		}
		return BTNodeStatus.Success;
	}
}
