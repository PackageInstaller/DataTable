using System;
using BilliardGame.Runtime;
using UnityEngine;

namespace BilliardGame.EditorPreview;

[Serializable]
public class BilliardGameEntityPreview : MonoBehaviour
{
	public string entityPath;

	public BilliardEntityType type;

	public BilliardTurnType turnType = BilliardTurnType.None;

	public int turnIndex = 1;

	public int waveIndex = 1;

	public int wave = 1;

	public int stageEntityId = 1;

	public bool hideWhenMagnify;

	private bool isMonster => type == BilliardEntityType.Monster;

	private bool isMechanism => type == BilliardEntityType.Mechanism;

	private bool isShowTurn
	{
		get
		{
			if (isMonster)
			{
				if (turnType != BilliardTurnType.FixedTurn)
				{
					return turnType == BilliardTurnType.AfterPreTurn;
				}
				return true;
			}
			return false;
		}
	}

	private bool isShowWave
	{
		get
		{
			if (isMonster)
			{
				return turnType == BilliardTurnType.AfterPreTurn;
			}
			return false;
		}
	}
}
