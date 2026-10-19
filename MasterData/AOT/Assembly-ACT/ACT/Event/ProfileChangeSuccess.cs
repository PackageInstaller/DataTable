using ACT.Game.Data;

namespace ACT.Event;

public class ProfileChangeSuccess : BaseEventContent
{
	public PresetTeam teamProfile;

	public bool isBattleTeam;
}
