namespace BilliardGame.Runtime;

public enum TurnState
{
	WaitingForInit,
	RoundBeginPhase,
	PlayerShootPhase,
	PlayerAttackPhase,
	EnemyActionPhase,
	RoundOverPhase,
	WaitingForDispose
}
