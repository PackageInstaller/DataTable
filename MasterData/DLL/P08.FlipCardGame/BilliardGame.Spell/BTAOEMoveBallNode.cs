using System.Collections.Generic;
using BilliardGame.Runtime;
using UnityEngine;

namespace BilliardGame.Spell;

public class BTAOEMoveBallNode : BActionNode
{
	public float radius;

	public float force;

	public override BTNodeStatus Run(BTEnv env)
	{
		Vector3 position = env.GetPlayer<BilliardGameEntityBase>("Caster").position;
		List<EntityPlayer> tempPlayerList = QueryCache.TempPlayerList;
		BilliardGameLogicManager.Instance.GetCirclePlayer(position, radius, tempPlayerList);
		for (int i = 0; i < tempPlayerList.Count; i++)
		{
			tempPlayerList[i].logic.DoMove((tempPlayerList[i].position - position).normalized, force);
		}
		return BTNodeStatus.Success;
	}
}
