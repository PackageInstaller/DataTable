using Bamboo.ECS;

namespace ACT.Battle;

public class EvtTryAssist : BaseEvt
{
	public bool canAssist = true;

	public Entity before;

	public Entity after;

	public override void Reset()
	{
		canAssist = true;
		before = default;
		after = default;
	}
}
