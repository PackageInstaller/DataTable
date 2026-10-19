using Bamboo.ECS;

namespace ACT.Event;

public class HatredEntity : BaseEventContent
{
	public Entity entity;

	public override void ReleaseEvt()
	{
		entity = Entity.Invalid;
	}
}
