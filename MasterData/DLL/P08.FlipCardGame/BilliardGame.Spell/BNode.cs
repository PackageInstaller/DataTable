using System;
using System.Collections.Generic;
using System.Linq;
using UnityEngine;

namespace BilliardGame.Spell;

[Serializable]
public abstract class BNode
{
	[SerializeField]
	public int parentIdx;

	[SerializeField]
	public int nodeIdx;

	public virtual void OnEnd(BTEnv env)
	{
	}

	public virtual void OnBehaviorRestart(BTEnv env)
	{
	}

	public static bool CheckRequiredParamsFromEnv(BTEnv env, params string[] names)
	{
		return CheckRequiredParamsFromEnv(env, names.AsEnumerable());
	}

	public static bool CheckRequiredParamsFromEnv(BTEnv env, IEnumerable<string> names)
	{
		return names?.All((string name) => env.ContainKey(name)) ?? true;
	}
}
