using System;

namespace Unity.VisualScripting;

[AttributeUsage(AttributeTargets.Class, AllowMultiple = false, Inherited = true)]
public sealed class UnitOrderAttribute : Attribute
{
	public int order { get; private set; }

	public UnitOrderAttribute(int order)
	{
		this.order = order;
	}
}
