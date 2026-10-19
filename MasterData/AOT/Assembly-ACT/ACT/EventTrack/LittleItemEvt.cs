using ACT.Config;

namespace ACT.EventTrack;

public abstract class LittleItemEvt<T> : TrackBaseEvt<T> where T : LittleItemEvt<T>, new()
{
	public ItemSmallData itemSmallData;
}
