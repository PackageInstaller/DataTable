using Bamboo.ECS;

namespace ACT.Event;

public class DetectCollisionsChange : BaseEventContent
{
	public bool enable;

	public Entity entity;

	public override void ReleaseEvt()
	{
		entity = default;
	}
}
