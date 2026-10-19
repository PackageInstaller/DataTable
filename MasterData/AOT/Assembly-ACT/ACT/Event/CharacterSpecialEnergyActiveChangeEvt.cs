using Bamboo.ECS;

namespace ACT.Event;

public class CharacterSpecialEnergyActiveChangeEvt : BaseEventContent
{
	public Entity entity;

	public bool active;

	public override void ReleaseEvt()
	{
		base.ReleaseEvt();
		active = true;
	}
}
