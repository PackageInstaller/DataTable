using UnityEngine;

[CreateAssetMenu(fileName = "NewNpcBehaviorTree", menuName = "NPC/Npc巡逻行为树", order = 0)]
public class NpcPatrolTree : NpcBehaviorTree
{
	private const string Selector0TurnToNewPatrolPoint = "Selector0TurnToNewPatrolPoint";

	private const string Selector1ReachPatrolPoint = "Selector1ReachPatrolPoint";

	private const string Selector1TurnToNewPatrolPoint = "Selector1TurnToNewPatrolPoint";

	private const string AddCount = "AddCount";

	private const string MovingToNextAnimation = "MovingToNextAnimation";

	private const string ReachNextAnimation = "ReachNextAnimation";

	private const string WaitForNextTimer = "WaitForNextTimer";

	private const string StartMovingToNextAnimation = "StartMovingToNextAnimation";
}
