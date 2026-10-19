using System;
using System.Collections.Generic;
using ACT.Core;
using UnityEngine;

namespace ACT.World.Asset;

[Serializable]
public class RoomData : IDataToBake
{
	[HideInInspector]
	public RoomNameData roomNameData;

	public EnvironmentElementData environmentElementData;

	public Bounds bounds;

	public ElementBitmask GetEnvironmentElement()
	{
		return environmentElementData.element;
	}

	public EnvironmentElementIntensity GetEnvironmentElementIntensity()
	{
		return environmentElementData.intensity;
	}

	public void GetAbilityNames(out List<string> abilityNames)
	{
		abilityNames = environmentElementData.abilityNames;
	}

	public void Bake(object baker)
	{
	}

	public IDataToBake Clone()
	{
		return new RoomData
		{
			roomNameData = roomNameData,
			environmentElementData = environmentElementData,
			bounds = bounds
		};
	}
}
