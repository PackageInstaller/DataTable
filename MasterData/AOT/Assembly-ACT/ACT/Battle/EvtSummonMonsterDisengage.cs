using Bamboo.ECS;

namespace ACT.Battle;

public class EvtSummonMonsterDisengage : BaseEvt, ISummonMonster
{
	public Entity monster;

	public override void Reset()
	{
		monster = default;
	}

	public Entity GetSummonMonster()
	{
		return monster;
	}
}
