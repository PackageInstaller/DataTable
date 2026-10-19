namespace ACT.EventTrack;

public abstract class TrackInteractBaseEvt<T> : TrackBaseEvt<T> where T : TrackBaseEvt<T>, new()
{
	public int interactId;

	public int stateCurrent;

	public string objectName;

	public int interactType;

	public int worldId;

	public int Roleid;
}
