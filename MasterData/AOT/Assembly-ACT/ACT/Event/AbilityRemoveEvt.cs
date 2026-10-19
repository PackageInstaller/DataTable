using Bamboo.ECS;

namespace ACT.Event;

public class AbilityRemoveEvt : BaseEventContent
{
	public int characterId;

	public string abilityName;

	public Entity curOwner;

	public Entity originalOwner;

	public override void ReleaseEvt()
	{
		base.ReleaseEvt();
		curOwner = default;
		originalOwner = default;
		characterId = 0;
		abilityName = string.Empty;
	}
}
