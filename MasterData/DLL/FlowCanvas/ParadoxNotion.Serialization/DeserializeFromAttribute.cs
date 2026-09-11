using System;

namespace ParadoxNotion.Serialization;

public class DeserializeFromAttribute : Attribute
{
	public string[] previousTypeNames;

	public DeserializeFromAttribute(params string[] previousTypeNames)
	{
		this.previousTypeNames = previousTypeNames;
	}
}
