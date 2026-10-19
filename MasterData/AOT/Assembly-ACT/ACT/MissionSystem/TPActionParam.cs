using System;
using ACT.Utility;

namespace ACT.MissionSystem;

[Serializable]
public class TPActionParam
{
	public int chunkId;

	public float positionX;

	public float positionY;

	public float positionZ;

	public TPTYPE tpType = TPTYPE.BlackScreenWithUI;

	public bool openBattleMain = true;
}
