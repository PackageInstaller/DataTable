using System;

namespace T0World;

[Serializable]
public class BedGameHandleSelectData : BedGameSelectBaseData
{
	public BedHandleEnum handleType = BedHandleEnum.none;

	public override BedSelectEnum selectType => BedSelectEnum.handle;
}
