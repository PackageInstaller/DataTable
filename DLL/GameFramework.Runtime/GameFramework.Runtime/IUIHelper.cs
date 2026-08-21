using Cysharp.Threading.Tasks;

namespace GameFramework.Runtime;

public interface IUIHelper
{
	void Initialize();

	UniTask OnWindowLoad(string uiFormAssetName, string uiGroupName, IWindow window, object userData);

	UniTask OnWindowShow(IWindow window);

	UniTask OnWindowHide(IWindow window);

	UniTask OnWindowDismiss(IWindow window);
}
