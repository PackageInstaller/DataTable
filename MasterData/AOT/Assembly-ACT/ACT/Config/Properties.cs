using System;

namespace ACT.Config;

[Serializable]
public class Properties
{
	public readonly int property;

	public readonly float value;

	public Properties(int property, float value)
	{
		this.property = property;
		this.value = value;
	}
}
