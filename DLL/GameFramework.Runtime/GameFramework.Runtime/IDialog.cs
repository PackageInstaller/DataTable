namespace GameFramework.Runtime;

public interface IDialog
{
	void Show();

	void Cancel();

	object WaitForClosed();
}
