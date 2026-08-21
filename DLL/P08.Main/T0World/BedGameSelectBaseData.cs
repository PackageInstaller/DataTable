using System;

namespace T0World;

[Serializable]
public abstract class BedGameSelectBaseData
{
	public int selectID;

	public virtual BedSelectEnum selectType => BedSelectEnum.none;
}
