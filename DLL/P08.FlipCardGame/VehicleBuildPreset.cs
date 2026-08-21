using System;
using System.Collections.Generic;
using UnityEngine;

[CreateAssetMenu(menuName = "SummerRace/ModularVehicle/Build Preset", fileName = "VehicleBuildPreset")]
public class VehicleBuildPreset : ScriptableObject
{
	[Serializable]
	public struct Entry
	{
		public string mountId;

		public ModuleDefinition module;
	}

	public string presetName = "Preset";

	public List<Entry> entries = new List<Entry>();
}
