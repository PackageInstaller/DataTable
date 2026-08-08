using BilliardGame.Runtime;

namespace BilliardGame.Spell;

public class BTAddShieldNode : BActionNode
{
	public enum ShieldType
	{
		Self,
		AllEnemy
	}

	public ShieldType type;

	public int shield;

	public override BTNodeStatus Run(BTEnv env)
	{
		if (type == ShieldType.AllEnemy)
		{
			BilliardGameLogicManager.Instance.AddAllEnemyShield(shield);
		}
		else
		{
			BilliardGameEntityBase player = env.GetPlayer<BilliardGameEntityBase>("Caster");
			if (player is EntityPlayer)
			{
				(player as EntityPlayer).TakeShield(shield);
			}
			else if (player is EntityEnemy)
			{
				(player as EntityEnemy).TakeShield(shield);
			}
		}
		return BTNodeStatus.Success;
	}
}
