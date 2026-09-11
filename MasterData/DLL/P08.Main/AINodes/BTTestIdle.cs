using BilliardGame.Spell;
using T0World;
using UnityEngine;

namespace AINodes;

public class BTTestIdle : BActionNode
{
	public string sourceName = "Self";

	public override BTNodeStatus Run(BTEnv env)
	{
		GameObject gameObject = env.GetObject<GameObject>(sourceName);
		T0CharacterAgent component = gameObject.GetComponent<T0CharacterAgent>();
		if (component != null)
		{
			if (!component.IsHaveEvent())
			{
				component.EnterInterationState();
			}
		}
		else
		{
			Debug.LogError("No T0CharacterAgent on " + gameObject.name);
		}
		return BTNodeStatus.Success;
	}
}
