using Bamboo.ECS;

namespace ACT.Event;

public class RemoveCharacterBattlePartEvt : BaseEventContent
{
	public Entity entityBehave;

	public override void ReleaseEvt()
	{
		entityBehave = default;
	}
}
