namespace ACT.EventTrack;

public class TrackCreateEvt : TrackBaseEvt<TrackCreateEvt>
{
	public string createData;

	public override bool SkipIfWorldNotStart => false;
}
