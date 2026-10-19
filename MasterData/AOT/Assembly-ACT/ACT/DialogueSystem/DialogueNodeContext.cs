namespace ACT.DialogueSystem;

public struct DialogueNodeContext
{
	public DialogueFlowProcessor Flow;

	public DialogueNodeProcessor Parent;

	public int Index;

	public DialogueNodeProcessor Previous;

	public DialogueNodeProcessor Next;
}
