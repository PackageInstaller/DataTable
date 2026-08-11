using System;

namespace Ase;

public static class KnapsackPropDataExtension
{
	public static bool IsKnapsackType(this KnapsackPropData propData)
	{
		return IsKnapsackType(propData.PropTypeEnum);
	}

	public static bool IsKnapsackType(PropTypeEnum propTypeEnum)
	{
		if (propTypeEnum != PropTypeEnum.Prop && propTypeEnum != PropTypeEnum.PropTask && propTypeEnum != PropTypeEnum.GiftPack)
		{
			return propTypeEnum == PropTypeEnum.HeroSkillSkinProp;
		}
		return true;
	}

	public static bool IsKnapsackType(int propType)
	{
		if (Enum.IsDefined(typeof(PropTypeEnum), propType))
		{
			return IsKnapsackType((PropTypeEnum)propType);
		}
		return false;
	}
}
