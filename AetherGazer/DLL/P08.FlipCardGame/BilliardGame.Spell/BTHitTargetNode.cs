using BilliardGame.Runtime;

namespace BilliardGame.Spell;

public class BTHitTargetNode : BActionNode
{
	public EntityType battleType;

	public int damage;

	public override BTNodeStatus Run(BTEnv env)
	{
		if (env.ContainKey("damage"))
		{
			damage += env.GetStruct<int>("damage");
		}
		if (env.ContainKey("TargetEntity"))
		{
			if (battleType == EntityType.Enemy)
			{
				if (env.GetPlayer<BilliardGameEntityBase>("TargetEntity") is EntityEnemy entityEnemy)
				{
					entityEnemy.TakeDamage(damage);
					return BTNodeStatus.Success;
				}
				return BTNodeStatus.Failure;
			}
			if (env.GetPlayer<BilliardGameEntityBase>("TargetEntity") is EntityPlayer entityPlayer)
			{
				entityPlayer.TakeDamage(damage);
				return BTNodeStatus.Success;
			}
			return BTNodeStatus.Failure;
		}
		return BTNodeStatus.Failure;
	}
}
