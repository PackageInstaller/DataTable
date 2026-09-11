using BilliardGame.Runtime;

namespace BilliardGame.Spell;

public class BTExtraATKNode : BActionNode
{
	public int extraAtk;

	public override BTNodeStatus Run(BTEnv env)
	{
		BilliardGameEntityBase player = env.GetPlayer<BilliardGameEntityBase>("Caster");
		if (extraAtk != 0 && player is EntityEnemy)
		{
			env.AddStruct("extra_damage", extraAtk);
			(player as EntityEnemy).CheckExtraDamageBuff();
		}
		return BTNodeStatus.Success;
	}
}
