using System;
using TrueSync;

public struct SpecialAttributeEntry : ICloneable
{
	private FDP current;

	private HotfixEnum.effectAttributeType max_type;

	public FDP Value => current;

	public void SetMaxType(HotfixEnum.effectAttributeType type)
	{
		max_type = type;
	}

	public void SetValue(AttributeList attributeList, HotfixEnum.parameterType subType, FDP value)
	{
		HotfixEnum.effectAttributeType effectAttributeType = max_type;
		if (effectAttributeType != HotfixEnum.effectAttributeType.NONE && effectAttributeType != HotfixEnum.effectAttributeType.MAX)
		{
			FDP attributeValue = attributeList.GetAttributeValue(max_type);
			switch (subType)
			{
			case HotfixEnum.parameterType.BASE_VALUE:
				current = value;
				break;
			case HotfixEnum.parameterType.PERCENTAGE:
				current += attributeValue * value;
				break;
			case HotfixEnum.parameterType.ABSOLUTE_VALUE:
				current += value;
				break;
			default:
				throw new ArgumentOutOfRangeException("subType", subType, null);
			}
			current = FDP.Clamp(current, FDP.Zero, attributeValue);
		}
	}

	public object Clone()
	{
		return MemberwiseClone();
	}
}
