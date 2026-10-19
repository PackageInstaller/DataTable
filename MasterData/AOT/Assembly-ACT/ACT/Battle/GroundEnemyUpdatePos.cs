using System;
using UnityEngine;

namespace ACT.Battle;

[Serializable]
public class GroundEnemyUpdatePos
{
	public float groundMinHoldDis = 2f;

	public float groundMaxHoldDis = 3f;

	public float groundMinUpdateDis = 1f;

	public float groundMaxUpdateDis = 4f;

	[HideInInspector]
	public float groundUpUpdateDis = 3f;

	[HideInInspector]
	public float groundDownUpdateDis = 3f;

	public GroundEnemyUpdatePos(GroundEnemyUpdatePos key)
	{
		groundMinHoldDis = key.groundMinHoldDis;
		groundMaxHoldDis = key.groundMaxHoldDis;
		groundMinUpdateDis = key.groundMinUpdateDis;
		groundMaxUpdateDis = key.groundMaxUpdateDis;
	}

	public GroundEnemyUpdatePos()
	{
	}
}
