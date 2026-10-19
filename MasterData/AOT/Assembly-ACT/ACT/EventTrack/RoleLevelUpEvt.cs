namespace ACT.EventTrack;

public class RoleLevelUpEvt : RoleEvt<RoleLevelUpEvt>
{
	public string levelUpReason;

	public int levelBefore;

	public int levelAfter;
}
