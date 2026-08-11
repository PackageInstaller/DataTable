using System;
using System.ComponentModel;

namespace Ase;

public static class EnumExtensions
{
	public static string GetDescription(this Enum val)
	{
		Attribute customAttribute = Attribute.GetCustomAttribute(val.GetType().GetField(val.ToString()), typeof(DescriptionAttribute));
		if (customAttribute != null)
		{
			return ((DescriptionAttribute)customAttribute).Description;
		}
		return val.ToString();
	}
}
