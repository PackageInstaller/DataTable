using System.Collections.Generic;
using System.Diagnostics;
using System.Runtime.CompilerServices;
using System.Runtime.InteropServices;
using System.Threading.Tasks.Sources;

namespace System.Threading.Tasks;

[StructLayout(LayoutKind.Auto)]
[AsyncMethodBuilder(typeof(AsyncValueTaskMethodBuilder))]
public readonly struct ValueTask : IEquatable<ValueTask>
{
	private sealed class ValueTaskSourceAsTask : Task<VoidTaskResult>
	{
		private static readonly Action<object> s_completionAction = delegate(object state)
		{
			if (!(state is ValueTaskSourceAsTask { _source: { } source } valueTaskSourceAsTask))
			{
				ThrowHelper.ThrowArgumentOutOfRangeException(ExceptionArgument.state);
				return;
			}
			valueTaskSourceAsTask._source = null;
			ValueTaskSourceStatus status = source.GetStatus(valueTaskSourceAsTask._token);
			try
			{
				source.GetResult(valueTaskSourceAsTask._token);
				valueTaskSourceAsTask.TrySetResult(default(VoidTaskResult));
			}
			catch (Exception ex)
			{
				if (status == ValueTaskSourceStatus.Canceled)
				{
					if (ex is OperationCanceledException ex2)
					{
						valueTaskSourceAsTask.TrySetCanceled(ex2.CancellationToken, ex2);
					}
					else
					{
						valueTaskSourceAsTask.TrySetCanceled(new CancellationToken(canceled: true));
					}
				}
				else
				{
					valueTaskSourceAsTask.TrySetException(ex);
				}
			}
		};

		private IValueTaskSource _source;

		private readonly short _token;

		public ValueTaskSourceAsTask(IValueTaskSource source, short token)
		{
			_token = token;
			_source = source;
			source.OnCompleted(s_completionAction, this, token, ValueTaskSourceOnCompletedFlags.None);
		}
	}

	private static readonly Task s_canceledTask = Task.FromCanceled(new CancellationToken(canceled: true));

	internal readonly object _obj;

	internal readonly short _token;

	internal readonly bool _continueOnCapturedContext;

	internal static Task CompletedTask => Task.CompletedTask;

	public bool IsCompleted
	{
		[MethodImpl((MethodImplOptions)256)]
		get
		{
			object obj = _obj;
			if (obj == null)
			{
				return true;
			}
			if (obj is Task task)
			{
				return task.IsCompleted;
			}
			return Unsafe.As<IValueTaskSource>(obj).GetStatus(_token) != ValueTaskSourceStatus.Pending;
		}
	}

	[MethodImpl((MethodImplOptions)256)]
	public ValueTask(Task task)
	{
		if (task == null)
		{
			ThrowHelper.ThrowArgumentNullException(ExceptionArgument.task);
		}
		_obj = task;
		_continueOnCapturedContext = true;
		_token = 0;
	}

	[MethodImpl((MethodImplOptions)256)]
	public ValueTask(IValueTaskSource source, short token)
	{
		if (source == null)
		{
			ThrowHelper.ThrowArgumentNullException(ExceptionArgument.source);
		}
		_obj = source;
		_token = token;
		_continueOnCapturedContext = true;
	}

	[MethodImpl((MethodImplOptions)256)]
	private ValueTask(object obj, short token, bool continueOnCapturedContext)
	{
		_obj = obj;
		_token = token;
		_continueOnCapturedContext = continueOnCapturedContext;
	}

	public override int GetHashCode()
	{
		return _obj?.GetHashCode() ?? 0;
	}

	public override bool Equals(object obj)
	{
		if (obj is ValueTask)
		{
			return Equals((ValueTask)obj);
		}
		return false;
	}

	public bool Equals(ValueTask other)
	{
		if (_obj == other._obj)
		{
			return _token == other._token;
		}
		return false;
	}

	public Task AsTask()
	{
		object obj = _obj;
		object obj2;
		if (obj != null)
		{
			obj2 = obj as Task;
			if (obj2 == null)
			{
				return GetTaskForValueTaskSource(Unsafe.As<IValueTaskSource>(obj));
			}
		}
		else
		{
			obj2 = CompletedTask;
		}
		return (Task)obj2;
	}

	private Task GetTaskForValueTaskSource(IValueTaskSource t)
	{
		ValueTaskSourceStatus status = t.GetStatus(_token);
		if (status != ValueTaskSourceStatus.Pending)
		{
			try
			{
				t.GetResult(_token);
				return CompletedTask;
			}
			catch (Exception ex)
			{
				if (status == ValueTaskSourceStatus.Canceled)
				{
					if (ex is OperationCanceledException ex2)
					{
						Task<VoidTaskResult> task = new Task<VoidTaskResult>();
						task.TrySetCanceled(ex2.CancellationToken, ex2);
						return task;
					}
					return s_canceledTask;
				}
				return Task.FromException(ex);
			}
		}
		return new ValueTaskSourceAsTask(t, _token);
	}

	[MethodImpl((MethodImplOptions)256)]
	[StackTraceHidden]
	internal void ThrowIfCompletedUnsuccessfully()
	{
		object obj = _obj;
		if (obj != null)
		{
			if (obj is Task task)
			{
				TaskAwaiter.ValidateEnd(task);
			}
			else
			{
				Unsafe.As<IValueTaskSource>(obj).GetResult(_token);
			}
		}
	}

	public ValueTaskAwaiter GetAwaiter()
	{
		return new ValueTaskAwaiter(this);
	}

	[MethodImpl((MethodImplOptions)256)]
	public ConfiguredValueTaskAwaitable ConfigureAwait(bool continueOnCapturedContext)
	{
		return new ConfiguredValueTaskAwaitable(new ValueTask(_obj, _token, continueOnCapturedContext));
	}
}
[StructLayout(LayoutKind.Auto)]
[AsyncMethodBuilder(typeof(AsyncValueTaskMethodBuilder<>))]
public readonly struct ValueTask<TResult> : IEquatable<ValueTask<TResult>>
{
	private sealed class ValueTaskSourceAsTask : Task<TResult>
	{
		private static readonly Action<object> s_completionAction = delegate(object state)
		{
			if (!(state is ValueTaskSourceAsTask { _source: { } source } valueTaskSourceAsTask))
			{
				ThrowHelper.ThrowArgumentOutOfRangeException(ExceptionArgument.state);
				return;
			}
			valueTaskSourceAsTask._source = null;
			ValueTaskSourceStatus status = source.GetStatus(valueTaskSourceAsTask._token);
			try
			{
				valueTaskSourceAsTask.TrySetResult(source.GetResult(valueTaskSourceAsTask._token));
			}
			catch (Exception ex)
			{
				if (status == ValueTaskSourceStatus.Canceled)
				{
					if (ex is OperationCanceledException ex2)
					{
						valueTaskSourceAsTask.TrySetCanceled(ex2.CancellationToken, ex2);
					}
					else
					{
						valueTaskSourceAsTask.TrySetCanceled(new CancellationToken(canceled: true));
					}
				}
				else
				{
					valueTaskSourceAsTask.TrySetException(ex);
				}
			}
		};

		private IValueTaskSource<TResult> _source;

		private readonly short _token;

		public ValueTaskSourceAsTask(IValueTaskSource<TResult> source, short token)
		{
			_source = source;
			_token = token;
			source.OnCompleted(s_completionAction, this, token, ValueTaskSourceOnCompletedFlags.None);
		}
	}

	private static Task<TResult> s_canceledTask;

	internal readonly object _obj;

	internal readonly TResult _result;

	internal readonly short _token;

	internal readonly bool _continueOnCapturedContext;

	public bool IsCompleted
	{
		[MethodImpl((MethodImplOptions)256)]
		get
		{
			object obj = _obj;
			if (obj == null)
			{
				return true;
			}
			if (obj is Task<TResult> task)
			{
				return task.IsCompleted;
			}
			return Unsafe.As<IValueTaskSource<TResult>>(obj).GetStatus(_token) != ValueTaskSourceStatus.Pending;
		}
	}

	public bool IsCompletedSuccessfully
	{
		[MethodImpl((MethodImplOptions)256)]
		get
		{
			object obj = _obj;
			if (obj == null)
			{
				return true;
			}
			if (obj is Task<TResult> task)
			{
				return task.IsCompletedSuccessfully;
			}
			return Unsafe.As<IValueTaskSource<TResult>>(obj).GetStatus(_token) == ValueTaskSourceStatus.Succeeded;
		}
	}

	public TResult Result
	{
		[MethodImpl((MethodImplOptions)256)]
		get
		{
			object obj = _obj;
			if (obj == null)
			{
				return _result;
			}
			if (obj is Task<TResult> task)
			{
				TaskAwaiter.ValidateEnd(task);
				return task.ResultOnSuccess;
			}
			return Unsafe.As<IValueTaskSource<TResult>>(obj).GetResult(_token);
		}
	}

	[MethodImpl((MethodImplOptions)256)]
	public ValueTask(TResult result)
	{
		_result = result;
		_obj = null;
		_continueOnCapturedContext = true;
		_token = 0;
	}

	[MethodImpl((MethodImplOptions)256)]
	public ValueTask(Task<TResult> task)
	{
		if (task == null)
		{
			ThrowHelper.ThrowArgumentNullException(ExceptionArgument.task);
		}
		_obj = task;
		_result = default(TResult);
		_continueOnCapturedContext = true;
		_token = 0;
	}

	[MethodImpl((MethodImplOptions)256)]
	public ValueTask(IValueTaskSource<TResult> source, short token)
	{
		if (source == null)
		{
			ThrowHelper.ThrowArgumentNullException(ExceptionArgument.source);
		}
		_obj = source;
		_token = token;
		_result = default(TResult);
		_continueOnCapturedContext = true;
	}

	[MethodImpl((MethodImplOptions)256)]
	private ValueTask(object obj, TResult result, short token, bool continueOnCapturedContext)
	{
		_obj = obj;
		_result = result;
		_token = token;
		_continueOnCapturedContext = continueOnCapturedContext;
	}

	public override int GetHashCode()
	{
		if (_obj == null)
		{
			if (_result == null)
			{
				return 0;
			}
			return _result.GetHashCode();
		}
		return _obj.GetHashCode();
	}

	public override bool Equals(object obj)
	{
		if (obj is ValueTask<TResult>)
		{
			return Equals((ValueTask<TResult>)obj);
		}
		return false;
	}

	public bool Equals(ValueTask<TResult> other)
	{
		if (_obj == null && other._obj == null)
		{
			return EqualityComparer<TResult>.Default.Equals(_result, other._result);
		}
		if (_obj == other._obj)
		{
			return _token == other._token;
		}
		return false;
	}

	public Task<TResult> AsTask()
	{
		object obj = _obj;
		if (obj == null)
		{
			return AsyncTaskMethodBuilder<TResult>.GetTaskForResult(_result);
		}
		if (obj is Task<TResult> result)
		{
			return result;
		}
		return GetTaskForValueTaskSource(Unsafe.As<IValueTaskSource<TResult>>(obj));
	}

	private Task<TResult> GetTaskForValueTaskSource(IValueTaskSource<TResult> t)
	{
		ValueTaskSourceStatus status = t.GetStatus(_token);
		if (status != ValueTaskSourceStatus.Pending)
		{
			try
			{
				return AsyncTaskMethodBuilder<TResult>.GetTaskForResult(t.GetResult(_token));
			}
			catch (Exception ex)
			{
				if (status == ValueTaskSourceStatus.Canceled)
				{
					if (ex is OperationCanceledException ex2)
					{
						Task<TResult> task = new Task<TResult>();
						task.TrySetCanceled(ex2.CancellationToken, ex2);
						return task;
					}
					Task<TResult> task2 = s_canceledTask;
					if (task2 == null)
					{
						task2 = (s_canceledTask = Task.FromCanceled<TResult>(new CancellationToken(canceled: true)));
					}
					return task2;
				}
				return Task.FromException<TResult>(ex);
			}
		}
		return new ValueTaskSourceAsTask(t, _token);
	}

	[MethodImpl((MethodImplOptions)256)]
	public ValueTaskAwaiter<TResult> GetAwaiter()
	{
		return new ValueTaskAwaiter<TResult>(this);
	}

	[MethodImpl((MethodImplOptions)256)]
	public ConfiguredValueTaskAwaitable<TResult> ConfigureAwait(bool continueOnCapturedContext)
	{
		return new ConfiguredValueTaskAwaitable<TResult>(new ValueTask<TResult>(_obj, _result, _token, continueOnCapturedContext));
	}

	public override string ToString()
	{
		if (IsCompletedSuccessfully)
		{
			TResult result = Result;
			if (result != null)
			{
				return result.ToString();
			}
		}
		return string.Empty;
	}
}
