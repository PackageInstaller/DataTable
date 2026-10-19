using System;
using UnityEngine;

namespace ACT.World.Asset;

[Serializable]
public class AnimEventInfo : IDataToBake
{
	[HideInInspector]
	public string normalName;

	[HideInInspector]
	public string failName;

	[SerializeReference]
	public MachineEvent tarEvent = new MachineEvent();
}
