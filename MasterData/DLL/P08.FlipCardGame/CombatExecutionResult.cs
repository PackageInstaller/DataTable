public readonly struct CombatExecutionResult(bool success, string failureReason, int appliedEffects, int damageDealt)
{
	public readonly bool Success = success;

	public readonly string FailureReason = failureReason ?? string.Empty;

	public readonly int AppliedEffects = appliedEffects;

	public readonly int DamageDealt = damageDealt;

	public static CombatExecutionResult Failed(string reason)
	{
		return new CombatExecutionResult(success: false, reason, 0, 0);
	}

	public static CombatExecutionResult Succeeded(int appliedEffects, int damageDealt)
	{
		return new CombatExecutionResult(success: true, string.Empty, appliedEffects, damageDealt);
	}
}
