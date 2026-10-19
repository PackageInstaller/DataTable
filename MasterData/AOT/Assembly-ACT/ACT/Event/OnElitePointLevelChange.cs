using ACT.Game.Data;

namespace ACT.Event;

public class OnElitePointLevelChange : BaseEventContent
{
	public Character character;

	public int elitePointId;

	public int addLevel;

	public override void ReleaseEvt()
	{
		character = null;
		elitePointId = 0;
		addLevel = 0;
	}
}
