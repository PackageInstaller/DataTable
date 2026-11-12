using System;
using TrueSync;

public sealed class SpecialAttributeList : ICloneable
{
	public delegate void ValueChangedHandle(HotfixEnum.specialAttributeType attributeType, HotfixEnum.parameterType parameterType, FDP old, FDP current);

	private readonly SpecialAttributeEntry[] entries = new SpecialAttributeEntry[5];

	public event ValueChangedHandle ValueChangedEvent;

	public SpecialAttributeList()
	{
		SetAttributeMaxType(HotfixEnum.specialAttributeType.HP, HotfixEnum.effectAttributeType.MAXHP);
		SetAttributeMaxType(HotfixEnum.specialAttributeType.TOUGHNESS_V, HotfixEnum.effectAttributeType.TOUGHNESS_MAX);
		SetAttributeMaxType(HotfixEnum.specialAttributeType.SHIELD_V, HotfixEnum.effectAttributeType.SHIELD_MAX);
		SetAttributeMaxType(HotfixEnum.specialAttributeType.ENERGY, HotfixEnum.effectAttributeType.ENERGY_MAX);
	}

	public FDP GetAttributeValue(HotfixEnum.specialAttributeType type)
	{
		if (type == HotfixEnum.specialAttributeType.NONE || type == HotfixEnum.specialAttributeType.MAX)
		{
			return FDP.Zero;
		}
		return entries[(int)type].Value;
	}

	private void SetAttributeMaxType(HotfixEnum.specialAttributeType type, HotfixEnum.effectAttributeType type1)
	{
		if (type != HotfixEnum.specialAttributeType.NONE && type != HotfixEnum.specialAttributeType.MAX)
		{
			entries[(int)type].SetMaxType(type1);
		}
	}

	public void SetAttributeValue(AttributeList attributeList, HotfixEnum.specialAttributeType type, HotfixEnum.parameterType subType, FDP value)
	{
		if (type != HotfixEnum.specialAttributeType.NONE && type != HotfixEnum.specialAttributeType.MAX)
		{
			ref SpecialAttributeEntry reference = ref entries[(int)type];
			FDP value2 = reference.Value;
			reference.SetValue(attributeList, subType, value);
			ValueChangedEvent?.Invoke(type, subType, value2, reference.Value);
		}
	}

	public object Clone()
	{
		return MemberwiseClone();
	}
}
