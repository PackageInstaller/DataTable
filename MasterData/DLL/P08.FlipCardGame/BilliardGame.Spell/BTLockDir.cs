using BilliardGame.Runtime;

namespace BilliardGame.Spell;

public class BTLockDir : BActionNode
{
	public int buffID;

	public int bulletNum = 1;

	public int angle = 30;

	public string name;

	public override BTNodeStatus Run(BTEnv env)
	{
		EntityEnemy entityEnemy = env.GetPlayer<BilliardGameEntityBase>("Caster") as EntityEnemy;
		BilliardGameSpellManager.Instance.CastBuff(buffID, entityEnemy);
		entityEnemy.logic.ShowPredictZone();
		return BTNodeStatus.Success;
	}
}
