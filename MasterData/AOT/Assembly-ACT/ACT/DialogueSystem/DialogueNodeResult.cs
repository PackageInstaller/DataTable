namespace ACT.DialogueSystem;

public struct DialogueNodeResult
{
	public static readonly DialogueNodeResult Continue = new DialogueNodeResult(DialogueNodeResultType.Continue, string.Empty);

	public static readonly DialogueNodeResult Break = new DialogueNodeResult(DialogueNodeResultType.Break, string.Empty);

	public readonly DialogueNodeResultType Type;

	public readonly string Message;

	public static DialogueNodeResult Error(string message)
	{
		return new DialogueNodeResult(DialogueNodeResultType.Error, message);
	}

	private DialogueNodeResult(DialogueNodeResultType type, string message)
	{
		Type = type;
		Message = message;
	}
}
