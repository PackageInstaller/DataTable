using ACT.World;
using Bamboo.ECS;

namespace ACT.Event;

public class TriggerStateChange : BaseEventContent
{
	public bool enter;

	public ITrigger trigger;

	public Entity entity;
}
