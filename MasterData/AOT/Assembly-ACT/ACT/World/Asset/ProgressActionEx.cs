using System;
using UnityEngine;

namespace ACT.World.Asset;

[Serializable]
public class ProgressActionEx : IDataToBake
{
	public float progress;

	[SerializeReference]
	public DoActionBases doAction = new DoActionBases();
}
