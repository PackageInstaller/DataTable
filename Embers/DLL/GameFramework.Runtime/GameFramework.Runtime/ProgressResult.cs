namespace GameFramework.Runtime;

public class ProgressResult<TProgress> : AsyncResult, IProgressResult<TProgress>, IAsyncResult, IProgressPromise<TProgress>, IPromise
{
	private ProgressCallbackable<TProgress> callbackable;

	protected TProgress _progress;

	public virtual TProgress Progress => _progress;

	public ProgressResult()
		: this(false)
	{
	}

	public ProgressResult(bool cancelable)
		: base(cancelable)
	{
	}

	protected override void RaiseOnCallback()
	{
		base.RaiseOnCallback();
		if (callbackable != null)
		{
			callbackable.RaiseOnCallback();
		}
	}

	protected virtual void RaiseOnProgressCallback(TProgress progress)
	{
		if (callbackable != null)
		{
			callbackable.RaiseOnProgressCallback(progress);
		}
	}

	public new virtual IProgressCallbackable<TProgress> Callbackable()
	{
		lock (_lock)
		{
			return callbackable ?? (callbackable = new ProgressCallbackable<TProgress>(this));
		}
	}

	public virtual void UpdateProgress(TProgress progress)
	{
		_progress = progress;
		RaiseOnProgressCallback(progress);
	}
}
public class ProgressResult<TProgress, TResult> : ProgressResult<TProgress>, IProgressResult<TProgress, TResult>, IAsyncResult<TResult>, IAsyncResult, IProgressResult<TProgress>, IProgressPromise<TProgress, TResult>, IProgressPromise<TProgress>, IPromise, IPromise<TResult>
{
	private Callbackable<TResult> callbackable;

	private ProgressCallbackable<TProgress, TResult> progressCallbackable;

	private Synchronizable<TResult> synchronizable;

	public new virtual TResult Result
	{
		get
		{
			object obj = base.Result;
			return (obj != null) ? ((TResult)obj) : default(TResult);
		}
	}

	public ProgressResult()
		: this(false)
	{
	}

	public ProgressResult(bool cancelable)
		: base(cancelable)
	{
	}

	public virtual void SetResult(TResult result)
	{
		base.SetResult(result);
	}

	protected override void RaiseOnCallback()
	{
		base.RaiseOnCallback();
		if (callbackable != null)
		{
			callbackable.RaiseOnCallback();
		}
		if (progressCallbackable != null)
		{
			progressCallbackable.RaiseOnCallback();
		}
	}

	protected override void RaiseOnProgressCallback(TProgress progress)
	{
		base.RaiseOnProgressCallback(progress);
		if (progressCallbackable != null)
		{
			progressCallbackable.RaiseOnProgressCallback(progress);
		}
	}

	public new virtual IProgressCallbackable<TProgress, TResult> Callbackable()
	{
		lock (_lock)
		{
			return progressCallbackable ?? (progressCallbackable = new ProgressCallbackable<TProgress, TResult>(this));
		}
	}

	public new virtual ISynchronizable<TResult> Synchronized()
	{
		lock (_lock)
		{
			return synchronizable ?? (synchronizable = new Synchronizable<TResult>(this, _lock));
		}
	}

	ICallbackable<TResult> IAsyncResult<TResult>.Callbackable()
	{
		lock (_lock)
		{
			return callbackable ?? (callbackable = new Callbackable<TResult>(this));
		}
	}
}
