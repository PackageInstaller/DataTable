using Bamboo.ECS;

namespace ACT.Event;

public class LevelChangeEvt : BaseEventContent
{
	public Entity entity;

	public int beforeLevel;

	public int curretLevel;
}
