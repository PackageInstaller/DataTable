using BilliardGame.Runtime;

namespace BilliardGame.Spell;

public class BTChargedAttack : BActionNode
{
	public int changedNum;

	public int buffID;

	public override BTNodeStatus Run(BTEnv env)
	{
		(env.GetPlayer<BilliardGameEntityBase>("Caster") as EntityEnemy).SetChagedNumAndBuff(changedNum + 1, buffID);
		return BTNodeStatus.Success;
	}
}
