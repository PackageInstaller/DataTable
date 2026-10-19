using ACT.Game.Data;

namespace ACT.EventTrack;

public abstract class RoleEvt<T> : TrackBaseEvt<T> where T : TrackBaseEvt<T>, new()
{
	public Character role;
}
