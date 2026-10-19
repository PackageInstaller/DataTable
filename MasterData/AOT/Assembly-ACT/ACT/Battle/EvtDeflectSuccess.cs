using Bamboo.ECS;

namespace ACT.Battle;

public class EvtDeflectSuccess : BaseEvt
{
	public Entity attackee;

	public Entity attacker;

	public override void Reset()
	{
	}
}
