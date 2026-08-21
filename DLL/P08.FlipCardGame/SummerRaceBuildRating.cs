using System;
using UnityEngine;

[Serializable]
public struct SummerRaceBuildRating
{
	public float Mobility;

	public float Stability;

	public float Firepower;

	public float Overall;

	public string ToShortLabel()
	{
		return "O" + Mathf.RoundToInt(Overall) + " M" + Mathf.RoundToInt(Mobility) + " S" + Mathf.RoundToInt(Stability) + " F" + Mathf.RoundToInt(Firepower);
	}
}
