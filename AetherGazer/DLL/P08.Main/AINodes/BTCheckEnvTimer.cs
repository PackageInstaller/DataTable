using System.Collections.Generic;
using BilliardGame.Spell;
using UnityEngine;

namespace AINodes;

public class BTCheckEnvTimer : BTCheckerNode
{
	public string field;

	public bool autoStartTimer;

	public float threashold = 5f;

	public float Now()
	{
		return Time.time;
	}

	public override bool CheckWillExecute(BTEnv env)
	{
		float num = Now();
		if (env.ContainKey(field))
		{
			return num - env.GetStruct<float>(field) > threashold;
		}
		if (autoStartTimer)
		{
			env.AddStruct(field, num);
			return threashold <= 0f;
		}
		return false;
	}

	public override IEnumerable<string> RequiredParams()
	{
		if (!autoStartTimer)
		{
			yield return field;
		}
	}
}
