using System;
using System.Collections.Generic;

namespace T0World;

[Serializable]
public class BedGamePropSelectData : BedGameSelectBaseData
{
	public BedPropEnum propType = BedPropEnum.none;

	public int unlockLikeValue;

	public List<BedInteractPosGameData> interactPosDataList = new List<BedInteractPosGameData>();

	public override BedSelectEnum selectType => BedSelectEnum.prop;
}
