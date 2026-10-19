using Bamboo.ECS;

namespace ACT.Event;

public class AbilityDurationChangeEvt : BaseEventContent
{
	public int characterId;

	public string abilityName;

	public float curDuration;

	public float maxDuration;

	public Entity entity;

	public float DurationPercent => curDuration / maxDuration;

	public override void ReleaseEvt()
	{
		base.ReleaseEvt();
		characterId = 0;
		abilityName = string.Empty;
		curDuration = 0f;
		maxDuration = 0f;
	}
}
