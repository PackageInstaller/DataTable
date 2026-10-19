using Bamboo.ECS;

namespace ACT.Event;

public class AbilityAddEvt : BaseEventContent
{
	public Entity eb;

	public string abilityName;

	public int curStack;

	public int minStack;

	public int maxStack;

	public override void ReleaseEvt()
	{
		base.ReleaseEvt();
		eb = default;
		abilityName = string.Empty;
		curStack = 0;
		minStack = 0;
		maxStack = 0;
	}
}
