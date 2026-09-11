using System.Collections.Generic;
using BilliardGame.Runtime;

namespace BilliardGame.Spell;

public class BTCheckCircleEntityNode : BActionNode
{
	public float radius;

	public override BTNodeStatus Run(BTEnv env)
	{
		List<EntityPlayer> tempPlayerList = QueryCache.TempPlayerList;
		BilliardGameLogicManager.Instance.GetCirclePlayer(env.GetPlayer<BilliardGameEntityBase>("Caster").position, radius, tempPlayerList);
		if (tempPlayerList.Count > 0)
		{
			return BTNodeStatus.Success;
		}
		return BTNodeStatus.Failure;
	}
}
