namespace ACT.DialogueSystem;

public interface INodeFactory
{
	DialogueNodeProcessor Produce();
}
