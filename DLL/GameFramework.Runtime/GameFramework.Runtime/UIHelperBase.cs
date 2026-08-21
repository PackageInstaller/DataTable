using Cysharp.Threading.Tasks;

namespace GameFramework.Runtime;

public abstract class UIHelperBase : IUIHelper
{
	public void Initialize()
	{
	}

	public virtual UniTask OnWindowLoad(string uiFormAssetName, string uiGroupName, IWindow window, object userData)
	{
		return UniTask.CompletedTask;
	}

	public virtual UniTask OnWindowShow(IWindow window)
	{
		return UniTask.CompletedTask;
	}

	public virtual UniTask OnWindowHide(IWindow window)
	{
		return UniTask.CompletedTask;
	}

	public virtual UniTask OnWindowDismiss(IWindow window)
	{
		return UniTask.CompletedTask;
	}
}
