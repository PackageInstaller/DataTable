using BilliardGame.Runtime;

namespace BilliardGame.Spell;

public class BTAddBuff : BActionNode
{
	public int buffID;

	public int level = 1;

	public bool isConnectParent;

	public override BTNodeStatus Run(BTEnv env)
	{
		BilliardGameEntityBase player = env.GetPlayer<BilliardGameEntityBase>("Caster");
		if (player is EntityPlayer)
		{
			BilliardGameSpellManager.Instance.CastBuff(buffID, player as EntityPlayer, level);
		}
		else if (player is EntityEnemy)
		{
			BilliardGameSpellManager.Instance.CastBuff(buffID, player as EntityEnemy, level);
		}
		if (isConnectParent)
		{
			int parentBuffId = env.GetStruct<int>("BuffId");
			BilliardGameLogicManager.Instance.UpdateBuffConnect(parentBuffId, buffID);
		}
		return BTNodeStatus.Success;
	}
}
