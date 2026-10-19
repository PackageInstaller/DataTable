using System;
using UnityEngine;

namespace ACT.World.Asset;

[Serializable]
public class ProgressAction : IDataToBake
{
	public float progress;

	[SerializeReference]
	public DoActionBases doAction = new DoActionBases();
}
