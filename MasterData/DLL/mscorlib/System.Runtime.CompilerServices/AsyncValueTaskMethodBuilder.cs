using System.Runtime.InteropServices;
using System.Threading.Tasks;

namespace System.Runtime.CompilerServices;

[StructLayout(LayoutKind.Auto)]
public struct AsyncValueTaskMethodBuilder
{
	private AsyncTaskMethodBuilder _methodBuilder;

	private bool _haveResult;

	private bool _useBuilder;

	public ValueTask Task
	{
		get
		{
			if (_haveResult)
			{
				return default(ValueTask);
			}
			_useBuilder = true;
			return new ValueTask(_methodBuilder.Task);
		}
	}

	public static AsyncValueTaskMethodBuilder Create()
	{
		return default(AsyncValueTaskMethodBuilder);
	}

	[MethodImpl((MethodImplOptions)256)]
	public void Start<TStateMachine>(ref TStateMachine stateMachine) where TStateMachine : IAsyncStateMachine
	{
		_methodBuilder.Start(ref stateMachine);
	}

	public void SetStateMachine(IAsyncStateMachine stateMachine)
	{
		_methodBuilder.SetStateMachine(stateMachine);
	}

	public void SetResult()
	{
		if (_useBuilder)
		{
			_methodBuilder.SetResult();
		}
		else
		{
			_haveResult = true;
		}
	}

	public void SetException(Exception exception)
	{
		_methodBuilder.SetException(exception);
	}

	public void AwaitUnsafeOnCompleted<TAwaiter, TStateMachine>(ref TAwaiter awaiter, ref TStateMachine stateMachine) where TAwaiter : ICriticalNotifyCompletion where TStateMachine : IAsyncStateMachine
	{
		_useBuilder = true;
		_methodBuilder.AwaitUnsafeOnCompleted(ref awaiter, ref stateMachine);
	}
}
[StructLayout(LayoutKind.Auto)]
public struct AsyncValueTaskMethodBuilder<TResult>
{
	private AsyncTaskMethodBuilder<TResult> _methodBuilder;

	private TResult _result;

	private bool _haveResult;

	private bool _useBuilder;

	public ValueTask<TResult> Task
	{
		get
		{
			if (_haveResult)
			{
				return new ValueTask<TResult>(_result);
			}
			_useBuilder = true;
			return new ValueTask<TResult>(_methodBuilder.Task);
		}
	}

	public static AsyncValueTaskMethodBuilder<TResult> Create()
	{
		return default(AsyncValueTaskMethodBuilder<TResult>);
	}

	[MethodImpl((MethodImplOptions)256)]
	public void Start<TStateMachine>(ref TStateMachine stateMachine) where TStateMachine : IAsyncStateMachine
	{
		_methodBuilder.Start(ref stateMachine);
	}

	public void SetStateMachine(IAsyncStateMachine stateMachine)
	{
		_methodBuilder.SetStateMachine(stateMachine);
	}

	public void SetResult(TResult result)
	{
		if (_useBuilder)
		{
			_methodBuilder.SetResult(result);
			return;
		}
		_result = result;
		_haveResult = true;
	}

	public void SetException(Exception exception)
	{
		_methodBuilder.SetException(exception);
	}

	public void AwaitUnsafeOnCompleted<TAwaiter, TStateMachine>(ref TAwaiter awaiter, ref TStateMachine stateMachine) where TAwaiter : ICriticalNotifyCompletion where TStateMachine : IAsyncStateMachine
	{
		_useBuilder = true;
		_methodBuilder.AwaitUnsafeOnCompleted(ref awaiter, ref stateMachine);
	}
}
