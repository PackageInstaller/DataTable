using ACT.Game.Data;

namespace ACT.EventTrack;

public abstract class ChipEvt<T> : TrackBaseEvt<T> where T : TrackBaseEvt<T>, new()
{
	public Chip chip;

	public int changeWay;
}
