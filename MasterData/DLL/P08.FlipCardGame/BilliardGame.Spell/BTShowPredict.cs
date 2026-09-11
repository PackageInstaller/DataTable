using BilliardGame.Runtime;

namespace BilliardGame.Spell;

public class BTShowPredict : BActionNode
{
	public float radius;

	public override BTNodeStatus Run(BTEnv env)
	{
		(env.GetPlayer<BilliardGameEntityBase>("Caster") as EntityEnemy).logic.ShowCirclePredictZone(radius);
		return BTNodeStatus.Success;
	}
}
