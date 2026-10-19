using Bamboo.ECS;

namespace ACT.Battle;

public class EvtComboCountChange : BaseEvt
{
	public Entity attackee;

	public int oldComboCount;

	public int newComboCount;

	public override void Reset()
	{
		oldComboCount = (newComboCount = 0);
		attackee = default;
	}
}
