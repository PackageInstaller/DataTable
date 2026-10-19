namespace ACT.NPC;

public static class NpcConditionIds
{
	public const int MissionDuration = 1;

	public const int MissionReceive = 2;

	public const int MissionComplete = 3;

	public const int KeyPointPass = 4;

	public const int PlayingDialogue = 5;

	public const int AlwaysFalse = 6;

	public const int BehaviorState = 7;

	public const int ReachedPatrolPoint = 8;

	public const int MissionConditionActive = 10;

	public static readonly int[] All = new int[9] { 1, 2, 3, 4, 5, 6, 7, 8, 10 };
}
