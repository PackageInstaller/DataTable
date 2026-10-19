namespace ACT.Battle;

public interface IHitResolveRule
{
	bool TryResolve(HitResolveContext context, out HitResolveDecision decision);
}
