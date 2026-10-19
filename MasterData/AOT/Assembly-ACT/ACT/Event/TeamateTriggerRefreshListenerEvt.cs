using Bamboo.ECS;

namespace ACT.Event;

public class TeamateTriggerRefreshListenerEvt : BaseEventContent
{
	public Entity mainCharacter;

	public override void ReleaseEvt()
	{
		mainCharacter = default;
	}
}
