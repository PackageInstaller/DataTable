namespace ACT.EventTrack;

public class PlayerLevelUpEvt : TrackBaseEvt<PlayerLevelUpEvt>
{
	public int levelBefore;

	public int levelAfter;
}
