using System;

namespace Unity.VisualScripting;

[AttributeUsage(AttributeTargets.Property | AttributeTargets.Field, AllowMultiple = false, Inherited = false)]
public class PortLabelAttribute : Attribute
{
	public string label { get; private set; }

	public bool hidden { get; set; }

	public PortLabelAttribute(string label)
	{
		this.label = label;
	}
}
