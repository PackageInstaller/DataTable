namespace ACT.DialogueSystem;

public sealed class NodeFactory<T> : INodeFactory where T : DialogueNodeProcessor, new()
{
	public DialogueNodeProcessor Produce()
	{
		return new T();
	}
}
