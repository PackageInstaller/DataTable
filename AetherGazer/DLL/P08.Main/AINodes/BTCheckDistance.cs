using System.Collections.Generic;
using BilliardGame.Spell;
using UnityEngine;

namespace AINodes;

public class BTCheckDistance : BTCheckerNode
{
	public string sourceName = "Self";

	public string targetName = "Target";

	public float threashold = 5f;

	public override bool CheckWillExecute(BTEnv env)
	{
		Transform transform = env.GetObject<Transform>(targetName);
		if (Vector3.Distance(b: env.GetObject<GameObject>(sourceName).transform.position, a: transform.position) < threashold)
		{
			return false;
		}
		return true;
	}

	public override IEnumerable<string> RequiredParams()
	{
		yield return sourceName;
		yield return targetName;
	}
}
