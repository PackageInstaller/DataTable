namespace ACT.DialogueSystem;

public class DialogueContext
{
	public readonly DialogueStates States = new DialogueStates();

	public readonly DialogueBlackboard Blackboard = new DialogueBlackboard();
}
