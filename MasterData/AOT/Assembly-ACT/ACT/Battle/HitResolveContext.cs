using ACT.Battle.Configs;

namespace ACT.Battle;

public struct HitResolveContext
{
	public ActionMemory memory;

	public HitResolveTag hitResolveTag;

	public bool forceHit;

	public DefenseStateSnapshot defenseState;

	public HitResolveDecision decision;
}
