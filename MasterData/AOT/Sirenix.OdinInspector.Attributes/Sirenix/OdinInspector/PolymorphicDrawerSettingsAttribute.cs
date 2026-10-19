using System;

namespace Sirenix.OdinInspector;

[AttributeUsage(AttributeTargets.Property | AttributeTargets.Field)]
public class PolymorphicDrawerSettingsAttribute : Attribute
{
	public bool ReadOnlyIfNotNullReference;

	public string CreateInstanceFunction;

	[Obsolete("Use OnValueChangedAttribute instead.", false)]
	public string OnInstanceAssigned;

	private bool? showBaseType;

	private NonDefaultConstructorPreference? nonDefaultConstructorPreference;

	public bool ShowBaseType
	{
		get
		{
			return showBaseType == true;
		}
		set
		{
			showBaseType = value;
		}
	}

	public NonDefaultConstructorPreference NonDefaultConstructorPreference
	{
		get
		{
			return nonDefaultConstructorPreference ?? NonDefaultConstructorPreference.ConstructIdeal;
		}
		set
		{
			nonDefaultConstructorPreference = value;
		}
	}

	public bool ShowBaseTypeIsSet => showBaseType.HasValue;

	public bool NonDefaultConstructorPreferenceIsSet => nonDefaultConstructorPreference.HasValue;
}
