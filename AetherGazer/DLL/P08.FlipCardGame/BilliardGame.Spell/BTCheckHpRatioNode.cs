using BilliardGame.Runtime;

namespace BilliardGame.Spell;

public class BTCheckHpRatioNode : BActionNode
{
	public float ratio;

	public override BTNodeStatus Run(BTEnv env)
	{
		EntityEnemy entityEnemy = env.GetPlayer<BilliardGameEntityBase>("Caster") as EntityEnemy;
		if ((float)entityEnemy.remainHP / (float)entityEnemy.maxHP < ratio / 100f)
		{
			return BTNodeStatus.Success;
		}
		return BTNodeStatus.Failure;
	}
}
