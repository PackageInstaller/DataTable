namespace GameFramework.Runtime;

public interface IManageable : IWindow
{
	IAsyncResult Activate(bool ignoreAnimation);

	IAsyncResult Passivate(bool ignoreAnimation);

	IAsyncResult DoShow(bool ignoreAnimation = false);

	IAsyncResult DoHide(bool ignoreAnimation = false);

	void DoDismiss();
}
