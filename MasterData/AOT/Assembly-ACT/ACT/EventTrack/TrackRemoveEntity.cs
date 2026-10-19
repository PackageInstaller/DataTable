namespace ACT.EventTrack;

public class TrackRemoveEntity : TrackBaseEvt<TrackRemoveEntity>
{
	public override bool SkipIfWorldNotStart => false;
}
