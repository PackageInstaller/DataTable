namespace ACT.EventTrack;

public class TrackLogoutEvt : TrackBaseEvt<TrackLogoutEvt>
{
	public int logoutType;

	public override bool SkipIfWorldNotStart => false;
}
