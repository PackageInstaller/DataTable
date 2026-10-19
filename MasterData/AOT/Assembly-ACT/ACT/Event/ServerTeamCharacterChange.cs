using System;
using ACT.Game.Data;
using ACT.Model;
using ACT.UI;

namespace ACT.Event;

public class ServerTeamCharacterChange : BaseEventContent
{
	public int index;

	public PresetTeam teamProfile;

	public Action<bool> finishAction;

	public TeamProfileSource source;

	public ProfileChangeType changeType;
}
