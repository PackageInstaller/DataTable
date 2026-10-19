namespace ACT.EventTrack;

public class AssistValueChange : TrackBaseEvt<AssistValueChange>
{
	public float valueBefore;

	public float valueAfter;

	public float valueChange;

	public string reason;

	public override void OnDispatch()
	{
	}
}
