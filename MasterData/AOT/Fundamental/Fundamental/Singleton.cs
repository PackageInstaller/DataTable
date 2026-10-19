namespace Fundamental;

public class Singleton<T> : IContext where T : Singleton<T>, new()
{
	private static T s_instance;

	private ContextState _contextState;

	public static T instance
	{
		get
		{
			if (s_instance == null)
			{
				CreateInstance();
			}
			if (s_instance._contextState == ContextState.Reset)
			{
				s_instance._contextState = ContextState.Loaded;
				s_instance.Init();
			}
			return s_instance;
		}
	}

	public virtual ContextType ContextType => ContextType.GAME;

	protected Singleton()
	{
	}

	public static void CreateInstance()
	{
		if (s_instance == null)
		{
			s_instance = new T();
			ContextManager.AddContext(s_instance);
		}
		else if (s_instance._contextState == ContextState.Reset)
		{
			s_instance._contextState = ContextState.Loaded;
		}
		s_instance.Init();
	}

	public static void DestroyInstance()
	{
		if (s_instance != null)
		{
			ContextManager.RemoveContext(s_instance);
			s_instance.UnInit();
			s_instance.OnDestroy();
			s_instance = null;
		}
	}

	public static T GetInstance()
	{
		if (s_instance == null)
		{
			CreateInstance();
		}
		return s_instance;
	}

	public static bool HasInstance()
	{
		return s_instance != null;
	}

	public virtual void Init()
	{
	}

	public virtual void UnInit()
	{
	}

	public virtual void OnDestroy()
	{
	}

	void IContext.ContextDestroy()
	{
		DestroyInstance();
	}

	void IContext.ContextReset()
	{
		if (s_instance != null && s_instance._contextState == ContextState.Loaded)
		{
			s_instance.UnInit();
			s_instance._contextState = ContextState.Reset;
		}
	}
}
