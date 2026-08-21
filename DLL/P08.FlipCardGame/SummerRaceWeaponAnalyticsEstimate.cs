using System;
using UnityEngine;

[Serializable]
public readonly struct SummerRaceWeaponAnalyticsEstimate(float estimatedDps, float recoilLoad)
{
	public readonly float EstimatedDps = Mathf.Max(0f, estimatedDps);

	public readonly float RecoilLoad = Mathf.Max(0f, recoilLoad);
}
