namespace GameFramework.Runtime;

public abstract class AbstractServiceBundle : IServiceBundle
{
	private IServiceContainer container;

	public AbstractServiceBundle(IServiceContainer container)
	{
		this.container = container;
	}

	public void Start()
	{
		OnStart(container);
	}

	protected abstract void OnStart(IServiceContainer container);

	public void Stop()
	{
		OnStop(container);
	}

	protected abstract void OnStop(IServiceContainer container);
}
