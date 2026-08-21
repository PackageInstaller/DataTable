using System.Collections.Generic;
using BilliardGame.Runtime;
using UnityEngine;

namespace BilliardGame.Spell;

public class BTRandomCreateEnemy : BActionNode
{
	public List<int> enemyList;

	public int randomNum;

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
		for (int i = 0; i < randomNum; i++)
		{
			if (enemyList.Count == 0)
			{
				break;
			}
			if (emptySlot.Count == 0)
			{
				break;
			}
			int num = enemyList[Random.Range(0, enemyList.Count)];
			int index = Random.Range(0, emptySlot.Count);
			Vector2 vector = emptySlot[index];
			Vector3 pos = new Vector3(vector.x, vector.y, 0f);
			BilliardGameLogicManager.Instance.LoadEnemyByPath($"BilliardGame/Monster/Monster_{num}", pos, scale);
			emptySlot.RemoveAt(index);
		}
		return BTNodeStatus.Success;
	}
}
