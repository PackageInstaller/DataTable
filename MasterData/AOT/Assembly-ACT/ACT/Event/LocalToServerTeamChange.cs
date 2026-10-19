using ACT.Game.Data;

namespace ACT.Event;

public class LocalToServerTeamChange : BaseEventContent
{
	public PresetTeam LocalTeamProfile;

	public int index;

	public PresetTeam ServerTeamProfile;
}
