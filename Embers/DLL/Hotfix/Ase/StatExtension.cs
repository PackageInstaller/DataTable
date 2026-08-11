using System;
using System.ComponentModel;

namespace Ase;

public static class StatExtension
{
	public static string GetStatDescription(this Enum val)
	{
		Attribute customAttribute = Attribute.GetCustomAttribute(val.GetType().GetField(val.ToString()), typeof(DescriptionAttribute));
		if (customAttribute != null)
		{
			return ((DescriptionAttribute)customAttribute).Description;
		}
		return val.ToString();
	}
}
