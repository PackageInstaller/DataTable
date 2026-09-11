using BilliardGame.Runtime;

namespace BilliardGame.Spell;

public class BTDeleteBuff : BActionNode
{
	public enum EntityType
	{
		Player,
		Enemy
	}

	public int buffID;

	public EntityType type;

	public override BTNodeStatus Run(BTEnv env)
	{
		if (type == EntityType.Player)
		{
			(env.GetPlayer<BilliardGameEntityBase>("Caster") as EntityPlayer).GetBuff(buffID)?.Dispose();
		}
		else
		{
			env.GetPlayer<BilliardGameEntityBase>("Caster");
		}
		return BTNodeStatus.Success;
	}
}
