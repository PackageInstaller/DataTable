using BilliardGame.Spell;
using UnityEngine;

namespace AINodes;

public class BTSetEnvTimer : BActionNode
{
	public string field;

	public float Now()
	{
		return Time.time;
	}

	public override BTNodeStatus Run(BTEnv env)
	{
		env.AddStruct(field, Now());
		return BTNodeStatus.Success;
	}
}
