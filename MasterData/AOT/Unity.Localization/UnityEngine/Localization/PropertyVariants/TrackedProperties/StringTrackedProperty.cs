using System;

namespace UnityEngine.Localization.PropertyVariants.TrackedProperties;

[Serializable]
public class StringTrackedProperty : TrackedProperty<string>
{
	protected override string ConvertFromString(string value)
	{
		return value;
	}

	protected override string ConvertToString(string value)
	{
		return value;
	}
}
