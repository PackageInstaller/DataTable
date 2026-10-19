namespace ACT.Drama;

public interface IDialogueInputHandler
{
	bool TryNext();

	void ForceNext();
}
