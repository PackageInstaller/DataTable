using System.Collections.Generic;
using ACT.Game.Data;
using ACT.UI;

namespace ACT.Event;

public class ChangeAllTeamProfile : BaseEventContent
{
	public List<PresetTeam> teamProfiles;

	public int battleIndex;

	public int battleTeamIndex;

	public TeamProfileSource source;
}
