using System;
using UnityEngine;

namespace ACT.World.Asset;

[Serializable]
public class AnimEventInfoEx : IDataToBake
{
	[HideInInspector]
	public string routeName;

	[HideInInspector]
	public string endFallName;

	[HideInInspector]
	public string endEscapeName;

	[SerializeReference]
	public MachineEvent tarEvent = new MachineEvent();
}
