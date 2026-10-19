using System;

namespace Unity.VisualScripting;

[AttributeUsage(AttributeTargets.Class, AllowMultiple = false, Inherited = false)]
public sealed class UnitSurtitleAttribute : Attribute
{
	public string surtitle { get; private set; }

	public UnitSurtitleAttribute(string surtitle)
	{
		this.surtitle = surtitle;
	}
}
