using Bamboo.ECS;

namespace ACT.Event;

public class CharacterSpecialEnergyConsumeEvt : BaseEventContent
{
	public Entity entity;

	public int characterId;

	public float consumedValue;

	public override void ReleaseEvt()
	{
		base.ReleaseEvt();
		entity = default;
		characterId = 0;
		consumedValue = 0f;
	}
}
