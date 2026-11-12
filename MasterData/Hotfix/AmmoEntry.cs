using System;
using TrueSync;

public struct AmmoEntry
{
	private int origin;

	private int baseAmend;

	private FP percentAmend;

	private int absAmend;

	public int Value { get; private set; }

	public int Max { get; private set; }

	public int AmendMax => (int)(long)((origin + baseAmend) * (1 + percentAmend) + absAmend);

	public void SetOrigin(int val)
	{
		origin = val;
		Max = origin;
	}

	public void ChangeValue(HotfixEnum.ammoParameterType subType, FP val)
	{
		int num = (AmmoInfo.useValued ? Max : AmendMax);
		switch (subType)
		{
		case HotfixEnum.ammoParameterType.MAX_BASE_VALUE:
			baseAmend += (int)(long)val;
			break;
		case HotfixEnum.ammoParameterType.MAX_PERCENTAGE:
			percentAmend += val;
			break;
		case HotfixEnum.ammoParameterType.MAX_ABSOLUTE_VALUE:
			absAmend += (int)(long)val;
			break;
		case HotfixEnum.ammoParameterType.SET_MAX_PERCENTAGE_VALUE:
			Max = (int)(long)(Max * val);
			break;
		case HotfixEnum.ammoParameterType.SET_MAX_ABSOLUTE_VALUE:
			Max = (int)(long)val;
			break;
		case HotfixEnum.ammoParameterType.PERCENTAGE:
			Value += (int)(long)(num * val);
			Value = Math.Clamp(Value, 0, num);
			break;
		case HotfixEnum.ammoParameterType.ABSOLUTE_VALUE:
			Value += (int)(long)val;
			Value = Math.Clamp(Value, 0, num);
			break;
		case HotfixEnum.ammoParameterType.SET_PERCENTAGE_VALUE:
			Value = (int)(long)(num * val);
			Value = Math.Clamp(Value, 0, num);
			break;
		case HotfixEnum.ammoParameterType.SET_ABSOLUTE_VALUE:
			Value = (int)(long)val;
			Value = Math.Clamp(Value, 0, num);
			break;
		default:
			throw new ArgumentOutOfRangeException("subType", subType, null);
		}
	}
}
