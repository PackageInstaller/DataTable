namespace GameFramework.Runtime;

public interface IUIViewLocator
{
	IView LoadView(string name);

	T LoadView<T>(string name) where T : IView;

	IWindow LoadWindow(string name);

	T LoadWindow<T>(string name) where T : IWindow;

	IWindow LoadWindow(IWindowManager windowManager, string name);

	T LoadWindow<T>(IWindowManager windowManager, string name) where T : IWindow;

	IProgressResult<float, IView> LoadViewAsync(string name);

	IProgressResult<float, T> LoadViewAsync<T>(string name) where T : IView;

	IProgressResult<float, IWindow> LoadWindowAsync(string name);

	IProgressResult<float, T> LoadWindowAsync<T>(string name) where T : IWindow;

	IProgressResult<float, IWindow> LoadWindowAsync(IWindowManager windowManager, string name);

	IProgressResult<float, T> LoadWindowAsync<T>(IWindowManager windowManager, string name) where T : IWindow;
}
