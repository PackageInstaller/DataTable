using System;
using System.Collections.Generic;
using System.Linq;
using ACT.Core;

namespace ACT.World.Asset;

[Serializable]
public class EnvironmentElementData
{
	public ElementBitmask element;

	public EnvironmentElementIntensity intensity;

	public List<string> abilityNames = new List<string> { "eni_test_buff" };

	public EnvironmentElementData()
	{
	}

	public EnvironmentElementData(EnvironmentElementData otherData)
	{
		element = otherData.element;
		intensity = otherData.intensity;
		abilityNames = new List<string>(otherData.abilityNames);
	}

	protected bool Equals(EnvironmentElementData other)
	{
		if (element == other.element && intensity == other.intensity)
		{
			return abilityNames.SequenceEqual(other.abilityNames);
		}
		return false;
	}

	public override bool Equals(object obj)
	{
		if (obj == null)
		{
			return false;
		}
		if (this == obj)
		{
			return true;
		}
		if (obj.GetType() != GetType())
		{
			return false;
		}
		return Equals((EnvironmentElementData)obj);
	}

	public override int GetHashCode()
	{
		return HashCode.Combine((int)element, (int)intensity, abilityNames);
	}

	public bool HasElement()
	{
		return element != ElementBitmask.None;
	}

	public List<string> GetAbilityNames()
	{
		return new List<string>(abilityNames);
	}
}
