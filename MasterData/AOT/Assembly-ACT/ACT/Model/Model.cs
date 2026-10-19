using Fundamental;

namespace ACT.Model;

public abstract class Model<T> : IContext where T : Model<T>, new()
{
	private static T mModel;

	private ContextState _contextState;

	public static T Interface
	{
		get
		{
			if (mModel == null)
			{
				_ = LuminApplication.LogEnabled;
				return null;
			}
			if (mModel._contextState == ContextState.Reset)
			{
				mModel._contextState = ContextState.Loaded;
				mModel.Init();
			}
			return mModel;
		}
	}

	public virtual ContextType ContextType => ContextType.GAME;

	protected abstract void Init();

	protected abstract void UnInit();

	protected virtual void OnDestroy()
	{
	}

	public static void CreateModel()
	{
		if (mModel == null)
		{
			mModel = new T();
			ContextManager.AddContext(mModel);
		}
		mModel._contextState = ContextState.Loaded;
		mModel.Init();
	}

	public static bool HasInstance()
	{
		if (mModel != null)
		{
			return mModel._contextState == ContextState.Loaded;
		}
		return false;
	}

	private void Destroy()
	{
		if (mModel != null)
		{
			ContextManager.RemoveContext(mModel);
			mModel.UnInit();
			mModel.OnDestroy();
			mModel = null;
		}
	}

	void IContext.ContextDestroy()
	{
		Destroy();
	}

	void IContext.ContextReset()
	{
		if (mModel != null && mModel._contextState == ContextState.Loaded)
		{
			mModel.UnInit();
			mModel._contextState = ContextState.Reset;
		}
	}
}
