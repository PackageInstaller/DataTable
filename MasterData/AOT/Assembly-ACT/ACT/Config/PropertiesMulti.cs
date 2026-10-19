using System;

namespace ACT.Config;

[Serializable]
public class PropertiesMulti
{
	public readonly int property;

	public readonly float multi;

	public PropertiesMulti(int property, float multi)
	{
		this.property = property;
		this.multi = multi;
	}
}
