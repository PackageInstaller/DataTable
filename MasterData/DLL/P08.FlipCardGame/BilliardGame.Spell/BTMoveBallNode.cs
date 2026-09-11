using BilliardGame.Runtime;

namespace BilliardGame.Spell;

public class BTMoveBallNode : BActionNode
{
	public float force = 5f;

	public override BTNodeStatus Run(BTEnv env)
	{
		if (env.ContainKey("TargetEntity"))
		{
			BilliardGameEntityBase player = env.GetPlayer<BilliardGameEntityBase>("TargetEntity");
			if (!(player is EntityPlayer))
			{
				return BTNodeStatus.Failure;
			}
			EntityPlayer entityPlayer = player as EntityPlayer;
			if (env.ContainKey("Caster"))
			{
				BilliardGameEntityBase player2 = env.GetPlayer<BilliardGameEntityBase>("Caster");
				entityPlayer.logic.DoMove((entityPlayer.position - player2.position).normalized, force);
				return BTNodeStatus.Success;
			}
			return BTNodeStatus.Failure;
		}
		return BTNodeStatus.Failure;
	}
}
