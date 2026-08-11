using UnityEngine;

public class RateAdjustDistanceData : BaseAdjustDistanceData
{
	public ChangeValueType ChangeType;

	public float ChangeValue;

	public float ChangeRateValue;

	public float ComputerTargetDistance(float minLimit, float maxLimit, float currentValue, float defaultValue)
	{
		float num = 0f;
		num = ((ChangeType != ChangeValueType.Rate) ? (currentValue + ChangeValue) : (currentValue + ChangeRateValue * (currentValue / defaultValue)));
		return Distance = Mathf.Clamp(num, minLimit, maxLimit);
	}

	public override void Clear()
	{
		base.Clear();
		ChangeRateValue = 0f;
		ChangeValue = 0f;
	}
}
