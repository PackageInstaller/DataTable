using ACT.Battle.Configs;
using Bamboo.ECS;

namespace ACT.Battle;

public class EvtAttack : BaseEvt
{
	public Entity target;

	public FindTargetResult targetResult;

	public HitTag hitTag;

	public override void Reset()
	{
		target = default;
		targetResult = default;
		hitTag = HitTag.None;
	}
}
