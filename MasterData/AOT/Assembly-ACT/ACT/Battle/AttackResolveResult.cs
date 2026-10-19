namespace ACT.Battle;

internal readonly struct AttackResolveResult(bool isResolved, int actualDamage, bool causedDeath)
{
	public readonly bool isResolved = isResolved;

	public readonly int actualDamage = actualDamage;

	public readonly bool causedDeath = causedDeath;
}
