using TrueSync;

public class AttributeSetLimitInfo
{
	public bool IsLimited;

	public FDP Lower = FDP.MinValue;

	public FDP Upper = FDP.MaxValue;

	public bool OnlyLimitPlayer;

	public AttributeSetLimitInfo()
	{
	}

	public AttributeSetLimitInfo(bool isLimited, FDP low, FDP up, bool onlyLimitPlayer)
	{
		IsLimited = isLimited;
		Lower = low;
		Upper = up;
		OnlyLimitPlayer = onlyLimitPlayer;
	}
}
