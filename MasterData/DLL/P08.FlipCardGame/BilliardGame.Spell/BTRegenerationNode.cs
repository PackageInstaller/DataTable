using BilliardGame.Runtime;

namespace BilliardGame.Spell;

public class BTRegenerationNode : BActionNode
{
	public int hp;

	public float hpRatio;

	public CollisionType collisionType;

	public override BTNodeStatus Run(BTEnv env)
	{
		if (collisionType == CollisionType.Other)
		{
			if (!env.ContainKey("TargetEntity"))
			{
				return BTNodeStatus.Failure;
			}
			BilliardGameEntityBase player = env.GetPlayer<BilliardGameEntityBase>("TargetEntity");
			if (player is EntityMechanism)
			{
				(player as EntityMechanism).TakeRegeneration(hp, hpRatio);
			}
			else if (player is EntityPlayer)
			{
				(player as EntityPlayer).TakeRegeneration(hp, hpRatio);
			}
		}
		else
		{
			BilliardGameEntityBase player = env.GetPlayer<BilliardGameEntityBase>("Caster");
			if (player is EntityPlayer)
			{
				(player as EntityPlayer).TakeRegeneration(hp, hpRatio / 100f);
			}
			else if (player is EntityEnemy)
			{
				(player as EntityEnemy).TakeRegeneration(hp);
				(player as EntityEnemy).TakeRegenerationByHpRatio(hpRatio / 100f);
			}
		}
		return BTNodeStatus.Success;
	}
}
