namespace GameFramework.Runtime;

public class ApplicationContext : Context
{
	private IMainLoopExecutor mainLoopExecutor;

	public ApplicationContext()
		: this(null, null)
	{
	}

	public ApplicationContext(IServiceContainer container, IMainLoopExecutor mainLoopExecutor)
		: base(container, null)
	{
		this.mainLoopExecutor = mainLoopExecutor;
		if (this.mainLoopExecutor == null)
		{
			this.mainLoopExecutor = new MainLoopExecutor();
		}
	}

	public virtual IMainLoopExecutor GetMainLoopExcutor()
	{
		return mainLoopExecutor;
	}

	public virtual Preferences GetGlobalPreferences()
	{
		return Preferences.GetGlobalPreferences();
	}

	public virtual Preferences GetUserPreferences(string name)
	{
		return Preferences.GetPreferences(name);
	}
}
