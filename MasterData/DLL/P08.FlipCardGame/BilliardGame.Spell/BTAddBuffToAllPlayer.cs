using BilliardGame.Runtime;

namespace BilliardGame.Spell;

public class BTAddBuffToAllPlayer : BActionNode
{
	public int buffID;

	public override BTNodeStatus Run(BTEnv env)
	{
		BilliardGameLogicManager.Instance.CastAllPlayerBuff(buffID);
		return BTNodeStatus.Success;
	}
}
