using System;
using UnityEngine.Localization;

namespace ACT.World.Asset;

[Serializable]
public class NPCStateInfo : IDataToBake
{
	public int stateId;

	public Pos pos;

	public LocalizedString localizedString;

	public int mapLayer;
}
