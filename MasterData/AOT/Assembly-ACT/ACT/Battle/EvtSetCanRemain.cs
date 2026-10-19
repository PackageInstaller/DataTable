using Bamboo.ECS;

namespace ACT.Battle;

public class EvtSetCanRemain : BaseEvt
{
	public bool canRemain;

	public bool showCharacter;

	public Entity after;

	public override void Reset()
	{
		canRemain = false;
		showCharacter = false;
		after = default;
	}
}
