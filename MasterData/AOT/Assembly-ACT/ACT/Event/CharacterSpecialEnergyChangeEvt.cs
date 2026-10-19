using Bamboo.ECS;

namespace ACT.Event;

public class CharacterSpecialEnergyChangeEvt : BaseEventContent
{
	public Entity entity;

	public int characterId;

	public float value;

	public float percent;

	public float min;

	public float max;

	public override void ReleaseEvt()
	{
		base.ReleaseEvt();
		entity = default;
		characterId = 0;
		value = 0f;
		percent = 0f;
		min = 0f;
		max = 0f;
	}
}
