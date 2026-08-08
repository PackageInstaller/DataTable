using BilliardGame.Runtime;

namespace BilliardGame.Spell;

public class BTLockPlayer : BActionNode
{
	public int buffID;

	public string name;

	public override BTNodeStatus Run(BTEnv env)
	{
		EntityEnemy entityEnemy = env.GetPlayer<BilliardGameEntityBase>("Caster") as EntityEnemy;
		BTEnv bTEnv = BilliardGameSpellManager.Instance.CastBuff(buffID, entityEnemy);
		EntityPlayer nearestPlayer = BilliardGameLogicManager.Instance.GetNearestPlayer(entityEnemy.position);
		if (nearestPlayer != null)
		{
			bTEnv.AddPlayer("TargetEntity", (BilliardGameEntityBase)nearestPlayer, false);
		}
		if (nearestPlayer != null && name != null && name != "")
		{
			BilliardGameLogicManager.Instance.MakeEffectWorld(name, nearestPlayer.position, 1f);
		}
		return BTNodeStatus.Success;
	}
}
