using Bamboo.ECS;

namespace ACT.Battle;

public class EvtOnSpawnProduct : BaseEvt
{
	public Entity product;

	public override void Reset()
	{
		product = default;
	}
}
