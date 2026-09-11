using System;

public abstract class ResettableSubsystemBase
{
	private bool mIsInitialized;

	public bool IsInitialized => mIsInitialized;

	protected virtual void Initialize()
	{
		if (mIsInitialized)
		{
			throw new ApplicationException($"{GetType().Name}: subsystem is already initialized");
		}
		mIsInitialized = true;
	}

	public abstract void Reset();

	public virtual void Shutdown()
	{
		if (!mIsInitialized)
		{
			throw new ApplicationException($"{GetType().Name}: subsystem is not initialized, can't shut down");
		}
		mIsInitialized = false;
	}

	public virtual void Update()
	{
	}
}
