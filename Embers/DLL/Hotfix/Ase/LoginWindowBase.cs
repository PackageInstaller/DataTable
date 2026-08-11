using GameFramework.Runtime;

namespace Ase;

public class LoginWindowBase : UGuiWindow
{
	protected virtual async void OnToastShow(object sender, InteractionEventArgs args)
	{
		if (args.Context is Notification notification)
		{
			Toast.ShowInfo(notification.Message);
		}
	}
}
