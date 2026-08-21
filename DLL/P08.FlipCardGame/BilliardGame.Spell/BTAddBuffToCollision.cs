using BilliardGame.Runtime;

namespace BilliardGame.Spell;

public class BTAddBuffToCollision : BActionNode
{
	public int buffID;

	public int level;

	public EntityType type;

	public override BTNodeStatus Run(BTEnv env)
	{
		if (env.ContainKey("TargetEntity"))
		{
			if (env.GetPlayer<BilliardGameEntityBase>("TargetEntity") is EntityMechanism)
			{
				return BTNodeStatus.Failure;
			}
			if (type == EntityType.Player)
			{
				if (env.GetPlayer<BilliardGameEntityBase>("TargetEntity") is EntityPlayer caster)
				{
					BilliardGameSpellManager.Instance.CastBuff(buffID, caster, level);
				}
			}
			else if (env.GetPlayer<BilliardGameEntityBase>("TargetEntity") is EntityEnemy caster2)
			{
				BilliardGameSpellManager.Instance.CastBuff(buffID, caster2, level);
			}
			return BTNodeStatus.Success;
		}
		return BTNodeStatus.Failure;
	}
}
