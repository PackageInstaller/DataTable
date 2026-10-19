using Bamboo.ECS;

namespace ACT.Event;

public class CharacterAssistActiveChangeEvt : BaseEventContent
{
	public Entity entity;

	public bool active;

	public override void ReleaseEvt()
	{
		base.ReleaseEvt();
		active = true;
	}
}
