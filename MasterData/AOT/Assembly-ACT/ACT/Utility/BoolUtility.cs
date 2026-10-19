using ACT.Battle.Configs;
using Bamboo.ECS;
using UnityEngine;

namespace ACT.Utility;

public static class BoolUtility
{
	public static bool IsBetweenApprox(float a, float b, float c, float tolerance = 0.0001f)
	{
		float num = Mathf.Min(b, c) - tolerance;
		float num2 = Mathf.Max(b, c) + tolerance;
		if (a > num)
		{
			return a < num2;
		}
		return false;
	}

	public static bool IsInFront(bool faceLeft, float self, float target)
	{
		if (target < self == faceLeft)
		{
			return true;
		}
		return false;
	}

	public static bool IsAttackTokenNeedUpdateByNavMesh(Entity entityBehave)
	{
		return entityBehave.GetConfig().MonsterAttackType == MonsterAttackType.melee;
	}
}
