public class FixedAdjustDistanceData : BaseAdjustDistanceData
{
	public float DistanceValue;

	public DistanceValueLimit DistanceLimit;

	public bool ComputerTargetDistance(float currentDistance)
	{
		if (DistanceLimit == DistanceValueLimit.MaxLimit && DistanceValue > currentDistance)
		{
			return false;
		}
		if (DistanceLimit == DistanceValueLimit.MinLimit && DistanceValue < currentDistance)
		{
			return false;
		}
		Distance = DistanceValue;
		return true;
	}

	public override void Clear()
	{
		base.Clear();
		DistanceValue = 0f;
	}
}
