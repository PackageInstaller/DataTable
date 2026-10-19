using System;
using UnityEngine;

namespace ACT.Battle.Configs;

public class RandomComparer : TargetResultComparer
{
	private System.Random random;

	private RandomComparer()
	{
		random = new System.Random();
	}

	public override int Compare(FindTargetResult x, FindTargetResult y)
	{
		return UnityEngine.Random.Range(-1, 2);
	}
}
