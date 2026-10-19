using System;
using System.Collections.Generic;

namespace ACT.UI;

[Serializable]
public class PropertyKeyframes
{
	public string PropertyName;

	public List<KeyframeData> Keyframes;

	public PropertyKeyframes(string propertyName)
	{
		PropertyName = propertyName;
		Keyframes = new List<KeyframeData>();
	}
}
