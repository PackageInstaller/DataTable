using BilliardGame.Runtime;

namespace BilliardGame.Spell;

public class BTAddBuffToPenetrate : BActionNode
{
	public int buffID;

	public EntityType type;

	public override BTNodeStatus Run(BTEnv env)
	{
		if (env.ContainKey("TargetEntity"))
		{
			if (env.Remove("TargetEntity", out var value) && value != null)
			{
				if (type == EntityType.Player && value is EntityPlayer)
				{
					EntityPlayer caster = value as EntityPlayer;
					BilliardGameSpellManager.Instance.CastBuff(buffID, caster);
				}
				else if (type == EntityType.Enemy && value is EntityEnemy)
				{
					EntityEnemy caster2 = value as EntityEnemy;
					BilliardGameSpellManager.Instance.CastBuff(buffID, caster2);
				}
			}
			return BTNodeStatus.Success;
		}
		return BTNodeStatus.Failure;
	}
}
