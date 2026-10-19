using ACT.Game.Data;

namespace ACT.EventTrack;

public abstract class WeaponEvt<T> : TrackBaseEvt<T> where T : TrackBaseEvt<T>, new()
{
	public Weapon weapon;

	public int changeWay;
}
