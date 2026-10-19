namespace ACT.Battle;

public enum AICombatMoveCommitResult
{
	Committed,
	ReusedCurrentDestination,
	BlockedByBodyCommitment,
	FailCooldown,
	InvalidNav,
	Unreachable,
	CommitCooldown
}
