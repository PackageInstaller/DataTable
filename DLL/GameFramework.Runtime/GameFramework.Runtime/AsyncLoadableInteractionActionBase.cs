using System;
using System.Threading.Tasks;

namespace GameFramework.Runtime;

public abstract class AsyncLoadableInteractionActionBase<TNotification> : AsyncInteractionActionBase<TNotification>
{
	private string viewName;

	private IUIViewLocator locator;

	protected string ViewName => viewName;

	protected IUIViewLocator Locator
	{
		get
		{
			if (locator == null)
			{
				ApplicationContext applicationContext = Context.GetApplicationContext();
				locator = applicationContext.GetService<IUIViewLocator>();
			}
			return locator;
		}
	}

	public AsyncLoadableInteractionActionBase(string viewName, IUIViewLocator locator)
	{
		this.viewName = viewName;
		this.locator = locator;
	}

	protected async Task<T> LoadViewAsync<T>() where T : IView
	{
		IUIViewLocator locator = Locator;
		if (locator == null)
		{
			throw new NotFoundException("Not found the \"IUIViewLocator\".");
		}
		if (string.IsNullOrEmpty(viewName))
		{
			throw new ArgumentNullException("The view name is null.");
		}
		return await locator.LoadViewAsync<T>(viewName);
	}

	protected async Task<T> LoadWindowAsync<T>() where T : IWindow
	{
		IUIViewLocator locator = Locator;
		if (locator == null)
		{
			throw new NotFoundException("Not found the \"IUIViewLocator\".");
		}
		if (string.IsNullOrEmpty(viewName))
		{
			throw new ArgumentNullException("The view name is null.");
		}
		return await locator.LoadWindowAsync<T>(viewName);
	}
}
