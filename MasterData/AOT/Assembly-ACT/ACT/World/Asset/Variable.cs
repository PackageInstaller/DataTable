using System;

namespace ACT.World.Asset;

[Serializable]
public class Variable
{
	public string name;

	public object value;

	public Variable(string name, object value)
	{
		this.name = name;
		this.value = value;
	}
}
