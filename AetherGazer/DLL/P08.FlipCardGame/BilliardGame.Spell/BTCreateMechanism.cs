using System.Collections.Generic;
using BilliardGame.Runtime;
using UnityEngine;

namespace BilliardGame.Spell;

public class BTCreateMechanism : BActionNode
{
	public string mechanismName;

	public int mechanismNum = 1;

	public Vector3 scale = Vector3.one;

	public float minX;

	public float maxX;

	public float minY;

	public float maxY;

	public override BTNodeStatus Run(BTEnv env)
	{
		List<Vector2> emptySlot = BilliardGameLogicManager.Instance.GetEmptySlot(minX, maxX, minY, maxY);
		if (emptySlot.Count == 0)
		{
			return BTNodeStatus.Failure;
		}
		for (int i = 0; i < mechanismNum; i++)
		{
			if (emptySlot.Count == 0)
			{
				break;
			}
			int index = Random.Range(0, emptySlot.Count);
			Vector2 vector = emptySlot[index];
			Vector3 pos = new Vector3(vector.x, vector.y, 0f);
			BilliardGameLogicManager.Instance.LoadMechanismByPath("BilliardGame/Mec/" + mechanismName, pos, scale);
			emptySlot.RemoveAt(index);
		}
		return BTNodeStatus.Success;
	}
}
