namespace GameFramework.Runtime;

public abstract class UIViewLocatorBase : IUIViewLocator
{
	public virtual IView LoadView(string name)
	{
		return LoadView<IView>(name);
	}

	public abstract T LoadView<T>(string name) where T : IView;

	public virtual IWindow LoadWindow(string name)
	{
		return LoadWindow<Window>(name);
	}

	public abstract T LoadWindow<T>(string name) where T : IWindow;

	public virtual IWindow LoadWindow(IWindowManager windowManager, string name)
	{
		return LoadWindow<IWindow>(windowManager, name);
	}

	public abstract T LoadWindow<T>(IWindowManager windowManager, string name) where T : IWindow;

	public virtual IProgressResult<float, IView> LoadViewAsync(string name)
	{
		return LoadViewAsync<IView>(name);
	}

	public abstract IProgressResult<float, T> LoadViewAsync<T>(string name) where T : IView;

	public virtual IProgressResult<float, IWindow> LoadWindowAsync(string name)
	{
		return LoadWindowAsync<IWindow>(name);
	}

	public abstract IProgressResult<float, T> LoadWindowAsync<T>(string name) where T : IWindow;

	public virtual IProgressResult<float, IWindow> LoadWindowAsync(IWindowManager windowManager, string name)
	{
		return LoadWindowAsync<IWindow>(windowManager, name);
	}

	public abstract IProgressResult<float, T> LoadWindowAsync<T>(IWindowManager windowManager, string name) where T : IWindow;
}
