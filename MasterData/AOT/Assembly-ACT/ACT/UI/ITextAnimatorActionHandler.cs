namespace ACT.UI;

public interface ITextAnimatorActionHandler
{
	void Execute(TextAnimatorComponent component, in TextAnimatorAction action);
}
