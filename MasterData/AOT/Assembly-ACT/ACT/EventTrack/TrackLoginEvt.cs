namespace ACT.EventTrack;

public class TrackLoginEvt : TrackBaseEvt<TrackLoginEvt>
{
	public override bool SkipIfWorldNotStart => false;
}
