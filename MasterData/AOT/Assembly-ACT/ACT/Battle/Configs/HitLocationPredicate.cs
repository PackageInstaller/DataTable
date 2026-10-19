using EasyCharacterMovement;

namespace ACT.Battle.Configs;

[AbilityTypeMetadata("判断命中Location", "Predicate", new string[] { "hit", "location", "predicate", "check", "condition" })]
public class HitLocationPredicate : ConfigPredicate
{
	public HitLocation compareValue;

	public override bool Check(ActionMemory memory)
	{
		if (memory.evt is EvtHitWall && (memory.evt as EvtHitWall).result.hitLocation == compareValue)
		{
			return true;
		}
		return false;
	}
}
