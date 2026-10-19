using ACT.Game.Data;

namespace ACT.EventTrack;

public abstract class ItemEvt<T> : TrackBaseEvt<T> where T : TrackBaseEvt<T>, new()
{
	public Item item;

	public int changeWay;

	public int changeNum;
}
