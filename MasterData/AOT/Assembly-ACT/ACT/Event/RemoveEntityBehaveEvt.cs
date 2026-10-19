using Bamboo.ECS;

namespace ACT.Event;

public class RemoveEntityBehaveEvt : BaseEventContent
{
	public Entity entityBehave;

	public override void ReleaseEvt()
	{
		entityBehave = default;
	}
}
