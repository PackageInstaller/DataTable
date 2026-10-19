using System;

namespace Sirenix.OdinInspector;

public class UnitAttribute : Attribute
{
	public Units Base = Units.Unset;

	public Units Display = Units.Unset;

	public string BaseName;

	public string DisplayName;

	public bool DisplayAsString;

	public bool ForceDisplayUnit;

	public UnitAttribute(Units unit)
	{
		Base = unit;
		Display = unit;
	}

	public UnitAttribute(string unit)
	{
		BaseName = unit;
		DisplayName = unit;
	}

	public UnitAttribute(Units @base, Units display)
	{
		Base = @base;
		Display = display;
	}

	public UnitAttribute(Units @base, string display)
	{
		Base = @base;
		DisplayName = display;
	}

	public UnitAttribute(string @base, Units display)
	{
		BaseName = @base;
		Display = display;
	}

	public UnitAttribute(string @base, string display)
	{
		BaseName = @base;
		DisplayName = display;
	}
}
