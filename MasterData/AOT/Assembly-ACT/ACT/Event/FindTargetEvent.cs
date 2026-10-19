using ACT.Battle.Configs;
using Bamboo.ECS;

namespace ACT.Event;

public class FindTargetEvent : BaseEventContent
{
	public Entity owner;

	public BaseFindTargets findTargets;
}
