using Bamboo.ECS;

namespace ACT.Battle;

public class EvtBeforeRemoveSummonMonster : BaseEvt, ISummonMonster
{
	public Entity monster;

	public RemoveSummonMonsterParam removeSummonMonsterParam;

	public override void Reset()
	{
		monster = default;
		removeSummonMonsterParam = null;
	}

	public Entity GetSummonMonster()
	{
		return monster;
	}
}
