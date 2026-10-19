using System;

namespace UnityEngine.Localization.PropertyVariants.TrackedProperties;

[Serializable]
public class BoolTrackedProperty : TrackedProperty<bool>
{
	protected override bool ConvertFromString(string value)
	{
		if (int.TryParse(value, out var result))
		{
			return (bool)Convert.ChangeType(result, typeof(bool));
		}
		return base.ConvertFromString(value);
	}

	protected override string ConvertToString(bool value)
	{
		if (!value)
		{
			return "0";
		}
		return "1";
	}
}
