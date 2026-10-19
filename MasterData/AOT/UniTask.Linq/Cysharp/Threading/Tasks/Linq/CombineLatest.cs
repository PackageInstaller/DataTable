using System;
using System.Threading;

namespace Cysharp.Threading.Tasks.Linq;

internal class CombineLatest<T1, T2, TResult> : IUniTaskAsyncEnumerable<TResult>
{
	private class _CombineLatest : MoveNextSource, IUniTaskAsyncEnumerator<TResult>, IUniTaskAsyncDisposable
	{
		private static readonly Action<object> Completed1Delegate = Completed1;

		private static readonly Action<object> Completed2Delegate = Completed2;

		private readonly IUniTaskAsyncEnumerable<T1> source1;

		private readonly IUniTaskAsyncEnumerable<T2> source2;

		private readonly Func<T1, T2, TResult> resultSelector;

		private CancellationToken cancellationToken;

		private IUniTaskAsyncEnumerator<T1> enumerator1;

		private UniTask<bool>.Awaiter awaiter1;

		private bool hasCurrent1;

		private bool running1;

		private T1 current1;

		private IUniTaskAsyncEnumerator<T2> enumerator2;

		private UniTask<bool>.Awaiter awaiter2;

		private bool hasCurrent2;

		private bool running2;

		private T2 current2;

		private int completedCount;

		private bool syncRunning;

		private TResult result;

		public TResult Current => result;

		public _CombineLatest(IUniTaskAsyncEnumerable<T1> source1, IUniTaskAsyncEnumerable<T2> source2, Func<T1, T2, TResult> resultSelector, CancellationToken cancellationToken)
		{
			this.source1 = source1;
			this.source2 = source2;
			this.resultSelector = resultSelector;
			this.cancellationToken = cancellationToken;
		}

		public UniTask<bool> MoveNextAsync()
		{
			cancellationToken.ThrowIfCancellationRequested();
			if (completedCount == 2)
			{
				return CompletedTasks.False;
			}
			if (enumerator1 == null)
			{
				enumerator1 = source1.GetAsyncEnumerator(cancellationToken);
				enumerator2 = source2.GetAsyncEnumerator(cancellationToken);
			}
			completionSource.Reset();
			do
			{
				syncRunning = true;
				if (!running1)
				{
					running1 = true;
					awaiter1 = enumerator1.MoveNextAsync().GetAwaiter();
					if (awaiter1.IsCompleted)
					{
						Completed1(this);
					}
					else
					{
						awaiter1.SourceOnCompleted(Completed1Delegate, this);
					}
				}
				if (!running2)
				{
					running2 = true;
					awaiter2 = enumerator2.MoveNextAsync().GetAwaiter();
					if (awaiter2.IsCompleted)
					{
						Completed2(this);
					}
					else
					{
						awaiter2.SourceOnCompleted(Completed2Delegate, this);
					}
				}
			}
			while (!running1 || !running2);
			syncRunning = false;
			return new UniTask<bool>(this, completionSource.Version);
		}

		private static void Completed1(object state)
		{
			_CombineLatest combineLatest = (_CombineLatest)state;
			combineLatest.running1 = false;
			try
			{
				if (combineLatest.awaiter1.GetResult())
				{
					combineLatest.hasCurrent1 = true;
					combineLatest.current1 = combineLatest.enumerator1.Current;
					goto IL_006f;
				}
				combineLatest.running1 = true;
				if (Interlocked.Increment(ref combineLatest.completedCount) != 2)
				{
					return;
				}
			}
			catch (Exception error)
			{
				combineLatest.running1 = true;
				combineLatest.completedCount = 2;
				combineLatest.completionSource.TrySetException(error);
				return;
			}
			combineLatest.completionSource.TrySetResult(result: false);
			return;
			IL_006f:
			if (!combineLatest.TrySetResult() && !combineLatest.syncRunning)
			{
				combineLatest.running1 = true;
				try
				{
					combineLatest.awaiter1 = combineLatest.enumerator1.MoveNextAsync().GetAwaiter();
				}
				catch (Exception error2)
				{
					combineLatest.completedCount = 2;
					combineLatest.completionSource.TrySetException(error2);
					return;
				}
				combineLatest.awaiter1.SourceOnCompleted(Completed1Delegate, combineLatest);
			}
		}

		private static void Completed2(object state)
		{
			_CombineLatest combineLatest = (_CombineLatest)state;
			combineLatest.running2 = false;
			try
			{
				if (combineLatest.awaiter2.GetResult())
				{
					combineLatest.hasCurrent2 = true;
					combineLatest.current2 = combineLatest.enumerator2.Current;
					goto IL_006f;
				}
				combineLatest.running2 = true;
				if (Interlocked.Increment(ref combineLatest.completedCount) != 2)
				{
					return;
				}
			}
			catch (Exception error)
			{
				combineLatest.running2 = true;
				combineLatest.completedCount = 2;
				combineLatest.completionSource.TrySetException(error);
				return;
			}
			combineLatest.completionSource.TrySetResult(result: false);
			return;
			IL_006f:
			if (!combineLatest.TrySetResult() && !combineLatest.syncRunning)
			{
				combineLatest.running2 = true;
				try
				{
					combineLatest.awaiter2 = combineLatest.enumerator2.MoveNextAsync().GetAwaiter();
				}
				catch (Exception error2)
				{
					combineLatest.completedCount = 2;
					combineLatest.completionSource.TrySetException(error2);
					return;
				}
				combineLatest.awaiter2.SourceOnCompleted(Completed2Delegate, combineLatest);
			}
		}

		private bool TrySetResult()
		{
			if (hasCurrent1 && hasCurrent2)
			{
				result = resultSelector(current1, current2);
				completionSource.TrySetResult(result: true);
				return true;
			}
			return false;
		}

		public async UniTask DisposeAsync()
		{
			if (enumerator1 != null)
			{
				await enumerator1.DisposeAsync();
			}
			if (enumerator2 != null)
			{
				await enumerator2.DisposeAsync();
			}
		}
	}

	private readonly IUniTaskAsyncEnumerable<T1> source1;

	private readonly IUniTaskAsyncEnumerable<T2> source2;

	private readonly Func<T1, T2, TResult> resultSelector;

	public CombineLatest(IUniTaskAsyncEnumerable<T1> source1, IUniTaskAsyncEnumerable<T2> source2, Func<T1, T2, TResult> resultSelector)
	{
		this.source1 = source1;
		this.source2 = source2;
		this.resultSelector = resultSelector;
	}

	public IUniTaskAsyncEnumerator<TResult> GetAsyncEnumerator(CancellationToken cancellationToken = default(CancellationToken))
	{
		return new _CombineLatest(source1, source2, resultSelector, cancellationToken);
	}
}
internal class CombineLatest<T1, T2, T3, TResult> : IUniTaskAsyncEnumerable<TResult>
{
	private class _CombineLatest : MoveNextSource, IUniTaskAsyncEnumerator<TResult>, IUniTaskAsyncDisposable
	{
		private static readonly Action<object> Completed1Delegate = Completed1;

		private static readonly Action<object> Completed2Delegate = Completed2;

		private static readonly Action<object> Completed3Delegate = Completed3;

		private readonly IUniTaskAsyncEnumerable<T1> source1;

		private readonly IUniTaskAsyncEnumerable<T2> source2;

		private readonly IUniTaskAsyncEnumerable<T3> source3;

		private readonly Func<T1, T2, T3, TResult> resultSelector;

		private CancellationToken cancellationToken;

		private IUniTaskAsyncEnumerator<T1> enumerator1;

		private UniTask<bool>.Awaiter awaiter1;

		private bool hasCurrent1;

		private bool running1;

		private T1 current1;

		private IUniTaskAsyncEnumerator<T2> enumerator2;

		private UniTask<bool>.Awaiter awaiter2;

		private bool hasCurrent2;

		private bool running2;

		private T2 current2;

		private IUniTaskAsyncEnumerator<T3> enumerator3;

		private UniTask<bool>.Awaiter awaiter3;

		private bool hasCurrent3;

		private bool running3;

		private T3 current3;

		private int completedCount;

		private bool syncRunning;

		private TResult result;

		public TResult Current => result;

		public _CombineLatest(IUniTaskAsyncEnumerable<T1> source1, IUniTaskAsyncEnumerable<T2> source2, IUniTaskAsyncEnumerable<T3> source3, Func<T1, T2, T3, TResult> resultSelector, CancellationToken cancellationToken)
		{
			this.source1 = source1;
			this.source2 = source2;
			this.source3 = source3;
			this.resultSelector = resultSelector;
			this.cancellationToken = cancellationToken;
		}

		public UniTask<bool> MoveNextAsync()
		{
			cancellationToken.ThrowIfCancellationRequested();
			if (completedCount == 3)
			{
				return CompletedTasks.False;
			}
			if (enumerator1 == null)
			{
				enumerator1 = source1.GetAsyncEnumerator(cancellationToken);
				enumerator2 = source2.GetAsyncEnumerator(cancellationToken);
				enumerator3 = source3.GetAsyncEnumerator(cancellationToken);
			}
			completionSource.Reset();
			do
			{
				syncRunning = true;
				if (!running1)
				{
					running1 = true;
					awaiter1 = enumerator1.MoveNextAsync().GetAwaiter();
					if (awaiter1.IsCompleted)
					{
						Completed1(this);
					}
					else
					{
						awaiter1.SourceOnCompleted(Completed1Delegate, this);
					}
				}
				if (!running2)
				{
					running2 = true;
					awaiter2 = enumerator2.MoveNextAsync().GetAwaiter();
					if (awaiter2.IsCompleted)
					{
						Completed2(this);
					}
					else
					{
						awaiter2.SourceOnCompleted(Completed2Delegate, this);
					}
				}
				if (!running3)
				{
					running3 = true;
					awaiter3 = enumerator3.MoveNextAsync().GetAwaiter();
					if (awaiter3.IsCompleted)
					{
						Completed3(this);
					}
					else
					{
						awaiter3.SourceOnCompleted(Completed3Delegate, this);
					}
				}
			}
			while (!running1 || !running2 || !running3);
			syncRunning = false;
			return new UniTask<bool>(this, completionSource.Version);
		}

		private static void Completed1(object state)
		{
			_CombineLatest combineLatest = (_CombineLatest)state;
			combineLatest.running1 = false;
			try
			{
				if (combineLatest.awaiter1.GetResult())
				{
					combineLatest.hasCurrent1 = true;
					combineLatest.current1 = combineLatest.enumerator1.Current;
					goto IL_006f;
				}
				combineLatest.running1 = true;
				if (Interlocked.Increment(ref combineLatest.completedCount) != 3)
				{
					return;
				}
			}
			catch (Exception error)
			{
				combineLatest.running1 = true;
				combineLatest.completedCount = 3;
				combineLatest.completionSource.TrySetException(error);
				return;
			}
			combineLatest.completionSource.TrySetResult(result: false);
			return;
			IL_006f:
			if (!combineLatest.TrySetResult() && !combineLatest.syncRunning)
			{
				combineLatest.running1 = true;
				try
				{
					combineLatest.awaiter1 = combineLatest.enumerator1.MoveNextAsync().GetAwaiter();
				}
				catch (Exception error2)
				{
					combineLatest.completedCount = 3;
					combineLatest.completionSource.TrySetException(error2);
					return;
				}
				combineLatest.awaiter1.SourceOnCompleted(Completed1Delegate, combineLatest);
			}
		}

		private static void Completed2(object state)
		{
			_CombineLatest combineLatest = (_CombineLatest)state;
			combineLatest.running2 = false;
			try
			{
				if (combineLatest.awaiter2.GetResult())
				{
					combineLatest.hasCurrent2 = true;
					combineLatest.current2 = combineLatest.enumerator2.Current;
					goto IL_006f;
				}
				combineLatest.running2 = true;
				if (Interlocked.Increment(ref combineLatest.completedCount) != 3)
				{
					return;
				}
			}
			catch (Exception error)
			{
				combineLatest.running2 = true;
				combineLatest.completedCount = 3;
				combineLatest.completionSource.TrySetException(error);
				return;
			}
			combineLatest.completionSource.TrySetResult(result: false);
			return;
			IL_006f:
			if (!combineLatest.TrySetResult() && !combineLatest.syncRunning)
			{
				combineLatest.running2 = true;
				try
				{
					combineLatest.awaiter2 = combineLatest.enumerator2.MoveNextAsync().GetAwaiter();
				}
				catch (Exception error2)
				{
					combineLatest.completedCount = 3;
					combineLatest.completionSource.TrySetException(error2);
					return;
				}
				combineLatest.awaiter2.SourceOnCompleted(Completed2Delegate, combineLatest);
			}
		}

		private static void Completed3(object state)
		{
			_CombineLatest combineLatest = (_CombineLatest)state;
			combineLatest.running3 = false;
			try
			{
				if (combineLatest.awaiter3.GetResult())
				{
					combineLatest.hasCurrent3 = true;
					combineLatest.current3 = combineLatest.enumerator3.Current;
					goto IL_006f;
				}
				combineLatest.running3 = true;
				if (Interlocked.Increment(ref combineLatest.completedCount) != 3)
				{
					return;
				}
			}
			catch (Exception error)
			{
				combineLatest.running3 = true;
				combineLatest.completedCount = 3;
				combineLatest.completionSource.TrySetException(error);
				return;
			}
			combineLatest.completionSource.TrySetResult(result: false);
			return;
			IL_006f:
			if (!combineLatest.TrySetResult() && !combineLatest.syncRunning)
			{
				combineLatest.running3 = true;
				try
				{
					combineLatest.awaiter3 = combineLatest.enumerator3.MoveNextAsync().GetAwaiter();
				}
				catch (Exception error2)
				{
					combineLatest.completedCount = 3;
					combineLatest.completionSource.TrySetException(error2);
					return;
				}
				combineLatest.awaiter3.SourceOnCompleted(Completed3Delegate, combineLatest);
			}
		}

		private bool TrySetResult()
		{
			if (hasCurrent1 && hasCurrent2 && hasCurrent3)
			{
				result = resultSelector(current1, current2, current3);
				completionSource.TrySetResult(result: true);
				return true;
			}
			return false;
		}

		public async UniTask DisposeAsync()
		{
			if (enumerator1 != null)
			{
				await enumerator1.DisposeAsync();
			}
			if (enumerator2 != null)
			{
				await enumerator2.DisposeAsync();
			}
			if (enumerator3 != null)
			{
				await enumerator3.DisposeAsync();
			}
		}
	}

	private readonly IUniTaskAsyncEnumerable<T1> source1;

	private readonly IUniTaskAsyncEnumerable<T2> source2;

	private readonly IUniTaskAsyncEnumerable<T3> source3;

	private readonly Func<T1, T2, T3, TResult> resultSelector;

	public CombineLatest(IUniTaskAsyncEnumerable<T1> source1, IUniTaskAsyncEnumerable<T2> source2, IUniTaskAsyncEnumerable<T3> source3, Func<T1, T2, T3, TResult> resultSelector)
	{
		this.source1 = source1;
		this.source2 = source2;
		this.source3 = source3;
		this.resultSelector = resultSelector;
	}

	public IUniTaskAsyncEnumerator<TResult> GetAsyncEnumerator(CancellationToken cancellationToken = default(CancellationToken))
	{
		return new _CombineLatest(source1, source2, source3, resultSelector, cancellationToken);
	}
}
internal class CombineLatest<T1, T2, T3, T4, TResult> : IUniTaskAsyncEnumerable<TResult>
{
	private class _CombineLatest : MoveNextSource, IUniTaskAsyncEnumerator<TResult>, IUniTaskAsyncDisposable
	{
		private static readonly Action<object> Completed1Delegate = Completed1;

		private static readonly Action<object> Completed2Delegate = Completed2;

		private static readonly Action<object> Completed3Delegate = Completed3;

		private static readonly Action<object> Completed4Delegate = Completed4;

		private readonly IUniTaskAsyncEnumerable<T1> source1;

		private readonly IUniTaskAsyncEnumerable<T2> source2;

		private readonly IUniTaskAsyncEnumerable<T3> source3;

		private readonly IUniTaskAsyncEnumerable<T4> source4;

		private readonly Func<T1, T2, T3, T4, TResult> resultSelector;

		private CancellationToken cancellationToken;

		private IUniTaskAsyncEnumerator<T1> enumerator1;

		private UniTask<bool>.Awaiter awaiter1;

		private bool hasCurrent1;

		private bool running1;

		private T1 current1;

		private IUniTaskAsyncEnumerator<T2> enumerator2;

		private UniTask<bool>.Awaiter awaiter2;

		private bool hasCurrent2;

		private bool running2;

		private T2 current2;

		private IUniTaskAsyncEnumerator<T3> enumerator3;

		private UniTask<bool>.Awaiter awaiter3;

		private bool hasCurrent3;

		private bool running3;

		private T3 current3;

		private IUniTaskAsyncEnumerator<T4> enumerator4;

		private UniTask<bool>.Awaiter awaiter4;

		private bool hasCurrent4;

		private bool running4;

		private T4 current4;

		private int completedCount;

		private bool syncRunning;

		private TResult result;

		public TResult Current => result;

		public _CombineLatest(IUniTaskAsyncEnumerable<T1> source1, IUniTaskAsyncEnumerable<T2> source2, IUniTaskAsyncEnumerable<T3> source3, IUniTaskAsyncEnumerable<T4> source4, Func<T1, T2, T3, T4, TResult> resultSelector, CancellationToken cancellationToken)
		{
			this.source1 = source1;
			this.source2 = source2;
			this.source3 = source3;
			this.source4 = source4;
			this.resultSelector = resultSelector;
			this.cancellationToken = cancellationToken;
		}

		public UniTask<bool> MoveNextAsync()
		{
			cancellationToken.ThrowIfCancellationRequested();
			if (completedCount == 4)
			{
				return CompletedTasks.False;
			}
			if (enumerator1 == null)
			{
				enumerator1 = source1.GetAsyncEnumerator(cancellationToken);
				enumerator2 = source2.GetAsyncEnumerator(cancellationToken);
				enumerator3 = source3.GetAsyncEnumerator(cancellationToken);
				enumerator4 = source4.GetAsyncEnumerator(cancellationToken);
			}
			completionSource.Reset();
			do
			{
				syncRunning = true;
				if (!running1)
				{
					running1 = true;
					awaiter1 = enumerator1.MoveNextAsync().GetAwaiter();
					if (awaiter1.IsCompleted)
					{
						Completed1(this);
					}
					else
					{
						awaiter1.SourceOnCompleted(Completed1Delegate, this);
					}
				}
				if (!running2)
				{
					running2 = true;
					awaiter2 = enumerator2.MoveNextAsync().GetAwaiter();
					if (awaiter2.IsCompleted)
					{
						Completed2(this);
					}
					else
					{
						awaiter2.SourceOnCompleted(Completed2Delegate, this);
					}
				}
				if (!running3)
				{
					running3 = true;
					awaiter3 = enumerator3.MoveNextAsync().GetAwaiter();
					if (awaiter3.IsCompleted)
					{
						Completed3(this);
					}
					else
					{
						awaiter3.SourceOnCompleted(Completed3Delegate, this);
					}
				}
				if (!running4)
				{
					running4 = true;
					awaiter4 = enumerator4.MoveNextAsync().GetAwaiter();
					if (awaiter4.IsCompleted)
					{
						Completed4(this);
					}
					else
					{
						awaiter4.SourceOnCompleted(Completed4Delegate, this);
					}
				}
			}
			while (!running1 || !running2 || !running3 || !running4);
			syncRunning = false;
			return new UniTask<bool>(this, completionSource.Version);
		}

		private static void Completed1(object state)
		{
			_CombineLatest combineLatest = (_CombineLatest)state;
			combineLatest.running1 = false;
			try
			{
				if (combineLatest.awaiter1.GetResult())
				{
					combineLatest.hasCurrent1 = true;
					combineLatest.current1 = combineLatest.enumerator1.Current;
					goto IL_006f;
				}
				combineLatest.running1 = true;
				if (Interlocked.Increment(ref combineLatest.completedCount) != 4)
				{
					return;
				}
			}
			catch (Exception error)
			{
				combineLatest.running1 = true;
				combineLatest.completedCount = 4;
				combineLatest.completionSource.TrySetException(error);
				return;
			}
			combineLatest.completionSource.TrySetResult(result: false);
			return;
			IL_006f:
			if (!combineLatest.TrySetResult() && !combineLatest.syncRunning)
			{
				combineLatest.running1 = true;
				try
				{
					combineLatest.awaiter1 = combineLatest.enumerator1.MoveNextAsync().GetAwaiter();
				}
				catch (Exception error2)
				{
					combineLatest.completedCount = 4;
					combineLatest.completionSource.TrySetException(error2);
					return;
				}
				combineLatest.awaiter1.SourceOnCompleted(Completed1Delegate, combineLatest);
			}
		}

		private static void Completed2(object state)
		{
			_CombineLatest combineLatest = (_CombineLatest)state;
			combineLatest.running2 = false;
			try
			{
				if (combineLatest.awaiter2.GetResult())
				{
					combineLatest.hasCurrent2 = true;
					combineLatest.current2 = combineLatest.enumerator2.Current;
					goto IL_006f;
				}
				combineLatest.running2 = true;
				if (Interlocked.Increment(ref combineLatest.completedCount) != 4)
				{
					return;
				}
			}
			catch (Exception error)
			{
				combineLatest.running2 = true;
				combineLatest.completedCount = 4;
				combineLatest.completionSource.TrySetException(error);
				return;
			}
			combineLatest.completionSource.TrySetResult(result: false);
			return;
			IL_006f:
			if (!combineLatest.TrySetResult() && !combineLatest.syncRunning)
			{
				combineLatest.running2 = true;
				try
				{
					combineLatest.awaiter2 = combineLatest.enumerator2.MoveNextAsync().GetAwaiter();
				}
				catch (Exception error2)
				{
					combineLatest.completedCount = 4;
					combineLatest.completionSource.TrySetException(error2);
					return;
				}
				combineLatest.awaiter2.SourceOnCompleted(Completed2Delegate, combineLatest);
			}
		}

		private static void Completed3(object state)
		{
			_CombineLatest combineLatest = (_CombineLatest)state;
			combineLatest.running3 = false;
			try
			{
				if (combineLatest.awaiter3.GetResult())
				{
					combineLatest.hasCurrent3 = true;
					combineLatest.current3 = combineLatest.enumerator3.Current;
					goto IL_006f;
				}
				combineLatest.running3 = true;
				if (Interlocked.Increment(ref combineLatest.completedCount) != 4)
				{
					return;
				}
			}
			catch (Exception error)
			{
				combineLatest.running3 = true;
				combineLatest.completedCount = 4;
				combineLatest.completionSource.TrySetException(error);
				return;
			}
			combineLatest.completionSource.TrySetResult(result: false);
			return;
			IL_006f:
			if (!combineLatest.TrySetResult() && !combineLatest.syncRunning)
			{
				combineLatest.running3 = true;
				try
				{
					combineLatest.awaiter3 = combineLatest.enumerator3.MoveNextAsync().GetAwaiter();
				}
				catch (Exception error2)
				{
					combineLatest.completedCount = 4;
					combineLatest.completionSource.TrySetException(error2);
					return;
				}
				combineLatest.awaiter3.SourceOnCompleted(Completed3Delegate, combineLatest);
			}
		}

		private static void Completed4(object state)
		{
			_CombineLatest combineLatest = (_CombineLatest)state;
			combineLatest.running4 = false;
			try
			{
				if (combineLatest.awaiter4.GetResult())
				{
					combineLatest.hasCurrent4 = true;
					combineLatest.current4 = combineLatest.enumerator4.Current;
					goto IL_006f;
				}
				combineLatest.running4 = true;
				if (Interlocked.Increment(ref combineLatest.completedCount) != 4)
				{
					return;
				}
			}
			catch (Exception error)
			{
				combineLatest.running4 = true;
				combineLatest.completedCount = 4;
				combineLatest.completionSource.TrySetException(error);
				return;
			}
			combineLatest.completionSource.TrySetResult(result: false);
			return;
			IL_006f:
			if (!combineLatest.TrySetResult() && !combineLatest.syncRunning)
			{
				combineLatest.running4 = true;
				try
				{
					combineLatest.awaiter4 = combineLatest.enumerator4.MoveNextAsync().GetAwaiter();
				}
				catch (Exception error2)
				{
					combineLatest.completedCount = 4;
					combineLatest.completionSource.TrySetException(error2);
					return;
				}
				combineLatest.awaiter4.SourceOnCompleted(Completed4Delegate, combineLatest);
			}
		}

		private bool TrySetResult()
		{
			if (hasCurrent1 && hasCurrent2 && hasCurrent3 && hasCurrent4)
			{
				result = resultSelector(current1, current2, current3, current4);
				completionSource.TrySetResult(result: true);
				return true;
			}
			return false;
		}

		public async UniTask DisposeAsync()
		{
			if (enumerator1 != null)
			{
				await enumerator1.DisposeAsync();
			}
			if (enumerator2 != null)
			{
				await enumerator2.DisposeAsync();
			}
			if (enumerator3 != null)
			{
				await enumerator3.DisposeAsync();
			}
			if (enumerator4 != null)
			{
				await enumerator4.DisposeAsync();
			}
		}
	}

	private readonly IUniTaskAsyncEnumerable<T1> source1;

	private readonly IUniTaskAsyncEnumerable<T2> source2;

	private readonly IUniTaskAsyncEnumerable<T3> source3;

	private readonly IUniTaskAsyncEnumerable<T4> source4;

	private readonly Func<T1, T2, T3, T4, TResult> resultSelector;

	public CombineLatest(IUniTaskAsyncEnumerable<T1> source1, IUniTaskAsyncEnumerable<T2> source2, IUniTaskAsyncEnumerable<T3> source3, IUniTaskAsyncEnumerable<T4> source4, Func<T1, T2, T3, T4, TResult> resultSelector)
	{
		this.source1 = source1;
		this.source2 = source2;
		this.source3 = source3;
		this.source4 = source4;
		this.resultSelector = resultSelector;
	}

	public IUniTaskAsyncEnumerator<TResult> GetAsyncEnumerator(CancellationToken cancellationToken = default(CancellationToken))
	{
		return new _CombineLatest(source1, source2, source3, source4, resultSelector, cancellationToken);
	}
}
internal class CombineLatest<T1, T2, T3, T4, T5, TResult> : IUniTaskAsyncEnumerable<TResult>
{
	private class _CombineLatest : MoveNextSource, IUniTaskAsyncEnumerator<TResult>, IUniTaskAsyncDisposable
	{
		private static readonly Action<object> Completed1Delegate = Completed1;

		private static readonly Action<object> Completed2Delegate = Completed2;

		private static readonly Action<object> Completed3Delegate = Completed3;

		private static readonly Action<object> Completed4Delegate = Completed4;

		private static readonly Action<object> Completed5Delegate = Completed5;

		private readonly IUniTaskAsyncEnumerable<T1> source1;

		private readonly IUniTaskAsyncEnumerable<T2> source2;

		private readonly IUniTaskAsyncEnumerable<T3> source3;

		private readonly IUniTaskAsyncEnumerable<T4> source4;

		private readonly IUniTaskAsyncEnumerable<T5> source5;

		private readonly Func<T1, T2, T3, T4, T5, TResult> resultSelector;

		private CancellationToken cancellationToken;

		private IUniTaskAsyncEnumerator<T1> enumerator1;

		private UniTask<bool>.Awaiter awaiter1;

		private bool hasCurrent1;

		private bool running1;

		private T1 current1;

		private IUniTaskAsyncEnumerator<T2> enumerator2;

		private UniTask<bool>.Awaiter awaiter2;

		private bool hasCurrent2;

		private bool running2;

		private T2 current2;

		private IUniTaskAsyncEnumerator<T3> enumerator3;

		private UniTask<bool>.Awaiter awaiter3;

		private bool hasCurrent3;

		private bool running3;

		private T3 current3;

		private IUniTaskAsyncEnumerator<T4> enumerator4;

		private UniTask<bool>.Awaiter awaiter4;

		private bool hasCurrent4;

		private bool running4;

		private T4 current4;

		private IUniTaskAsyncEnumerator<T5> enumerator5;

		private UniTask<bool>.Awaiter awaiter5;

		private bool hasCurrent5;

		private bool running5;

		private T5 current5;

		private int completedCount;

		private bool syncRunning;

		private TResult result;

		public TResult Current => result;

		public _CombineLatest(IUniTaskAsyncEnumerable<T1> source1, IUniTaskAsyncEnumerable<T2> source2, IUniTaskAsyncEnumerable<T3> source3, IUniTaskAsyncEnumerable<T4> source4, IUniTaskAsyncEnumerable<T5> source5, Func<T1, T2, T3, T4, T5, TResult> resultSelector, CancellationToken cancellationToken)
		{
			this.source1 = source1;
			this.source2 = source2;
			this.source3 = source3;
			this.source4 = source4;
			this.source5 = source5;
			this.resultSelector = resultSelector;
			this.cancellationToken = cancellationToken;
		}

		public UniTask<bool> MoveNextAsync()
		{
			cancellationToken.ThrowIfCancellationRequested();
			if (completedCount == 5)
			{
				return CompletedTasks.False;
			}
			if (enumerator1 == null)
			{
				enumerator1 = source1.GetAsyncEnumerator(cancellationToken);
				enumerator2 = source2.GetAsyncEnumerator(cancellationToken);
				enumerator3 = source3.GetAsyncEnumerator(cancellationToken);
				enumerator4 = source4.GetAsyncEnumerator(cancellationToken);
				enumerator5 = source5.GetAsyncEnumerator(cancellationToken);
			}
			completionSource.Reset();
			do
			{
				syncRunning = true;
				if (!running1)
				{
					running1 = true;
					awaiter1 = enumerator1.MoveNextAsync().GetAwaiter();
					if (awaiter1.IsCompleted)
					{
						Completed1(this);
					}
					else
					{
						awaiter1.SourceOnCompleted(Completed1Delegate, this);
					}
				}
				if (!running2)
				{
					running2 = true;
					awaiter2 = enumerator2.MoveNextAsync().GetAwaiter();
					if (awaiter2.IsCompleted)
					{
						Completed2(this);
					}
					else
					{
						awaiter2.SourceOnCompleted(Completed2Delegate, this);
					}
				}
				if (!running3)
				{
					running3 = true;
					awaiter3 = enumerator3.MoveNextAsync().GetAwaiter();
					if (awaiter3.IsCompleted)
					{
						Completed3(this);
					}
					else
					{
						awaiter3.SourceOnCompleted(Completed3Delegate, this);
					}
				}
				if (!running4)
				{
					running4 = true;
					awaiter4 = enumerator4.MoveNextAsync().GetAwaiter();
					if (awaiter4.IsCompleted)
					{
						Completed4(this);
					}
					else
					{
						awaiter4.SourceOnCompleted(Completed4Delegate, this);
					}
				}
				if (!running5)
				{
					running5 = true;
					awaiter5 = enumerator5.MoveNextAsync().GetAwaiter();
					if (awaiter5.IsCompleted)
					{
						Completed5(this);
					}
					else
					{
						awaiter5.SourceOnCompleted(Completed5Delegate, this);
					}
				}
			}
			while (!running1 || !running2 || !running3 || !running4 || !running5);
			syncRunning = false;
			return new UniTask<bool>(this, completionSource.Version);
		}

		private static void Completed1(object state)
		{
			_CombineLatest combineLatest = (_CombineLatest)state;
			combineLatest.running1 = false;
			try
			{
				if (combineLatest.awaiter1.GetResult())
				{
					combineLatest.hasCurrent1 = true;
					combineLatest.current1 = combineLatest.enumerator1.Current;
					goto IL_006f;
				}
				combineLatest.running1 = true;
				if (Interlocked.Increment(ref combineLatest.completedCount) != 5)
				{
					return;
				}
			}
			catch (Exception error)
			{
				combineLatest.running1 = true;
				combineLatest.completedCount = 5;
				combineLatest.completionSource.TrySetException(error);
				return;
			}
			combineLatest.completionSource.TrySetResult(result: false);
			return;
			IL_006f:
			if (!combineLatest.TrySetResult() && !combineLatest.syncRunning)
			{
				combineLatest.running1 = true;
				try
				{
					combineLatest.awaiter1 = combineLatest.enumerator1.MoveNextAsync().GetAwaiter();
				}
				catch (Exception error2)
				{
					combineLatest.completedCount = 5;
					combineLatest.completionSource.TrySetException(error2);
					return;
				}
				combineLatest.awaiter1.SourceOnCompleted(Completed1Delegate, combineLatest);
			}
		}

		private static void Completed2(object state)
		{
			_CombineLatest combineLatest = (_CombineLatest)state;
			combineLatest.running2 = false;
			try
			{
				if (combineLatest.awaiter2.GetResult())
				{
					combineLatest.hasCurrent2 = true;
					combineLatest.current2 = combineLatest.enumerator2.Current;
					goto IL_006f;
				}
				combineLatest.running2 = true;
				if (Interlocked.Increment(ref combineLatest.completedCount) != 5)
				{
					return;
				}
			}
			catch (Exception error)
			{
				combineLatest.running2 = true;
				combineLatest.completedCount = 5;
				combineLatest.completionSource.TrySetException(error);
				return;
			}
			combineLatest.completionSource.TrySetResult(result: false);
			return;
			IL_006f:
			if (!combineLatest.TrySetResult() && !combineLatest.syncRunning)
			{
				combineLatest.running2 = true;
				try
				{
					combineLatest.awaiter2 = combineLatest.enumerator2.MoveNextAsync().GetAwaiter();
				}
				catch (Exception error2)
				{
					combineLatest.completedCount = 5;
					combineLatest.completionSource.TrySetException(error2);
					return;
				}
				combineLatest.awaiter2.SourceOnCompleted(Completed2Delegate, combineLatest);
			}
		}

		private static void Completed3(object state)
		{
			_CombineLatest combineLatest = (_CombineLatest)state;
			combineLatest.running3 = false;
			try
			{
				if (combineLatest.awaiter3.GetResult())
				{
					combineLatest.hasCurrent3 = true;
					combineLatest.current3 = combineLatest.enumerator3.Current;
					goto IL_006f;
				}
				combineLatest.running3 = true;
				if (Interlocked.Increment(ref combineLatest.completedCount) != 5)
				{
					return;
				}
			}
			catch (Exception error)
			{
				combineLatest.running3 = true;
				combineLatest.completedCount = 5;
				combineLatest.completionSource.TrySetException(error);
				return;
			}
			combineLatest.completionSource.TrySetResult(result: false);
			return;
			IL_006f:
			if (!combineLatest.TrySetResult() && !combineLatest.syncRunning)
			{
				combineLatest.running3 = true;
				try
				{
					combineLatest.awaiter3 = combineLatest.enumerator3.MoveNextAsync().GetAwaiter();
				}
				catch (Exception error2)
				{
					combineLatest.completedCount = 5;
					combineLatest.completionSource.TrySetException(error2);
					return;
				}
				combineLatest.awaiter3.SourceOnCompleted(Completed3Delegate, combineLatest);
			}
		}

		private static void Completed4(object state)
		{
			_CombineLatest combineLatest = (_CombineLatest)state;
			combineLatest.running4 = false;
			try
			{
				if (combineLatest.awaiter4.GetResult())
				{
					combineLatest.hasCurrent4 = true;
					combineLatest.current4 = combineLatest.enumerator4.Current;
					goto IL_006f;
				}
				combineLatest.running4 = true;
				if (Interlocked.Increment(ref combineLatest.completedCount) != 5)
				{
					return;
				}
			}
			catch (Exception error)
			{
				combineLatest.running4 = true;
				combineLatest.completedCount = 5;
				combineLatest.completionSource.TrySetException(error);
				return;
			}
			combineLatest.completionSource.TrySetResult(result: false);
			return;
			IL_006f:
			if (!combineLatest.TrySetResult() && !combineLatest.syncRunning)
			{
				combineLatest.running4 = true;
				try
				{
					combineLatest.awaiter4 = combineLatest.enumerator4.MoveNextAsync().GetAwaiter();
				}
				catch (Exception error2)
				{
					combineLatest.completedCount = 5;
					combineLatest.completionSource.TrySetException(error2);
					return;
				}
				combineLatest.awaiter4.SourceOnCompleted(Completed4Delegate, combineLatest);
			}
		}

		private static void Completed5(object state)
		{
			_CombineLatest combineLatest = (_CombineLatest)state;
			combineLatest.running5 = false;
			try
			{
				if (combineLatest.awaiter5.GetResult())
				{
					combineLatest.hasCurrent5 = true;
					combineLatest.current5 = combineLatest.enumerator5.Current;
					goto IL_006f;
				}
				combineLatest.running5 = true;
				if (Interlocked.Increment(ref combineLatest.completedCount) != 5)
				{
					return;
				}
			}
			catch (Exception error)
			{
				combineLatest.running5 = true;
				combineLatest.completedCount = 5;
				combineLatest.completionSource.TrySetException(error);
				return;
			}
			combineLatest.completionSource.TrySetResult(result: false);
			return;
			IL_006f:
			if (!combineLatest.TrySetResult() && !combineLatest.syncRunning)
			{
				combineLatest.running5 = true;
				try
				{
					combineLatest.awaiter5 = combineLatest.enumerator5.MoveNextAsync().GetAwaiter();
				}
				catch (Exception error2)
				{
					combineLatest.completedCount = 5;
					combineLatest.completionSource.TrySetException(error2);
					return;
				}
				combineLatest.awaiter5.SourceOnCompleted(Completed5Delegate, combineLatest);
			}
		}

		private bool TrySetResult()
		{
			if (hasCurrent1 && hasCurrent2 && hasCurrent3 && hasCurrent4 && hasCurrent5)
			{
				result = resultSelector(current1, current2, current3, current4, current5);
				completionSource.TrySetResult(result: true);
				return true;
			}
			return false;
		}

		public async UniTask DisposeAsync()
		{
			if (enumerator1 != null)
			{
				await enumerator1.DisposeAsync();
			}
			if (enumerator2 != null)
			{
				await enumerator2.DisposeAsync();
			}
			if (enumerator3 != null)
			{
				await enumerator3.DisposeAsync();
			}
			if (enumerator4 != null)
			{
				await enumerator4.DisposeAsync();
			}
			if (enumerator5 != null)
			{
				await enumerator5.DisposeAsync();
			}
		}
	}

	private readonly IUniTaskAsyncEnumerable<T1> source1;

	private readonly IUniTaskAsyncEnumerable<T2> source2;

	private readonly IUniTaskAsyncEnumerable<T3> source3;

	private readonly IUniTaskAsyncEnumerable<T4> source4;

	private readonly IUniTaskAsyncEnumerable<T5> source5;

	private readonly Func<T1, T2, T3, T4, T5, TResult> resultSelector;

	public CombineLatest(IUniTaskAsyncEnumerable<T1> source1, IUniTaskAsyncEnumerable<T2> source2, IUniTaskAsyncEnumerable<T3> source3, IUniTaskAsyncEnumerable<T4> source4, IUniTaskAsyncEnumerable<T5> source5, Func<T1, T2, T3, T4, T5, TResult> resultSelector)
	{
		this.source1 = source1;
		this.source2 = source2;
		this.source3 = source3;
		this.source4 = source4;
		this.source5 = source5;
		this.resultSelector = resultSelector;
	}

	public IUniTaskAsyncEnumerator<TResult> GetAsyncEnumerator(CancellationToken cancellationToken = default(CancellationToken))
	{
		return new _CombineLatest(source1, source2, source3, source4, source5, resultSelector, cancellationToken);
	}
}
internal class CombineLatest<T1, T2, T3, T4, T5, T6, TResult> : IUniTaskAsyncEnumerable<TResult>
{
	private class _CombineLatest : MoveNextSource, IUniTaskAsyncEnumerator<TResult>, IUniTaskAsyncDisposable
	{
		private static readonly Action<object> Completed1Delegate = Completed1;

		private static readonly Action<object> Completed2Delegate = Completed2;

		private static readonly Action<object> Completed3Delegate = Completed3;

		private static readonly Action<object> Completed4Delegate = Completed4;

		private static readonly Action<object> Completed5Delegate = Completed5;

		private static readonly Action<object> Completed6Delegate = Completed6;

		private readonly IUniTaskAsyncEnumerable<T1> source1;

		private readonly IUniTaskAsyncEnumerable<T2> source2;

		private readonly IUniTaskAsyncEnumerable<T3> source3;

		private readonly IUniTaskAsyncEnumerable<T4> source4;

		private readonly IUniTaskAsyncEnumerable<T5> source5;

		private readonly IUniTaskAsyncEnumerable<T6> source6;

		private readonly Func<T1, T2, T3, T4, T5, T6, TResult> resultSelector;

		private CancellationToken cancellationToken;

		private IUniTaskAsyncEnumerator<T1> enumerator1;

		private UniTask<bool>.Awaiter awaiter1;

		private bool hasCurrent1;

		private bool running1;

		private T1 current1;

		private IUniTaskAsyncEnumerator<T2> enumerator2;

		private UniTask<bool>.Awaiter awaiter2;

		private bool hasCurrent2;

		private bool running2;

		private T2 current2;

		private IUniTaskAsyncEnumerator<T3> enumerator3;

		private UniTask<bool>.Awaiter awaiter3;

		private bool hasCurrent3;

		private bool running3;

		private T3 current3;

		private IUniTaskAsyncEnumerator<T4> enumerator4;

		private UniTask<bool>.Awaiter awaiter4;

		private bool hasCurrent4;

		private bool running4;

		private T4 current4;

		private IUniTaskAsyncEnumerator<T5> enumerator5;

		private UniTask<bool>.Awaiter awaiter5;

		private bool hasCurrent5;

		private bool running5;

		private T5 current5;

		private IUniTaskAsyncEnumerator<T6> enumerator6;

		private UniTask<bool>.Awaiter awaiter6;

		private bool hasCurrent6;

		private bool running6;

		private T6 current6;

		private int completedCount;

		private bool syncRunning;

		private TResult result;

		public TResult Current => result;

		public _CombineLatest(IUniTaskAsyncEnumerable<T1> source1, IUniTaskAsyncEnumerable<T2> source2, IUniTaskAsyncEnumerable<T3> source3, IUniTaskAsyncEnumerable<T4> source4, IUniTaskAsyncEnumerable<T5> source5, IUniTaskAsyncEnumerable<T6> source6, Func<T1, T2, T3, T4, T5, T6, TResult> resultSelector, CancellationToken cancellationToken)
		{
			this.source1 = source1;
			this.source2 = source2;
			this.source3 = source3;
			this.source4 = source4;
			this.source5 = source5;
			this.source6 = source6;
			this.resultSelector = resultSelector;
			this.cancellationToken = cancellationToken;
		}

		public UniTask<bool> MoveNextAsync()
		{
			cancellationToken.ThrowIfCancellationRequested();
			if (completedCount == 6)
			{
				return CompletedTasks.False;
			}
			if (enumerator1 == null)
			{
				enumerator1 = source1.GetAsyncEnumerator(cancellationToken);
				enumerator2 = source2.GetAsyncEnumerator(cancellationToken);
				enumerator3 = source3.GetAsyncEnumerator(cancellationToken);
				enumerator4 = source4.GetAsyncEnumerator(cancellationToken);
				enumerator5 = source5.GetAsyncEnumerator(cancellationToken);
				enumerator6 = source6.GetAsyncEnumerator(cancellationToken);
			}
			completionSource.Reset();
			do
			{
				syncRunning = true;
				if (!running1)
				{
					running1 = true;
					awaiter1 = enumerator1.MoveNextAsync().GetAwaiter();
					if (awaiter1.IsCompleted)
					{
						Completed1(this);
					}
					else
					{
						awaiter1.SourceOnCompleted(Completed1Delegate, this);
					}
				}
				if (!running2)
				{
					running2 = true;
					awaiter2 = enumerator2.MoveNextAsync().GetAwaiter();
					if (awaiter2.IsCompleted)
					{
						Completed2(this);
					}
					else
					{
						awaiter2.SourceOnCompleted(Completed2Delegate, this);
					}
				}
				if (!running3)
				{
					running3 = true;
					awaiter3 = enumerator3.MoveNextAsync().GetAwaiter();
					if (awaiter3.IsCompleted)
					{
						Completed3(this);
					}
					else
					{
						awaiter3.SourceOnCompleted(Completed3Delegate, this);
					}
				}
				if (!running4)
				{
					running4 = true;
					awaiter4 = enumerator4.MoveNextAsync().GetAwaiter();
					if (awaiter4.IsCompleted)
					{
						Completed4(this);
					}
					else
					{
						awaiter4.SourceOnCompleted(Completed4Delegate, this);
					}
				}
				if (!running5)
				{
					running5 = true;
					awaiter5 = enumerator5.MoveNextAsync().GetAwaiter();
					if (awaiter5.IsCompleted)
					{
						Completed5(this);
					}
					else
					{
						awaiter5.SourceOnCompleted(Completed5Delegate, this);
					}
				}
				if (!running6)
				{
					running6 = true;
					awaiter6 = enumerator6.MoveNextAsync().GetAwaiter();
					if (awaiter6.IsCompleted)
					{
						Completed6(this);
					}
					else
					{
						awaiter6.SourceOnCompleted(Completed6Delegate, this);
					}
				}
			}
			while (!running1 || !running2 || !running3 || !running4 || !running5 || !running6);
			syncRunning = false;
			return new UniTask<bool>(this, completionSource.Version);
		}

		private static void Completed1(object state)
		{
			_CombineLatest combineLatest = (_CombineLatest)state;
			combineLatest.running1 = false;
			try
			{
				if (combineLatest.awaiter1.GetResult())
				{
					combineLatest.hasCurrent1 = true;
					combineLatest.current1 = combineLatest.enumerator1.Current;
					goto IL_006f;
				}
				combineLatest.running1 = true;
				if (Interlocked.Increment(ref combineLatest.completedCount) != 6)
				{
					return;
				}
			}
			catch (Exception error)
			{
				combineLatest.running1 = true;
				combineLatest.completedCount = 6;
				combineLatest.completionSource.TrySetException(error);
				return;
			}
			combineLatest.completionSource.TrySetResult(result: false);
			return;
			IL_006f:
			if (!combineLatest.TrySetResult() && !combineLatest.syncRunning)
			{
				combineLatest.running1 = true;
				try
				{
					combineLatest.awaiter1 = combineLatest.enumerator1.MoveNextAsync().GetAwaiter();
				}
				catch (Exception error2)
				{
					combineLatest.completedCount = 6;
					combineLatest.completionSource.TrySetException(error2);
					return;
				}
				combineLatest.awaiter1.SourceOnCompleted(Completed1Delegate, combineLatest);
			}
		}

		private static void Completed2(object state)
		{
			_CombineLatest combineLatest = (_CombineLatest)state;
			combineLatest.running2 = false;
			try
			{
				if (combineLatest.awaiter2.GetResult())
				{
					combineLatest.hasCurrent2 = true;
					combineLatest.current2 = combineLatest.enumerator2.Current;
					goto IL_006f;
				}
				combineLatest.running2 = true;
				if (Interlocked.Increment(ref combineLatest.completedCount) != 6)
				{
					return;
				}
			}
			catch (Exception error)
			{
				combineLatest.running2 = true;
				combineLatest.completedCount = 6;
				combineLatest.completionSource.TrySetException(error);
				return;
			}
			combineLatest.completionSource.TrySetResult(result: false);
			return;
			IL_006f:
			if (!combineLatest.TrySetResult() && !combineLatest.syncRunning)
			{
				combineLatest.running2 = true;
				try
				{
					combineLatest.awaiter2 = combineLatest.enumerator2.MoveNextAsync().GetAwaiter();
				}
				catch (Exception error2)
				{
					combineLatest.completedCount = 6;
					combineLatest.completionSource.TrySetException(error2);
					return;
				}
				combineLatest.awaiter2.SourceOnCompleted(Completed2Delegate, combineLatest);
			}
		}

		private static void Completed3(object state)
		{
			_CombineLatest combineLatest = (_CombineLatest)state;
			combineLatest.running3 = false;
			try
			{
				if (combineLatest.awaiter3.GetResult())
				{
					combineLatest.hasCurrent3 = true;
					combineLatest.current3 = combineLatest.enumerator3.Current;
					goto IL_006f;
				}
				combineLatest.running3 = true;
				if (Interlocked.Increment(ref combineLatest.completedCount) != 6)
				{
					return;
				}
			}
			catch (Exception error)
			{
				combineLatest.running3 = true;
				combineLatest.completedCount = 6;
				combineLatest.completionSource.TrySetException(error);
				return;
			}
			combineLatest.completionSource.TrySetResult(result: false);
			return;
			IL_006f:
			if (!combineLatest.TrySetResult() && !combineLatest.syncRunning)
			{
				combineLatest.running3 = true;
				try
				{
					combineLatest.awaiter3 = combineLatest.enumerator3.MoveNextAsync().GetAwaiter();
				}
				catch (Exception error2)
				{
					combineLatest.completedCount = 6;
					combineLatest.completionSource.TrySetException(error2);
					return;
				}
				combineLatest.awaiter3.SourceOnCompleted(Completed3Delegate, combineLatest);
			}
		}

		private static void Completed4(object state)
		{
			_CombineLatest combineLatest = (_CombineLatest)state;
			combineLatest.running4 = false;
			try
			{
				if (combineLatest.awaiter4.GetResult())
				{
					combineLatest.hasCurrent4 = true;
					combineLatest.current4 = combineLatest.enumerator4.Current;
					goto IL_006f;
				}
				combineLatest.running4 = true;
				if (Interlocked.Increment(ref combineLatest.completedCount) != 6)
				{
					return;
				}
			}
			catch (Exception error)
			{
				combineLatest.running4 = true;
				combineLatest.completedCount = 6;
				combineLatest.completionSource.TrySetException(error);
				return;
			}
			combineLatest.completionSource.TrySetResult(result: false);
			return;
			IL_006f:
			if (!combineLatest.TrySetResult() && !combineLatest.syncRunning)
			{
				combineLatest.running4 = true;
				try
				{
					combineLatest.awaiter4 = combineLatest.enumerator4.MoveNextAsync().GetAwaiter();
				}
				catch (Exception error2)
				{
					combineLatest.completedCount = 6;
					combineLatest.completionSource.TrySetException(error2);
					return;
				}
				combineLatest.awaiter4.SourceOnCompleted(Completed4Delegate, combineLatest);
			}
		}

		private static void Completed5(object state)
		{
			_CombineLatest combineLatest = (_CombineLatest)state;
			combineLatest.running5 = false;
			try
			{
				if (combineLatest.awaiter5.GetResult())
				{
					combineLatest.hasCurrent5 = true;
					combineLatest.current5 = combineLatest.enumerator5.Current;
					goto IL_006f;
				}
				combineLatest.running5 = true;
				if (Interlocked.Increment(ref combineLatest.completedCount) != 6)
				{
					return;
				}
			}
			catch (Exception error)
			{
				combineLatest.running5 = true;
				combineLatest.completedCount = 6;
				combineLatest.completionSource.TrySetException(error);
				return;
			}
			combineLatest.completionSource.TrySetResult(result: false);
			return;
			IL_006f:
			if (!combineLatest.TrySetResult() && !combineLatest.syncRunning)
			{
				combineLatest.running5 = true;
				try
				{
					combineLatest.awaiter5 = combineLatest.enumerator5.MoveNextAsync().GetAwaiter();
				}
				catch (Exception error2)
				{
					combineLatest.completedCount = 6;
					combineLatest.completionSource.TrySetException(error2);
					return;
				}
				combineLatest.awaiter5.SourceOnCompleted(Completed5Delegate, combineLatest);
			}
		}

		private static void Completed6(object state)
		{
			_CombineLatest combineLatest = (_CombineLatest)state;
			combineLatest.running6 = false;
			try
			{
				if (combineLatest.awaiter6.GetResult())
				{
					combineLatest.hasCurrent6 = true;
					combineLatest.current6 = combineLatest.enumerator6.Current;
					goto IL_006f;
				}
				combineLatest.running6 = true;
				if (Interlocked.Increment(ref combineLatest.completedCount) != 6)
				{
					return;
				}
			}
			catch (Exception error)
			{
				combineLatest.running6 = true;
				combineLatest.completedCount = 6;
				combineLatest.completionSource.TrySetException(error);
				return;
			}
			combineLatest.completionSource.TrySetResult(result: false);
			return;
			IL_006f:
			if (!combineLatest.TrySetResult() && !combineLatest.syncRunning)
			{
				combineLatest.running6 = true;
				try
				{
					combineLatest.awaiter6 = combineLatest.enumerator6.MoveNextAsync().GetAwaiter();
				}
				catch (Exception error2)
				{
					combineLatest.completedCount = 6;
					combineLatest.completionSource.TrySetException(error2);
					return;
				}
				combineLatest.awaiter6.SourceOnCompleted(Completed6Delegate, combineLatest);
			}
		}

		private bool TrySetResult()
		{
			if (hasCurrent1 && hasCurrent2 && hasCurrent3 && hasCurrent4 && hasCurrent5 && hasCurrent6)
			{
				result = resultSelector(current1, current2, current3, current4, current5, current6);
				completionSource.TrySetResult(result: true);
				return true;
			}
			return false;
		}

		public async UniTask DisposeAsync()
		{
			if (enumerator1 != null)
			{
				await enumerator1.DisposeAsync();
			}
			if (enumerator2 != null)
			{
				await enumerator2.DisposeAsync();
			}
			if (enumerator3 != null)
			{
				await enumerator3.DisposeAsync();
			}
			if (enumerator4 != null)
			{
				await enumerator4.DisposeAsync();
			}
			if (enumerator5 != null)
			{
				await enumerator5.DisposeAsync();
			}
			if (enumerator6 != null)
			{
				await enumerator6.DisposeAsync();
			}
		}
	}

	private readonly IUniTaskAsyncEnumerable<T1> source1;

	private readonly IUniTaskAsyncEnumerable<T2> source2;

	private readonly IUniTaskAsyncEnumerable<T3> source3;

	private readonly IUniTaskAsyncEnumerable<T4> source4;

	private readonly IUniTaskAsyncEnumerable<T5> source5;

	private readonly IUniTaskAsyncEnumerable<T6> source6;

	private readonly Func<T1, T2, T3, T4, T5, T6, TResult> resultSelector;

	public CombineLatest(IUniTaskAsyncEnumerable<T1> source1, IUniTaskAsyncEnumerable<T2> source2, IUniTaskAsyncEnumerable<T3> source3, IUniTaskAsyncEnumerable<T4> source4, IUniTaskAsyncEnumerable<T5> source5, IUniTaskAsyncEnumerable<T6> source6, Func<T1, T2, T3, T4, T5, T6, TResult> resultSelector)
	{
		this.source1 = source1;
		this.source2 = source2;
		this.source3 = source3;
		this.source4 = source4;
		this.source5 = source5;
		this.source6 = source6;
		this.resultSelector = resultSelector;
	}

	public IUniTaskAsyncEnumerator<TResult> GetAsyncEnumerator(CancellationToken cancellationToken = default(CancellationToken))
	{
		return new _CombineLatest(source1, source2, source3, source4, source5, source6, resultSelector, cancellationToken);
	}
}
internal class CombineLatest<T1, T2, T3, T4, T5, T6, T7, TResult> : IUniTaskAsyncEnumerable<TResult>
{
	private class _CombineLatest : MoveNextSource, IUniTaskAsyncEnumerator<TResult>, IUniTaskAsyncDisposable
	{
		private static readonly Action<object> Completed1Delegate = Completed1;

		private static readonly Action<object> Completed2Delegate = Completed2;

		private static readonly Action<object> Completed3Delegate = Completed3;

		private static readonly Action<object> Completed4Delegate = Completed4;

		private static readonly Action<object> Completed5Delegate = Completed5;

		private static readonly Action<object> Completed6Delegate = Completed6;

		private static readonly Action<object> Completed7Delegate = Completed7;

		private readonly IUniTaskAsyncEnumerable<T1> source1;

		private readonly IUniTaskAsyncEnumerable<T2> source2;

		private readonly IUniTaskAsyncEnumerable<T3> source3;

		private readonly IUniTaskAsyncEnumerable<T4> source4;

		private readonly IUniTaskAsyncEnumerable<T5> source5;

		private readonly IUniTaskAsyncEnumerable<T6> source6;

		private readonly IUniTaskAsyncEnumerable<T7> source7;

		private readonly Func<T1, T2, T3, T4, T5, T6, T7, TResult> resultSelector;

		private CancellationToken cancellationToken;

		private IUniTaskAsyncEnumerator<T1> enumerator1;

		private UniTask<bool>.Awaiter awaiter1;

		private bool hasCurrent1;

		private bool running1;

		private T1 current1;

		private IUniTaskAsyncEnumerator<T2> enumerator2;

		private UniTask<bool>.Awaiter awaiter2;

		private bool hasCurrent2;

		private bool running2;

		private T2 current2;

		private IUniTaskAsyncEnumerator<T3> enumerator3;

		private UniTask<bool>.Awaiter awaiter3;

		private bool hasCurrent3;

		private bool running3;

		private T3 current3;

		private IUniTaskAsyncEnumerator<T4> enumerator4;

		private UniTask<bool>.Awaiter awaiter4;

		private bool hasCurrent4;

		private bool running4;

		private T4 current4;

		private IUniTaskAsyncEnumerator<T5> enumerator5;

		private UniTask<bool>.Awaiter awaiter5;

		private bool hasCurrent5;

		private bool running5;

		private T5 current5;

		private IUniTaskAsyncEnumerator<T6> enumerator6;

		private UniTask<bool>.Awaiter awaiter6;

		private bool hasCurrent6;

		private bool running6;

		private T6 current6;

		private IUniTaskAsyncEnumerator<T7> enumerator7;

		private UniTask<bool>.Awaiter awaiter7;

		private bool hasCurrent7;

		private bool running7;

		private T7 current7;

		private int completedCount;

		private bool syncRunning;

		private TResult result;

		public TResult Current => result;

		public _CombineLatest(IUniTaskAsyncEnumerable<T1> source1, IUniTaskAsyncEnumerable<T2> source2, IUniTaskAsyncEnumerable<T3> source3, IUniTaskAsyncEnumerable<T4> source4, IUniTaskAsyncEnumerable<T5> source5, IUniTaskAsyncEnumerable<T6> source6, IUniTaskAsyncEnumerable<T7> source7, Func<T1, T2, T3, T4, T5, T6, T7, TResult> resultSelector, CancellationToken cancellationToken)
		{
			this.source1 = source1;
			this.source2 = source2;
			this.source3 = source3;
			this.source4 = source4;
			this.source5 = source5;
			this.source6 = source6;
			this.source7 = source7;
			this.resultSelector = resultSelector;
			this.cancellationToken = cancellationToken;
		}

		public UniTask<bool> MoveNextAsync()
		{
			cancellationToken.ThrowIfCancellationRequested();
			if (completedCount == 7)
			{
				return CompletedTasks.False;
			}
			if (enumerator1 == null)
			{
				enumerator1 = source1.GetAsyncEnumerator(cancellationToken);
				enumerator2 = source2.GetAsyncEnumerator(cancellationToken);
				enumerator3 = source3.GetAsyncEnumerator(cancellationToken);
				enumerator4 = source4.GetAsyncEnumerator(cancellationToken);
				enumerator5 = source5.GetAsyncEnumerator(cancellationToken);
				enumerator6 = source6.GetAsyncEnumerator(cancellationToken);
				enumerator7 = source7.GetAsyncEnumerator(cancellationToken);
			}
			completionSource.Reset();
			do
			{
				syncRunning = true;
				if (!running1)
				{
					running1 = true;
					awaiter1 = enumerator1.MoveNextAsync().GetAwaiter();
					if (awaiter1.IsCompleted)
					{
						Completed1(this);
					}
					else
					{
						awaiter1.SourceOnCompleted(Completed1Delegate, this);
					}
				}
				if (!running2)
				{
					running2 = true;
					awaiter2 = enumerator2.MoveNextAsync().GetAwaiter();
					if (awaiter2.IsCompleted)
					{
						Completed2(this);
					}
					else
					{
						awaiter2.SourceOnCompleted(Completed2Delegate, this);
					}
				}
				if (!running3)
				{
					running3 = true;
					awaiter3 = enumerator3.MoveNextAsync().GetAwaiter();
					if (awaiter3.IsCompleted)
					{
						Completed3(this);
					}
					else
					{
						awaiter3.SourceOnCompleted(Completed3Delegate, this);
					}
				}
				if (!running4)
				{
					running4 = true;
					awaiter4 = enumerator4.MoveNextAsync().GetAwaiter();
					if (awaiter4.IsCompleted)
					{
						Completed4(this);
					}
					else
					{
						awaiter4.SourceOnCompleted(Completed4Delegate, this);
					}
				}
				if (!running5)
				{
					running5 = true;
					awaiter5 = enumerator5.MoveNextAsync().GetAwaiter();
					if (awaiter5.IsCompleted)
					{
						Completed5(this);
					}
					else
					{
						awaiter5.SourceOnCompleted(Completed5Delegate, this);
					}
				}
				if (!running6)
				{
					running6 = true;
					awaiter6 = enumerator6.MoveNextAsync().GetAwaiter();
					if (awaiter6.IsCompleted)
					{
						Completed6(this);
					}
					else
					{
						awaiter6.SourceOnCompleted(Completed6Delegate, this);
					}
				}
				if (!running7)
				{
					running7 = true;
					awaiter7 = enumerator7.MoveNextAsync().GetAwaiter();
					if (awaiter7.IsCompleted)
					{
						Completed7(this);
					}
					else
					{
						awaiter7.SourceOnCompleted(Completed7Delegate, this);
					}
				}
			}
			while (!running1 || !running2 || !running3 || !running4 || !running5 || !running6 || !running7);
			syncRunning = false;
			return new UniTask<bool>(this, completionSource.Version);
		}

		private static void Completed1(object state)
		{
			_CombineLatest combineLatest = (_CombineLatest)state;
			combineLatest.running1 = false;
			try
			{
				if (combineLatest.awaiter1.GetResult())
				{
					combineLatest.hasCurrent1 = true;
					combineLatest.current1 = combineLatest.enumerator1.Current;
					goto IL_006f;
				}
				combineLatest.running1 = true;
				if (Interlocked.Increment(ref combineLatest.completedCount) != 7)
				{
					return;
				}
			}
			catch (Exception error)
			{
				combineLatest.running1 = true;
				combineLatest.completedCount = 7;
				combineLatest.completionSource.TrySetException(error);
				return;
			}
			combineLatest.completionSource.TrySetResult(result: false);
			return;
			IL_006f:
			if (!combineLatest.TrySetResult() && !combineLatest.syncRunning)
			{
				combineLatest.running1 = true;
				try
				{
					combineLatest.awaiter1 = combineLatest.enumerator1.MoveNextAsync().GetAwaiter();
				}
				catch (Exception error2)
				{
					combineLatest.completedCount = 7;
					combineLatest.completionSource.TrySetException(error2);
					return;
				}
				combineLatest.awaiter1.SourceOnCompleted(Completed1Delegate, combineLatest);
			}
		}

		private static void Completed2(object state)
		{
			_CombineLatest combineLatest = (_CombineLatest)state;
			combineLatest.running2 = false;
			try
			{
				if (combineLatest.awaiter2.GetResult())
				{
					combineLatest.hasCurrent2 = true;
					combineLatest.current2 = combineLatest.enumerator2.Current;
					goto IL_006f;
				}
				combineLatest.running2 = true;
				if (Interlocked.Increment(ref combineLatest.completedCount) != 7)
				{
					return;
				}
			}
			catch (Exception error)
			{
				combineLatest.running2 = true;
				combineLatest.completedCount = 7;
				combineLatest.completionSource.TrySetException(error);
				return;
			}
			combineLatest.completionSource.TrySetResult(result: false);
			return;
			IL_006f:
			if (!combineLatest.TrySetResult() && !combineLatest.syncRunning)
			{
				combineLatest.running2 = true;
				try
				{
					combineLatest.awaiter2 = combineLatest.enumerator2.MoveNextAsync().GetAwaiter();
				}
				catch (Exception error2)
				{
					combineLatest.completedCount = 7;
					combineLatest.completionSource.TrySetException(error2);
					return;
				}
				combineLatest.awaiter2.SourceOnCompleted(Completed2Delegate, combineLatest);
			}
		}

		private static void Completed3(object state)
		{
			_CombineLatest combineLatest = (_CombineLatest)state;
			combineLatest.running3 = false;
			try
			{
				if (combineLatest.awaiter3.GetResult())
				{
					combineLatest.hasCurrent3 = true;
					combineLatest.current3 = combineLatest.enumerator3.Current;
					goto IL_006f;
				}
				combineLatest.running3 = true;
				if (Interlocked.Increment(ref combineLatest.completedCount) != 7)
				{
					return;
				}
			}
			catch (Exception error)
			{
				combineLatest.running3 = true;
				combineLatest.completedCount = 7;
				combineLatest.completionSource.TrySetException(error);
				return;
			}
			combineLatest.completionSource.TrySetResult(result: false);
			return;
			IL_006f:
			if (!combineLatest.TrySetResult() && !combineLatest.syncRunning)
			{
				combineLatest.running3 = true;
				try
				{
					combineLatest.awaiter3 = combineLatest.enumerator3.MoveNextAsync().GetAwaiter();
				}
				catch (Exception error2)
				{
					combineLatest.completedCount = 7;
					combineLatest.completionSource.TrySetException(error2);
					return;
				}
				combineLatest.awaiter3.SourceOnCompleted(Completed3Delegate, combineLatest);
			}
		}

		private static void Completed4(object state)
		{
			_CombineLatest combineLatest = (_CombineLatest)state;
			combineLatest.running4 = false;
			try
			{
				if (combineLatest.awaiter4.GetResult())
				{
					combineLatest.hasCurrent4 = true;
					combineLatest.current4 = combineLatest.enumerator4.Current;
					goto IL_006f;
				}
				combineLatest.running4 = true;
				if (Interlocked.Increment(ref combineLatest.completedCount) != 7)
				{
					return;
				}
			}
			catch (Exception error)
			{
				combineLatest.running4 = true;
				combineLatest.completedCount = 7;
				combineLatest.completionSource.TrySetException(error);
				return;
			}
			combineLatest.completionSource.TrySetResult(result: false);
			return;
			IL_006f:
			if (!combineLatest.TrySetResult() && !combineLatest.syncRunning)
			{
				combineLatest.running4 = true;
				try
				{
					combineLatest.awaiter4 = combineLatest.enumerator4.MoveNextAsync().GetAwaiter();
				}
				catch (Exception error2)
				{
					combineLatest.completedCount = 7;
					combineLatest.completionSource.TrySetException(error2);
					return;
				}
				combineLatest.awaiter4.SourceOnCompleted(Completed4Delegate, combineLatest);
			}
		}

		private static void Completed5(object state)
		{
			_CombineLatest combineLatest = (_CombineLatest)state;
			combineLatest.running5 = false;
			try
			{
				if (combineLatest.awaiter5.GetResult())
				{
					combineLatest.hasCurrent5 = true;
					combineLatest.current5 = combineLatest.enumerator5.Current;
					goto IL_006f;
				}
				combineLatest.running5 = true;
				if (Interlocked.Increment(ref combineLatest.completedCount) != 7)
				{
					return;
				}
			}
			catch (Exception error)
			{
				combineLatest.running5 = true;
				combineLatest.completedCount = 7;
				combineLatest.completionSource.TrySetException(error);
				return;
			}
			combineLatest.completionSource.TrySetResult(result: false);
			return;
			IL_006f:
			if (!combineLatest.TrySetResult() && !combineLatest.syncRunning)
			{
				combineLatest.running5 = true;
				try
				{
					combineLatest.awaiter5 = combineLatest.enumerator5.MoveNextAsync().GetAwaiter();
				}
				catch (Exception error2)
				{
					combineLatest.completedCount = 7;
					combineLatest.completionSource.TrySetException(error2);
					return;
				}
				combineLatest.awaiter5.SourceOnCompleted(Completed5Delegate, combineLatest);
			}
		}

		private static void Completed6(object state)
		{
			_CombineLatest combineLatest = (_CombineLatest)state;
			combineLatest.running6 = false;
			try
			{
				if (combineLatest.awaiter6.GetResult())
				{
					combineLatest.hasCurrent6 = true;
					combineLatest.current6 = combineLatest.enumerator6.Current;
					goto IL_006f;
				}
				combineLatest.running6 = true;
				if (Interlocked.Increment(ref combineLatest.completedCount) != 7)
				{
					return;
				}
			}
			catch (Exception error)
			{
				combineLatest.running6 = true;
				combineLatest.completedCount = 7;
				combineLatest.completionSource.TrySetException(error);
				return;
			}
			combineLatest.completionSource.TrySetResult(result: false);
			return;
			IL_006f:
			if (!combineLatest.TrySetResult() && !combineLatest.syncRunning)
			{
				combineLatest.running6 = true;
				try
				{
					combineLatest.awaiter6 = combineLatest.enumerator6.MoveNextAsync().GetAwaiter();
				}
				catch (Exception error2)
				{
					combineLatest.completedCount = 7;
					combineLatest.completionSource.TrySetException(error2);
					return;
				}
				combineLatest.awaiter6.SourceOnCompleted(Completed6Delegate, combineLatest);
			}
		}

		private static void Completed7(object state)
		{
			_CombineLatest combineLatest = (_CombineLatest)state;
			combineLatest.running7 = false;
			try
			{
				if (combineLatest.awaiter7.GetResult())
				{
					combineLatest.hasCurrent7 = true;
					combineLatest.current7 = combineLatest.enumerator7.Current;
					goto IL_006f;
				}
				combineLatest.running7 = true;
				if (Interlocked.Increment(ref combineLatest.completedCount) != 7)
				{
					return;
				}
			}
			catch (Exception error)
			{
				combineLatest.running7 = true;
				combineLatest.completedCount = 7;
				combineLatest.completionSource.TrySetException(error);
				return;
			}
			combineLatest.completionSource.TrySetResult(result: false);
			return;
			IL_006f:
			if (!combineLatest.TrySetResult() && !combineLatest.syncRunning)
			{
				combineLatest.running7 = true;
				try
				{
					combineLatest.awaiter7 = combineLatest.enumerator7.MoveNextAsync().GetAwaiter();
				}
				catch (Exception error2)
				{
					combineLatest.completedCount = 7;
					combineLatest.completionSource.TrySetException(error2);
					return;
				}
				combineLatest.awaiter7.SourceOnCompleted(Completed7Delegate, combineLatest);
			}
		}

		private bool TrySetResult()
		{
			if (hasCurrent1 && hasCurrent2 && hasCurrent3 && hasCurrent4 && hasCurrent5 && hasCurrent6 && hasCurrent7)
			{
				result = resultSelector(current1, current2, current3, current4, current5, current6, current7);
				completionSource.TrySetResult(result: true);
				return true;
			}
			return false;
		}

		public async UniTask DisposeAsync()
		{
			if (enumerator1 != null)
			{
				await enumerator1.DisposeAsync();
			}
			if (enumerator2 != null)
			{
				await enumerator2.DisposeAsync();
			}
			if (enumerator3 != null)
			{
				await enumerator3.DisposeAsync();
			}
			if (enumerator4 != null)
			{
				await enumerator4.DisposeAsync();
			}
			if (enumerator5 != null)
			{
				await enumerator5.DisposeAsync();
			}
			if (enumerator6 != null)
			{
				await enumerator6.DisposeAsync();
			}
			if (enumerator7 != null)
			{
				await enumerator7.DisposeAsync();
			}
		}
	}

	private readonly IUniTaskAsyncEnumerable<T1> source1;

	private readonly IUniTaskAsyncEnumerable<T2> source2;

	private readonly IUniTaskAsyncEnumerable<T3> source3;

	private readonly IUniTaskAsyncEnumerable<T4> source4;

	private readonly IUniTaskAsyncEnumerable<T5> source5;

	private readonly IUniTaskAsyncEnumerable<T6> source6;

	private readonly IUniTaskAsyncEnumerable<T7> source7;

	private readonly Func<T1, T2, T3, T4, T5, T6, T7, TResult> resultSelector;

	public CombineLatest(IUniTaskAsyncEnumerable<T1> source1, IUniTaskAsyncEnumerable<T2> source2, IUniTaskAsyncEnumerable<T3> source3, IUniTaskAsyncEnumerable<T4> source4, IUniTaskAsyncEnumerable<T5> source5, IUniTaskAsyncEnumerable<T6> source6, IUniTaskAsyncEnumerable<T7> source7, Func<T1, T2, T3, T4, T5, T6, T7, TResult> resultSelector)
	{
		this.source1 = source1;
		this.source2 = source2;
		this.source3 = source3;
		this.source4 = source4;
		this.source5 = source5;
		this.source6 = source6;
		this.source7 = source7;
		this.resultSelector = resultSelector;
	}

	public IUniTaskAsyncEnumerator<TResult> GetAsyncEnumerator(CancellationToken cancellationToken = default(CancellationToken))
	{
		return new _CombineLatest(source1, source2, source3, source4, source5, source6, source7, resultSelector, cancellationToken);
	}
}
internal class CombineLatest<T1, T2, T3, T4, T5, T6, T7, T8, TResult> : IUniTaskAsyncEnumerable<TResult>
{
	private class _CombineLatest : MoveNextSource, IUniTaskAsyncEnumerator<TResult>, IUniTaskAsyncDisposable
	{
		private static readonly Action<object> Completed1Delegate = Completed1;

		private static readonly Action<object> Completed2Delegate = Completed2;

		private static readonly Action<object> Completed3Delegate = Completed3;

		private static readonly Action<object> Completed4Delegate = Completed4;

		private static readonly Action<object> Completed5Delegate = Completed5;

		private static readonly Action<object> Completed6Delegate = Completed6;

		private static readonly Action<object> Completed7Delegate = Completed7;

		private static readonly Action<object> Completed8Delegate = Completed8;

		private readonly IUniTaskAsyncEnumerable<T1> source1;

		private readonly IUniTaskAsyncEnumerable<T2> source2;

		private readonly IUniTaskAsyncEnumerable<T3> source3;

		private readonly IUniTaskAsyncEnumerable<T4> source4;

		private readonly IUniTaskAsyncEnumerable<T5> source5;

		private readonly IUniTaskAsyncEnumerable<T6> source6;

		private readonly IUniTaskAsyncEnumerable<T7> source7;

		private readonly IUniTaskAsyncEnumerable<T8> source8;

		private readonly Func<T1, T2, T3, T4, T5, T6, T7, T8, TResult> resultSelector;

		private CancellationToken cancellationToken;

		private IUniTaskAsyncEnumerator<T1> enumerator1;

		private UniTask<bool>.Awaiter awaiter1;

		private bool hasCurrent1;

		private bool running1;

		private T1 current1;

		private IUniTaskAsyncEnumerator<T2> enumerator2;

		private UniTask<bool>.Awaiter awaiter2;

		private bool hasCurrent2;

		private bool running2;

		private T2 current2;

		private IUniTaskAsyncEnumerator<T3> enumerator3;

		private UniTask<bool>.Awaiter awaiter3;

		private bool hasCurrent3;

		private bool running3;

		private T3 current3;

		private IUniTaskAsyncEnumerator<T4> enumerator4;

		private UniTask<bool>.Awaiter awaiter4;

		private bool hasCurrent4;

		private bool running4;

		private T4 current4;

		private IUniTaskAsyncEnumerator<T5> enumerator5;

		private UniTask<bool>.Awaiter awaiter5;

		private bool hasCurrent5;

		private bool running5;

		private T5 current5;

		private IUniTaskAsyncEnumerator<T6> enumerator6;

		private UniTask<bool>.Awaiter awaiter6;

		private bool hasCurrent6;

		private bool running6;

		private T6 current6;

		private IUniTaskAsyncEnumerator<T7> enumerator7;

		private UniTask<bool>.Awaiter awaiter7;

		private bool hasCurrent7;

		private bool running7;

		private T7 current7;

		private IUniTaskAsyncEnumerator<T8> enumerator8;

		private UniTask<bool>.Awaiter awaiter8;

		private bool hasCurrent8;

		private bool running8;

		private T8 current8;

		private int completedCount;

		private bool syncRunning;

		private TResult result;

		public TResult Current => result;

		public _CombineLatest(IUniTaskAsyncEnumerable<T1> source1, IUniTaskAsyncEnumerable<T2> source2, IUniTaskAsyncEnumerable<T3> source3, IUniTaskAsyncEnumerable<T4> source4, IUniTaskAsyncEnumerable<T5> source5, IUniTaskAsyncEnumerable<T6> source6, IUniTaskAsyncEnumerable<T7> source7, IUniTaskAsyncEnumerable<T8> source8, Func<T1, T2, T3, T4, T5, T6, T7, T8, TResult> resultSelector, CancellationToken cancellationToken)
		{
			this.source1 = source1;
			this.source2 = source2;
			this.source3 = source3;
			this.source4 = source4;
			this.source5 = source5;
			this.source6 = source6;
			this.source7 = source7;
			this.source8 = source8;
			this.resultSelector = resultSelector;
			this.cancellationToken = cancellationToken;
		}

		public UniTask<bool> MoveNextAsync()
		{
			cancellationToken.ThrowIfCancellationRequested();
			if (completedCount == 8)
			{
				return CompletedTasks.False;
			}
			if (enumerator1 == null)
			{
				enumerator1 = source1.GetAsyncEnumerator(cancellationToken);
				enumerator2 = source2.GetAsyncEnumerator(cancellationToken);
				enumerator3 = source3.GetAsyncEnumerator(cancellationToken);
				enumerator4 = source4.GetAsyncEnumerator(cancellationToken);
				enumerator5 = source5.GetAsyncEnumerator(cancellationToken);
				enumerator6 = source6.GetAsyncEnumerator(cancellationToken);
				enumerator7 = source7.GetAsyncEnumerator(cancellationToken);
				enumerator8 = source8.GetAsyncEnumerator(cancellationToken);
			}
			completionSource.Reset();
			do
			{
				syncRunning = true;
				if (!running1)
				{
					running1 = true;
					awaiter1 = enumerator1.MoveNextAsync().GetAwaiter();
					if (awaiter1.IsCompleted)
					{
						Completed1(this);
					}
					else
					{
						awaiter1.SourceOnCompleted(Completed1Delegate, this);
					}
				}
				if (!running2)
				{
					running2 = true;
					awaiter2 = enumerator2.MoveNextAsync().GetAwaiter();
					if (awaiter2.IsCompleted)
					{
						Completed2(this);
					}
					else
					{
						awaiter2.SourceOnCompleted(Completed2Delegate, this);
					}
				}
				if (!running3)
				{
					running3 = true;
					awaiter3 = enumerator3.MoveNextAsync().GetAwaiter();
					if (awaiter3.IsCompleted)
					{
						Completed3(this);
					}
					else
					{
						awaiter3.SourceOnCompleted(Completed3Delegate, this);
					}
				}
				if (!running4)
				{
					running4 = true;
					awaiter4 = enumerator4.MoveNextAsync().GetAwaiter();
					if (awaiter4.IsCompleted)
					{
						Completed4(this);
					}
					else
					{
						awaiter4.SourceOnCompleted(Completed4Delegate, this);
					}
				}
				if (!running5)
				{
					running5 = true;
					awaiter5 = enumerator5.MoveNextAsync().GetAwaiter();
					if (awaiter5.IsCompleted)
					{
						Completed5(this);
					}
					else
					{
						awaiter5.SourceOnCompleted(Completed5Delegate, this);
					}
				}
				if (!running6)
				{
					running6 = true;
					awaiter6 = enumerator6.MoveNextAsync().GetAwaiter();
					if (awaiter6.IsCompleted)
					{
						Completed6(this);
					}
					else
					{
						awaiter6.SourceOnCompleted(Completed6Delegate, this);
					}
				}
				if (!running7)
				{
					running7 = true;
					awaiter7 = enumerator7.MoveNextAsync().GetAwaiter();
					if (awaiter7.IsCompleted)
					{
						Completed7(this);
					}
					else
					{
						awaiter7.SourceOnCompleted(Completed7Delegate, this);
					}
				}
				if (!running8)
				{
					running8 = true;
					awaiter8 = enumerator8.MoveNextAsync().GetAwaiter();
					if (awaiter8.IsCompleted)
					{
						Completed8(this);
					}
					else
					{
						awaiter8.SourceOnCompleted(Completed8Delegate, this);
					}
				}
			}
			while (!running1 || !running2 || !running3 || !running4 || !running5 || !running6 || !running7 || !running8);
			syncRunning = false;
			return new UniTask<bool>(this, completionSource.Version);
		}

		private static void Completed1(object state)
		{
			_CombineLatest combineLatest = (_CombineLatest)state;
			combineLatest.running1 = false;
			try
			{
				if (combineLatest.awaiter1.GetResult())
				{
					combineLatest.hasCurrent1 = true;
					combineLatest.current1 = combineLatest.enumerator1.Current;
					goto IL_006f;
				}
				combineLatest.running1 = true;
				if (Interlocked.Increment(ref combineLatest.completedCount) != 8)
				{
					return;
				}
			}
			catch (Exception error)
			{
				combineLatest.running1 = true;
				combineLatest.completedCount = 8;
				combineLatest.completionSource.TrySetException(error);
				return;
			}
			combineLatest.completionSource.TrySetResult(result: false);
			return;
			IL_006f:
			if (!combineLatest.TrySetResult() && !combineLatest.syncRunning)
			{
				combineLatest.running1 = true;
				try
				{
					combineLatest.awaiter1 = combineLatest.enumerator1.MoveNextAsync().GetAwaiter();
				}
				catch (Exception error2)
				{
					combineLatest.completedCount = 8;
					combineLatest.completionSource.TrySetException(error2);
					return;
				}
				combineLatest.awaiter1.SourceOnCompleted(Completed1Delegate, combineLatest);
			}
		}

		private static void Completed2(object state)
		{
			_CombineLatest combineLatest = (_CombineLatest)state;
			combineLatest.running2 = false;
			try
			{
				if (combineLatest.awaiter2.GetResult())
				{
					combineLatest.hasCurrent2 = true;
					combineLatest.current2 = combineLatest.enumerator2.Current;
					goto IL_006f;
				}
				combineLatest.running2 = true;
				if (Interlocked.Increment(ref combineLatest.completedCount) != 8)
				{
					return;
				}
			}
			catch (Exception error)
			{
				combineLatest.running2 = true;
				combineLatest.completedCount = 8;
				combineLatest.completionSource.TrySetException(error);
				return;
			}
			combineLatest.completionSource.TrySetResult(result: false);
			return;
			IL_006f:
			if (!combineLatest.TrySetResult() && !combineLatest.syncRunning)
			{
				combineLatest.running2 = true;
				try
				{
					combineLatest.awaiter2 = combineLatest.enumerator2.MoveNextAsync().GetAwaiter();
				}
				catch (Exception error2)
				{
					combineLatest.completedCount = 8;
					combineLatest.completionSource.TrySetException(error2);
					return;
				}
				combineLatest.awaiter2.SourceOnCompleted(Completed2Delegate, combineLatest);
			}
		}

		private static void Completed3(object state)
		{
			_CombineLatest combineLatest = (_CombineLatest)state;
			combineLatest.running3 = false;
			try
			{
				if (combineLatest.awaiter3.GetResult())
				{
					combineLatest.hasCurrent3 = true;
					combineLatest.current3 = combineLatest.enumerator3.Current;
					goto IL_006f;
				}
				combineLatest.running3 = true;
				if (Interlocked.Increment(ref combineLatest.completedCount) != 8)
				{
					return;
				}
			}
			catch (Exception error)
			{
				combineLatest.running3 = true;
				combineLatest.completedCount = 8;
				combineLatest.completionSource.TrySetException(error);
				return;
			}
			combineLatest.completionSource.TrySetResult(result: false);
			return;
			IL_006f:
			if (!combineLatest.TrySetResult() && !combineLatest.syncRunning)
			{
				combineLatest.running3 = true;
				try
				{
					combineLatest.awaiter3 = combineLatest.enumerator3.MoveNextAsync().GetAwaiter();
				}
				catch (Exception error2)
				{
					combineLatest.completedCount = 8;
					combineLatest.completionSource.TrySetException(error2);
					return;
				}
				combineLatest.awaiter3.SourceOnCompleted(Completed3Delegate, combineLatest);
			}
		}

		private static void Completed4(object state)
		{
			_CombineLatest combineLatest = (_CombineLatest)state;
			combineLatest.running4 = false;
			try
			{
				if (combineLatest.awaiter4.GetResult())
				{
					combineLatest.hasCurrent4 = true;
					combineLatest.current4 = combineLatest.enumerator4.Current;
					goto IL_006f;
				}
				combineLatest.running4 = true;
				if (Interlocked.Increment(ref combineLatest.completedCount) != 8)
				{
					return;
				}
			}
			catch (Exception error)
			{
				combineLatest.running4 = true;
				combineLatest.completedCount = 8;
				combineLatest.completionSource.TrySetException(error);
				return;
			}
			combineLatest.completionSource.TrySetResult(result: false);
			return;
			IL_006f:
			if (!combineLatest.TrySetResult() && !combineLatest.syncRunning)
			{
				combineLatest.running4 = true;
				try
				{
					combineLatest.awaiter4 = combineLatest.enumerator4.MoveNextAsync().GetAwaiter();
				}
				catch (Exception error2)
				{
					combineLatest.completedCount = 8;
					combineLatest.completionSource.TrySetException(error2);
					return;
				}
				combineLatest.awaiter4.SourceOnCompleted(Completed4Delegate, combineLatest);
			}
		}

		private static void Completed5(object state)
		{
			_CombineLatest combineLatest = (_CombineLatest)state;
			combineLatest.running5 = false;
			try
			{
				if (combineLatest.awaiter5.GetResult())
				{
					combineLatest.hasCurrent5 = true;
					combineLatest.current5 = combineLatest.enumerator5.Current;
					goto IL_006f;
				}
				combineLatest.running5 = true;
				if (Interlocked.Increment(ref combineLatest.completedCount) != 8)
				{
					return;
				}
			}
			catch (Exception error)
			{
				combineLatest.running5 = true;
				combineLatest.completedCount = 8;
				combineLatest.completionSource.TrySetException(error);
				return;
			}
			combineLatest.completionSource.TrySetResult(result: false);
			return;
			IL_006f:
			if (!combineLatest.TrySetResult() && !combineLatest.syncRunning)
			{
				combineLatest.running5 = true;
				try
				{
					combineLatest.awaiter5 = combineLatest.enumerator5.MoveNextAsync().GetAwaiter();
				}
				catch (Exception error2)
				{
					combineLatest.completedCount = 8;
					combineLatest.completionSource.TrySetException(error2);
					return;
				}
				combineLatest.awaiter5.SourceOnCompleted(Completed5Delegate, combineLatest);
			}
		}

		private static void Completed6(object state)
		{
			_CombineLatest combineLatest = (_CombineLatest)state;
			combineLatest.running6 = false;
			try
			{
				if (combineLatest.awaiter6.GetResult())
				{
					combineLatest.hasCurrent6 = true;
					combineLatest.current6 = combineLatest.enumerator6.Current;
					goto IL_006f;
				}
				combineLatest.running6 = true;
				if (Interlocked.Increment(ref combineLatest.completedCount) != 8)
				{
					return;
				}
			}
			catch (Exception error)
			{
				combineLatest.running6 = true;
				combineLatest.completedCount = 8;
				combineLatest.completionSource.TrySetException(error);
				return;
			}
			combineLatest.completionSource.TrySetResult(result: false);
			return;
			IL_006f:
			if (!combineLatest.TrySetResult() && !combineLatest.syncRunning)
			{
				combineLatest.running6 = true;
				try
				{
					combineLatest.awaiter6 = combineLatest.enumerator6.MoveNextAsync().GetAwaiter();
				}
				catch (Exception error2)
				{
					combineLatest.completedCount = 8;
					combineLatest.completionSource.TrySetException(error2);
					return;
				}
				combineLatest.awaiter6.SourceOnCompleted(Completed6Delegate, combineLatest);
			}
		}

		private static void Completed7(object state)
		{
			_CombineLatest combineLatest = (_CombineLatest)state;
			combineLatest.running7 = false;
			try
			{
				if (combineLatest.awaiter7.GetResult())
				{
					combineLatest.hasCurrent7 = true;
					combineLatest.current7 = combineLatest.enumerator7.Current;
					goto IL_006f;
				}
				combineLatest.running7 = true;
				if (Interlocked.Increment(ref combineLatest.completedCount) != 8)
				{
					return;
				}
			}
			catch (Exception error)
			{
				combineLatest.running7 = true;
				combineLatest.completedCount = 8;
				combineLatest.completionSource.TrySetException(error);
				return;
			}
			combineLatest.completionSource.TrySetResult(result: false);
			return;
			IL_006f:
			if (!combineLatest.TrySetResult() && !combineLatest.syncRunning)
			{
				combineLatest.running7 = true;
				try
				{
					combineLatest.awaiter7 = combineLatest.enumerator7.MoveNextAsync().GetAwaiter();
				}
				catch (Exception error2)
				{
					combineLatest.completedCount = 8;
					combineLatest.completionSource.TrySetException(error2);
					return;
				}
				combineLatest.awaiter7.SourceOnCompleted(Completed7Delegate, combineLatest);
			}
		}

		private static void Completed8(object state)
		{
			_CombineLatest combineLatest = (_CombineLatest)state;
			combineLatest.running8 = false;
			try
			{
				if (combineLatest.awaiter8.GetResult())
				{
					combineLatest.hasCurrent8 = true;
					combineLatest.current8 = combineLatest.enumerator8.Current;
					goto IL_006f;
				}
				combineLatest.running8 = true;
				if (Interlocked.Increment(ref combineLatest.completedCount) != 8)
				{
					return;
				}
			}
			catch (Exception error)
			{
				combineLatest.running8 = true;
				combineLatest.completedCount = 8;
				combineLatest.completionSource.TrySetException(error);
				return;
			}
			combineLatest.completionSource.TrySetResult(result: false);
			return;
			IL_006f:
			if (!combineLatest.TrySetResult() && !combineLatest.syncRunning)
			{
				combineLatest.running8 = true;
				try
				{
					combineLatest.awaiter8 = combineLatest.enumerator8.MoveNextAsync().GetAwaiter();
				}
				catch (Exception error2)
				{
					combineLatest.completedCount = 8;
					combineLatest.completionSource.TrySetException(error2);
					return;
				}
				combineLatest.awaiter8.SourceOnCompleted(Completed8Delegate, combineLatest);
			}
		}

		private bool TrySetResult()
		{
			if (hasCurrent1 && hasCurrent2 && hasCurrent3 && hasCurrent4 && hasCurrent5 && hasCurrent6 && hasCurrent7 && hasCurrent8)
			{
				result = resultSelector(current1, current2, current3, current4, current5, current6, current7, current8);
				completionSource.TrySetResult(result: true);
				return true;
			}
			return false;
		}

		public async UniTask DisposeAsync()
		{
			if (enumerator1 != null)
			{
				await enumerator1.DisposeAsync();
			}
			if (enumerator2 != null)
			{
				await enumerator2.DisposeAsync();
			}
			if (enumerator3 != null)
			{
				await enumerator3.DisposeAsync();
			}
			if (enumerator4 != null)
			{
				await enumerator4.DisposeAsync();
			}
			if (enumerator5 != null)
			{
				await enumerator5.DisposeAsync();
			}
			if (enumerator6 != null)
			{
				await enumerator6.DisposeAsync();
			}
			if (enumerator7 != null)
			{
				await enumerator7.DisposeAsync();
			}
			if (enumerator8 != null)
			{
				await enumerator8.DisposeAsync();
			}
		}
	}

	private readonly IUniTaskAsyncEnumerable<T1> source1;

	private readonly IUniTaskAsyncEnumerable<T2> source2;

	private readonly IUniTaskAsyncEnumerable<T3> source3;

	private readonly IUniTaskAsyncEnumerable<T4> source4;

	private readonly IUniTaskAsyncEnumerable<T5> source5;

	private readonly IUniTaskAsyncEnumerable<T6> source6;

	private readonly IUniTaskAsyncEnumerable<T7> source7;

	private readonly IUniTaskAsyncEnumerable<T8> source8;

	private readonly Func<T1, T2, T3, T4, T5, T6, T7, T8, TResult> resultSelector;

	public CombineLatest(IUniTaskAsyncEnumerable<T1> source1, IUniTaskAsyncEnumerable<T2> source2, IUniTaskAsyncEnumerable<T3> source3, IUniTaskAsyncEnumerable<T4> source4, IUniTaskAsyncEnumerable<T5> source5, IUniTaskAsyncEnumerable<T6> source6, IUniTaskAsyncEnumerable<T7> source7, IUniTaskAsyncEnumerable<T8> source8, Func<T1, T2, T3, T4, T5, T6, T7, T8, TResult> resultSelector)
	{
		this.source1 = source1;
		this.source2 = source2;
		this.source3 = source3;
		this.source4 = source4;
		this.source5 = source5;
		this.source6 = source6;
		this.source7 = source7;
		this.source8 = source8;
		this.resultSelector = resultSelector;
	}

	public IUniTaskAsyncEnumerator<TResult> GetAsyncEnumerator(CancellationToken cancellationToken = default(CancellationToken))
	{
		return new _CombineLatest(source1, source2, source3, source4, source5, source6, source7, source8, resultSelector, cancellationToken);
	}
}
internal class CombineLatest<T1, T2, T3, T4, T5, T6, T7, T8, T9, TResult> : IUniTaskAsyncEnumerable<TResult>
{
	private class _CombineLatest : MoveNextSource, IUniTaskAsyncEnumerator<TResult>, IUniTaskAsyncDisposable
	{
		private static readonly Action<object> Completed1Delegate = Completed1;

		private static readonly Action<object> Completed2Delegate = Completed2;

		private static readonly Action<object> Completed3Delegate = Completed3;

		private static readonly Action<object> Completed4Delegate = Completed4;

		private static readonly Action<object> Completed5Delegate = Completed5;

		private static readonly Action<object> Completed6Delegate = Completed6;

		private static readonly Action<object> Completed7Delegate = Completed7;

		private static readonly Action<object> Completed8Delegate = Completed8;

		private static readonly Action<object> Completed9Delegate = Completed9;

		private readonly IUniTaskAsyncEnumerable<T1> source1;

		private readonly IUniTaskAsyncEnumerable<T2> source2;

		private readonly IUniTaskAsyncEnumerable<T3> source3;

		private readonly IUniTaskAsyncEnumerable<T4> source4;

		private readonly IUniTaskAsyncEnumerable<T5> source5;

		private readonly IUniTaskAsyncEnumerable<T6> source6;

		private readonly IUniTaskAsyncEnumerable<T7> source7;

		private readonly IUniTaskAsyncEnumerable<T8> source8;

		private readonly IUniTaskAsyncEnumerable<T9> source9;

		private readonly Func<T1, T2, T3, T4, T5, T6, T7, T8, T9, TResult> resultSelector;

		private CancellationToken cancellationToken;

		private IUniTaskAsyncEnumerator<T1> enumerator1;

		private UniTask<bool>.Awaiter awaiter1;

		private bool hasCurrent1;

		private bool running1;

		private T1 current1;

		private IUniTaskAsyncEnumerator<T2> enumerator2;

		private UniTask<bool>.Awaiter awaiter2;

		private bool hasCurrent2;

		private bool running2;

		private T2 current2;

		private IUniTaskAsyncEnumerator<T3> enumerator3;

		private UniTask<bool>.Awaiter awaiter3;

		private bool hasCurrent3;

		private bool running3;

		private T3 current3;

		private IUniTaskAsyncEnumerator<T4> enumerator4;

		private UniTask<bool>.Awaiter awaiter4;

		private bool hasCurrent4;

		private bool running4;

		private T4 current4;

		private IUniTaskAsyncEnumerator<T5> enumerator5;

		private UniTask<bool>.Awaiter awaiter5;

		private bool hasCurrent5;

		private bool running5;

		private T5 current5;

		private IUniTaskAsyncEnumerator<T6> enumerator6;

		private UniTask<bool>.Awaiter awaiter6;

		private bool hasCurrent6;

		private bool running6;

		private T6 current6;

		private IUniTaskAsyncEnumerator<T7> enumerator7;

		private UniTask<bool>.Awaiter awaiter7;

		private bool hasCurrent7;

		private bool running7;

		private T7 current7;

		private IUniTaskAsyncEnumerator<T8> enumerator8;

		private UniTask<bool>.Awaiter awaiter8;

		private bool hasCurrent8;

		private bool running8;

		private T8 current8;

		private IUniTaskAsyncEnumerator<T9> enumerator9;

		private UniTask<bool>.Awaiter awaiter9;

		private bool hasCurrent9;

		private bool running9;

		private T9 current9;

		private int completedCount;

		private bool syncRunning;

		private TResult result;

		public TResult Current => result;

		public _CombineLatest(IUniTaskAsyncEnumerable<T1> source1, IUniTaskAsyncEnumerable<T2> source2, IUniTaskAsyncEnumerable<T3> source3, IUniTaskAsyncEnumerable<T4> source4, IUniTaskAsyncEnumerable<T5> source5, IUniTaskAsyncEnumerable<T6> source6, IUniTaskAsyncEnumerable<T7> source7, IUniTaskAsyncEnumerable<T8> source8, IUniTaskAsyncEnumerable<T9> source9, Func<T1, T2, T3, T4, T5, T6, T7, T8, T9, TResult> resultSelector, CancellationToken cancellationToken)
		{
			this.source1 = source1;
			this.source2 = source2;
			this.source3 = source3;
			this.source4 = source4;
			this.source5 = source5;
			this.source6 = source6;
			this.source7 = source7;
			this.source8 = source8;
			this.source9 = source9;
			this.resultSelector = resultSelector;
			this.cancellationToken = cancellationToken;
		}

		public UniTask<bool> MoveNextAsync()
		{
			cancellationToken.ThrowIfCancellationRequested();
			if (completedCount == 9)
			{
				return CompletedTasks.False;
			}
			if (enumerator1 == null)
			{
				enumerator1 = source1.GetAsyncEnumerator(cancellationToken);
				enumerator2 = source2.GetAsyncEnumerator(cancellationToken);
				enumerator3 = source3.GetAsyncEnumerator(cancellationToken);
				enumerator4 = source4.GetAsyncEnumerator(cancellationToken);
				enumerator5 = source5.GetAsyncEnumerator(cancellationToken);
				enumerator6 = source6.GetAsyncEnumerator(cancellationToken);
				enumerator7 = source7.GetAsyncEnumerator(cancellationToken);
				enumerator8 = source8.GetAsyncEnumerator(cancellationToken);
				enumerator9 = source9.GetAsyncEnumerator(cancellationToken);
			}
			completionSource.Reset();
			do
			{
				syncRunning = true;
				if (!running1)
				{
					running1 = true;
					awaiter1 = enumerator1.MoveNextAsync().GetAwaiter();
					if (awaiter1.IsCompleted)
					{
						Completed1(this);
					}
					else
					{
						awaiter1.SourceOnCompleted(Completed1Delegate, this);
					}
				}
				if (!running2)
				{
					running2 = true;
					awaiter2 = enumerator2.MoveNextAsync().GetAwaiter();
					if (awaiter2.IsCompleted)
					{
						Completed2(this);
					}
					else
					{
						awaiter2.SourceOnCompleted(Completed2Delegate, this);
					}
				}
				if (!running3)
				{
					running3 = true;
					awaiter3 = enumerator3.MoveNextAsync().GetAwaiter();
					if (awaiter3.IsCompleted)
					{
						Completed3(this);
					}
					else
					{
						awaiter3.SourceOnCompleted(Completed3Delegate, this);
					}
				}
				if (!running4)
				{
					running4 = true;
					awaiter4 = enumerator4.MoveNextAsync().GetAwaiter();
					if (awaiter4.IsCompleted)
					{
						Completed4(this);
					}
					else
					{
						awaiter4.SourceOnCompleted(Completed4Delegate, this);
					}
				}
				if (!running5)
				{
					running5 = true;
					awaiter5 = enumerator5.MoveNextAsync().GetAwaiter();
					if (awaiter5.IsCompleted)
					{
						Completed5(this);
					}
					else
					{
						awaiter5.SourceOnCompleted(Completed5Delegate, this);
					}
				}
				if (!running6)
				{
					running6 = true;
					awaiter6 = enumerator6.MoveNextAsync().GetAwaiter();
					if (awaiter6.IsCompleted)
					{
						Completed6(this);
					}
					else
					{
						awaiter6.SourceOnCompleted(Completed6Delegate, this);
					}
				}
				if (!running7)
				{
					running7 = true;
					awaiter7 = enumerator7.MoveNextAsync().GetAwaiter();
					if (awaiter7.IsCompleted)
					{
						Completed7(this);
					}
					else
					{
						awaiter7.SourceOnCompleted(Completed7Delegate, this);
					}
				}
				if (!running8)
				{
					running8 = true;
					awaiter8 = enumerator8.MoveNextAsync().GetAwaiter();
					if (awaiter8.IsCompleted)
					{
						Completed8(this);
					}
					else
					{
						awaiter8.SourceOnCompleted(Completed8Delegate, this);
					}
				}
				if (!running9)
				{
					running9 = true;
					awaiter9 = enumerator9.MoveNextAsync().GetAwaiter();
					if (awaiter9.IsCompleted)
					{
						Completed9(this);
					}
					else
					{
						awaiter9.SourceOnCompleted(Completed9Delegate, this);
					}
				}
			}
			while (!running1 || !running2 || !running3 || !running4 || !running5 || !running6 || !running7 || !running8 || !running9);
			syncRunning = false;
			return new UniTask<bool>(this, completionSource.Version);
		}

		private static void Completed1(object state)
		{
			_CombineLatest combineLatest = (_CombineLatest)state;
			combineLatest.running1 = false;
			try
			{
				if (combineLatest.awaiter1.GetResult())
				{
					combineLatest.hasCurrent1 = true;
					combineLatest.current1 = combineLatest.enumerator1.Current;
					goto IL_0074;
				}
				combineLatest.running1 = true;
				if (Interlocked.Increment(ref combineLatest.completedCount) != 9)
				{
					return;
				}
			}
			catch (Exception error)
			{
				combineLatest.running1 = true;
				combineLatest.completedCount = 9;
				combineLatest.completionSource.TrySetException(error);
				return;
			}
			combineLatest.completionSource.TrySetResult(result: false);
			return;
			IL_0074:
			if (!combineLatest.TrySetResult() && !combineLatest.syncRunning)
			{
				combineLatest.running1 = true;
				try
				{
					combineLatest.awaiter1 = combineLatest.enumerator1.MoveNextAsync().GetAwaiter();
				}
				catch (Exception error2)
				{
					combineLatest.completedCount = 9;
					combineLatest.completionSource.TrySetException(error2);
					return;
				}
				combineLatest.awaiter1.SourceOnCompleted(Completed1Delegate, combineLatest);
			}
		}

		private static void Completed2(object state)
		{
			_CombineLatest combineLatest = (_CombineLatest)state;
			combineLatest.running2 = false;
			try
			{
				if (combineLatest.awaiter2.GetResult())
				{
					combineLatest.hasCurrent2 = true;
					combineLatest.current2 = combineLatest.enumerator2.Current;
					goto IL_0074;
				}
				combineLatest.running2 = true;
				if (Interlocked.Increment(ref combineLatest.completedCount) != 9)
				{
					return;
				}
			}
			catch (Exception error)
			{
				combineLatest.running2 = true;
				combineLatest.completedCount = 9;
				combineLatest.completionSource.TrySetException(error);
				return;
			}
			combineLatest.completionSource.TrySetResult(result: false);
			return;
			IL_0074:
			if (!combineLatest.TrySetResult() && !combineLatest.syncRunning)
			{
				combineLatest.running2 = true;
				try
				{
					combineLatest.awaiter2 = combineLatest.enumerator2.MoveNextAsync().GetAwaiter();
				}
				catch (Exception error2)
				{
					combineLatest.completedCount = 9;
					combineLatest.completionSource.TrySetException(error2);
					return;
				}
				combineLatest.awaiter2.SourceOnCompleted(Completed2Delegate, combineLatest);
			}
		}

		private static void Completed3(object state)
		{
			_CombineLatest combineLatest = (_CombineLatest)state;
			combineLatest.running3 = false;
			try
			{
				if (combineLatest.awaiter3.GetResult())
				{
					combineLatest.hasCurrent3 = true;
					combineLatest.current3 = combineLatest.enumerator3.Current;
					goto IL_0074;
				}
				combineLatest.running3 = true;
				if (Interlocked.Increment(ref combineLatest.completedCount) != 9)
				{
					return;
				}
			}
			catch (Exception error)
			{
				combineLatest.running3 = true;
				combineLatest.completedCount = 9;
				combineLatest.completionSource.TrySetException(error);
				return;
			}
			combineLatest.completionSource.TrySetResult(result: false);
			return;
			IL_0074:
			if (!combineLatest.TrySetResult() && !combineLatest.syncRunning)
			{
				combineLatest.running3 = true;
				try
				{
					combineLatest.awaiter3 = combineLatest.enumerator3.MoveNextAsync().GetAwaiter();
				}
				catch (Exception error2)
				{
					combineLatest.completedCount = 9;
					combineLatest.completionSource.TrySetException(error2);
					return;
				}
				combineLatest.awaiter3.SourceOnCompleted(Completed3Delegate, combineLatest);
			}
		}

		private static void Completed4(object state)
		{
			_CombineLatest combineLatest = (_CombineLatest)state;
			combineLatest.running4 = false;
			try
			{
				if (combineLatest.awaiter4.GetResult())
				{
					combineLatest.hasCurrent4 = true;
					combineLatest.current4 = combineLatest.enumerator4.Current;
					goto IL_0074;
				}
				combineLatest.running4 = true;
				if (Interlocked.Increment(ref combineLatest.completedCount) != 9)
				{
					return;
				}
			}
			catch (Exception error)
			{
				combineLatest.running4 = true;
				combineLatest.completedCount = 9;
				combineLatest.completionSource.TrySetException(error);
				return;
			}
			combineLatest.completionSource.TrySetResult(result: false);
			return;
			IL_0074:
			if (!combineLatest.TrySetResult() && !combineLatest.syncRunning)
			{
				combineLatest.running4 = true;
				try
				{
					combineLatest.awaiter4 = combineLatest.enumerator4.MoveNextAsync().GetAwaiter();
				}
				catch (Exception error2)
				{
					combineLatest.completedCount = 9;
					combineLatest.completionSource.TrySetException(error2);
					return;
				}
				combineLatest.awaiter4.SourceOnCompleted(Completed4Delegate, combineLatest);
			}
		}

		private static void Completed5(object state)
		{
			_CombineLatest combineLatest = (_CombineLatest)state;
			combineLatest.running5 = false;
			try
			{
				if (combineLatest.awaiter5.GetResult())
				{
					combineLatest.hasCurrent5 = true;
					combineLatest.current5 = combineLatest.enumerator5.Current;
					goto IL_0074;
				}
				combineLatest.running5 = true;
				if (Interlocked.Increment(ref combineLatest.completedCount) != 9)
				{
					return;
				}
			}
			catch (Exception error)
			{
				combineLatest.running5 = true;
				combineLatest.completedCount = 9;
				combineLatest.completionSource.TrySetException(error);
				return;
			}
			combineLatest.completionSource.TrySetResult(result: false);
			return;
			IL_0074:
			if (!combineLatest.TrySetResult() && !combineLatest.syncRunning)
			{
				combineLatest.running5 = true;
				try
				{
					combineLatest.awaiter5 = combineLatest.enumerator5.MoveNextAsync().GetAwaiter();
				}
				catch (Exception error2)
				{
					combineLatest.completedCount = 9;
					combineLatest.completionSource.TrySetException(error2);
					return;
				}
				combineLatest.awaiter5.SourceOnCompleted(Completed5Delegate, combineLatest);
			}
		}

		private static void Completed6(object state)
		{
			_CombineLatest combineLatest = (_CombineLatest)state;
			combineLatest.running6 = false;
			try
			{
				if (combineLatest.awaiter6.GetResult())
				{
					combineLatest.hasCurrent6 = true;
					combineLatest.current6 = combineLatest.enumerator6.Current;
					goto IL_0074;
				}
				combineLatest.running6 = true;
				if (Interlocked.Increment(ref combineLatest.completedCount) != 9)
				{
					return;
				}
			}
			catch (Exception error)
			{
				combineLatest.running6 = true;
				combineLatest.completedCount = 9;
				combineLatest.completionSource.TrySetException(error);
				return;
			}
			combineLatest.completionSource.TrySetResult(result: false);
			return;
			IL_0074:
			if (!combineLatest.TrySetResult() && !combineLatest.syncRunning)
			{
				combineLatest.running6 = true;
				try
				{
					combineLatest.awaiter6 = combineLatest.enumerator6.MoveNextAsync().GetAwaiter();
				}
				catch (Exception error2)
				{
					combineLatest.completedCount = 9;
					combineLatest.completionSource.TrySetException(error2);
					return;
				}
				combineLatest.awaiter6.SourceOnCompleted(Completed6Delegate, combineLatest);
			}
		}

		private static void Completed7(object state)
		{
			_CombineLatest combineLatest = (_CombineLatest)state;
			combineLatest.running7 = false;
			try
			{
				if (combineLatest.awaiter7.GetResult())
				{
					combineLatest.hasCurrent7 = true;
					combineLatest.current7 = combineLatest.enumerator7.Current;
					goto IL_0074;
				}
				combineLatest.running7 = true;
				if (Interlocked.Increment(ref combineLatest.completedCount) != 9)
				{
					return;
				}
			}
			catch (Exception error)
			{
				combineLatest.running7 = true;
				combineLatest.completedCount = 9;
				combineLatest.completionSource.TrySetException(error);
				return;
			}
			combineLatest.completionSource.TrySetResult(result: false);
			return;
			IL_0074:
			if (!combineLatest.TrySetResult() && !combineLatest.syncRunning)
			{
				combineLatest.running7 = true;
				try
				{
					combineLatest.awaiter7 = combineLatest.enumerator7.MoveNextAsync().GetAwaiter();
				}
				catch (Exception error2)
				{
					combineLatest.completedCount = 9;
					combineLatest.completionSource.TrySetException(error2);
					return;
				}
				combineLatest.awaiter7.SourceOnCompleted(Completed7Delegate, combineLatest);
			}
		}

		private static void Completed8(object state)
		{
			_CombineLatest combineLatest = (_CombineLatest)state;
			combineLatest.running8 = false;
			try
			{
				if (combineLatest.awaiter8.GetResult())
				{
					combineLatest.hasCurrent8 = true;
					combineLatest.current8 = combineLatest.enumerator8.Current;
					goto IL_0074;
				}
				combineLatest.running8 = true;
				if (Interlocked.Increment(ref combineLatest.completedCount) != 9)
				{
					return;
				}
			}
			catch (Exception error)
			{
				combineLatest.running8 = true;
				combineLatest.completedCount = 9;
				combineLatest.completionSource.TrySetException(error);
				return;
			}
			combineLatest.completionSource.TrySetResult(result: false);
			return;
			IL_0074:
			if (!combineLatest.TrySetResult() && !combineLatest.syncRunning)
			{
				combineLatest.running8 = true;
				try
				{
					combineLatest.awaiter8 = combineLatest.enumerator8.MoveNextAsync().GetAwaiter();
				}
				catch (Exception error2)
				{
					combineLatest.completedCount = 9;
					combineLatest.completionSource.TrySetException(error2);
					return;
				}
				combineLatest.awaiter8.SourceOnCompleted(Completed8Delegate, combineLatest);
			}
		}

		private static void Completed9(object state)
		{
			_CombineLatest combineLatest = (_CombineLatest)state;
			combineLatest.running9 = false;
			try
			{
				if (combineLatest.awaiter9.GetResult())
				{
					combineLatest.hasCurrent9 = true;
					combineLatest.current9 = combineLatest.enumerator9.Current;
					goto IL_0074;
				}
				combineLatest.running9 = true;
				if (Interlocked.Increment(ref combineLatest.completedCount) != 9)
				{
					return;
				}
			}
			catch (Exception error)
			{
				combineLatest.running9 = true;
				combineLatest.completedCount = 9;
				combineLatest.completionSource.TrySetException(error);
				return;
			}
			combineLatest.completionSource.TrySetResult(result: false);
			return;
			IL_0074:
			if (!combineLatest.TrySetResult() && !combineLatest.syncRunning)
			{
				combineLatest.running9 = true;
				try
				{
					combineLatest.awaiter9 = combineLatest.enumerator9.MoveNextAsync().GetAwaiter();
				}
				catch (Exception error2)
				{
					combineLatest.completedCount = 9;
					combineLatest.completionSource.TrySetException(error2);
					return;
				}
				combineLatest.awaiter9.SourceOnCompleted(Completed9Delegate, combineLatest);
			}
		}

		private bool TrySetResult()
		{
			if (hasCurrent1 && hasCurrent2 && hasCurrent3 && hasCurrent4 && hasCurrent5 && hasCurrent6 && hasCurrent7 && hasCurrent8 && hasCurrent9)
			{
				result = resultSelector(current1, current2, current3, current4, current5, current6, current7, current8, current9);
				completionSource.TrySetResult(result: true);
				return true;
			}
			return false;
		}

		public async UniTask DisposeAsync()
		{
			if (enumerator1 != null)
			{
				await enumerator1.DisposeAsync();
			}
			if (enumerator2 != null)
			{
				await enumerator2.DisposeAsync();
			}
			if (enumerator3 != null)
			{
				await enumerator3.DisposeAsync();
			}
			if (enumerator4 != null)
			{
				await enumerator4.DisposeAsync();
			}
			if (enumerator5 != null)
			{
				await enumerator5.DisposeAsync();
			}
			if (enumerator6 != null)
			{
				await enumerator6.DisposeAsync();
			}
			if (enumerator7 != null)
			{
				await enumerator7.DisposeAsync();
			}
			if (enumerator8 != null)
			{
				await enumerator8.DisposeAsync();
			}
			if (enumerator9 != null)
			{
				await enumerator9.DisposeAsync();
			}
		}
	}

	private readonly IUniTaskAsyncEnumerable<T1> source1;

	private readonly IUniTaskAsyncEnumerable<T2> source2;

	private readonly IUniTaskAsyncEnumerable<T3> source3;

	private readonly IUniTaskAsyncEnumerable<T4> source4;

	private readonly IUniTaskAsyncEnumerable<T5> source5;

	private readonly IUniTaskAsyncEnumerable<T6> source6;

	private readonly IUniTaskAsyncEnumerable<T7> source7;

	private readonly IUniTaskAsyncEnumerable<T8> source8;

	private readonly IUniTaskAsyncEnumerable<T9> source9;

	private readonly Func<T1, T2, T3, T4, T5, T6, T7, T8, T9, TResult> resultSelector;

	public CombineLatest(IUniTaskAsyncEnumerable<T1> source1, IUniTaskAsyncEnumerable<T2> source2, IUniTaskAsyncEnumerable<T3> source3, IUniTaskAsyncEnumerable<T4> source4, IUniTaskAsyncEnumerable<T5> source5, IUniTaskAsyncEnumerable<T6> source6, IUniTaskAsyncEnumerable<T7> source7, IUniTaskAsyncEnumerable<T8> source8, IUniTaskAsyncEnumerable<T9> source9, Func<T1, T2, T3, T4, T5, T6, T7, T8, T9, TResult> resultSelector)
	{
		this.source1 = source1;
		this.source2 = source2;
		this.source3 = source3;
		this.source4 = source4;
		this.source5 = source5;
		this.source6 = source6;
		this.source7 = source7;
		this.source8 = source8;
		this.source9 = source9;
		this.resultSelector = resultSelector;
	}

	public IUniTaskAsyncEnumerator<TResult> GetAsyncEnumerator(CancellationToken cancellationToken = default(CancellationToken))
	{
		return new _CombineLatest(source1, source2, source3, source4, source5, source6, source7, source8, source9, resultSelector, cancellationToken);
	}
}
internal class CombineLatest<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, TResult> : IUniTaskAsyncEnumerable<TResult>
{
	private class _CombineLatest : MoveNextSource, IUniTaskAsyncEnumerator<TResult>, IUniTaskAsyncDisposable
	{
		private static readonly Action<object> Completed1Delegate = Completed1;

		private static readonly Action<object> Completed2Delegate = Completed2;

		private static readonly Action<object> Completed3Delegate = Completed3;

		private static readonly Action<object> Completed4Delegate = Completed4;

		private static readonly Action<object> Completed5Delegate = Completed5;

		private static readonly Action<object> Completed6Delegate = Completed6;

		private static readonly Action<object> Completed7Delegate = Completed7;

		private static readonly Action<object> Completed8Delegate = Completed8;

		private static readonly Action<object> Completed9Delegate = Completed9;

		private static readonly Action<object> Completed10Delegate = Completed10;

		private readonly IUniTaskAsyncEnumerable<T1> source1;

		private readonly IUniTaskAsyncEnumerable<T2> source2;

		private readonly IUniTaskAsyncEnumerable<T3> source3;

		private readonly IUniTaskAsyncEnumerable<T4> source4;

		private readonly IUniTaskAsyncEnumerable<T5> source5;

		private readonly IUniTaskAsyncEnumerable<T6> source6;

		private readonly IUniTaskAsyncEnumerable<T7> source7;

		private readonly IUniTaskAsyncEnumerable<T8> source8;

		private readonly IUniTaskAsyncEnumerable<T9> source9;

		private readonly IUniTaskAsyncEnumerable<T10> source10;

		private readonly Func<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, TResult> resultSelector;

		private CancellationToken cancellationToken;

		private IUniTaskAsyncEnumerator<T1> enumerator1;

		private UniTask<bool>.Awaiter awaiter1;

		private bool hasCurrent1;

		private bool running1;

		private T1 current1;

		private IUniTaskAsyncEnumerator<T2> enumerator2;

		private UniTask<bool>.Awaiter awaiter2;

		private bool hasCurrent2;

		private bool running2;

		private T2 current2;

		private IUniTaskAsyncEnumerator<T3> enumerator3;

		private UniTask<bool>.Awaiter awaiter3;

		private bool hasCurrent3;

		private bool running3;

		private T3 current3;

		private IUniTaskAsyncEnumerator<T4> enumerator4;

		private UniTask<bool>.Awaiter awaiter4;

		private bool hasCurrent4;

		private bool running4;

		private T4 current4;

		private IUniTaskAsyncEnumerator<T5> enumerator5;

		private UniTask<bool>.Awaiter awaiter5;

		private bool hasCurrent5;

		private bool running5;

		private T5 current5;

		private IUniTaskAsyncEnumerator<T6> enumerator6;

		private UniTask<bool>.Awaiter awaiter6;

		private bool hasCurrent6;

		private bool running6;

		private T6 current6;

		private IUniTaskAsyncEnumerator<T7> enumerator7;

		private UniTask<bool>.Awaiter awaiter7;

		private bool hasCurrent7;

		private bool running7;

		private T7 current7;

		private IUniTaskAsyncEnumerator<T8> enumerator8;

		private UniTask<bool>.Awaiter awaiter8;

		private bool hasCurrent8;

		private bool running8;

		private T8 current8;

		private IUniTaskAsyncEnumerator<T9> enumerator9;

		private UniTask<bool>.Awaiter awaiter9;

		private bool hasCurrent9;

		private bool running9;

		private T9 current9;

		private IUniTaskAsyncEnumerator<T10> enumerator10;

		private UniTask<bool>.Awaiter awaiter10;

		private bool hasCurrent10;

		private bool running10;

		private T10 current10;

		private int completedCount;

		private bool syncRunning;

		private TResult result;

		public TResult Current => result;

		public _CombineLatest(IUniTaskAsyncEnumerable<T1> source1, IUniTaskAsyncEnumerable<T2> source2, IUniTaskAsyncEnumerable<T3> source3, IUniTaskAsyncEnumerable<T4> source4, IUniTaskAsyncEnumerable<T5> source5, IUniTaskAsyncEnumerable<T6> source6, IUniTaskAsyncEnumerable<T7> source7, IUniTaskAsyncEnumerable<T8> source8, IUniTaskAsyncEnumerable<T9> source9, IUniTaskAsyncEnumerable<T10> source10, Func<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, TResult> resultSelector, CancellationToken cancellationToken)
		{
			this.source1 = source1;
			this.source2 = source2;
			this.source3 = source3;
			this.source4 = source4;
			this.source5 = source5;
			this.source6 = source6;
			this.source7 = source7;
			this.source8 = source8;
			this.source9 = source9;
			this.source10 = source10;
			this.resultSelector = resultSelector;
			this.cancellationToken = cancellationToken;
		}

		public UniTask<bool> MoveNextAsync()
		{
			cancellationToken.ThrowIfCancellationRequested();
			if (completedCount == 10)
			{
				return CompletedTasks.False;
			}
			if (enumerator1 == null)
			{
				enumerator1 = source1.GetAsyncEnumerator(cancellationToken);
				enumerator2 = source2.GetAsyncEnumerator(cancellationToken);
				enumerator3 = source3.GetAsyncEnumerator(cancellationToken);
				enumerator4 = source4.GetAsyncEnumerator(cancellationToken);
				enumerator5 = source5.GetAsyncEnumerator(cancellationToken);
				enumerator6 = source6.GetAsyncEnumerator(cancellationToken);
				enumerator7 = source7.GetAsyncEnumerator(cancellationToken);
				enumerator8 = source8.GetAsyncEnumerator(cancellationToken);
				enumerator9 = source9.GetAsyncEnumerator(cancellationToken);
				enumerator10 = source10.GetAsyncEnumerator(cancellationToken);
			}
			completionSource.Reset();
			do
			{
				syncRunning = true;
				if (!running1)
				{
					running1 = true;
					awaiter1 = enumerator1.MoveNextAsync().GetAwaiter();
					if (awaiter1.IsCompleted)
					{
						Completed1(this);
					}
					else
					{
						awaiter1.SourceOnCompleted(Completed1Delegate, this);
					}
				}
				if (!running2)
				{
					running2 = true;
					awaiter2 = enumerator2.MoveNextAsync().GetAwaiter();
					if (awaiter2.IsCompleted)
					{
						Completed2(this);
					}
					else
					{
						awaiter2.SourceOnCompleted(Completed2Delegate, this);
					}
				}
				if (!running3)
				{
					running3 = true;
					awaiter3 = enumerator3.MoveNextAsync().GetAwaiter();
					if (awaiter3.IsCompleted)
					{
						Completed3(this);
					}
					else
					{
						awaiter3.SourceOnCompleted(Completed3Delegate, this);
					}
				}
				if (!running4)
				{
					running4 = true;
					awaiter4 = enumerator4.MoveNextAsync().GetAwaiter();
					if (awaiter4.IsCompleted)
					{
						Completed4(this);
					}
					else
					{
						awaiter4.SourceOnCompleted(Completed4Delegate, this);
					}
				}
				if (!running5)
				{
					running5 = true;
					awaiter5 = enumerator5.MoveNextAsync().GetAwaiter();
					if (awaiter5.IsCompleted)
					{
						Completed5(this);
					}
					else
					{
						awaiter5.SourceOnCompleted(Completed5Delegate, this);
					}
				}
				if (!running6)
				{
					running6 = true;
					awaiter6 = enumerator6.MoveNextAsync().GetAwaiter();
					if (awaiter6.IsCompleted)
					{
						Completed6(this);
					}
					else
					{
						awaiter6.SourceOnCompleted(Completed6Delegate, this);
					}
				}
				if (!running7)
				{
					running7 = true;
					awaiter7 = enumerator7.MoveNextAsync().GetAwaiter();
					if (awaiter7.IsCompleted)
					{
						Completed7(this);
					}
					else
					{
						awaiter7.SourceOnCompleted(Completed7Delegate, this);
					}
				}
				if (!running8)
				{
					running8 = true;
					awaiter8 = enumerator8.MoveNextAsync().GetAwaiter();
					if (awaiter8.IsCompleted)
					{
						Completed8(this);
					}
					else
					{
						awaiter8.SourceOnCompleted(Completed8Delegate, this);
					}
				}
				if (!running9)
				{
					running9 = true;
					awaiter9 = enumerator9.MoveNextAsync().GetAwaiter();
					if (awaiter9.IsCompleted)
					{
						Completed9(this);
					}
					else
					{
						awaiter9.SourceOnCompleted(Completed9Delegate, this);
					}
				}
				if (!running10)
				{
					running10 = true;
					awaiter10 = enumerator10.MoveNextAsync().GetAwaiter();
					if (awaiter10.IsCompleted)
					{
						Completed10(this);
					}
					else
					{
						awaiter10.SourceOnCompleted(Completed10Delegate, this);
					}
				}
			}
			while (!running1 || !running2 || !running3 || !running4 || !running5 || !running6 || !running7 || !running8 || !running9 || !running10);
			syncRunning = false;
			return new UniTask<bool>(this, completionSource.Version);
		}

		private static void Completed1(object state)
		{
			_CombineLatest combineLatest = (_CombineLatest)state;
			combineLatest.running1 = false;
			try
			{
				if (combineLatest.awaiter1.GetResult())
				{
					combineLatest.hasCurrent1 = true;
					combineLatest.current1 = combineLatest.enumerator1.Current;
					goto IL_0074;
				}
				combineLatest.running1 = true;
				if (Interlocked.Increment(ref combineLatest.completedCount) != 10)
				{
					return;
				}
			}
			catch (Exception error)
			{
				combineLatest.running1 = true;
				combineLatest.completedCount = 10;
				combineLatest.completionSource.TrySetException(error);
				return;
			}
			combineLatest.completionSource.TrySetResult(result: false);
			return;
			IL_0074:
			if (!combineLatest.TrySetResult() && !combineLatest.syncRunning)
			{
				combineLatest.running1 = true;
				try
				{
					combineLatest.awaiter1 = combineLatest.enumerator1.MoveNextAsync().GetAwaiter();
				}
				catch (Exception error2)
				{
					combineLatest.completedCount = 10;
					combineLatest.completionSource.TrySetException(error2);
					return;
				}
				combineLatest.awaiter1.SourceOnCompleted(Completed1Delegate, combineLatest);
			}
		}

		private static void Completed2(object state)
		{
			_CombineLatest combineLatest = (_CombineLatest)state;
			combineLatest.running2 = false;
			try
			{
				if (combineLatest.awaiter2.GetResult())
				{
					combineLatest.hasCurrent2 = true;
					combineLatest.current2 = combineLatest.enumerator2.Current;
					goto IL_0074;
				}
				combineLatest.running2 = true;
				if (Interlocked.Increment(ref combineLatest.completedCount) != 10)
				{
					return;
				}
			}
			catch (Exception error)
			{
				combineLatest.running2 = true;
				combineLatest.completedCount = 10;
				combineLatest.completionSource.TrySetException(error);
				return;
			}
			combineLatest.completionSource.TrySetResult(result: false);
			return;
			IL_0074:
			if (!combineLatest.TrySetResult() && !combineLatest.syncRunning)
			{
				combineLatest.running2 = true;
				try
				{
					combineLatest.awaiter2 = combineLatest.enumerator2.MoveNextAsync().GetAwaiter();
				}
				catch (Exception error2)
				{
					combineLatest.completedCount = 10;
					combineLatest.completionSource.TrySetException(error2);
					return;
				}
				combineLatest.awaiter2.SourceOnCompleted(Completed2Delegate, combineLatest);
			}
		}

		private static void Completed3(object state)
		{
			_CombineLatest combineLatest = (_CombineLatest)state;
			combineLatest.running3 = false;
			try
			{
				if (combineLatest.awaiter3.GetResult())
				{
					combineLatest.hasCurrent3 = true;
					combineLatest.current3 = combineLatest.enumerator3.Current;
					goto IL_0074;
				}
				combineLatest.running3 = true;
				if (Interlocked.Increment(ref combineLatest.completedCount) != 10)
				{
					return;
				}
			}
			catch (Exception error)
			{
				combineLatest.running3 = true;
				combineLatest.completedCount = 10;
				combineLatest.completionSource.TrySetException(error);
				return;
			}
			combineLatest.completionSource.TrySetResult(result: false);
			return;
			IL_0074:
			if (!combineLatest.TrySetResult() && !combineLatest.syncRunning)
			{
				combineLatest.running3 = true;
				try
				{
					combineLatest.awaiter3 = combineLatest.enumerator3.MoveNextAsync().GetAwaiter();
				}
				catch (Exception error2)
				{
					combineLatest.completedCount = 10;
					combineLatest.completionSource.TrySetException(error2);
					return;
				}
				combineLatest.awaiter3.SourceOnCompleted(Completed3Delegate, combineLatest);
			}
		}

		private static void Completed4(object state)
		{
			_CombineLatest combineLatest = (_CombineLatest)state;
			combineLatest.running4 = false;
			try
			{
				if (combineLatest.awaiter4.GetResult())
				{
					combineLatest.hasCurrent4 = true;
					combineLatest.current4 = combineLatest.enumerator4.Current;
					goto IL_0074;
				}
				combineLatest.running4 = true;
				if (Interlocked.Increment(ref combineLatest.completedCount) != 10)
				{
					return;
				}
			}
			catch (Exception error)
			{
				combineLatest.running4 = true;
				combineLatest.completedCount = 10;
				combineLatest.completionSource.TrySetException(error);
				return;
			}
			combineLatest.completionSource.TrySetResult(result: false);
			return;
			IL_0074:
			if (!combineLatest.TrySetResult() && !combineLatest.syncRunning)
			{
				combineLatest.running4 = true;
				try
				{
					combineLatest.awaiter4 = combineLatest.enumerator4.MoveNextAsync().GetAwaiter();
				}
				catch (Exception error2)
				{
					combineLatest.completedCount = 10;
					combineLatest.completionSource.TrySetException(error2);
					return;
				}
				combineLatest.awaiter4.SourceOnCompleted(Completed4Delegate, combineLatest);
			}
		}

		private static void Completed5(object state)
		{
			_CombineLatest combineLatest = (_CombineLatest)state;
			combineLatest.running5 = false;
			try
			{
				if (combineLatest.awaiter5.GetResult())
				{
					combineLatest.hasCurrent5 = true;
					combineLatest.current5 = combineLatest.enumerator5.Current;
					goto IL_0074;
				}
				combineLatest.running5 = true;
				if (Interlocked.Increment(ref combineLatest.completedCount) != 10)
				{
					return;
				}
			}
			catch (Exception error)
			{
				combineLatest.running5 = true;
				combineLatest.completedCount = 10;
				combineLatest.completionSource.TrySetException(error);
				return;
			}
			combineLatest.completionSource.TrySetResult(result: false);
			return;
			IL_0074:
			if (!combineLatest.TrySetResult() && !combineLatest.syncRunning)
			{
				combineLatest.running5 = true;
				try
				{
					combineLatest.awaiter5 = combineLatest.enumerator5.MoveNextAsync().GetAwaiter();
				}
				catch (Exception error2)
				{
					combineLatest.completedCount = 10;
					combineLatest.completionSource.TrySetException(error2);
					return;
				}
				combineLatest.awaiter5.SourceOnCompleted(Completed5Delegate, combineLatest);
			}
		}

		private static void Completed6(object state)
		{
			_CombineLatest combineLatest = (_CombineLatest)state;
			combineLatest.running6 = false;
			try
			{
				if (combineLatest.awaiter6.GetResult())
				{
					combineLatest.hasCurrent6 = true;
					combineLatest.current6 = combineLatest.enumerator6.Current;
					goto IL_0074;
				}
				combineLatest.running6 = true;
				if (Interlocked.Increment(ref combineLatest.completedCount) != 10)
				{
					return;
				}
			}
			catch (Exception error)
			{
				combineLatest.running6 = true;
				combineLatest.completedCount = 10;
				combineLatest.completionSource.TrySetException(error);
				return;
			}
			combineLatest.completionSource.TrySetResult(result: false);
			return;
			IL_0074:
			if (!combineLatest.TrySetResult() && !combineLatest.syncRunning)
			{
				combineLatest.running6 = true;
				try
				{
					combineLatest.awaiter6 = combineLatest.enumerator6.MoveNextAsync().GetAwaiter();
				}
				catch (Exception error2)
				{
					combineLatest.completedCount = 10;
					combineLatest.completionSource.TrySetException(error2);
					return;
				}
				combineLatest.awaiter6.SourceOnCompleted(Completed6Delegate, combineLatest);
			}
		}

		private static void Completed7(object state)
		{
			_CombineLatest combineLatest = (_CombineLatest)state;
			combineLatest.running7 = false;
			try
			{
				if (combineLatest.awaiter7.GetResult())
				{
					combineLatest.hasCurrent7 = true;
					combineLatest.current7 = combineLatest.enumerator7.Current;
					goto IL_0074;
				}
				combineLatest.running7 = true;
				if (Interlocked.Increment(ref combineLatest.completedCount) != 10)
				{
					return;
				}
			}
			catch (Exception error)
			{
				combineLatest.running7 = true;
				combineLatest.completedCount = 10;
				combineLatest.completionSource.TrySetException(error);
				return;
			}
			combineLatest.completionSource.TrySetResult(result: false);
			return;
			IL_0074:
			if (!combineLatest.TrySetResult() && !combineLatest.syncRunning)
			{
				combineLatest.running7 = true;
				try
				{
					combineLatest.awaiter7 = combineLatest.enumerator7.MoveNextAsync().GetAwaiter();
				}
				catch (Exception error2)
				{
					combineLatest.completedCount = 10;
					combineLatest.completionSource.TrySetException(error2);
					return;
				}
				combineLatest.awaiter7.SourceOnCompleted(Completed7Delegate, combineLatest);
			}
		}

		private static void Completed8(object state)
		{
			_CombineLatest combineLatest = (_CombineLatest)state;
			combineLatest.running8 = false;
			try
			{
				if (combineLatest.awaiter8.GetResult())
				{
					combineLatest.hasCurrent8 = true;
					combineLatest.current8 = combineLatest.enumerator8.Current;
					goto IL_0074;
				}
				combineLatest.running8 = true;
				if (Interlocked.Increment(ref combineLatest.completedCount) != 10)
				{
					return;
				}
			}
			catch (Exception error)
			{
				combineLatest.running8 = true;
				combineLatest.completedCount = 10;
				combineLatest.completionSource.TrySetException(error);
				return;
			}
			combineLatest.completionSource.TrySetResult(result: false);
			return;
			IL_0074:
			if (!combineLatest.TrySetResult() && !combineLatest.syncRunning)
			{
				combineLatest.running8 = true;
				try
				{
					combineLatest.awaiter8 = combineLatest.enumerator8.MoveNextAsync().GetAwaiter();
				}
				catch (Exception error2)
				{
					combineLatest.completedCount = 10;
					combineLatest.completionSource.TrySetException(error2);
					return;
				}
				combineLatest.awaiter8.SourceOnCompleted(Completed8Delegate, combineLatest);
			}
		}

		private static void Completed9(object state)
		{
			_CombineLatest combineLatest = (_CombineLatest)state;
			combineLatest.running9 = false;
			try
			{
				if (combineLatest.awaiter9.GetResult())
				{
					combineLatest.hasCurrent9 = true;
					combineLatest.current9 = combineLatest.enumerator9.Current;
					goto IL_0074;
				}
				combineLatest.running9 = true;
				if (Interlocked.Increment(ref combineLatest.completedCount) != 10)
				{
					return;
				}
			}
			catch (Exception error)
			{
				combineLatest.running9 = true;
				combineLatest.completedCount = 10;
				combineLatest.completionSource.TrySetException(error);
				return;
			}
			combineLatest.completionSource.TrySetResult(result: false);
			return;
			IL_0074:
			if (!combineLatest.TrySetResult() && !combineLatest.syncRunning)
			{
				combineLatest.running9 = true;
				try
				{
					combineLatest.awaiter9 = combineLatest.enumerator9.MoveNextAsync().GetAwaiter();
				}
				catch (Exception error2)
				{
					combineLatest.completedCount = 10;
					combineLatest.completionSource.TrySetException(error2);
					return;
				}
				combineLatest.awaiter9.SourceOnCompleted(Completed9Delegate, combineLatest);
			}
		}

		private static void Completed10(object state)
		{
			_CombineLatest combineLatest = (_CombineLatest)state;
			combineLatest.running10 = false;
			try
			{
				if (combineLatest.awaiter10.GetResult())
				{
					combineLatest.hasCurrent10 = true;
					combineLatest.current10 = combineLatest.enumerator10.Current;
					goto IL_0074;
				}
				combineLatest.running10 = true;
				if (Interlocked.Increment(ref combineLatest.completedCount) != 10)
				{
					return;
				}
			}
			catch (Exception error)
			{
				combineLatest.running10 = true;
				combineLatest.completedCount = 10;
				combineLatest.completionSource.TrySetException(error);
				return;
			}
			combineLatest.completionSource.TrySetResult(result: false);
			return;
			IL_0074:
			if (!combineLatest.TrySetResult() && !combineLatest.syncRunning)
			{
				combineLatest.running10 = true;
				try
				{
					combineLatest.awaiter10 = combineLatest.enumerator10.MoveNextAsync().GetAwaiter();
				}
				catch (Exception error2)
				{
					combineLatest.completedCount = 10;
					combineLatest.completionSource.TrySetException(error2);
					return;
				}
				combineLatest.awaiter10.SourceOnCompleted(Completed10Delegate, combineLatest);
			}
		}

		private bool TrySetResult()
		{
			if (hasCurrent1 && hasCurrent2 && hasCurrent3 && hasCurrent4 && hasCurrent5 && hasCurrent6 && hasCurrent7 && hasCurrent8 && hasCurrent9 && hasCurrent10)
			{
				result = resultSelector(current1, current2, current3, current4, current5, current6, current7, current8, current9, current10);
				completionSource.TrySetResult(result: true);
				return true;
			}
			return false;
		}

		public async UniTask DisposeAsync()
		{
			if (enumerator1 != null)
			{
				await enumerator1.DisposeAsync();
			}
			if (enumerator2 != null)
			{
				await enumerator2.DisposeAsync();
			}
			if (enumerator3 != null)
			{
				await enumerator3.DisposeAsync();
			}
			if (enumerator4 != null)
			{
				await enumerator4.DisposeAsync();
			}
			if (enumerator5 != null)
			{
				await enumerator5.DisposeAsync();
			}
			if (enumerator6 != null)
			{
				await enumerator6.DisposeAsync();
			}
			if (enumerator7 != null)
			{
				await enumerator7.DisposeAsync();
			}
			if (enumerator8 != null)
			{
				await enumerator8.DisposeAsync();
			}
			if (enumerator9 != null)
			{
				await enumerator9.DisposeAsync();
			}
			if (enumerator10 != null)
			{
				await enumerator10.DisposeAsync();
			}
		}
	}

	private readonly IUniTaskAsyncEnumerable<T1> source1;

	private readonly IUniTaskAsyncEnumerable<T2> source2;

	private readonly IUniTaskAsyncEnumerable<T3> source3;

	private readonly IUniTaskAsyncEnumerable<T4> source4;

	private readonly IUniTaskAsyncEnumerable<T5> source5;

	private readonly IUniTaskAsyncEnumerable<T6> source6;

	private readonly IUniTaskAsyncEnumerable<T7> source7;

	private readonly IUniTaskAsyncEnumerable<T8> source8;

	private readonly IUniTaskAsyncEnumerable<T9> source9;

	private readonly IUniTaskAsyncEnumerable<T10> source10;

	private readonly Func<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, TResult> resultSelector;

	public CombineLatest(IUniTaskAsyncEnumerable<T1> source1, IUniTaskAsyncEnumerable<T2> source2, IUniTaskAsyncEnumerable<T3> source3, IUniTaskAsyncEnumerable<T4> source4, IUniTaskAsyncEnumerable<T5> source5, IUniTaskAsyncEnumerable<T6> source6, IUniTaskAsyncEnumerable<T7> source7, IUniTaskAsyncEnumerable<T8> source8, IUniTaskAsyncEnumerable<T9> source9, IUniTaskAsyncEnumerable<T10> source10, Func<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, TResult> resultSelector)
	{
		this.source1 = source1;
		this.source2 = source2;
		this.source3 = source3;
		this.source4 = source4;
		this.source5 = source5;
		this.source6 = source6;
		this.source7 = source7;
		this.source8 = source8;
		this.source9 = source9;
		this.source10 = source10;
		this.resultSelector = resultSelector;
	}

	public IUniTaskAsyncEnumerator<TResult> GetAsyncEnumerator(CancellationToken cancellationToken = default(CancellationToken))
	{
		return new _CombineLatest(source1, source2, source3, source4, source5, source6, source7, source8, source9, source10, resultSelector, cancellationToken);
	}
}
internal class CombineLatest<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, TResult> : IUniTaskAsyncEnumerable<TResult>
{
	private class _CombineLatest : MoveNextSource, IUniTaskAsyncEnumerator<TResult>, IUniTaskAsyncDisposable
	{
		private static readonly Action<object> Completed1Delegate = Completed1;

		private static readonly Action<object> Completed2Delegate = Completed2;

		private static readonly Action<object> Completed3Delegate = Completed3;

		private static readonly Action<object> Completed4Delegate = Completed4;

		private static readonly Action<object> Completed5Delegate = Completed5;

		private static readonly Action<object> Completed6Delegate = Completed6;

		private static readonly Action<object> Completed7Delegate = Completed7;

		private static readonly Action<object> Completed8Delegate = Completed8;

		private static readonly Action<object> Completed9Delegate = Completed9;

		private static readonly Action<object> Completed10Delegate = Completed10;

		private static readonly Action<object> Completed11Delegate = Completed11;

		private readonly IUniTaskAsyncEnumerable<T1> source1;

		private readonly IUniTaskAsyncEnumerable<T2> source2;

		private readonly IUniTaskAsyncEnumerable<T3> source3;

		private readonly IUniTaskAsyncEnumerable<T4> source4;

		private readonly IUniTaskAsyncEnumerable<T5> source5;

		private readonly IUniTaskAsyncEnumerable<T6> source6;

		private readonly IUniTaskAsyncEnumerable<T7> source7;

		private readonly IUniTaskAsyncEnumerable<T8> source8;

		private readonly IUniTaskAsyncEnumerable<T9> source9;

		private readonly IUniTaskAsyncEnumerable<T10> source10;

		private readonly IUniTaskAsyncEnumerable<T11> source11;

		private readonly Func<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, TResult> resultSelector;

		private CancellationToken cancellationToken;

		private IUniTaskAsyncEnumerator<T1> enumerator1;

		private UniTask<bool>.Awaiter awaiter1;

		private bool hasCurrent1;

		private bool running1;

		private T1 current1;

		private IUniTaskAsyncEnumerator<T2> enumerator2;

		private UniTask<bool>.Awaiter awaiter2;

		private bool hasCurrent2;

		private bool running2;

		private T2 current2;

		private IUniTaskAsyncEnumerator<T3> enumerator3;

		private UniTask<bool>.Awaiter awaiter3;

		private bool hasCurrent3;

		private bool running3;

		private T3 current3;

		private IUniTaskAsyncEnumerator<T4> enumerator4;

		private UniTask<bool>.Awaiter awaiter4;

		private bool hasCurrent4;

		private bool running4;

		private T4 current4;

		private IUniTaskAsyncEnumerator<T5> enumerator5;

		private UniTask<bool>.Awaiter awaiter5;

		private bool hasCurrent5;

		private bool running5;

		private T5 current5;

		private IUniTaskAsyncEnumerator<T6> enumerator6;

		private UniTask<bool>.Awaiter awaiter6;

		private bool hasCurrent6;

		private bool running6;

		private T6 current6;

		private IUniTaskAsyncEnumerator<T7> enumerator7;

		private UniTask<bool>.Awaiter awaiter7;

		private bool hasCurrent7;

		private bool running7;

		private T7 current7;

		private IUniTaskAsyncEnumerator<T8> enumerator8;

		private UniTask<bool>.Awaiter awaiter8;

		private bool hasCurrent8;

		private bool running8;

		private T8 current8;

		private IUniTaskAsyncEnumerator<T9> enumerator9;

		private UniTask<bool>.Awaiter awaiter9;

		private bool hasCurrent9;

		private bool running9;

		private T9 current9;

		private IUniTaskAsyncEnumerator<T10> enumerator10;

		private UniTask<bool>.Awaiter awaiter10;

		private bool hasCurrent10;

		private bool running10;

		private T10 current10;

		private IUniTaskAsyncEnumerator<T11> enumerator11;

		private UniTask<bool>.Awaiter awaiter11;

		private bool hasCurrent11;

		private bool running11;

		private T11 current11;

		private int completedCount;

		private bool syncRunning;

		private TResult result;

		public TResult Current => result;

		public _CombineLatest(IUniTaskAsyncEnumerable<T1> source1, IUniTaskAsyncEnumerable<T2> source2, IUniTaskAsyncEnumerable<T3> source3, IUniTaskAsyncEnumerable<T4> source4, IUniTaskAsyncEnumerable<T5> source5, IUniTaskAsyncEnumerable<T6> source6, IUniTaskAsyncEnumerable<T7> source7, IUniTaskAsyncEnumerable<T8> source8, IUniTaskAsyncEnumerable<T9> source9, IUniTaskAsyncEnumerable<T10> source10, IUniTaskAsyncEnumerable<T11> source11, Func<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, TResult> resultSelector, CancellationToken cancellationToken)
		{
			this.source1 = source1;
			this.source2 = source2;
			this.source3 = source3;
			this.source4 = source4;
			this.source5 = source5;
			this.source6 = source6;
			this.source7 = source7;
			this.source8 = source8;
			this.source9 = source9;
			this.source10 = source10;
			this.source11 = source11;
			this.resultSelector = resultSelector;
			this.cancellationToken = cancellationToken;
		}

		public UniTask<bool> MoveNextAsync()
		{
			cancellationToken.ThrowIfCancellationRequested();
			if (completedCount == 11)
			{
				return CompletedTasks.False;
			}
			if (enumerator1 == null)
			{
				enumerator1 = source1.GetAsyncEnumerator(cancellationToken);
				enumerator2 = source2.GetAsyncEnumerator(cancellationToken);
				enumerator3 = source3.GetAsyncEnumerator(cancellationToken);
				enumerator4 = source4.GetAsyncEnumerator(cancellationToken);
				enumerator5 = source5.GetAsyncEnumerator(cancellationToken);
				enumerator6 = source6.GetAsyncEnumerator(cancellationToken);
				enumerator7 = source7.GetAsyncEnumerator(cancellationToken);
				enumerator8 = source8.GetAsyncEnumerator(cancellationToken);
				enumerator9 = source9.GetAsyncEnumerator(cancellationToken);
				enumerator10 = source10.GetAsyncEnumerator(cancellationToken);
				enumerator11 = source11.GetAsyncEnumerator(cancellationToken);
			}
			completionSource.Reset();
			do
			{
				syncRunning = true;
				if (!running1)
				{
					running1 = true;
					awaiter1 = enumerator1.MoveNextAsync().GetAwaiter();
					if (awaiter1.IsCompleted)
					{
						Completed1(this);
					}
					else
					{
						awaiter1.SourceOnCompleted(Completed1Delegate, this);
					}
				}
				if (!running2)
				{
					running2 = true;
					awaiter2 = enumerator2.MoveNextAsync().GetAwaiter();
					if (awaiter2.IsCompleted)
					{
						Completed2(this);
					}
					else
					{
						awaiter2.SourceOnCompleted(Completed2Delegate, this);
					}
				}
				if (!running3)
				{
					running3 = true;
					awaiter3 = enumerator3.MoveNextAsync().GetAwaiter();
					if (awaiter3.IsCompleted)
					{
						Completed3(this);
					}
					else
					{
						awaiter3.SourceOnCompleted(Completed3Delegate, this);
					}
				}
				if (!running4)
				{
					running4 = true;
					awaiter4 = enumerator4.MoveNextAsync().GetAwaiter();
					if (awaiter4.IsCompleted)
					{
						Completed4(this);
					}
					else
					{
						awaiter4.SourceOnCompleted(Completed4Delegate, this);
					}
				}
				if (!running5)
				{
					running5 = true;
					awaiter5 = enumerator5.MoveNextAsync().GetAwaiter();
					if (awaiter5.IsCompleted)
					{
						Completed5(this);
					}
					else
					{
						awaiter5.SourceOnCompleted(Completed5Delegate, this);
					}
				}
				if (!running6)
				{
					running6 = true;
					awaiter6 = enumerator6.MoveNextAsync().GetAwaiter();
					if (awaiter6.IsCompleted)
					{
						Completed6(this);
					}
					else
					{
						awaiter6.SourceOnCompleted(Completed6Delegate, this);
					}
				}
				if (!running7)
				{
					running7 = true;
					awaiter7 = enumerator7.MoveNextAsync().GetAwaiter();
					if (awaiter7.IsCompleted)
					{
						Completed7(this);
					}
					else
					{
						awaiter7.SourceOnCompleted(Completed7Delegate, this);
					}
				}
				if (!running8)
				{
					running8 = true;
					awaiter8 = enumerator8.MoveNextAsync().GetAwaiter();
					if (awaiter8.IsCompleted)
					{
						Completed8(this);
					}
					else
					{
						awaiter8.SourceOnCompleted(Completed8Delegate, this);
					}
				}
				if (!running9)
				{
					running9 = true;
					awaiter9 = enumerator9.MoveNextAsync().GetAwaiter();
					if (awaiter9.IsCompleted)
					{
						Completed9(this);
					}
					else
					{
						awaiter9.SourceOnCompleted(Completed9Delegate, this);
					}
				}
				if (!running10)
				{
					running10 = true;
					awaiter10 = enumerator10.MoveNextAsync().GetAwaiter();
					if (awaiter10.IsCompleted)
					{
						Completed10(this);
					}
					else
					{
						awaiter10.SourceOnCompleted(Completed10Delegate, this);
					}
				}
				if (!running11)
				{
					running11 = true;
					awaiter11 = enumerator11.MoveNextAsync().GetAwaiter();
					if (awaiter11.IsCompleted)
					{
						Completed11(this);
					}
					else
					{
						awaiter11.SourceOnCompleted(Completed11Delegate, this);
					}
				}
			}
			while (!running1 || !running2 || !running3 || !running4 || !running5 || !running6 || !running7 || !running8 || !running9 || !running10 || !running11);
			syncRunning = false;
			return new UniTask<bool>(this, completionSource.Version);
		}

		private static void Completed1(object state)
		{
			_CombineLatest combineLatest = (_CombineLatest)state;
			combineLatest.running1 = false;
			try
			{
				if (combineLatest.awaiter1.GetResult())
				{
					combineLatest.hasCurrent1 = true;
					combineLatest.current1 = combineLatest.enumerator1.Current;
					goto IL_0074;
				}
				combineLatest.running1 = true;
				if (Interlocked.Increment(ref combineLatest.completedCount) != 11)
				{
					return;
				}
			}
			catch (Exception error)
			{
				combineLatest.running1 = true;
				combineLatest.completedCount = 11;
				combineLatest.completionSource.TrySetException(error);
				return;
			}
			combineLatest.completionSource.TrySetResult(result: false);
			return;
			IL_0074:
			if (!combineLatest.TrySetResult() && !combineLatest.syncRunning)
			{
				combineLatest.running1 = true;
				try
				{
					combineLatest.awaiter1 = combineLatest.enumerator1.MoveNextAsync().GetAwaiter();
				}
				catch (Exception error2)
				{
					combineLatest.completedCount = 11;
					combineLatest.completionSource.TrySetException(error2);
					return;
				}
				combineLatest.awaiter1.SourceOnCompleted(Completed1Delegate, combineLatest);
			}
		}

		private static void Completed2(object state)
		{
			_CombineLatest combineLatest = (_CombineLatest)state;
			combineLatest.running2 = false;
			try
			{
				if (combineLatest.awaiter2.GetResult())
				{
					combineLatest.hasCurrent2 = true;
					combineLatest.current2 = combineLatest.enumerator2.Current;
					goto IL_0074;
				}
				combineLatest.running2 = true;
				if (Interlocked.Increment(ref combineLatest.completedCount) != 11)
				{
					return;
				}
			}
			catch (Exception error)
			{
				combineLatest.running2 = true;
				combineLatest.completedCount = 11;
				combineLatest.completionSource.TrySetException(error);
				return;
			}
			combineLatest.completionSource.TrySetResult(result: false);
			return;
			IL_0074:
			if (!combineLatest.TrySetResult() && !combineLatest.syncRunning)
			{
				combineLatest.running2 = true;
				try
				{
					combineLatest.awaiter2 = combineLatest.enumerator2.MoveNextAsync().GetAwaiter();
				}
				catch (Exception error2)
				{
					combineLatest.completedCount = 11;
					combineLatest.completionSource.TrySetException(error2);
					return;
				}
				combineLatest.awaiter2.SourceOnCompleted(Completed2Delegate, combineLatest);
			}
		}

		private static void Completed3(object state)
		{
			_CombineLatest combineLatest = (_CombineLatest)state;
			combineLatest.running3 = false;
			try
			{
				if (combineLatest.awaiter3.GetResult())
				{
					combineLatest.hasCurrent3 = true;
					combineLatest.current3 = combineLatest.enumerator3.Current;
					goto IL_0074;
				}
				combineLatest.running3 = true;
				if (Interlocked.Increment(ref combineLatest.completedCount) != 11)
				{
					return;
				}
			}
			catch (Exception error)
			{
				combineLatest.running3 = true;
				combineLatest.completedCount = 11;
				combineLatest.completionSource.TrySetException(error);
				return;
			}
			combineLatest.completionSource.TrySetResult(result: false);
			return;
			IL_0074:
			if (!combineLatest.TrySetResult() && !combineLatest.syncRunning)
			{
				combineLatest.running3 = true;
				try
				{
					combineLatest.awaiter3 = combineLatest.enumerator3.MoveNextAsync().GetAwaiter();
				}
				catch (Exception error2)
				{
					combineLatest.completedCount = 11;
					combineLatest.completionSource.TrySetException(error2);
					return;
				}
				combineLatest.awaiter3.SourceOnCompleted(Completed3Delegate, combineLatest);
			}
		}

		private static void Completed4(object state)
		{
			_CombineLatest combineLatest = (_CombineLatest)state;
			combineLatest.running4 = false;
			try
			{
				if (combineLatest.awaiter4.GetResult())
				{
					combineLatest.hasCurrent4 = true;
					combineLatest.current4 = combineLatest.enumerator4.Current;
					goto IL_0074;
				}
				combineLatest.running4 = true;
				if (Interlocked.Increment(ref combineLatest.completedCount) != 11)
				{
					return;
				}
			}
			catch (Exception error)
			{
				combineLatest.running4 = true;
				combineLatest.completedCount = 11;
				combineLatest.completionSource.TrySetException(error);
				return;
			}
			combineLatest.completionSource.TrySetResult(result: false);
			return;
			IL_0074:
			if (!combineLatest.TrySetResult() && !combineLatest.syncRunning)
			{
				combineLatest.running4 = true;
				try
				{
					combineLatest.awaiter4 = combineLatest.enumerator4.MoveNextAsync().GetAwaiter();
				}
				catch (Exception error2)
				{
					combineLatest.completedCount = 11;
					combineLatest.completionSource.TrySetException(error2);
					return;
				}
				combineLatest.awaiter4.SourceOnCompleted(Completed4Delegate, combineLatest);
			}
		}

		private static void Completed5(object state)
		{
			_CombineLatest combineLatest = (_CombineLatest)state;
			combineLatest.running5 = false;
			try
			{
				if (combineLatest.awaiter5.GetResult())
				{
					combineLatest.hasCurrent5 = true;
					combineLatest.current5 = combineLatest.enumerator5.Current;
					goto IL_0074;
				}
				combineLatest.running5 = true;
				if (Interlocked.Increment(ref combineLatest.completedCount) != 11)
				{
					return;
				}
			}
			catch (Exception error)
			{
				combineLatest.running5 = true;
				combineLatest.completedCount = 11;
				combineLatest.completionSource.TrySetException(error);
				return;
			}
			combineLatest.completionSource.TrySetResult(result: false);
			return;
			IL_0074:
			if (!combineLatest.TrySetResult() && !combineLatest.syncRunning)
			{
				combineLatest.running5 = true;
				try
				{
					combineLatest.awaiter5 = combineLatest.enumerator5.MoveNextAsync().GetAwaiter();
				}
				catch (Exception error2)
				{
					combineLatest.completedCount = 11;
					combineLatest.completionSource.TrySetException(error2);
					return;
				}
				combineLatest.awaiter5.SourceOnCompleted(Completed5Delegate, combineLatest);
			}
		}

		private static void Completed6(object state)
		{
			_CombineLatest combineLatest = (_CombineLatest)state;
			combineLatest.running6 = false;
			try
			{
				if (combineLatest.awaiter6.GetResult())
				{
					combineLatest.hasCurrent6 = true;
					combineLatest.current6 = combineLatest.enumerator6.Current;
					goto IL_0074;
				}
				combineLatest.running6 = true;
				if (Interlocked.Increment(ref combineLatest.completedCount) != 11)
				{
					return;
				}
			}
			catch (Exception error)
			{
				combineLatest.running6 = true;
				combineLatest.completedCount = 11;
				combineLatest.completionSource.TrySetException(error);
				return;
			}
			combineLatest.completionSource.TrySetResult(result: false);
			return;
			IL_0074:
			if (!combineLatest.TrySetResult() && !combineLatest.syncRunning)
			{
				combineLatest.running6 = true;
				try
				{
					combineLatest.awaiter6 = combineLatest.enumerator6.MoveNextAsync().GetAwaiter();
				}
				catch (Exception error2)
				{
					combineLatest.completedCount = 11;
					combineLatest.completionSource.TrySetException(error2);
					return;
				}
				combineLatest.awaiter6.SourceOnCompleted(Completed6Delegate, combineLatest);
			}
		}

		private static void Completed7(object state)
		{
			_CombineLatest combineLatest = (_CombineLatest)state;
			combineLatest.running7 = false;
			try
			{
				if (combineLatest.awaiter7.GetResult())
				{
					combineLatest.hasCurrent7 = true;
					combineLatest.current7 = combineLatest.enumerator7.Current;
					goto IL_0074;
				}
				combineLatest.running7 = true;
				if (Interlocked.Increment(ref combineLatest.completedCount) != 11)
				{
					return;
				}
			}
			catch (Exception error)
			{
				combineLatest.running7 = true;
				combineLatest.completedCount = 11;
				combineLatest.completionSource.TrySetException(error);
				return;
			}
			combineLatest.completionSource.TrySetResult(result: false);
			return;
			IL_0074:
			if (!combineLatest.TrySetResult() && !combineLatest.syncRunning)
			{
				combineLatest.running7 = true;
				try
				{
					combineLatest.awaiter7 = combineLatest.enumerator7.MoveNextAsync().GetAwaiter();
				}
				catch (Exception error2)
				{
					combineLatest.completedCount = 11;
					combineLatest.completionSource.TrySetException(error2);
					return;
				}
				combineLatest.awaiter7.SourceOnCompleted(Completed7Delegate, combineLatest);
			}
		}

		private static void Completed8(object state)
		{
			_CombineLatest combineLatest = (_CombineLatest)state;
			combineLatest.running8 = false;
			try
			{
				if (combineLatest.awaiter8.GetResult())
				{
					combineLatest.hasCurrent8 = true;
					combineLatest.current8 = combineLatest.enumerator8.Current;
					goto IL_0074;
				}
				combineLatest.running8 = true;
				if (Interlocked.Increment(ref combineLatest.completedCount) != 11)
				{
					return;
				}
			}
			catch (Exception error)
			{
				combineLatest.running8 = true;
				combineLatest.completedCount = 11;
				combineLatest.completionSource.TrySetException(error);
				return;
			}
			combineLatest.completionSource.TrySetResult(result: false);
			return;
			IL_0074:
			if (!combineLatest.TrySetResult() && !combineLatest.syncRunning)
			{
				combineLatest.running8 = true;
				try
				{
					combineLatest.awaiter8 = combineLatest.enumerator8.MoveNextAsync().GetAwaiter();
				}
				catch (Exception error2)
				{
					combineLatest.completedCount = 11;
					combineLatest.completionSource.TrySetException(error2);
					return;
				}
				combineLatest.awaiter8.SourceOnCompleted(Completed8Delegate, combineLatest);
			}
		}

		private static void Completed9(object state)
		{
			_CombineLatest combineLatest = (_CombineLatest)state;
			combineLatest.running9 = false;
			try
			{
				if (combineLatest.awaiter9.GetResult())
				{
					combineLatest.hasCurrent9 = true;
					combineLatest.current9 = combineLatest.enumerator9.Current;
					goto IL_0074;
				}
				combineLatest.running9 = true;
				if (Interlocked.Increment(ref combineLatest.completedCount) != 11)
				{
					return;
				}
			}
			catch (Exception error)
			{
				combineLatest.running9 = true;
				combineLatest.completedCount = 11;
				combineLatest.completionSource.TrySetException(error);
				return;
			}
			combineLatest.completionSource.TrySetResult(result: false);
			return;
			IL_0074:
			if (!combineLatest.TrySetResult() && !combineLatest.syncRunning)
			{
				combineLatest.running9 = true;
				try
				{
					combineLatest.awaiter9 = combineLatest.enumerator9.MoveNextAsync().GetAwaiter();
				}
				catch (Exception error2)
				{
					combineLatest.completedCount = 11;
					combineLatest.completionSource.TrySetException(error2);
					return;
				}
				combineLatest.awaiter9.SourceOnCompleted(Completed9Delegate, combineLatest);
			}
		}

		private static void Completed10(object state)
		{
			_CombineLatest combineLatest = (_CombineLatest)state;
			combineLatest.running10 = false;
			try
			{
				if (combineLatest.awaiter10.GetResult())
				{
					combineLatest.hasCurrent10 = true;
					combineLatest.current10 = combineLatest.enumerator10.Current;
					goto IL_0074;
				}
				combineLatest.running10 = true;
				if (Interlocked.Increment(ref combineLatest.completedCount) != 11)
				{
					return;
				}
			}
			catch (Exception error)
			{
				combineLatest.running10 = true;
				combineLatest.completedCount = 11;
				combineLatest.completionSource.TrySetException(error);
				return;
			}
			combineLatest.completionSource.TrySetResult(result: false);
			return;
			IL_0074:
			if (!combineLatest.TrySetResult() && !combineLatest.syncRunning)
			{
				combineLatest.running10 = true;
				try
				{
					combineLatest.awaiter10 = combineLatest.enumerator10.MoveNextAsync().GetAwaiter();
				}
				catch (Exception error2)
				{
					combineLatest.completedCount = 11;
					combineLatest.completionSource.TrySetException(error2);
					return;
				}
				combineLatest.awaiter10.SourceOnCompleted(Completed10Delegate, combineLatest);
			}
		}

		private static void Completed11(object state)
		{
			_CombineLatest combineLatest = (_CombineLatest)state;
			combineLatest.running11 = false;
			try
			{
				if (combineLatest.awaiter11.GetResult())
				{
					combineLatest.hasCurrent11 = true;
					combineLatest.current11 = combineLatest.enumerator11.Current;
					goto IL_0074;
				}
				combineLatest.running11 = true;
				if (Interlocked.Increment(ref combineLatest.completedCount) != 11)
				{
					return;
				}
			}
			catch (Exception error)
			{
				combineLatest.running11 = true;
				combineLatest.completedCount = 11;
				combineLatest.completionSource.TrySetException(error);
				return;
			}
			combineLatest.completionSource.TrySetResult(result: false);
			return;
			IL_0074:
			if (!combineLatest.TrySetResult() && !combineLatest.syncRunning)
			{
				combineLatest.running11 = true;
				try
				{
					combineLatest.awaiter11 = combineLatest.enumerator11.MoveNextAsync().GetAwaiter();
				}
				catch (Exception error2)
				{
					combineLatest.completedCount = 11;
					combineLatest.completionSource.TrySetException(error2);
					return;
				}
				combineLatest.awaiter11.SourceOnCompleted(Completed11Delegate, combineLatest);
			}
		}

		private bool TrySetResult()
		{
			if (hasCurrent1 && hasCurrent2 && hasCurrent3 && hasCurrent4 && hasCurrent5 && hasCurrent6 && hasCurrent7 && hasCurrent8 && hasCurrent9 && hasCurrent10 && hasCurrent11)
			{
				result = resultSelector(current1, current2, current3, current4, current5, current6, current7, current8, current9, current10, current11);
				completionSource.TrySetResult(result: true);
				return true;
			}
			return false;
		}

		public async UniTask DisposeAsync()
		{
			if (enumerator1 != null)
			{
				await enumerator1.DisposeAsync();
			}
			if (enumerator2 != null)
			{
				await enumerator2.DisposeAsync();
			}
			if (enumerator3 != null)
			{
				await enumerator3.DisposeAsync();
			}
			if (enumerator4 != null)
			{
				await enumerator4.DisposeAsync();
			}
			if (enumerator5 != null)
			{
				await enumerator5.DisposeAsync();
			}
			if (enumerator6 != null)
			{
				await enumerator6.DisposeAsync();
			}
			if (enumerator7 != null)
			{
				await enumerator7.DisposeAsync();
			}
			if (enumerator8 != null)
			{
				await enumerator8.DisposeAsync();
			}
			if (enumerator9 != null)
			{
				await enumerator9.DisposeAsync();
			}
			if (enumerator10 != null)
			{
				await enumerator10.DisposeAsync();
			}
			if (enumerator11 != null)
			{
				await enumerator11.DisposeAsync();
			}
		}
	}

	private readonly IUniTaskAsyncEnumerable<T1> source1;

	private readonly IUniTaskAsyncEnumerable<T2> source2;

	private readonly IUniTaskAsyncEnumerable<T3> source3;

	private readonly IUniTaskAsyncEnumerable<T4> source4;

	private readonly IUniTaskAsyncEnumerable<T5> source5;

	private readonly IUniTaskAsyncEnumerable<T6> source6;

	private readonly IUniTaskAsyncEnumerable<T7> source7;

	private readonly IUniTaskAsyncEnumerable<T8> source8;

	private readonly IUniTaskAsyncEnumerable<T9> source9;

	private readonly IUniTaskAsyncEnumerable<T10> source10;

	private readonly IUniTaskAsyncEnumerable<T11> source11;

	private readonly Func<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, TResult> resultSelector;

	public CombineLatest(IUniTaskAsyncEnumerable<T1> source1, IUniTaskAsyncEnumerable<T2> source2, IUniTaskAsyncEnumerable<T3> source3, IUniTaskAsyncEnumerable<T4> source4, IUniTaskAsyncEnumerable<T5> source5, IUniTaskAsyncEnumerable<T6> source6, IUniTaskAsyncEnumerable<T7> source7, IUniTaskAsyncEnumerable<T8> source8, IUniTaskAsyncEnumerable<T9> source9, IUniTaskAsyncEnumerable<T10> source10, IUniTaskAsyncEnumerable<T11> source11, Func<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, TResult> resultSelector)
	{
		this.source1 = source1;
		this.source2 = source2;
		this.source3 = source3;
		this.source4 = source4;
		this.source5 = source5;
		this.source6 = source6;
		this.source7 = source7;
		this.source8 = source8;
		this.source9 = source9;
		this.source10 = source10;
		this.source11 = source11;
		this.resultSelector = resultSelector;
	}

	public IUniTaskAsyncEnumerator<TResult> GetAsyncEnumerator(CancellationToken cancellationToken = default(CancellationToken))
	{
		return new _CombineLatest(source1, source2, source3, source4, source5, source6, source7, source8, source9, source10, source11, resultSelector, cancellationToken);
	}
}
internal class CombineLatest<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, TResult> : IUniTaskAsyncEnumerable<TResult>
{
	private class _CombineLatest : MoveNextSource, IUniTaskAsyncEnumerator<TResult>, IUniTaskAsyncDisposable
	{
		private static readonly Action<object> Completed1Delegate = Completed1;

		private static readonly Action<object> Completed2Delegate = Completed2;

		private static readonly Action<object> Completed3Delegate = Completed3;

		private static readonly Action<object> Completed4Delegate = Completed4;

		private static readonly Action<object> Completed5Delegate = Completed5;

		private static readonly Action<object> Completed6Delegate = Completed6;

		private static readonly Action<object> Completed7Delegate = Completed7;

		private static readonly Action<object> Completed8Delegate = Completed8;

		private static readonly Action<object> Completed9Delegate = Completed9;

		private static readonly Action<object> Completed10Delegate = Completed10;

		private static readonly Action<object> Completed11Delegate = Completed11;

		private static readonly Action<object> Completed12Delegate = Completed12;

		private readonly IUniTaskAsyncEnumerable<T1> source1;

		private readonly IUniTaskAsyncEnumerable<T2> source2;

		private readonly IUniTaskAsyncEnumerable<T3> source3;

		private readonly IUniTaskAsyncEnumerable<T4> source4;

		private readonly IUniTaskAsyncEnumerable<T5> source5;

		private readonly IUniTaskAsyncEnumerable<T6> source6;

		private readonly IUniTaskAsyncEnumerable<T7> source7;

		private readonly IUniTaskAsyncEnumerable<T8> source8;

		private readonly IUniTaskAsyncEnumerable<T9> source9;

		private readonly IUniTaskAsyncEnumerable<T10> source10;

		private readonly IUniTaskAsyncEnumerable<T11> source11;

		private readonly IUniTaskAsyncEnumerable<T12> source12;

		private readonly Func<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, TResult> resultSelector;

		private CancellationToken cancellationToken;

		private IUniTaskAsyncEnumerator<T1> enumerator1;

		private UniTask<bool>.Awaiter awaiter1;

		private bool hasCurrent1;

		private bool running1;

		private T1 current1;

		private IUniTaskAsyncEnumerator<T2> enumerator2;

		private UniTask<bool>.Awaiter awaiter2;

		private bool hasCurrent2;

		private bool running2;

		private T2 current2;

		private IUniTaskAsyncEnumerator<T3> enumerator3;

		private UniTask<bool>.Awaiter awaiter3;

		private bool hasCurrent3;

		private bool running3;

		private T3 current3;

		private IUniTaskAsyncEnumerator<T4> enumerator4;

		private UniTask<bool>.Awaiter awaiter4;

		private bool hasCurrent4;

		private bool running4;

		private T4 current4;

		private IUniTaskAsyncEnumerator<T5> enumerator5;

		private UniTask<bool>.Awaiter awaiter5;

		private bool hasCurrent5;

		private bool running5;

		private T5 current5;

		private IUniTaskAsyncEnumerator<T6> enumerator6;

		private UniTask<bool>.Awaiter awaiter6;

		private bool hasCurrent6;

		private bool running6;

		private T6 current6;

		private IUniTaskAsyncEnumerator<T7> enumerator7;

		private UniTask<bool>.Awaiter awaiter7;

		private bool hasCurrent7;

		private bool running7;

		private T7 current7;

		private IUniTaskAsyncEnumerator<T8> enumerator8;

		private UniTask<bool>.Awaiter awaiter8;

		private bool hasCurrent8;

		private bool running8;

		private T8 current8;

		private IUniTaskAsyncEnumerator<T9> enumerator9;

		private UniTask<bool>.Awaiter awaiter9;

		private bool hasCurrent9;

		private bool running9;

		private T9 current9;

		private IUniTaskAsyncEnumerator<T10> enumerator10;

		private UniTask<bool>.Awaiter awaiter10;

		private bool hasCurrent10;

		private bool running10;

		private T10 current10;

		private IUniTaskAsyncEnumerator<T11> enumerator11;

		private UniTask<bool>.Awaiter awaiter11;

		private bool hasCurrent11;

		private bool running11;

		private T11 current11;

		private IUniTaskAsyncEnumerator<T12> enumerator12;

		private UniTask<bool>.Awaiter awaiter12;

		private bool hasCurrent12;

		private bool running12;

		private T12 current12;

		private int completedCount;

		private bool syncRunning;

		private TResult result;

		public TResult Current => result;

		public _CombineLatest(IUniTaskAsyncEnumerable<T1> source1, IUniTaskAsyncEnumerable<T2> source2, IUniTaskAsyncEnumerable<T3> source3, IUniTaskAsyncEnumerable<T4> source4, IUniTaskAsyncEnumerable<T5> source5, IUniTaskAsyncEnumerable<T6> source6, IUniTaskAsyncEnumerable<T7> source7, IUniTaskAsyncEnumerable<T8> source8, IUniTaskAsyncEnumerable<T9> source9, IUniTaskAsyncEnumerable<T10> source10, IUniTaskAsyncEnumerable<T11> source11, IUniTaskAsyncEnumerable<T12> source12, Func<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, TResult> resultSelector, CancellationToken cancellationToken)
		{
			this.source1 = source1;
			this.source2 = source2;
			this.source3 = source3;
			this.source4 = source4;
			this.source5 = source5;
			this.source6 = source6;
			this.source7 = source7;
			this.source8 = source8;
			this.source9 = source9;
			this.source10 = source10;
			this.source11 = source11;
			this.source12 = source12;
			this.resultSelector = resultSelector;
			this.cancellationToken = cancellationToken;
		}

		public UniTask<bool> MoveNextAsync()
		{
			cancellationToken.ThrowIfCancellationRequested();
			if (completedCount == 12)
			{
				return CompletedTasks.False;
			}
			if (enumerator1 == null)
			{
				enumerator1 = source1.GetAsyncEnumerator(cancellationToken);
				enumerator2 = source2.GetAsyncEnumerator(cancellationToken);
				enumerator3 = source3.GetAsyncEnumerator(cancellationToken);
				enumerator4 = source4.GetAsyncEnumerator(cancellationToken);
				enumerator5 = source5.GetAsyncEnumerator(cancellationToken);
				enumerator6 = source6.GetAsyncEnumerator(cancellationToken);
				enumerator7 = source7.GetAsyncEnumerator(cancellationToken);
				enumerator8 = source8.GetAsyncEnumerator(cancellationToken);
				enumerator9 = source9.GetAsyncEnumerator(cancellationToken);
				enumerator10 = source10.GetAsyncEnumerator(cancellationToken);
				enumerator11 = source11.GetAsyncEnumerator(cancellationToken);
				enumerator12 = source12.GetAsyncEnumerator(cancellationToken);
			}
			completionSource.Reset();
			do
			{
				syncRunning = true;
				if (!running1)
				{
					running1 = true;
					awaiter1 = enumerator1.MoveNextAsync().GetAwaiter();
					if (awaiter1.IsCompleted)
					{
						Completed1(this);
					}
					else
					{
						awaiter1.SourceOnCompleted(Completed1Delegate, this);
					}
				}
				if (!running2)
				{
					running2 = true;
					awaiter2 = enumerator2.MoveNextAsync().GetAwaiter();
					if (awaiter2.IsCompleted)
					{
						Completed2(this);
					}
					else
					{
						awaiter2.SourceOnCompleted(Completed2Delegate, this);
					}
				}
				if (!running3)
				{
					running3 = true;
					awaiter3 = enumerator3.MoveNextAsync().GetAwaiter();
					if (awaiter3.IsCompleted)
					{
						Completed3(this);
					}
					else
					{
						awaiter3.SourceOnCompleted(Completed3Delegate, this);
					}
				}
				if (!running4)
				{
					running4 = true;
					awaiter4 = enumerator4.MoveNextAsync().GetAwaiter();
					if (awaiter4.IsCompleted)
					{
						Completed4(this);
					}
					else
					{
						awaiter4.SourceOnCompleted(Completed4Delegate, this);
					}
				}
				if (!running5)
				{
					running5 = true;
					awaiter5 = enumerator5.MoveNextAsync().GetAwaiter();
					if (awaiter5.IsCompleted)
					{
						Completed5(this);
					}
					else
					{
						awaiter5.SourceOnCompleted(Completed5Delegate, this);
					}
				}
				if (!running6)
				{
					running6 = true;
					awaiter6 = enumerator6.MoveNextAsync().GetAwaiter();
					if (awaiter6.IsCompleted)
					{
						Completed6(this);
					}
					else
					{
						awaiter6.SourceOnCompleted(Completed6Delegate, this);
					}
				}
				if (!running7)
				{
					running7 = true;
					awaiter7 = enumerator7.MoveNextAsync().GetAwaiter();
					if (awaiter7.IsCompleted)
					{
						Completed7(this);
					}
					else
					{
						awaiter7.SourceOnCompleted(Completed7Delegate, this);
					}
				}
				if (!running8)
				{
					running8 = true;
					awaiter8 = enumerator8.MoveNextAsync().GetAwaiter();
					if (awaiter8.IsCompleted)
					{
						Completed8(this);
					}
					else
					{
						awaiter8.SourceOnCompleted(Completed8Delegate, this);
					}
				}
				if (!running9)
				{
					running9 = true;
					awaiter9 = enumerator9.MoveNextAsync().GetAwaiter();
					if (awaiter9.IsCompleted)
					{
						Completed9(this);
					}
					else
					{
						awaiter9.SourceOnCompleted(Completed9Delegate, this);
					}
				}
				if (!running10)
				{
					running10 = true;
					awaiter10 = enumerator10.MoveNextAsync().GetAwaiter();
					if (awaiter10.IsCompleted)
					{
						Completed10(this);
					}
					else
					{
						awaiter10.SourceOnCompleted(Completed10Delegate, this);
					}
				}
				if (!running11)
				{
					running11 = true;
					awaiter11 = enumerator11.MoveNextAsync().GetAwaiter();
					if (awaiter11.IsCompleted)
					{
						Completed11(this);
					}
					else
					{
						awaiter11.SourceOnCompleted(Completed11Delegate, this);
					}
				}
				if (!running12)
				{
					running12 = true;
					awaiter12 = enumerator12.MoveNextAsync().GetAwaiter();
					if (awaiter12.IsCompleted)
					{
						Completed12(this);
					}
					else
					{
						awaiter12.SourceOnCompleted(Completed12Delegate, this);
					}
				}
			}
			while (!running1 || !running2 || !running3 || !running4 || !running5 || !running6 || !running7 || !running8 || !running9 || !running10 || !running11 || !running12);
			syncRunning = false;
			return new UniTask<bool>(this, completionSource.Version);
		}

		private static void Completed1(object state)
		{
			_CombineLatest combineLatest = (_CombineLatest)state;
			combineLatest.running1 = false;
			try
			{
				if (combineLatest.awaiter1.GetResult())
				{
					combineLatest.hasCurrent1 = true;
					combineLatest.current1 = combineLatest.enumerator1.Current;
					goto IL_0074;
				}
				combineLatest.running1 = true;
				if (Interlocked.Increment(ref combineLatest.completedCount) != 12)
				{
					return;
				}
			}
			catch (Exception error)
			{
				combineLatest.running1 = true;
				combineLatest.completedCount = 12;
				combineLatest.completionSource.TrySetException(error);
				return;
			}
			combineLatest.completionSource.TrySetResult(result: false);
			return;
			IL_0074:
			if (!combineLatest.TrySetResult() && !combineLatest.syncRunning)
			{
				combineLatest.running1 = true;
				try
				{
					combineLatest.awaiter1 = combineLatest.enumerator1.MoveNextAsync().GetAwaiter();
				}
				catch (Exception error2)
				{
					combineLatest.completedCount = 12;
					combineLatest.completionSource.TrySetException(error2);
					return;
				}
				combineLatest.awaiter1.SourceOnCompleted(Completed1Delegate, combineLatest);
			}
		}

		private static void Completed2(object state)
		{
			_CombineLatest combineLatest = (_CombineLatest)state;
			combineLatest.running2 = false;
			try
			{
				if (combineLatest.awaiter2.GetResult())
				{
					combineLatest.hasCurrent2 = true;
					combineLatest.current2 = combineLatest.enumerator2.Current;
					goto IL_0074;
				}
				combineLatest.running2 = true;
				if (Interlocked.Increment(ref combineLatest.completedCount) != 12)
				{
					return;
				}
			}
			catch (Exception error)
			{
				combineLatest.running2 = true;
				combineLatest.completedCount = 12;
				combineLatest.completionSource.TrySetException(error);
				return;
			}
			combineLatest.completionSource.TrySetResult(result: false);
			return;
			IL_0074:
			if (!combineLatest.TrySetResult() && !combineLatest.syncRunning)
			{
				combineLatest.running2 = true;
				try
				{
					combineLatest.awaiter2 = combineLatest.enumerator2.MoveNextAsync().GetAwaiter();
				}
				catch (Exception error2)
				{
					combineLatest.completedCount = 12;
					combineLatest.completionSource.TrySetException(error2);
					return;
				}
				combineLatest.awaiter2.SourceOnCompleted(Completed2Delegate, combineLatest);
			}
		}

		private static void Completed3(object state)
		{
			_CombineLatest combineLatest = (_CombineLatest)state;
			combineLatest.running3 = false;
			try
			{
				if (combineLatest.awaiter3.GetResult())
				{
					combineLatest.hasCurrent3 = true;
					combineLatest.current3 = combineLatest.enumerator3.Current;
					goto IL_0074;
				}
				combineLatest.running3 = true;
				if (Interlocked.Increment(ref combineLatest.completedCount) != 12)
				{
					return;
				}
			}
			catch (Exception error)
			{
				combineLatest.running3 = true;
				combineLatest.completedCount = 12;
				combineLatest.completionSource.TrySetException(error);
				return;
			}
			combineLatest.completionSource.TrySetResult(result: false);
			return;
			IL_0074:
			if (!combineLatest.TrySetResult() && !combineLatest.syncRunning)
			{
				combineLatest.running3 = true;
				try
				{
					combineLatest.awaiter3 = combineLatest.enumerator3.MoveNextAsync().GetAwaiter();
				}
				catch (Exception error2)
				{
					combineLatest.completedCount = 12;
					combineLatest.completionSource.TrySetException(error2);
					return;
				}
				combineLatest.awaiter3.SourceOnCompleted(Completed3Delegate, combineLatest);
			}
		}

		private static void Completed4(object state)
		{
			_CombineLatest combineLatest = (_CombineLatest)state;
			combineLatest.running4 = false;
			try
			{
				if (combineLatest.awaiter4.GetResult())
				{
					combineLatest.hasCurrent4 = true;
					combineLatest.current4 = combineLatest.enumerator4.Current;
					goto IL_0074;
				}
				combineLatest.running4 = true;
				if (Interlocked.Increment(ref combineLatest.completedCount) != 12)
				{
					return;
				}
			}
			catch (Exception error)
			{
				combineLatest.running4 = true;
				combineLatest.completedCount = 12;
				combineLatest.completionSource.TrySetException(error);
				return;
			}
			combineLatest.completionSource.TrySetResult(result: false);
			return;
			IL_0074:
			if (!combineLatest.TrySetResult() && !combineLatest.syncRunning)
			{
				combineLatest.running4 = true;
				try
				{
					combineLatest.awaiter4 = combineLatest.enumerator4.MoveNextAsync().GetAwaiter();
				}
				catch (Exception error2)
				{
					combineLatest.completedCount = 12;
					combineLatest.completionSource.TrySetException(error2);
					return;
				}
				combineLatest.awaiter4.SourceOnCompleted(Completed4Delegate, combineLatest);
			}
		}

		private static void Completed5(object state)
		{
			_CombineLatest combineLatest = (_CombineLatest)state;
			combineLatest.running5 = false;
			try
			{
				if (combineLatest.awaiter5.GetResult())
				{
					combineLatest.hasCurrent5 = true;
					combineLatest.current5 = combineLatest.enumerator5.Current;
					goto IL_0074;
				}
				combineLatest.running5 = true;
				if (Interlocked.Increment(ref combineLatest.completedCount) != 12)
				{
					return;
				}
			}
			catch (Exception error)
			{
				combineLatest.running5 = true;
				combineLatest.completedCount = 12;
				combineLatest.completionSource.TrySetException(error);
				return;
			}
			combineLatest.completionSource.TrySetResult(result: false);
			return;
			IL_0074:
			if (!combineLatest.TrySetResult() && !combineLatest.syncRunning)
			{
				combineLatest.running5 = true;
				try
				{
					combineLatest.awaiter5 = combineLatest.enumerator5.MoveNextAsync().GetAwaiter();
				}
				catch (Exception error2)
				{
					combineLatest.completedCount = 12;
					combineLatest.completionSource.TrySetException(error2);
					return;
				}
				combineLatest.awaiter5.SourceOnCompleted(Completed5Delegate, combineLatest);
			}
		}

		private static void Completed6(object state)
		{
			_CombineLatest combineLatest = (_CombineLatest)state;
			combineLatest.running6 = false;
			try
			{
				if (combineLatest.awaiter6.GetResult())
				{
					combineLatest.hasCurrent6 = true;
					combineLatest.current6 = combineLatest.enumerator6.Current;
					goto IL_0074;
				}
				combineLatest.running6 = true;
				if (Interlocked.Increment(ref combineLatest.completedCount) != 12)
				{
					return;
				}
			}
			catch (Exception error)
			{
				combineLatest.running6 = true;
				combineLatest.completedCount = 12;
				combineLatest.completionSource.TrySetException(error);
				return;
			}
			combineLatest.completionSource.TrySetResult(result: false);
			return;
			IL_0074:
			if (!combineLatest.TrySetResult() && !combineLatest.syncRunning)
			{
				combineLatest.running6 = true;
				try
				{
					combineLatest.awaiter6 = combineLatest.enumerator6.MoveNextAsync().GetAwaiter();
				}
				catch (Exception error2)
				{
					combineLatest.completedCount = 12;
					combineLatest.completionSource.TrySetException(error2);
					return;
				}
				combineLatest.awaiter6.SourceOnCompleted(Completed6Delegate, combineLatest);
			}
		}

		private static void Completed7(object state)
		{
			_CombineLatest combineLatest = (_CombineLatest)state;
			combineLatest.running7 = false;
			try
			{
				if (combineLatest.awaiter7.GetResult())
				{
					combineLatest.hasCurrent7 = true;
					combineLatest.current7 = combineLatest.enumerator7.Current;
					goto IL_0074;
				}
				combineLatest.running7 = true;
				if (Interlocked.Increment(ref combineLatest.completedCount) != 12)
				{
					return;
				}
			}
			catch (Exception error)
			{
				combineLatest.running7 = true;
				combineLatest.completedCount = 12;
				combineLatest.completionSource.TrySetException(error);
				return;
			}
			combineLatest.completionSource.TrySetResult(result: false);
			return;
			IL_0074:
			if (!combineLatest.TrySetResult() && !combineLatest.syncRunning)
			{
				combineLatest.running7 = true;
				try
				{
					combineLatest.awaiter7 = combineLatest.enumerator7.MoveNextAsync().GetAwaiter();
				}
				catch (Exception error2)
				{
					combineLatest.completedCount = 12;
					combineLatest.completionSource.TrySetException(error2);
					return;
				}
				combineLatest.awaiter7.SourceOnCompleted(Completed7Delegate, combineLatest);
			}
		}

		private static void Completed8(object state)
		{
			_CombineLatest combineLatest = (_CombineLatest)state;
			combineLatest.running8 = false;
			try
			{
				if (combineLatest.awaiter8.GetResult())
				{
					combineLatest.hasCurrent8 = true;
					combineLatest.current8 = combineLatest.enumerator8.Current;
					goto IL_0074;
				}
				combineLatest.running8 = true;
				if (Interlocked.Increment(ref combineLatest.completedCount) != 12)
				{
					return;
				}
			}
			catch (Exception error)
			{
				combineLatest.running8 = true;
				combineLatest.completedCount = 12;
				combineLatest.completionSource.TrySetException(error);
				return;
			}
			combineLatest.completionSource.TrySetResult(result: false);
			return;
			IL_0074:
			if (!combineLatest.TrySetResult() && !combineLatest.syncRunning)
			{
				combineLatest.running8 = true;
				try
				{
					combineLatest.awaiter8 = combineLatest.enumerator8.MoveNextAsync().GetAwaiter();
				}
				catch (Exception error2)
				{
					combineLatest.completedCount = 12;
					combineLatest.completionSource.TrySetException(error2);
					return;
				}
				combineLatest.awaiter8.SourceOnCompleted(Completed8Delegate, combineLatest);
			}
		}

		private static void Completed9(object state)
		{
			_CombineLatest combineLatest = (_CombineLatest)state;
			combineLatest.running9 = false;
			try
			{
				if (combineLatest.awaiter9.GetResult())
				{
					combineLatest.hasCurrent9 = true;
					combineLatest.current9 = combineLatest.enumerator9.Current;
					goto IL_0074;
				}
				combineLatest.running9 = true;
				if (Interlocked.Increment(ref combineLatest.completedCount) != 12)
				{
					return;
				}
			}
			catch (Exception error)
			{
				combineLatest.running9 = true;
				combineLatest.completedCount = 12;
				combineLatest.completionSource.TrySetException(error);
				return;
			}
			combineLatest.completionSource.TrySetResult(result: false);
			return;
			IL_0074:
			if (!combineLatest.TrySetResult() && !combineLatest.syncRunning)
			{
				combineLatest.running9 = true;
				try
				{
					combineLatest.awaiter9 = combineLatest.enumerator9.MoveNextAsync().GetAwaiter();
				}
				catch (Exception error2)
				{
					combineLatest.completedCount = 12;
					combineLatest.completionSource.TrySetException(error2);
					return;
				}
				combineLatest.awaiter9.SourceOnCompleted(Completed9Delegate, combineLatest);
			}
		}

		private static void Completed10(object state)
		{
			_CombineLatest combineLatest = (_CombineLatest)state;
			combineLatest.running10 = false;
			try
			{
				if (combineLatest.awaiter10.GetResult())
				{
					combineLatest.hasCurrent10 = true;
					combineLatest.current10 = combineLatest.enumerator10.Current;
					goto IL_0074;
				}
				combineLatest.running10 = true;
				if (Interlocked.Increment(ref combineLatest.completedCount) != 12)
				{
					return;
				}
			}
			catch (Exception error)
			{
				combineLatest.running10 = true;
				combineLatest.completedCount = 12;
				combineLatest.completionSource.TrySetException(error);
				return;
			}
			combineLatest.completionSource.TrySetResult(result: false);
			return;
			IL_0074:
			if (!combineLatest.TrySetResult() && !combineLatest.syncRunning)
			{
				combineLatest.running10 = true;
				try
				{
					combineLatest.awaiter10 = combineLatest.enumerator10.MoveNextAsync().GetAwaiter();
				}
				catch (Exception error2)
				{
					combineLatest.completedCount = 12;
					combineLatest.completionSource.TrySetException(error2);
					return;
				}
				combineLatest.awaiter10.SourceOnCompleted(Completed10Delegate, combineLatest);
			}
		}

		private static void Completed11(object state)
		{
			_CombineLatest combineLatest = (_CombineLatest)state;
			combineLatest.running11 = false;
			try
			{
				if (combineLatest.awaiter11.GetResult())
				{
					combineLatest.hasCurrent11 = true;
					combineLatest.current11 = combineLatest.enumerator11.Current;
					goto IL_0074;
				}
				combineLatest.running11 = true;
				if (Interlocked.Increment(ref combineLatest.completedCount) != 12)
				{
					return;
				}
			}
			catch (Exception error)
			{
				combineLatest.running11 = true;
				combineLatest.completedCount = 12;
				combineLatest.completionSource.TrySetException(error);
				return;
			}
			combineLatest.completionSource.TrySetResult(result: false);
			return;
			IL_0074:
			if (!combineLatest.TrySetResult() && !combineLatest.syncRunning)
			{
				combineLatest.running11 = true;
				try
				{
					combineLatest.awaiter11 = combineLatest.enumerator11.MoveNextAsync().GetAwaiter();
				}
				catch (Exception error2)
				{
					combineLatest.completedCount = 12;
					combineLatest.completionSource.TrySetException(error2);
					return;
				}
				combineLatest.awaiter11.SourceOnCompleted(Completed11Delegate, combineLatest);
			}
		}

		private static void Completed12(object state)
		{
			_CombineLatest combineLatest = (_CombineLatest)state;
			combineLatest.running12 = false;
			try
			{
				if (combineLatest.awaiter12.GetResult())
				{
					combineLatest.hasCurrent12 = true;
					combineLatest.current12 = combineLatest.enumerator12.Current;
					goto IL_0074;
				}
				combineLatest.running12 = true;
				if (Interlocked.Increment(ref combineLatest.completedCount) != 12)
				{
					return;
				}
			}
			catch (Exception error)
			{
				combineLatest.running12 = true;
				combineLatest.completedCount = 12;
				combineLatest.completionSource.TrySetException(error);
				return;
			}
			combineLatest.completionSource.TrySetResult(result: false);
			return;
			IL_0074:
			if (!combineLatest.TrySetResult() && !combineLatest.syncRunning)
			{
				combineLatest.running12 = true;
				try
				{
					combineLatest.awaiter12 = combineLatest.enumerator12.MoveNextAsync().GetAwaiter();
				}
				catch (Exception error2)
				{
					combineLatest.completedCount = 12;
					combineLatest.completionSource.TrySetException(error2);
					return;
				}
				combineLatest.awaiter12.SourceOnCompleted(Completed12Delegate, combineLatest);
			}
		}

		private bool TrySetResult()
		{
			if (hasCurrent1 && hasCurrent2 && hasCurrent3 && hasCurrent4 && hasCurrent5 && hasCurrent6 && hasCurrent7 && hasCurrent8 && hasCurrent9 && hasCurrent10 && hasCurrent11 && hasCurrent12)
			{
				result = resultSelector(current1, current2, current3, current4, current5, current6, current7, current8, current9, current10, current11, current12);
				completionSource.TrySetResult(result: true);
				return true;
			}
			return false;
		}

		public async UniTask DisposeAsync()
		{
			if (enumerator1 != null)
			{
				await enumerator1.DisposeAsync();
			}
			if (enumerator2 != null)
			{
				await enumerator2.DisposeAsync();
			}
			if (enumerator3 != null)
			{
				await enumerator3.DisposeAsync();
			}
			if (enumerator4 != null)
			{
				await enumerator4.DisposeAsync();
			}
			if (enumerator5 != null)
			{
				await enumerator5.DisposeAsync();
			}
			if (enumerator6 != null)
			{
				await enumerator6.DisposeAsync();
			}
			if (enumerator7 != null)
			{
				await enumerator7.DisposeAsync();
			}
			if (enumerator8 != null)
			{
				await enumerator8.DisposeAsync();
			}
			if (enumerator9 != null)
			{
				await enumerator9.DisposeAsync();
			}
			if (enumerator10 != null)
			{
				await enumerator10.DisposeAsync();
			}
			if (enumerator11 != null)
			{
				await enumerator11.DisposeAsync();
			}
			if (enumerator12 != null)
			{
				await enumerator12.DisposeAsync();
			}
		}
	}

	private readonly IUniTaskAsyncEnumerable<T1> source1;

	private readonly IUniTaskAsyncEnumerable<T2> source2;

	private readonly IUniTaskAsyncEnumerable<T3> source3;

	private readonly IUniTaskAsyncEnumerable<T4> source4;

	private readonly IUniTaskAsyncEnumerable<T5> source5;

	private readonly IUniTaskAsyncEnumerable<T6> source6;

	private readonly IUniTaskAsyncEnumerable<T7> source7;

	private readonly IUniTaskAsyncEnumerable<T8> source8;

	private readonly IUniTaskAsyncEnumerable<T9> source9;

	private readonly IUniTaskAsyncEnumerable<T10> source10;

	private readonly IUniTaskAsyncEnumerable<T11> source11;

	private readonly IUniTaskAsyncEnumerable<T12> source12;

	private readonly Func<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, TResult> resultSelector;

	public CombineLatest(IUniTaskAsyncEnumerable<T1> source1, IUniTaskAsyncEnumerable<T2> source2, IUniTaskAsyncEnumerable<T3> source3, IUniTaskAsyncEnumerable<T4> source4, IUniTaskAsyncEnumerable<T5> source5, IUniTaskAsyncEnumerable<T6> source6, IUniTaskAsyncEnumerable<T7> source7, IUniTaskAsyncEnumerable<T8> source8, IUniTaskAsyncEnumerable<T9> source9, IUniTaskAsyncEnumerable<T10> source10, IUniTaskAsyncEnumerable<T11> source11, IUniTaskAsyncEnumerable<T12> source12, Func<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, TResult> resultSelector)
	{
		this.source1 = source1;
		this.source2 = source2;
		this.source3 = source3;
		this.source4 = source4;
		this.source5 = source5;
		this.source6 = source6;
		this.source7 = source7;
		this.source8 = source8;
		this.source9 = source9;
		this.source10 = source10;
		this.source11 = source11;
		this.source12 = source12;
		this.resultSelector = resultSelector;
	}

	public IUniTaskAsyncEnumerator<TResult> GetAsyncEnumerator(CancellationToken cancellationToken = default(CancellationToken))
	{
		return new _CombineLatest(source1, source2, source3, source4, source5, source6, source7, source8, source9, source10, source11, source12, resultSelector, cancellationToken);
	}
}
internal class CombineLatest<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13, TResult> : IUniTaskAsyncEnumerable<TResult>
{
	private class _CombineLatest : MoveNextSource, IUniTaskAsyncEnumerator<TResult>, IUniTaskAsyncDisposable
	{
		private static readonly Action<object> Completed1Delegate = Completed1;

		private static readonly Action<object> Completed2Delegate = Completed2;

		private static readonly Action<object> Completed3Delegate = Completed3;

		private static readonly Action<object> Completed4Delegate = Completed4;

		private static readonly Action<object> Completed5Delegate = Completed5;

		private static readonly Action<object> Completed6Delegate = Completed6;

		private static readonly Action<object> Completed7Delegate = Completed7;

		private static readonly Action<object> Completed8Delegate = Completed8;

		private static readonly Action<object> Completed9Delegate = Completed9;

		private static readonly Action<object> Completed10Delegate = Completed10;

		private static readonly Action<object> Completed11Delegate = Completed11;

		private static readonly Action<object> Completed12Delegate = Completed12;

		private static readonly Action<object> Completed13Delegate = Completed13;

		private readonly IUniTaskAsyncEnumerable<T1> source1;

		private readonly IUniTaskAsyncEnumerable<T2> source2;

		private readonly IUniTaskAsyncEnumerable<T3> source3;

		private readonly IUniTaskAsyncEnumerable<T4> source4;

		private readonly IUniTaskAsyncEnumerable<T5> source5;

		private readonly IUniTaskAsyncEnumerable<T6> source6;

		private readonly IUniTaskAsyncEnumerable<T7> source7;

		private readonly IUniTaskAsyncEnumerable<T8> source8;

		private readonly IUniTaskAsyncEnumerable<T9> source9;

		private readonly IUniTaskAsyncEnumerable<T10> source10;

		private readonly IUniTaskAsyncEnumerable<T11> source11;

		private readonly IUniTaskAsyncEnumerable<T12> source12;

		private readonly IUniTaskAsyncEnumerable<T13> source13;

		private readonly Func<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13, TResult> resultSelector;

		private CancellationToken cancellationToken;

		private IUniTaskAsyncEnumerator<T1> enumerator1;

		private UniTask<bool>.Awaiter awaiter1;

		private bool hasCurrent1;

		private bool running1;

		private T1 current1;

		private IUniTaskAsyncEnumerator<T2> enumerator2;

		private UniTask<bool>.Awaiter awaiter2;

		private bool hasCurrent2;

		private bool running2;

		private T2 current2;

		private IUniTaskAsyncEnumerator<T3> enumerator3;

		private UniTask<bool>.Awaiter awaiter3;

		private bool hasCurrent3;

		private bool running3;

		private T3 current3;

		private IUniTaskAsyncEnumerator<T4> enumerator4;

		private UniTask<bool>.Awaiter awaiter4;

		private bool hasCurrent4;

		private bool running4;

		private T4 current4;

		private IUniTaskAsyncEnumerator<T5> enumerator5;

		private UniTask<bool>.Awaiter awaiter5;

		private bool hasCurrent5;

		private bool running5;

		private T5 current5;

		private IUniTaskAsyncEnumerator<T6> enumerator6;

		private UniTask<bool>.Awaiter awaiter6;

		private bool hasCurrent6;

		private bool running6;

		private T6 current6;

		private IUniTaskAsyncEnumerator<T7> enumerator7;

		private UniTask<bool>.Awaiter awaiter7;

		private bool hasCurrent7;

		private bool running7;

		private T7 current7;

		private IUniTaskAsyncEnumerator<T8> enumerator8;

		private UniTask<bool>.Awaiter awaiter8;

		private bool hasCurrent8;

		private bool running8;

		private T8 current8;

		private IUniTaskAsyncEnumerator<T9> enumerator9;

		private UniTask<bool>.Awaiter awaiter9;

		private bool hasCurrent9;

		private bool running9;

		private T9 current9;

		private IUniTaskAsyncEnumerator<T10> enumerator10;

		private UniTask<bool>.Awaiter awaiter10;

		private bool hasCurrent10;

		private bool running10;

		private T10 current10;

		private IUniTaskAsyncEnumerator<T11> enumerator11;

		private UniTask<bool>.Awaiter awaiter11;

		private bool hasCurrent11;

		private bool running11;

		private T11 current11;

		private IUniTaskAsyncEnumerator<T12> enumerator12;

		private UniTask<bool>.Awaiter awaiter12;

		private bool hasCurrent12;

		private bool running12;

		private T12 current12;

		private IUniTaskAsyncEnumerator<T13> enumerator13;

		private UniTask<bool>.Awaiter awaiter13;

		private bool hasCurrent13;

		private bool running13;

		private T13 current13;

		private int completedCount;

		private bool syncRunning;

		private TResult result;

		public TResult Current => result;

		public _CombineLatest(IUniTaskAsyncEnumerable<T1> source1, IUniTaskAsyncEnumerable<T2> source2, IUniTaskAsyncEnumerable<T3> source3, IUniTaskAsyncEnumerable<T4> source4, IUniTaskAsyncEnumerable<T5> source5, IUniTaskAsyncEnumerable<T6> source6, IUniTaskAsyncEnumerable<T7> source7, IUniTaskAsyncEnumerable<T8> source8, IUniTaskAsyncEnumerable<T9> source9, IUniTaskAsyncEnumerable<T10> source10, IUniTaskAsyncEnumerable<T11> source11, IUniTaskAsyncEnumerable<T12> source12, IUniTaskAsyncEnumerable<T13> source13, Func<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13, TResult> resultSelector, CancellationToken cancellationToken)
		{
			this.source1 = source1;
			this.source2 = source2;
			this.source3 = source3;
			this.source4 = source4;
			this.source5 = source5;
			this.source6 = source6;
			this.source7 = source7;
			this.source8 = source8;
			this.source9 = source9;
			this.source10 = source10;
			this.source11 = source11;
			this.source12 = source12;
			this.source13 = source13;
			this.resultSelector = resultSelector;
			this.cancellationToken = cancellationToken;
		}

		public UniTask<bool> MoveNextAsync()
		{
			cancellationToken.ThrowIfCancellationRequested();
			if (completedCount == 13)
			{
				return CompletedTasks.False;
			}
			if (enumerator1 == null)
			{
				enumerator1 = source1.GetAsyncEnumerator(cancellationToken);
				enumerator2 = source2.GetAsyncEnumerator(cancellationToken);
				enumerator3 = source3.GetAsyncEnumerator(cancellationToken);
				enumerator4 = source4.GetAsyncEnumerator(cancellationToken);
				enumerator5 = source5.GetAsyncEnumerator(cancellationToken);
				enumerator6 = source6.GetAsyncEnumerator(cancellationToken);
				enumerator7 = source7.GetAsyncEnumerator(cancellationToken);
				enumerator8 = source8.GetAsyncEnumerator(cancellationToken);
				enumerator9 = source9.GetAsyncEnumerator(cancellationToken);
				enumerator10 = source10.GetAsyncEnumerator(cancellationToken);
				enumerator11 = source11.GetAsyncEnumerator(cancellationToken);
				enumerator12 = source12.GetAsyncEnumerator(cancellationToken);
				enumerator13 = source13.GetAsyncEnumerator(cancellationToken);
			}
			completionSource.Reset();
			do
			{
				syncRunning = true;
				if (!running1)
				{
					running1 = true;
					awaiter1 = enumerator1.MoveNextAsync().GetAwaiter();
					if (awaiter1.IsCompleted)
					{
						Completed1(this);
					}
					else
					{
						awaiter1.SourceOnCompleted(Completed1Delegate, this);
					}
				}
				if (!running2)
				{
					running2 = true;
					awaiter2 = enumerator2.MoveNextAsync().GetAwaiter();
					if (awaiter2.IsCompleted)
					{
						Completed2(this);
					}
					else
					{
						awaiter2.SourceOnCompleted(Completed2Delegate, this);
					}
				}
				if (!running3)
				{
					running3 = true;
					awaiter3 = enumerator3.MoveNextAsync().GetAwaiter();
					if (awaiter3.IsCompleted)
					{
						Completed3(this);
					}
					else
					{
						awaiter3.SourceOnCompleted(Completed3Delegate, this);
					}
				}
				if (!running4)
				{
					running4 = true;
					awaiter4 = enumerator4.MoveNextAsync().GetAwaiter();
					if (awaiter4.IsCompleted)
					{
						Completed4(this);
					}
					else
					{
						awaiter4.SourceOnCompleted(Completed4Delegate, this);
					}
				}
				if (!running5)
				{
					running5 = true;
					awaiter5 = enumerator5.MoveNextAsync().GetAwaiter();
					if (awaiter5.IsCompleted)
					{
						Completed5(this);
					}
					else
					{
						awaiter5.SourceOnCompleted(Completed5Delegate, this);
					}
				}
				if (!running6)
				{
					running6 = true;
					awaiter6 = enumerator6.MoveNextAsync().GetAwaiter();
					if (awaiter6.IsCompleted)
					{
						Completed6(this);
					}
					else
					{
						awaiter6.SourceOnCompleted(Completed6Delegate, this);
					}
				}
				if (!running7)
				{
					running7 = true;
					awaiter7 = enumerator7.MoveNextAsync().GetAwaiter();
					if (awaiter7.IsCompleted)
					{
						Completed7(this);
					}
					else
					{
						awaiter7.SourceOnCompleted(Completed7Delegate, this);
					}
				}
				if (!running8)
				{
					running8 = true;
					awaiter8 = enumerator8.MoveNextAsync().GetAwaiter();
					if (awaiter8.IsCompleted)
					{
						Completed8(this);
					}
					else
					{
						awaiter8.SourceOnCompleted(Completed8Delegate, this);
					}
				}
				if (!running9)
				{
					running9 = true;
					awaiter9 = enumerator9.MoveNextAsync().GetAwaiter();
					if (awaiter9.IsCompleted)
					{
						Completed9(this);
					}
					else
					{
						awaiter9.SourceOnCompleted(Completed9Delegate, this);
					}
				}
				if (!running10)
				{
					running10 = true;
					awaiter10 = enumerator10.MoveNextAsync().GetAwaiter();
					if (awaiter10.IsCompleted)
					{
						Completed10(this);
					}
					else
					{
						awaiter10.SourceOnCompleted(Completed10Delegate, this);
					}
				}
				if (!running11)
				{
					running11 = true;
					awaiter11 = enumerator11.MoveNextAsync().GetAwaiter();
					if (awaiter11.IsCompleted)
					{
						Completed11(this);
					}
					else
					{
						awaiter11.SourceOnCompleted(Completed11Delegate, this);
					}
				}
				if (!running12)
				{
					running12 = true;
					awaiter12 = enumerator12.MoveNextAsync().GetAwaiter();
					if (awaiter12.IsCompleted)
					{
						Completed12(this);
					}
					else
					{
						awaiter12.SourceOnCompleted(Completed12Delegate, this);
					}
				}
				if (!running13)
				{
					running13 = true;
					awaiter13 = enumerator13.MoveNextAsync().GetAwaiter();
					if (awaiter13.IsCompleted)
					{
						Completed13(this);
					}
					else
					{
						awaiter13.SourceOnCompleted(Completed13Delegate, this);
					}
				}
			}
			while (!running1 || !running2 || !running3 || !running4 || !running5 || !running6 || !running7 || !running8 || !running9 || !running10 || !running11 || !running12 || !running13);
			syncRunning = false;
			return new UniTask<bool>(this, completionSource.Version);
		}

		private static void Completed1(object state)
		{
			_CombineLatest combineLatest = (_CombineLatest)state;
			combineLatest.running1 = false;
			try
			{
				if (combineLatest.awaiter1.GetResult())
				{
					combineLatest.hasCurrent1 = true;
					combineLatest.current1 = combineLatest.enumerator1.Current;
					goto IL_0074;
				}
				combineLatest.running1 = true;
				if (Interlocked.Increment(ref combineLatest.completedCount) != 13)
				{
					return;
				}
			}
			catch (Exception error)
			{
				combineLatest.running1 = true;
				combineLatest.completedCount = 13;
				combineLatest.completionSource.TrySetException(error);
				return;
			}
			combineLatest.completionSource.TrySetResult(result: false);
			return;
			IL_0074:
			if (!combineLatest.TrySetResult() && !combineLatest.syncRunning)
			{
				combineLatest.running1 = true;
				try
				{
					combineLatest.awaiter1 = combineLatest.enumerator1.MoveNextAsync().GetAwaiter();
				}
				catch (Exception error2)
				{
					combineLatest.completedCount = 13;
					combineLatest.completionSource.TrySetException(error2);
					return;
				}
				combineLatest.awaiter1.SourceOnCompleted(Completed1Delegate, combineLatest);
			}
		}

		private static void Completed2(object state)
		{
			_CombineLatest combineLatest = (_CombineLatest)state;
			combineLatest.running2 = false;
			try
			{
				if (combineLatest.awaiter2.GetResult())
				{
					combineLatest.hasCurrent2 = true;
					combineLatest.current2 = combineLatest.enumerator2.Current;
					goto IL_0074;
				}
				combineLatest.running2 = true;
				if (Interlocked.Increment(ref combineLatest.completedCount) != 13)
				{
					return;
				}
			}
			catch (Exception error)
			{
				combineLatest.running2 = true;
				combineLatest.completedCount = 13;
				combineLatest.completionSource.TrySetException(error);
				return;
			}
			combineLatest.completionSource.TrySetResult(result: false);
			return;
			IL_0074:
			if (!combineLatest.TrySetResult() && !combineLatest.syncRunning)
			{
				combineLatest.running2 = true;
				try
				{
					combineLatest.awaiter2 = combineLatest.enumerator2.MoveNextAsync().GetAwaiter();
				}
				catch (Exception error2)
				{
					combineLatest.completedCount = 13;
					combineLatest.completionSource.TrySetException(error2);
					return;
				}
				combineLatest.awaiter2.SourceOnCompleted(Completed2Delegate, combineLatest);
			}
		}

		private static void Completed3(object state)
		{
			_CombineLatest combineLatest = (_CombineLatest)state;
			combineLatest.running3 = false;
			try
			{
				if (combineLatest.awaiter3.GetResult())
				{
					combineLatest.hasCurrent3 = true;
					combineLatest.current3 = combineLatest.enumerator3.Current;
					goto IL_0074;
				}
				combineLatest.running3 = true;
				if (Interlocked.Increment(ref combineLatest.completedCount) != 13)
				{
					return;
				}
			}
			catch (Exception error)
			{
				combineLatest.running3 = true;
				combineLatest.completedCount = 13;
				combineLatest.completionSource.TrySetException(error);
				return;
			}
			combineLatest.completionSource.TrySetResult(result: false);
			return;
			IL_0074:
			if (!combineLatest.TrySetResult() && !combineLatest.syncRunning)
			{
				combineLatest.running3 = true;
				try
				{
					combineLatest.awaiter3 = combineLatest.enumerator3.MoveNextAsync().GetAwaiter();
				}
				catch (Exception error2)
				{
					combineLatest.completedCount = 13;
					combineLatest.completionSource.TrySetException(error2);
					return;
				}
				combineLatest.awaiter3.SourceOnCompleted(Completed3Delegate, combineLatest);
			}
		}

		private static void Completed4(object state)
		{
			_CombineLatest combineLatest = (_CombineLatest)state;
			combineLatest.running4 = false;
			try
			{
				if (combineLatest.awaiter4.GetResult())
				{
					combineLatest.hasCurrent4 = true;
					combineLatest.current4 = combineLatest.enumerator4.Current;
					goto IL_0074;
				}
				combineLatest.running4 = true;
				if (Interlocked.Increment(ref combineLatest.completedCount) != 13)
				{
					return;
				}
			}
			catch (Exception error)
			{
				combineLatest.running4 = true;
				combineLatest.completedCount = 13;
				combineLatest.completionSource.TrySetException(error);
				return;
			}
			combineLatest.completionSource.TrySetResult(result: false);
			return;
			IL_0074:
			if (!combineLatest.TrySetResult() && !combineLatest.syncRunning)
			{
				combineLatest.running4 = true;
				try
				{
					combineLatest.awaiter4 = combineLatest.enumerator4.MoveNextAsync().GetAwaiter();
				}
				catch (Exception error2)
				{
					combineLatest.completedCount = 13;
					combineLatest.completionSource.TrySetException(error2);
					return;
				}
				combineLatest.awaiter4.SourceOnCompleted(Completed4Delegate, combineLatest);
			}
		}

		private static void Completed5(object state)
		{
			_CombineLatest combineLatest = (_CombineLatest)state;
			combineLatest.running5 = false;
			try
			{
				if (combineLatest.awaiter5.GetResult())
				{
					combineLatest.hasCurrent5 = true;
					combineLatest.current5 = combineLatest.enumerator5.Current;
					goto IL_0074;
				}
				combineLatest.running5 = true;
				if (Interlocked.Increment(ref combineLatest.completedCount) != 13)
				{
					return;
				}
			}
			catch (Exception error)
			{
				combineLatest.running5 = true;
				combineLatest.completedCount = 13;
				combineLatest.completionSource.TrySetException(error);
				return;
			}
			combineLatest.completionSource.TrySetResult(result: false);
			return;
			IL_0074:
			if (!combineLatest.TrySetResult() && !combineLatest.syncRunning)
			{
				combineLatest.running5 = true;
				try
				{
					combineLatest.awaiter5 = combineLatest.enumerator5.MoveNextAsync().GetAwaiter();
				}
				catch (Exception error2)
				{
					combineLatest.completedCount = 13;
					combineLatest.completionSource.TrySetException(error2);
					return;
				}
				combineLatest.awaiter5.SourceOnCompleted(Completed5Delegate, combineLatest);
			}
		}

		private static void Completed6(object state)
		{
			_CombineLatest combineLatest = (_CombineLatest)state;
			combineLatest.running6 = false;
			try
			{
				if (combineLatest.awaiter6.GetResult())
				{
					combineLatest.hasCurrent6 = true;
					combineLatest.current6 = combineLatest.enumerator6.Current;
					goto IL_0074;
				}
				combineLatest.running6 = true;
				if (Interlocked.Increment(ref combineLatest.completedCount) != 13)
				{
					return;
				}
			}
			catch (Exception error)
			{
				combineLatest.running6 = true;
				combineLatest.completedCount = 13;
				combineLatest.completionSource.TrySetException(error);
				return;
			}
			combineLatest.completionSource.TrySetResult(result: false);
			return;
			IL_0074:
			if (!combineLatest.TrySetResult() && !combineLatest.syncRunning)
			{
				combineLatest.running6 = true;
				try
				{
					combineLatest.awaiter6 = combineLatest.enumerator6.MoveNextAsync().GetAwaiter();
				}
				catch (Exception error2)
				{
					combineLatest.completedCount = 13;
					combineLatest.completionSource.TrySetException(error2);
					return;
				}
				combineLatest.awaiter6.SourceOnCompleted(Completed6Delegate, combineLatest);
			}
		}

		private static void Completed7(object state)
		{
			_CombineLatest combineLatest = (_CombineLatest)state;
			combineLatest.running7 = false;
			try
			{
				if (combineLatest.awaiter7.GetResult())
				{
					combineLatest.hasCurrent7 = true;
					combineLatest.current7 = combineLatest.enumerator7.Current;
					goto IL_0074;
				}
				combineLatest.running7 = true;
				if (Interlocked.Increment(ref combineLatest.completedCount) != 13)
				{
					return;
				}
			}
			catch (Exception error)
			{
				combineLatest.running7 = true;
				combineLatest.completedCount = 13;
				combineLatest.completionSource.TrySetException(error);
				return;
			}
			combineLatest.completionSource.TrySetResult(result: false);
			return;
			IL_0074:
			if (!combineLatest.TrySetResult() && !combineLatest.syncRunning)
			{
				combineLatest.running7 = true;
				try
				{
					combineLatest.awaiter7 = combineLatest.enumerator7.MoveNextAsync().GetAwaiter();
				}
				catch (Exception error2)
				{
					combineLatest.completedCount = 13;
					combineLatest.completionSource.TrySetException(error2);
					return;
				}
				combineLatest.awaiter7.SourceOnCompleted(Completed7Delegate, combineLatest);
			}
		}

		private static void Completed8(object state)
		{
			_CombineLatest combineLatest = (_CombineLatest)state;
			combineLatest.running8 = false;
			try
			{
				if (combineLatest.awaiter8.GetResult())
				{
					combineLatest.hasCurrent8 = true;
					combineLatest.current8 = combineLatest.enumerator8.Current;
					goto IL_0074;
				}
				combineLatest.running8 = true;
				if (Interlocked.Increment(ref combineLatest.completedCount) != 13)
				{
					return;
				}
			}
			catch (Exception error)
			{
				combineLatest.running8 = true;
				combineLatest.completedCount = 13;
				combineLatest.completionSource.TrySetException(error);
				return;
			}
			combineLatest.completionSource.TrySetResult(result: false);
			return;
			IL_0074:
			if (!combineLatest.TrySetResult() && !combineLatest.syncRunning)
			{
				combineLatest.running8 = true;
				try
				{
					combineLatest.awaiter8 = combineLatest.enumerator8.MoveNextAsync().GetAwaiter();
				}
				catch (Exception error2)
				{
					combineLatest.completedCount = 13;
					combineLatest.completionSource.TrySetException(error2);
					return;
				}
				combineLatest.awaiter8.SourceOnCompleted(Completed8Delegate, combineLatest);
			}
		}

		private static void Completed9(object state)
		{
			_CombineLatest combineLatest = (_CombineLatest)state;
			combineLatest.running9 = false;
			try
			{
				if (combineLatest.awaiter9.GetResult())
				{
					combineLatest.hasCurrent9 = true;
					combineLatest.current9 = combineLatest.enumerator9.Current;
					goto IL_0074;
				}
				combineLatest.running9 = true;
				if (Interlocked.Increment(ref combineLatest.completedCount) != 13)
				{
					return;
				}
			}
			catch (Exception error)
			{
				combineLatest.running9 = true;
				combineLatest.completedCount = 13;
				combineLatest.completionSource.TrySetException(error);
				return;
			}
			combineLatest.completionSource.TrySetResult(result: false);
			return;
			IL_0074:
			if (!combineLatest.TrySetResult() && !combineLatest.syncRunning)
			{
				combineLatest.running9 = true;
				try
				{
					combineLatest.awaiter9 = combineLatest.enumerator9.MoveNextAsync().GetAwaiter();
				}
				catch (Exception error2)
				{
					combineLatest.completedCount = 13;
					combineLatest.completionSource.TrySetException(error2);
					return;
				}
				combineLatest.awaiter9.SourceOnCompleted(Completed9Delegate, combineLatest);
			}
		}

		private static void Completed10(object state)
		{
			_CombineLatest combineLatest = (_CombineLatest)state;
			combineLatest.running10 = false;
			try
			{
				if (combineLatest.awaiter10.GetResult())
				{
					combineLatest.hasCurrent10 = true;
					combineLatest.current10 = combineLatest.enumerator10.Current;
					goto IL_0074;
				}
				combineLatest.running10 = true;
				if (Interlocked.Increment(ref combineLatest.completedCount) != 13)
				{
					return;
				}
			}
			catch (Exception error)
			{
				combineLatest.running10 = true;
				combineLatest.completedCount = 13;
				combineLatest.completionSource.TrySetException(error);
				return;
			}
			combineLatest.completionSource.TrySetResult(result: false);
			return;
			IL_0074:
			if (!combineLatest.TrySetResult() && !combineLatest.syncRunning)
			{
				combineLatest.running10 = true;
				try
				{
					combineLatest.awaiter10 = combineLatest.enumerator10.MoveNextAsync().GetAwaiter();
				}
				catch (Exception error2)
				{
					combineLatest.completedCount = 13;
					combineLatest.completionSource.TrySetException(error2);
					return;
				}
				combineLatest.awaiter10.SourceOnCompleted(Completed10Delegate, combineLatest);
			}
		}

		private static void Completed11(object state)
		{
			_CombineLatest combineLatest = (_CombineLatest)state;
			combineLatest.running11 = false;
			try
			{
				if (combineLatest.awaiter11.GetResult())
				{
					combineLatest.hasCurrent11 = true;
					combineLatest.current11 = combineLatest.enumerator11.Current;
					goto IL_0074;
				}
				combineLatest.running11 = true;
				if (Interlocked.Increment(ref combineLatest.completedCount) != 13)
				{
					return;
				}
			}
			catch (Exception error)
			{
				combineLatest.running11 = true;
				combineLatest.completedCount = 13;
				combineLatest.completionSource.TrySetException(error);
				return;
			}
			combineLatest.completionSource.TrySetResult(result: false);
			return;
			IL_0074:
			if (!combineLatest.TrySetResult() && !combineLatest.syncRunning)
			{
				combineLatest.running11 = true;
				try
				{
					combineLatest.awaiter11 = combineLatest.enumerator11.MoveNextAsync().GetAwaiter();
				}
				catch (Exception error2)
				{
					combineLatest.completedCount = 13;
					combineLatest.completionSource.TrySetException(error2);
					return;
				}
				combineLatest.awaiter11.SourceOnCompleted(Completed11Delegate, combineLatest);
			}
		}

		private static void Completed12(object state)
		{
			_CombineLatest combineLatest = (_CombineLatest)state;
			combineLatest.running12 = false;
			try
			{
				if (combineLatest.awaiter12.GetResult())
				{
					combineLatest.hasCurrent12 = true;
					combineLatest.current12 = combineLatest.enumerator12.Current;
					goto IL_0074;
				}
				combineLatest.running12 = true;
				if (Interlocked.Increment(ref combineLatest.completedCount) != 13)
				{
					return;
				}
			}
			catch (Exception error)
			{
				combineLatest.running12 = true;
				combineLatest.completedCount = 13;
				combineLatest.completionSource.TrySetException(error);
				return;
			}
			combineLatest.completionSource.TrySetResult(result: false);
			return;
			IL_0074:
			if (!combineLatest.TrySetResult() && !combineLatest.syncRunning)
			{
				combineLatest.running12 = true;
				try
				{
					combineLatest.awaiter12 = combineLatest.enumerator12.MoveNextAsync().GetAwaiter();
				}
				catch (Exception error2)
				{
					combineLatest.completedCount = 13;
					combineLatest.completionSource.TrySetException(error2);
					return;
				}
				combineLatest.awaiter12.SourceOnCompleted(Completed12Delegate, combineLatest);
			}
		}

		private static void Completed13(object state)
		{
			_CombineLatest combineLatest = (_CombineLatest)state;
			combineLatest.running13 = false;
			try
			{
				if (combineLatest.awaiter13.GetResult())
				{
					combineLatest.hasCurrent13 = true;
					combineLatest.current13 = combineLatest.enumerator13.Current;
					goto IL_0074;
				}
				combineLatest.running13 = true;
				if (Interlocked.Increment(ref combineLatest.completedCount) != 13)
				{
					return;
				}
			}
			catch (Exception error)
			{
				combineLatest.running13 = true;
				combineLatest.completedCount = 13;
				combineLatest.completionSource.TrySetException(error);
				return;
			}
			combineLatest.completionSource.TrySetResult(result: false);
			return;
			IL_0074:
			if (!combineLatest.TrySetResult() && !combineLatest.syncRunning)
			{
				combineLatest.running13 = true;
				try
				{
					combineLatest.awaiter13 = combineLatest.enumerator13.MoveNextAsync().GetAwaiter();
				}
				catch (Exception error2)
				{
					combineLatest.completedCount = 13;
					combineLatest.completionSource.TrySetException(error2);
					return;
				}
				combineLatest.awaiter13.SourceOnCompleted(Completed13Delegate, combineLatest);
			}
		}

		private bool TrySetResult()
		{
			if (hasCurrent1 && hasCurrent2 && hasCurrent3 && hasCurrent4 && hasCurrent5 && hasCurrent6 && hasCurrent7 && hasCurrent8 && hasCurrent9 && hasCurrent10 && hasCurrent11 && hasCurrent12 && hasCurrent13)
			{
				result = resultSelector(current1, current2, current3, current4, current5, current6, current7, current8, current9, current10, current11, current12, current13);
				completionSource.TrySetResult(result: true);
				return true;
			}
			return false;
		}

		public async UniTask DisposeAsync()
		{
			if (enumerator1 != null)
			{
				await enumerator1.DisposeAsync();
			}
			if (enumerator2 != null)
			{
				await enumerator2.DisposeAsync();
			}
			if (enumerator3 != null)
			{
				await enumerator3.DisposeAsync();
			}
			if (enumerator4 != null)
			{
				await enumerator4.DisposeAsync();
			}
			if (enumerator5 != null)
			{
				await enumerator5.DisposeAsync();
			}
			if (enumerator6 != null)
			{
				await enumerator6.DisposeAsync();
			}
			if (enumerator7 != null)
			{
				await enumerator7.DisposeAsync();
			}
			if (enumerator8 != null)
			{
				await enumerator8.DisposeAsync();
			}
			if (enumerator9 != null)
			{
				await enumerator9.DisposeAsync();
			}
			if (enumerator10 != null)
			{
				await enumerator10.DisposeAsync();
			}
			if (enumerator11 != null)
			{
				await enumerator11.DisposeAsync();
			}
			if (enumerator12 != null)
			{
				await enumerator12.DisposeAsync();
			}
			if (enumerator13 != null)
			{
				await enumerator13.DisposeAsync();
			}
		}
	}

	private readonly IUniTaskAsyncEnumerable<T1> source1;

	private readonly IUniTaskAsyncEnumerable<T2> source2;

	private readonly IUniTaskAsyncEnumerable<T3> source3;

	private readonly IUniTaskAsyncEnumerable<T4> source4;

	private readonly IUniTaskAsyncEnumerable<T5> source5;

	private readonly IUniTaskAsyncEnumerable<T6> source6;

	private readonly IUniTaskAsyncEnumerable<T7> source7;

	private readonly IUniTaskAsyncEnumerable<T8> source8;

	private readonly IUniTaskAsyncEnumerable<T9> source9;

	private readonly IUniTaskAsyncEnumerable<T10> source10;

	private readonly IUniTaskAsyncEnumerable<T11> source11;

	private readonly IUniTaskAsyncEnumerable<T12> source12;

	private readonly IUniTaskAsyncEnumerable<T13> source13;

	private readonly Func<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13, TResult> resultSelector;

	public CombineLatest(IUniTaskAsyncEnumerable<T1> source1, IUniTaskAsyncEnumerable<T2> source2, IUniTaskAsyncEnumerable<T3> source3, IUniTaskAsyncEnumerable<T4> source4, IUniTaskAsyncEnumerable<T5> source5, IUniTaskAsyncEnumerable<T6> source6, IUniTaskAsyncEnumerable<T7> source7, IUniTaskAsyncEnumerable<T8> source8, IUniTaskAsyncEnumerable<T9> source9, IUniTaskAsyncEnumerable<T10> source10, IUniTaskAsyncEnumerable<T11> source11, IUniTaskAsyncEnumerable<T12> source12, IUniTaskAsyncEnumerable<T13> source13, Func<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13, TResult> resultSelector)
	{
		this.source1 = source1;
		this.source2 = source2;
		this.source3 = source3;
		this.source4 = source4;
		this.source5 = source5;
		this.source6 = source6;
		this.source7 = source7;
		this.source8 = source8;
		this.source9 = source9;
		this.source10 = source10;
		this.source11 = source11;
		this.source12 = source12;
		this.source13 = source13;
		this.resultSelector = resultSelector;
	}

	public IUniTaskAsyncEnumerator<TResult> GetAsyncEnumerator(CancellationToken cancellationToken = default(CancellationToken))
	{
		return new _CombineLatest(source1, source2, source3, source4, source5, source6, source7, source8, source9, source10, source11, source12, source13, resultSelector, cancellationToken);
	}
}
internal class CombineLatest<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13, T14, TResult> : IUniTaskAsyncEnumerable<TResult>
{
	private class _CombineLatest : MoveNextSource, IUniTaskAsyncEnumerator<TResult>, IUniTaskAsyncDisposable
	{
		private static readonly Action<object> Completed1Delegate = Completed1;

		private static readonly Action<object> Completed2Delegate = Completed2;

		private static readonly Action<object> Completed3Delegate = Completed3;

		private static readonly Action<object> Completed4Delegate = Completed4;

		private static readonly Action<object> Completed5Delegate = Completed5;

		private static readonly Action<object> Completed6Delegate = Completed6;

		private static readonly Action<object> Completed7Delegate = Completed7;

		private static readonly Action<object> Completed8Delegate = Completed8;

		private static readonly Action<object> Completed9Delegate = Completed9;

		private static readonly Action<object> Completed10Delegate = Completed10;

		private static readonly Action<object> Completed11Delegate = Completed11;

		private static readonly Action<object> Completed12Delegate = Completed12;

		private static readonly Action<object> Completed13Delegate = Completed13;

		private static readonly Action<object> Completed14Delegate = Completed14;

		private readonly IUniTaskAsyncEnumerable<T1> source1;

		private readonly IUniTaskAsyncEnumerable<T2> source2;

		private readonly IUniTaskAsyncEnumerable<T3> source3;

		private readonly IUniTaskAsyncEnumerable<T4> source4;

		private readonly IUniTaskAsyncEnumerable<T5> source5;

		private readonly IUniTaskAsyncEnumerable<T6> source6;

		private readonly IUniTaskAsyncEnumerable<T7> source7;

		private readonly IUniTaskAsyncEnumerable<T8> source8;

		private readonly IUniTaskAsyncEnumerable<T9> source9;

		private readonly IUniTaskAsyncEnumerable<T10> source10;

		private readonly IUniTaskAsyncEnumerable<T11> source11;

		private readonly IUniTaskAsyncEnumerable<T12> source12;

		private readonly IUniTaskAsyncEnumerable<T13> source13;

		private readonly IUniTaskAsyncEnumerable<T14> source14;

		private readonly Func<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13, T14, TResult> resultSelector;

		private CancellationToken cancellationToken;

		private IUniTaskAsyncEnumerator<T1> enumerator1;

		private UniTask<bool>.Awaiter awaiter1;

		private bool hasCurrent1;

		private bool running1;

		private T1 current1;

		private IUniTaskAsyncEnumerator<T2> enumerator2;

		private UniTask<bool>.Awaiter awaiter2;

		private bool hasCurrent2;

		private bool running2;

		private T2 current2;

		private IUniTaskAsyncEnumerator<T3> enumerator3;

		private UniTask<bool>.Awaiter awaiter3;

		private bool hasCurrent3;

		private bool running3;

		private T3 current3;

		private IUniTaskAsyncEnumerator<T4> enumerator4;

		private UniTask<bool>.Awaiter awaiter4;

		private bool hasCurrent4;

		private bool running4;

		private T4 current4;

		private IUniTaskAsyncEnumerator<T5> enumerator5;

		private UniTask<bool>.Awaiter awaiter5;

		private bool hasCurrent5;

		private bool running5;

		private T5 current5;

		private IUniTaskAsyncEnumerator<T6> enumerator6;

		private UniTask<bool>.Awaiter awaiter6;

		private bool hasCurrent6;

		private bool running6;

		private T6 current6;

		private IUniTaskAsyncEnumerator<T7> enumerator7;

		private UniTask<bool>.Awaiter awaiter7;

		private bool hasCurrent7;

		private bool running7;

		private T7 current7;

		private IUniTaskAsyncEnumerator<T8> enumerator8;

		private UniTask<bool>.Awaiter awaiter8;

		private bool hasCurrent8;

		private bool running8;

		private T8 current8;

		private IUniTaskAsyncEnumerator<T9> enumerator9;

		private UniTask<bool>.Awaiter awaiter9;

		private bool hasCurrent9;

		private bool running9;

		private T9 current9;

		private IUniTaskAsyncEnumerator<T10> enumerator10;

		private UniTask<bool>.Awaiter awaiter10;

		private bool hasCurrent10;

		private bool running10;

		private T10 current10;

		private IUniTaskAsyncEnumerator<T11> enumerator11;

		private UniTask<bool>.Awaiter awaiter11;

		private bool hasCurrent11;

		private bool running11;

		private T11 current11;

		private IUniTaskAsyncEnumerator<T12> enumerator12;

		private UniTask<bool>.Awaiter awaiter12;

		private bool hasCurrent12;

		private bool running12;

		private T12 current12;

		private IUniTaskAsyncEnumerator<T13> enumerator13;

		private UniTask<bool>.Awaiter awaiter13;

		private bool hasCurrent13;

		private bool running13;

		private T13 current13;

		private IUniTaskAsyncEnumerator<T14> enumerator14;

		private UniTask<bool>.Awaiter awaiter14;

		private bool hasCurrent14;

		private bool running14;

		private T14 current14;

		private int completedCount;

		private bool syncRunning;

		private TResult result;

		public TResult Current => result;

		public _CombineLatest(IUniTaskAsyncEnumerable<T1> source1, IUniTaskAsyncEnumerable<T2> source2, IUniTaskAsyncEnumerable<T3> source3, IUniTaskAsyncEnumerable<T4> source4, IUniTaskAsyncEnumerable<T5> source5, IUniTaskAsyncEnumerable<T6> source6, IUniTaskAsyncEnumerable<T7> source7, IUniTaskAsyncEnumerable<T8> source8, IUniTaskAsyncEnumerable<T9> source9, IUniTaskAsyncEnumerable<T10> source10, IUniTaskAsyncEnumerable<T11> source11, IUniTaskAsyncEnumerable<T12> source12, IUniTaskAsyncEnumerable<T13> source13, IUniTaskAsyncEnumerable<T14> source14, Func<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13, T14, TResult> resultSelector, CancellationToken cancellationToken)
		{
			this.source1 = source1;
			this.source2 = source2;
			this.source3 = source3;
			this.source4 = source4;
			this.source5 = source5;
			this.source6 = source6;
			this.source7 = source7;
			this.source8 = source8;
			this.source9 = source9;
			this.source10 = source10;
			this.source11 = source11;
			this.source12 = source12;
			this.source13 = source13;
			this.source14 = source14;
			this.resultSelector = resultSelector;
			this.cancellationToken = cancellationToken;
		}

		public UniTask<bool> MoveNextAsync()
		{
			cancellationToken.ThrowIfCancellationRequested();
			if (completedCount == 14)
			{
				return CompletedTasks.False;
			}
			if (enumerator1 == null)
			{
				enumerator1 = source1.GetAsyncEnumerator(cancellationToken);
				enumerator2 = source2.GetAsyncEnumerator(cancellationToken);
				enumerator3 = source3.GetAsyncEnumerator(cancellationToken);
				enumerator4 = source4.GetAsyncEnumerator(cancellationToken);
				enumerator5 = source5.GetAsyncEnumerator(cancellationToken);
				enumerator6 = source6.GetAsyncEnumerator(cancellationToken);
				enumerator7 = source7.GetAsyncEnumerator(cancellationToken);
				enumerator8 = source8.GetAsyncEnumerator(cancellationToken);
				enumerator9 = source9.GetAsyncEnumerator(cancellationToken);
				enumerator10 = source10.GetAsyncEnumerator(cancellationToken);
				enumerator11 = source11.GetAsyncEnumerator(cancellationToken);
				enumerator12 = source12.GetAsyncEnumerator(cancellationToken);
				enumerator13 = source13.GetAsyncEnumerator(cancellationToken);
				enumerator14 = source14.GetAsyncEnumerator(cancellationToken);
			}
			completionSource.Reset();
			do
			{
				syncRunning = true;
				if (!running1)
				{
					running1 = true;
					awaiter1 = enumerator1.MoveNextAsync().GetAwaiter();
					if (awaiter1.IsCompleted)
					{
						Completed1(this);
					}
					else
					{
						awaiter1.SourceOnCompleted(Completed1Delegate, this);
					}
				}
				if (!running2)
				{
					running2 = true;
					awaiter2 = enumerator2.MoveNextAsync().GetAwaiter();
					if (awaiter2.IsCompleted)
					{
						Completed2(this);
					}
					else
					{
						awaiter2.SourceOnCompleted(Completed2Delegate, this);
					}
				}
				if (!running3)
				{
					running3 = true;
					awaiter3 = enumerator3.MoveNextAsync().GetAwaiter();
					if (awaiter3.IsCompleted)
					{
						Completed3(this);
					}
					else
					{
						awaiter3.SourceOnCompleted(Completed3Delegate, this);
					}
				}
				if (!running4)
				{
					running4 = true;
					awaiter4 = enumerator4.MoveNextAsync().GetAwaiter();
					if (awaiter4.IsCompleted)
					{
						Completed4(this);
					}
					else
					{
						awaiter4.SourceOnCompleted(Completed4Delegate, this);
					}
				}
				if (!running5)
				{
					running5 = true;
					awaiter5 = enumerator5.MoveNextAsync().GetAwaiter();
					if (awaiter5.IsCompleted)
					{
						Completed5(this);
					}
					else
					{
						awaiter5.SourceOnCompleted(Completed5Delegate, this);
					}
				}
				if (!running6)
				{
					running6 = true;
					awaiter6 = enumerator6.MoveNextAsync().GetAwaiter();
					if (awaiter6.IsCompleted)
					{
						Completed6(this);
					}
					else
					{
						awaiter6.SourceOnCompleted(Completed6Delegate, this);
					}
				}
				if (!running7)
				{
					running7 = true;
					awaiter7 = enumerator7.MoveNextAsync().GetAwaiter();
					if (awaiter7.IsCompleted)
					{
						Completed7(this);
					}
					else
					{
						awaiter7.SourceOnCompleted(Completed7Delegate, this);
					}
				}
				if (!running8)
				{
					running8 = true;
					awaiter8 = enumerator8.MoveNextAsync().GetAwaiter();
					if (awaiter8.IsCompleted)
					{
						Completed8(this);
					}
					else
					{
						awaiter8.SourceOnCompleted(Completed8Delegate, this);
					}
				}
				if (!running9)
				{
					running9 = true;
					awaiter9 = enumerator9.MoveNextAsync().GetAwaiter();
					if (awaiter9.IsCompleted)
					{
						Completed9(this);
					}
					else
					{
						awaiter9.SourceOnCompleted(Completed9Delegate, this);
					}
				}
				if (!running10)
				{
					running10 = true;
					awaiter10 = enumerator10.MoveNextAsync().GetAwaiter();
					if (awaiter10.IsCompleted)
					{
						Completed10(this);
					}
					else
					{
						awaiter10.SourceOnCompleted(Completed10Delegate, this);
					}
				}
				if (!running11)
				{
					running11 = true;
					awaiter11 = enumerator11.MoveNextAsync().GetAwaiter();
					if (awaiter11.IsCompleted)
					{
						Completed11(this);
					}
					else
					{
						awaiter11.SourceOnCompleted(Completed11Delegate, this);
					}
				}
				if (!running12)
				{
					running12 = true;
					awaiter12 = enumerator12.MoveNextAsync().GetAwaiter();
					if (awaiter12.IsCompleted)
					{
						Completed12(this);
					}
					else
					{
						awaiter12.SourceOnCompleted(Completed12Delegate, this);
					}
				}
				if (!running13)
				{
					running13 = true;
					awaiter13 = enumerator13.MoveNextAsync().GetAwaiter();
					if (awaiter13.IsCompleted)
					{
						Completed13(this);
					}
					else
					{
						awaiter13.SourceOnCompleted(Completed13Delegate, this);
					}
				}
				if (!running14)
				{
					running14 = true;
					awaiter14 = enumerator14.MoveNextAsync().GetAwaiter();
					if (awaiter14.IsCompleted)
					{
						Completed14(this);
					}
					else
					{
						awaiter14.SourceOnCompleted(Completed14Delegate, this);
					}
				}
			}
			while (!running1 || !running2 || !running3 || !running4 || !running5 || !running6 || !running7 || !running8 || !running9 || !running10 || !running11 || !running12 || !running13 || !running14);
			syncRunning = false;
			return new UniTask<bool>(this, completionSource.Version);
		}

		private static void Completed1(object state)
		{
			_CombineLatest combineLatest = (_CombineLatest)state;
			combineLatest.running1 = false;
			try
			{
				if (combineLatest.awaiter1.GetResult())
				{
					combineLatest.hasCurrent1 = true;
					combineLatest.current1 = combineLatest.enumerator1.Current;
					goto IL_0074;
				}
				combineLatest.running1 = true;
				if (Interlocked.Increment(ref combineLatest.completedCount) != 14)
				{
					return;
				}
			}
			catch (Exception error)
			{
				combineLatest.running1 = true;
				combineLatest.completedCount = 14;
				combineLatest.completionSource.TrySetException(error);
				return;
			}
			combineLatest.completionSource.TrySetResult(result: false);
			return;
			IL_0074:
			if (!combineLatest.TrySetResult() && !combineLatest.syncRunning)
			{
				combineLatest.running1 = true;
				try
				{
					combineLatest.awaiter1 = combineLatest.enumerator1.MoveNextAsync().GetAwaiter();
				}
				catch (Exception error2)
				{
					combineLatest.completedCount = 14;
					combineLatest.completionSource.TrySetException(error2);
					return;
				}
				combineLatest.awaiter1.SourceOnCompleted(Completed1Delegate, combineLatest);
			}
		}

		private static void Completed2(object state)
		{
			_CombineLatest combineLatest = (_CombineLatest)state;
			combineLatest.running2 = false;
			try
			{
				if (combineLatest.awaiter2.GetResult())
				{
					combineLatest.hasCurrent2 = true;
					combineLatest.current2 = combineLatest.enumerator2.Current;
					goto IL_0074;
				}
				combineLatest.running2 = true;
				if (Interlocked.Increment(ref combineLatest.completedCount) != 14)
				{
					return;
				}
			}
			catch (Exception error)
			{
				combineLatest.running2 = true;
				combineLatest.completedCount = 14;
				combineLatest.completionSource.TrySetException(error);
				return;
			}
			combineLatest.completionSource.TrySetResult(result: false);
			return;
			IL_0074:
			if (!combineLatest.TrySetResult() && !combineLatest.syncRunning)
			{
				combineLatest.running2 = true;
				try
				{
					combineLatest.awaiter2 = combineLatest.enumerator2.MoveNextAsync().GetAwaiter();
				}
				catch (Exception error2)
				{
					combineLatest.completedCount = 14;
					combineLatest.completionSource.TrySetException(error2);
					return;
				}
				combineLatest.awaiter2.SourceOnCompleted(Completed2Delegate, combineLatest);
			}
		}

		private static void Completed3(object state)
		{
			_CombineLatest combineLatest = (_CombineLatest)state;
			combineLatest.running3 = false;
			try
			{
				if (combineLatest.awaiter3.GetResult())
				{
					combineLatest.hasCurrent3 = true;
					combineLatest.current3 = combineLatest.enumerator3.Current;
					goto IL_0074;
				}
				combineLatest.running3 = true;
				if (Interlocked.Increment(ref combineLatest.completedCount) != 14)
				{
					return;
				}
			}
			catch (Exception error)
			{
				combineLatest.running3 = true;
				combineLatest.completedCount = 14;
				combineLatest.completionSource.TrySetException(error);
				return;
			}
			combineLatest.completionSource.TrySetResult(result: false);
			return;
			IL_0074:
			if (!combineLatest.TrySetResult() && !combineLatest.syncRunning)
			{
				combineLatest.running3 = true;
				try
				{
					combineLatest.awaiter3 = combineLatest.enumerator3.MoveNextAsync().GetAwaiter();
				}
				catch (Exception error2)
				{
					combineLatest.completedCount = 14;
					combineLatest.completionSource.TrySetException(error2);
					return;
				}
				combineLatest.awaiter3.SourceOnCompleted(Completed3Delegate, combineLatest);
			}
		}

		private static void Completed4(object state)
		{
			_CombineLatest combineLatest = (_CombineLatest)state;
			combineLatest.running4 = false;
			try
			{
				if (combineLatest.awaiter4.GetResult())
				{
					combineLatest.hasCurrent4 = true;
					combineLatest.current4 = combineLatest.enumerator4.Current;
					goto IL_0074;
				}
				combineLatest.running4 = true;
				if (Interlocked.Increment(ref combineLatest.completedCount) != 14)
				{
					return;
				}
			}
			catch (Exception error)
			{
				combineLatest.running4 = true;
				combineLatest.completedCount = 14;
				combineLatest.completionSource.TrySetException(error);
				return;
			}
			combineLatest.completionSource.TrySetResult(result: false);
			return;
			IL_0074:
			if (!combineLatest.TrySetResult() && !combineLatest.syncRunning)
			{
				combineLatest.running4 = true;
				try
				{
					combineLatest.awaiter4 = combineLatest.enumerator4.MoveNextAsync().GetAwaiter();
				}
				catch (Exception error2)
				{
					combineLatest.completedCount = 14;
					combineLatest.completionSource.TrySetException(error2);
					return;
				}
				combineLatest.awaiter4.SourceOnCompleted(Completed4Delegate, combineLatest);
			}
		}

		private static void Completed5(object state)
		{
			_CombineLatest combineLatest = (_CombineLatest)state;
			combineLatest.running5 = false;
			try
			{
				if (combineLatest.awaiter5.GetResult())
				{
					combineLatest.hasCurrent5 = true;
					combineLatest.current5 = combineLatest.enumerator5.Current;
					goto IL_0074;
				}
				combineLatest.running5 = true;
				if (Interlocked.Increment(ref combineLatest.completedCount) != 14)
				{
					return;
				}
			}
			catch (Exception error)
			{
				combineLatest.running5 = true;
				combineLatest.completedCount = 14;
				combineLatest.completionSource.TrySetException(error);
				return;
			}
			combineLatest.completionSource.TrySetResult(result: false);
			return;
			IL_0074:
			if (!combineLatest.TrySetResult() && !combineLatest.syncRunning)
			{
				combineLatest.running5 = true;
				try
				{
					combineLatest.awaiter5 = combineLatest.enumerator5.MoveNextAsync().GetAwaiter();
				}
				catch (Exception error2)
				{
					combineLatest.completedCount = 14;
					combineLatest.completionSource.TrySetException(error2);
					return;
				}
				combineLatest.awaiter5.SourceOnCompleted(Completed5Delegate, combineLatest);
			}
		}

		private static void Completed6(object state)
		{
			_CombineLatest combineLatest = (_CombineLatest)state;
			combineLatest.running6 = false;
			try
			{
				if (combineLatest.awaiter6.GetResult())
				{
					combineLatest.hasCurrent6 = true;
					combineLatest.current6 = combineLatest.enumerator6.Current;
					goto IL_0074;
				}
				combineLatest.running6 = true;
				if (Interlocked.Increment(ref combineLatest.completedCount) != 14)
				{
					return;
				}
			}
			catch (Exception error)
			{
				combineLatest.running6 = true;
				combineLatest.completedCount = 14;
				combineLatest.completionSource.TrySetException(error);
				return;
			}
			combineLatest.completionSource.TrySetResult(result: false);
			return;
			IL_0074:
			if (!combineLatest.TrySetResult() && !combineLatest.syncRunning)
			{
				combineLatest.running6 = true;
				try
				{
					combineLatest.awaiter6 = combineLatest.enumerator6.MoveNextAsync().GetAwaiter();
				}
				catch (Exception error2)
				{
					combineLatest.completedCount = 14;
					combineLatest.completionSource.TrySetException(error2);
					return;
				}
				combineLatest.awaiter6.SourceOnCompleted(Completed6Delegate, combineLatest);
			}
		}

		private static void Completed7(object state)
		{
			_CombineLatest combineLatest = (_CombineLatest)state;
			combineLatest.running7 = false;
			try
			{
				if (combineLatest.awaiter7.GetResult())
				{
					combineLatest.hasCurrent7 = true;
					combineLatest.current7 = combineLatest.enumerator7.Current;
					goto IL_0074;
				}
				combineLatest.running7 = true;
				if (Interlocked.Increment(ref combineLatest.completedCount) != 14)
				{
					return;
				}
			}
			catch (Exception error)
			{
				combineLatest.running7 = true;
				combineLatest.completedCount = 14;
				combineLatest.completionSource.TrySetException(error);
				return;
			}
			combineLatest.completionSource.TrySetResult(result: false);
			return;
			IL_0074:
			if (!combineLatest.TrySetResult() && !combineLatest.syncRunning)
			{
				combineLatest.running7 = true;
				try
				{
					combineLatest.awaiter7 = combineLatest.enumerator7.MoveNextAsync().GetAwaiter();
				}
				catch (Exception error2)
				{
					combineLatest.completedCount = 14;
					combineLatest.completionSource.TrySetException(error2);
					return;
				}
				combineLatest.awaiter7.SourceOnCompleted(Completed7Delegate, combineLatest);
			}
		}

		private static void Completed8(object state)
		{
			_CombineLatest combineLatest = (_CombineLatest)state;
			combineLatest.running8 = false;
			try
			{
				if (combineLatest.awaiter8.GetResult())
				{
					combineLatest.hasCurrent8 = true;
					combineLatest.current8 = combineLatest.enumerator8.Current;
					goto IL_0074;
				}
				combineLatest.running8 = true;
				if (Interlocked.Increment(ref combineLatest.completedCount) != 14)
				{
					return;
				}
			}
			catch (Exception error)
			{
				combineLatest.running8 = true;
				combineLatest.completedCount = 14;
				combineLatest.completionSource.TrySetException(error);
				return;
			}
			combineLatest.completionSource.TrySetResult(result: false);
			return;
			IL_0074:
			if (!combineLatest.TrySetResult() && !combineLatest.syncRunning)
			{
				combineLatest.running8 = true;
				try
				{
					combineLatest.awaiter8 = combineLatest.enumerator8.MoveNextAsync().GetAwaiter();
				}
				catch (Exception error2)
				{
					combineLatest.completedCount = 14;
					combineLatest.completionSource.TrySetException(error2);
					return;
				}
				combineLatest.awaiter8.SourceOnCompleted(Completed8Delegate, combineLatest);
			}
		}

		private static void Completed9(object state)
		{
			_CombineLatest combineLatest = (_CombineLatest)state;
			combineLatest.running9 = false;
			try
			{
				if (combineLatest.awaiter9.GetResult())
				{
					combineLatest.hasCurrent9 = true;
					combineLatest.current9 = combineLatest.enumerator9.Current;
					goto IL_0074;
				}
				combineLatest.running9 = true;
				if (Interlocked.Increment(ref combineLatest.completedCount) != 14)
				{
					return;
				}
			}
			catch (Exception error)
			{
				combineLatest.running9 = true;
				combineLatest.completedCount = 14;
				combineLatest.completionSource.TrySetException(error);
				return;
			}
			combineLatest.completionSource.TrySetResult(result: false);
			return;
			IL_0074:
			if (!combineLatest.TrySetResult() && !combineLatest.syncRunning)
			{
				combineLatest.running9 = true;
				try
				{
					combineLatest.awaiter9 = combineLatest.enumerator9.MoveNextAsync().GetAwaiter();
				}
				catch (Exception error2)
				{
					combineLatest.completedCount = 14;
					combineLatest.completionSource.TrySetException(error2);
					return;
				}
				combineLatest.awaiter9.SourceOnCompleted(Completed9Delegate, combineLatest);
			}
		}

		private static void Completed10(object state)
		{
			_CombineLatest combineLatest = (_CombineLatest)state;
			combineLatest.running10 = false;
			try
			{
				if (combineLatest.awaiter10.GetResult())
				{
					combineLatest.hasCurrent10 = true;
					combineLatest.current10 = combineLatest.enumerator10.Current;
					goto IL_0074;
				}
				combineLatest.running10 = true;
				if (Interlocked.Increment(ref combineLatest.completedCount) != 14)
				{
					return;
				}
			}
			catch (Exception error)
			{
				combineLatest.running10 = true;
				combineLatest.completedCount = 14;
				combineLatest.completionSource.TrySetException(error);
				return;
			}
			combineLatest.completionSource.TrySetResult(result: false);
			return;
			IL_0074:
			if (!combineLatest.TrySetResult() && !combineLatest.syncRunning)
			{
				combineLatest.running10 = true;
				try
				{
					combineLatest.awaiter10 = combineLatest.enumerator10.MoveNextAsync().GetAwaiter();
				}
				catch (Exception error2)
				{
					combineLatest.completedCount = 14;
					combineLatest.completionSource.TrySetException(error2);
					return;
				}
				combineLatest.awaiter10.SourceOnCompleted(Completed10Delegate, combineLatest);
			}
		}

		private static void Completed11(object state)
		{
			_CombineLatest combineLatest = (_CombineLatest)state;
			combineLatest.running11 = false;
			try
			{
				if (combineLatest.awaiter11.GetResult())
				{
					combineLatest.hasCurrent11 = true;
					combineLatest.current11 = combineLatest.enumerator11.Current;
					goto IL_0074;
				}
				combineLatest.running11 = true;
				if (Interlocked.Increment(ref combineLatest.completedCount) != 14)
				{
					return;
				}
			}
			catch (Exception error)
			{
				combineLatest.running11 = true;
				combineLatest.completedCount = 14;
				combineLatest.completionSource.TrySetException(error);
				return;
			}
			combineLatest.completionSource.TrySetResult(result: false);
			return;
			IL_0074:
			if (!combineLatest.TrySetResult() && !combineLatest.syncRunning)
			{
				combineLatest.running11 = true;
				try
				{
					combineLatest.awaiter11 = combineLatest.enumerator11.MoveNextAsync().GetAwaiter();
				}
				catch (Exception error2)
				{
					combineLatest.completedCount = 14;
					combineLatest.completionSource.TrySetException(error2);
					return;
				}
				combineLatest.awaiter11.SourceOnCompleted(Completed11Delegate, combineLatest);
			}
		}

		private static void Completed12(object state)
		{
			_CombineLatest combineLatest = (_CombineLatest)state;
			combineLatest.running12 = false;
			try
			{
				if (combineLatest.awaiter12.GetResult())
				{
					combineLatest.hasCurrent12 = true;
					combineLatest.current12 = combineLatest.enumerator12.Current;
					goto IL_0074;
				}
				combineLatest.running12 = true;
				if (Interlocked.Increment(ref combineLatest.completedCount) != 14)
				{
					return;
				}
			}
			catch (Exception error)
			{
				combineLatest.running12 = true;
				combineLatest.completedCount = 14;
				combineLatest.completionSource.TrySetException(error);
				return;
			}
			combineLatest.completionSource.TrySetResult(result: false);
			return;
			IL_0074:
			if (!combineLatest.TrySetResult() && !combineLatest.syncRunning)
			{
				combineLatest.running12 = true;
				try
				{
					combineLatest.awaiter12 = combineLatest.enumerator12.MoveNextAsync().GetAwaiter();
				}
				catch (Exception error2)
				{
					combineLatest.completedCount = 14;
					combineLatest.completionSource.TrySetException(error2);
					return;
				}
				combineLatest.awaiter12.SourceOnCompleted(Completed12Delegate, combineLatest);
			}
		}

		private static void Completed13(object state)
		{
			_CombineLatest combineLatest = (_CombineLatest)state;
			combineLatest.running13 = false;
			try
			{
				if (combineLatest.awaiter13.GetResult())
				{
					combineLatest.hasCurrent13 = true;
					combineLatest.current13 = combineLatest.enumerator13.Current;
					goto IL_0074;
				}
				combineLatest.running13 = true;
				if (Interlocked.Increment(ref combineLatest.completedCount) != 14)
				{
					return;
				}
			}
			catch (Exception error)
			{
				combineLatest.running13 = true;
				combineLatest.completedCount = 14;
				combineLatest.completionSource.TrySetException(error);
				return;
			}
			combineLatest.completionSource.TrySetResult(result: false);
			return;
			IL_0074:
			if (!combineLatest.TrySetResult() && !combineLatest.syncRunning)
			{
				combineLatest.running13 = true;
				try
				{
					combineLatest.awaiter13 = combineLatest.enumerator13.MoveNextAsync().GetAwaiter();
				}
				catch (Exception error2)
				{
					combineLatest.completedCount = 14;
					combineLatest.completionSource.TrySetException(error2);
					return;
				}
				combineLatest.awaiter13.SourceOnCompleted(Completed13Delegate, combineLatest);
			}
		}

		private static void Completed14(object state)
		{
			_CombineLatest combineLatest = (_CombineLatest)state;
			combineLatest.running14 = false;
			try
			{
				if (combineLatest.awaiter14.GetResult())
				{
					combineLatest.hasCurrent14 = true;
					combineLatest.current14 = combineLatest.enumerator14.Current;
					goto IL_0074;
				}
				combineLatest.running14 = true;
				if (Interlocked.Increment(ref combineLatest.completedCount) != 14)
				{
					return;
				}
			}
			catch (Exception error)
			{
				combineLatest.running14 = true;
				combineLatest.completedCount = 14;
				combineLatest.completionSource.TrySetException(error);
				return;
			}
			combineLatest.completionSource.TrySetResult(result: false);
			return;
			IL_0074:
			if (!combineLatest.TrySetResult() && !combineLatest.syncRunning)
			{
				combineLatest.running14 = true;
				try
				{
					combineLatest.awaiter14 = combineLatest.enumerator14.MoveNextAsync().GetAwaiter();
				}
				catch (Exception error2)
				{
					combineLatest.completedCount = 14;
					combineLatest.completionSource.TrySetException(error2);
					return;
				}
				combineLatest.awaiter14.SourceOnCompleted(Completed14Delegate, combineLatest);
			}
		}

		private bool TrySetResult()
		{
			if (hasCurrent1 && hasCurrent2 && hasCurrent3 && hasCurrent4 && hasCurrent5 && hasCurrent6 && hasCurrent7 && hasCurrent8 && hasCurrent9 && hasCurrent10 && hasCurrent11 && hasCurrent12 && hasCurrent13 && hasCurrent14)
			{
				result = resultSelector(current1, current2, current3, current4, current5, current6, current7, current8, current9, current10, current11, current12, current13, current14);
				completionSource.TrySetResult(result: true);
				return true;
			}
			return false;
		}

		public async UniTask DisposeAsync()
		{
			if (enumerator1 != null)
			{
				await enumerator1.DisposeAsync();
			}
			if (enumerator2 != null)
			{
				await enumerator2.DisposeAsync();
			}
			if (enumerator3 != null)
			{
				await enumerator3.DisposeAsync();
			}
			if (enumerator4 != null)
			{
				await enumerator4.DisposeAsync();
			}
			if (enumerator5 != null)
			{
				await enumerator5.DisposeAsync();
			}
			if (enumerator6 != null)
			{
				await enumerator6.DisposeAsync();
			}
			if (enumerator7 != null)
			{
				await enumerator7.DisposeAsync();
			}
			if (enumerator8 != null)
			{
				await enumerator8.DisposeAsync();
			}
			if (enumerator9 != null)
			{
				await enumerator9.DisposeAsync();
			}
			if (enumerator10 != null)
			{
				await enumerator10.DisposeAsync();
			}
			if (enumerator11 != null)
			{
				await enumerator11.DisposeAsync();
			}
			if (enumerator12 != null)
			{
				await enumerator12.DisposeAsync();
			}
			if (enumerator13 != null)
			{
				await enumerator13.DisposeAsync();
			}
			if (enumerator14 != null)
			{
				await enumerator14.DisposeAsync();
			}
		}
	}

	private readonly IUniTaskAsyncEnumerable<T1> source1;

	private readonly IUniTaskAsyncEnumerable<T2> source2;

	private readonly IUniTaskAsyncEnumerable<T3> source3;

	private readonly IUniTaskAsyncEnumerable<T4> source4;

	private readonly IUniTaskAsyncEnumerable<T5> source5;

	private readonly IUniTaskAsyncEnumerable<T6> source6;

	private readonly IUniTaskAsyncEnumerable<T7> source7;

	private readonly IUniTaskAsyncEnumerable<T8> source8;

	private readonly IUniTaskAsyncEnumerable<T9> source9;

	private readonly IUniTaskAsyncEnumerable<T10> source10;

	private readonly IUniTaskAsyncEnumerable<T11> source11;

	private readonly IUniTaskAsyncEnumerable<T12> source12;

	private readonly IUniTaskAsyncEnumerable<T13> source13;

	private readonly IUniTaskAsyncEnumerable<T14> source14;

	private readonly Func<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13, T14, TResult> resultSelector;

	public CombineLatest(IUniTaskAsyncEnumerable<T1> source1, IUniTaskAsyncEnumerable<T2> source2, IUniTaskAsyncEnumerable<T3> source3, IUniTaskAsyncEnumerable<T4> source4, IUniTaskAsyncEnumerable<T5> source5, IUniTaskAsyncEnumerable<T6> source6, IUniTaskAsyncEnumerable<T7> source7, IUniTaskAsyncEnumerable<T8> source8, IUniTaskAsyncEnumerable<T9> source9, IUniTaskAsyncEnumerable<T10> source10, IUniTaskAsyncEnumerable<T11> source11, IUniTaskAsyncEnumerable<T12> source12, IUniTaskAsyncEnumerable<T13> source13, IUniTaskAsyncEnumerable<T14> source14, Func<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13, T14, TResult> resultSelector)
	{
		this.source1 = source1;
		this.source2 = source2;
		this.source3 = source3;
		this.source4 = source4;
		this.source5 = source5;
		this.source6 = source6;
		this.source7 = source7;
		this.source8 = source8;
		this.source9 = source9;
		this.source10 = source10;
		this.source11 = source11;
		this.source12 = source12;
		this.source13 = source13;
		this.source14 = source14;
		this.resultSelector = resultSelector;
	}

	public IUniTaskAsyncEnumerator<TResult> GetAsyncEnumerator(CancellationToken cancellationToken = default(CancellationToken))
	{
		return new _CombineLatest(source1, source2, source3, source4, source5, source6, source7, source8, source9, source10, source11, source12, source13, source14, resultSelector, cancellationToken);
	}
}
internal class CombineLatest<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13, T14, T15, TResult> : IUniTaskAsyncEnumerable<TResult>
{
	private class _CombineLatest : MoveNextSource, IUniTaskAsyncEnumerator<TResult>, IUniTaskAsyncDisposable
	{
		private static readonly Action<object> Completed1Delegate = Completed1;

		private static readonly Action<object> Completed2Delegate = Completed2;

		private static readonly Action<object> Completed3Delegate = Completed3;

		private static readonly Action<object> Completed4Delegate = Completed4;

		private static readonly Action<object> Completed5Delegate = Completed5;

		private static readonly Action<object> Completed6Delegate = Completed6;

		private static readonly Action<object> Completed7Delegate = Completed7;

		private static readonly Action<object> Completed8Delegate = Completed8;

		private static readonly Action<object> Completed9Delegate = Completed9;

		private static readonly Action<object> Completed10Delegate = Completed10;

		private static readonly Action<object> Completed11Delegate = Completed11;

		private static readonly Action<object> Completed12Delegate = Completed12;

		private static readonly Action<object> Completed13Delegate = Completed13;

		private static readonly Action<object> Completed14Delegate = Completed14;

		private static readonly Action<object> Completed15Delegate = Completed15;

		private readonly IUniTaskAsyncEnumerable<T1> source1;

		private readonly IUniTaskAsyncEnumerable<T2> source2;

		private readonly IUniTaskAsyncEnumerable<T3> source3;

		private readonly IUniTaskAsyncEnumerable<T4> source4;

		private readonly IUniTaskAsyncEnumerable<T5> source5;

		private readonly IUniTaskAsyncEnumerable<T6> source6;

		private readonly IUniTaskAsyncEnumerable<T7> source7;

		private readonly IUniTaskAsyncEnumerable<T8> source8;

		private readonly IUniTaskAsyncEnumerable<T9> source9;

		private readonly IUniTaskAsyncEnumerable<T10> source10;

		private readonly IUniTaskAsyncEnumerable<T11> source11;

		private readonly IUniTaskAsyncEnumerable<T12> source12;

		private readonly IUniTaskAsyncEnumerable<T13> source13;

		private readonly IUniTaskAsyncEnumerable<T14> source14;

		private readonly IUniTaskAsyncEnumerable<T15> source15;

		private readonly Func<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13, T14, T15, TResult> resultSelector;

		private CancellationToken cancellationToken;

		private IUniTaskAsyncEnumerator<T1> enumerator1;

		private UniTask<bool>.Awaiter awaiter1;

		private bool hasCurrent1;

		private bool running1;

		private T1 current1;

		private IUniTaskAsyncEnumerator<T2> enumerator2;

		private UniTask<bool>.Awaiter awaiter2;

		private bool hasCurrent2;

		private bool running2;

		private T2 current2;

		private IUniTaskAsyncEnumerator<T3> enumerator3;

		private UniTask<bool>.Awaiter awaiter3;

		private bool hasCurrent3;

		private bool running3;

		private T3 current3;

		private IUniTaskAsyncEnumerator<T4> enumerator4;

		private UniTask<bool>.Awaiter awaiter4;

		private bool hasCurrent4;

		private bool running4;

		private T4 current4;

		private IUniTaskAsyncEnumerator<T5> enumerator5;

		private UniTask<bool>.Awaiter awaiter5;

		private bool hasCurrent5;

		private bool running5;

		private T5 current5;

		private IUniTaskAsyncEnumerator<T6> enumerator6;

		private UniTask<bool>.Awaiter awaiter6;

		private bool hasCurrent6;

		private bool running6;

		private T6 current6;

		private IUniTaskAsyncEnumerator<T7> enumerator7;

		private UniTask<bool>.Awaiter awaiter7;

		private bool hasCurrent7;

		private bool running7;

		private T7 current7;

		private IUniTaskAsyncEnumerator<T8> enumerator8;

		private UniTask<bool>.Awaiter awaiter8;

		private bool hasCurrent8;

		private bool running8;

		private T8 current8;

		private IUniTaskAsyncEnumerator<T9> enumerator9;

		private UniTask<bool>.Awaiter awaiter9;

		private bool hasCurrent9;

		private bool running9;

		private T9 current9;

		private IUniTaskAsyncEnumerator<T10> enumerator10;

		private UniTask<bool>.Awaiter awaiter10;

		private bool hasCurrent10;

		private bool running10;

		private T10 current10;

		private IUniTaskAsyncEnumerator<T11> enumerator11;

		private UniTask<bool>.Awaiter awaiter11;

		private bool hasCurrent11;

		private bool running11;

		private T11 current11;

		private IUniTaskAsyncEnumerator<T12> enumerator12;

		private UniTask<bool>.Awaiter awaiter12;

		private bool hasCurrent12;

		private bool running12;

		private T12 current12;

		private IUniTaskAsyncEnumerator<T13> enumerator13;

		private UniTask<bool>.Awaiter awaiter13;

		private bool hasCurrent13;

		private bool running13;

		private T13 current13;

		private IUniTaskAsyncEnumerator<T14> enumerator14;

		private UniTask<bool>.Awaiter awaiter14;

		private bool hasCurrent14;

		private bool running14;

		private T14 current14;

		private IUniTaskAsyncEnumerator<T15> enumerator15;

		private UniTask<bool>.Awaiter awaiter15;

		private bool hasCurrent15;

		private bool running15;

		private T15 current15;

		private int completedCount;

		private bool syncRunning;

		private TResult result;

		public TResult Current => result;

		public _CombineLatest(IUniTaskAsyncEnumerable<T1> source1, IUniTaskAsyncEnumerable<T2> source2, IUniTaskAsyncEnumerable<T3> source3, IUniTaskAsyncEnumerable<T4> source4, IUniTaskAsyncEnumerable<T5> source5, IUniTaskAsyncEnumerable<T6> source6, IUniTaskAsyncEnumerable<T7> source7, IUniTaskAsyncEnumerable<T8> source8, IUniTaskAsyncEnumerable<T9> source9, IUniTaskAsyncEnumerable<T10> source10, IUniTaskAsyncEnumerable<T11> source11, IUniTaskAsyncEnumerable<T12> source12, IUniTaskAsyncEnumerable<T13> source13, IUniTaskAsyncEnumerable<T14> source14, IUniTaskAsyncEnumerable<T15> source15, Func<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13, T14, T15, TResult> resultSelector, CancellationToken cancellationToken)
		{
			this.source1 = source1;
			this.source2 = source2;
			this.source3 = source3;
			this.source4 = source4;
			this.source5 = source5;
			this.source6 = source6;
			this.source7 = source7;
			this.source8 = source8;
			this.source9 = source9;
			this.source10 = source10;
			this.source11 = source11;
			this.source12 = source12;
			this.source13 = source13;
			this.source14 = source14;
			this.source15 = source15;
			this.resultSelector = resultSelector;
			this.cancellationToken = cancellationToken;
		}

		public UniTask<bool> MoveNextAsync()
		{
			cancellationToken.ThrowIfCancellationRequested();
			if (completedCount == 15)
			{
				return CompletedTasks.False;
			}
			if (enumerator1 == null)
			{
				enumerator1 = source1.GetAsyncEnumerator(cancellationToken);
				enumerator2 = source2.GetAsyncEnumerator(cancellationToken);
				enumerator3 = source3.GetAsyncEnumerator(cancellationToken);
				enumerator4 = source4.GetAsyncEnumerator(cancellationToken);
				enumerator5 = source5.GetAsyncEnumerator(cancellationToken);
				enumerator6 = source6.GetAsyncEnumerator(cancellationToken);
				enumerator7 = source7.GetAsyncEnumerator(cancellationToken);
				enumerator8 = source8.GetAsyncEnumerator(cancellationToken);
				enumerator9 = source9.GetAsyncEnumerator(cancellationToken);
				enumerator10 = source10.GetAsyncEnumerator(cancellationToken);
				enumerator11 = source11.GetAsyncEnumerator(cancellationToken);
				enumerator12 = source12.GetAsyncEnumerator(cancellationToken);
				enumerator13 = source13.GetAsyncEnumerator(cancellationToken);
				enumerator14 = source14.GetAsyncEnumerator(cancellationToken);
				enumerator15 = source15.GetAsyncEnumerator(cancellationToken);
			}
			completionSource.Reset();
			do
			{
				syncRunning = true;
				if (!running1)
				{
					running1 = true;
					awaiter1 = enumerator1.MoveNextAsync().GetAwaiter();
					if (awaiter1.IsCompleted)
					{
						Completed1(this);
					}
					else
					{
						awaiter1.SourceOnCompleted(Completed1Delegate, this);
					}
				}
				if (!running2)
				{
					running2 = true;
					awaiter2 = enumerator2.MoveNextAsync().GetAwaiter();
					if (awaiter2.IsCompleted)
					{
						Completed2(this);
					}
					else
					{
						awaiter2.SourceOnCompleted(Completed2Delegate, this);
					}
				}
				if (!running3)
				{
					running3 = true;
					awaiter3 = enumerator3.MoveNextAsync().GetAwaiter();
					if (awaiter3.IsCompleted)
					{
						Completed3(this);
					}
					else
					{
						awaiter3.SourceOnCompleted(Completed3Delegate, this);
					}
				}
				if (!running4)
				{
					running4 = true;
					awaiter4 = enumerator4.MoveNextAsync().GetAwaiter();
					if (awaiter4.IsCompleted)
					{
						Completed4(this);
					}
					else
					{
						awaiter4.SourceOnCompleted(Completed4Delegate, this);
					}
				}
				if (!running5)
				{
					running5 = true;
					awaiter5 = enumerator5.MoveNextAsync().GetAwaiter();
					if (awaiter5.IsCompleted)
					{
						Completed5(this);
					}
					else
					{
						awaiter5.SourceOnCompleted(Completed5Delegate, this);
					}
				}
				if (!running6)
				{
					running6 = true;
					awaiter6 = enumerator6.MoveNextAsync().GetAwaiter();
					if (awaiter6.IsCompleted)
					{
						Completed6(this);
					}
					else
					{
						awaiter6.SourceOnCompleted(Completed6Delegate, this);
					}
				}
				if (!running7)
				{
					running7 = true;
					awaiter7 = enumerator7.MoveNextAsync().GetAwaiter();
					if (awaiter7.IsCompleted)
					{
						Completed7(this);
					}
					else
					{
						awaiter7.SourceOnCompleted(Completed7Delegate, this);
					}
				}
				if (!running8)
				{
					running8 = true;
					awaiter8 = enumerator8.MoveNextAsync().GetAwaiter();
					if (awaiter8.IsCompleted)
					{
						Completed8(this);
					}
					else
					{
						awaiter8.SourceOnCompleted(Completed8Delegate, this);
					}
				}
				if (!running9)
				{
					running9 = true;
					awaiter9 = enumerator9.MoveNextAsync().GetAwaiter();
					if (awaiter9.IsCompleted)
					{
						Completed9(this);
					}
					else
					{
						awaiter9.SourceOnCompleted(Completed9Delegate, this);
					}
				}
				if (!running10)
				{
					running10 = true;
					awaiter10 = enumerator10.MoveNextAsync().GetAwaiter();
					if (awaiter10.IsCompleted)
					{
						Completed10(this);
					}
					else
					{
						awaiter10.SourceOnCompleted(Completed10Delegate, this);
					}
				}
				if (!running11)
				{
					running11 = true;
					awaiter11 = enumerator11.MoveNextAsync().GetAwaiter();
					if (awaiter11.IsCompleted)
					{
						Completed11(this);
					}
					else
					{
						awaiter11.SourceOnCompleted(Completed11Delegate, this);
					}
				}
				if (!running12)
				{
					running12 = true;
					awaiter12 = enumerator12.MoveNextAsync().GetAwaiter();
					if (awaiter12.IsCompleted)
					{
						Completed12(this);
					}
					else
					{
						awaiter12.SourceOnCompleted(Completed12Delegate, this);
					}
				}
				if (!running13)
				{
					running13 = true;
					awaiter13 = enumerator13.MoveNextAsync().GetAwaiter();
					if (awaiter13.IsCompleted)
					{
						Completed13(this);
					}
					else
					{
						awaiter13.SourceOnCompleted(Completed13Delegate, this);
					}
				}
				if (!running14)
				{
					running14 = true;
					awaiter14 = enumerator14.MoveNextAsync().GetAwaiter();
					if (awaiter14.IsCompleted)
					{
						Completed14(this);
					}
					else
					{
						awaiter14.SourceOnCompleted(Completed14Delegate, this);
					}
				}
				if (!running15)
				{
					running15 = true;
					awaiter15 = enumerator15.MoveNextAsync().GetAwaiter();
					if (awaiter15.IsCompleted)
					{
						Completed15(this);
					}
					else
					{
						awaiter15.SourceOnCompleted(Completed15Delegate, this);
					}
				}
			}
			while (!running1 || !running2 || !running3 || !running4 || !running5 || !running6 || !running7 || !running8 || !running9 || !running10 || !running11 || !running12 || !running13 || !running14 || !running15);
			syncRunning = false;
			return new UniTask<bool>(this, completionSource.Version);
		}

		private static void Completed1(object state)
		{
			_CombineLatest combineLatest = (_CombineLatest)state;
			combineLatest.running1 = false;
			try
			{
				if (combineLatest.awaiter1.GetResult())
				{
					combineLatest.hasCurrent1 = true;
					combineLatest.current1 = combineLatest.enumerator1.Current;
					goto IL_0074;
				}
				combineLatest.running1 = true;
				if (Interlocked.Increment(ref combineLatest.completedCount) != 15)
				{
					return;
				}
			}
			catch (Exception error)
			{
				combineLatest.running1 = true;
				combineLatest.completedCount = 15;
				combineLatest.completionSource.TrySetException(error);
				return;
			}
			combineLatest.completionSource.TrySetResult(result: false);
			return;
			IL_0074:
			if (!combineLatest.TrySetResult() && !combineLatest.syncRunning)
			{
				combineLatest.running1 = true;
				try
				{
					combineLatest.awaiter1 = combineLatest.enumerator1.MoveNextAsync().GetAwaiter();
				}
				catch (Exception error2)
				{
					combineLatest.completedCount = 15;
					combineLatest.completionSource.TrySetException(error2);
					return;
				}
				combineLatest.awaiter1.SourceOnCompleted(Completed1Delegate, combineLatest);
			}
		}

		private static void Completed2(object state)
		{
			_CombineLatest combineLatest = (_CombineLatest)state;
			combineLatest.running2 = false;
			try
			{
				if (combineLatest.awaiter2.GetResult())
				{
					combineLatest.hasCurrent2 = true;
					combineLatest.current2 = combineLatest.enumerator2.Current;
					goto IL_0074;
				}
				combineLatest.running2 = true;
				if (Interlocked.Increment(ref combineLatest.completedCount) != 15)
				{
					return;
				}
			}
			catch (Exception error)
			{
				combineLatest.running2 = true;
				combineLatest.completedCount = 15;
				combineLatest.completionSource.TrySetException(error);
				return;
			}
			combineLatest.completionSource.TrySetResult(result: false);
			return;
			IL_0074:
			if (!combineLatest.TrySetResult() && !combineLatest.syncRunning)
			{
				combineLatest.running2 = true;
				try
				{
					combineLatest.awaiter2 = combineLatest.enumerator2.MoveNextAsync().GetAwaiter();
				}
				catch (Exception error2)
				{
					combineLatest.completedCount = 15;
					combineLatest.completionSource.TrySetException(error2);
					return;
				}
				combineLatest.awaiter2.SourceOnCompleted(Completed2Delegate, combineLatest);
			}
		}

		private static void Completed3(object state)
		{
			_CombineLatest combineLatest = (_CombineLatest)state;
			combineLatest.running3 = false;
			try
			{
				if (combineLatest.awaiter3.GetResult())
				{
					combineLatest.hasCurrent3 = true;
					combineLatest.current3 = combineLatest.enumerator3.Current;
					goto IL_0074;
				}
				combineLatest.running3 = true;
				if (Interlocked.Increment(ref combineLatest.completedCount) != 15)
				{
					return;
				}
			}
			catch (Exception error)
			{
				combineLatest.running3 = true;
				combineLatest.completedCount = 15;
				combineLatest.completionSource.TrySetException(error);
				return;
			}
			combineLatest.completionSource.TrySetResult(result: false);
			return;
			IL_0074:
			if (!combineLatest.TrySetResult() && !combineLatest.syncRunning)
			{
				combineLatest.running3 = true;
				try
				{
					combineLatest.awaiter3 = combineLatest.enumerator3.MoveNextAsync().GetAwaiter();
				}
				catch (Exception error2)
				{
					combineLatest.completedCount = 15;
					combineLatest.completionSource.TrySetException(error2);
					return;
				}
				combineLatest.awaiter3.SourceOnCompleted(Completed3Delegate, combineLatest);
			}
		}

		private static void Completed4(object state)
		{
			_CombineLatest combineLatest = (_CombineLatest)state;
			combineLatest.running4 = false;
			try
			{
				if (combineLatest.awaiter4.GetResult())
				{
					combineLatest.hasCurrent4 = true;
					combineLatest.current4 = combineLatest.enumerator4.Current;
					goto IL_0074;
				}
				combineLatest.running4 = true;
				if (Interlocked.Increment(ref combineLatest.completedCount) != 15)
				{
					return;
				}
			}
			catch (Exception error)
			{
				combineLatest.running4 = true;
				combineLatest.completedCount = 15;
				combineLatest.completionSource.TrySetException(error);
				return;
			}
			combineLatest.completionSource.TrySetResult(result: false);
			return;
			IL_0074:
			if (!combineLatest.TrySetResult() && !combineLatest.syncRunning)
			{
				combineLatest.running4 = true;
				try
				{
					combineLatest.awaiter4 = combineLatest.enumerator4.MoveNextAsync().GetAwaiter();
				}
				catch (Exception error2)
				{
					combineLatest.completedCount = 15;
					combineLatest.completionSource.TrySetException(error2);
					return;
				}
				combineLatest.awaiter4.SourceOnCompleted(Completed4Delegate, combineLatest);
			}
		}

		private static void Completed5(object state)
		{
			_CombineLatest combineLatest = (_CombineLatest)state;
			combineLatest.running5 = false;
			try
			{
				if (combineLatest.awaiter5.GetResult())
				{
					combineLatest.hasCurrent5 = true;
					combineLatest.current5 = combineLatest.enumerator5.Current;
					goto IL_0074;
				}
				combineLatest.running5 = true;
				if (Interlocked.Increment(ref combineLatest.completedCount) != 15)
				{
					return;
				}
			}
			catch (Exception error)
			{
				combineLatest.running5 = true;
				combineLatest.completedCount = 15;
				combineLatest.completionSource.TrySetException(error);
				return;
			}
			combineLatest.completionSource.TrySetResult(result: false);
			return;
			IL_0074:
			if (!combineLatest.TrySetResult() && !combineLatest.syncRunning)
			{
				combineLatest.running5 = true;
				try
				{
					combineLatest.awaiter5 = combineLatest.enumerator5.MoveNextAsync().GetAwaiter();
				}
				catch (Exception error2)
				{
					combineLatest.completedCount = 15;
					combineLatest.completionSource.TrySetException(error2);
					return;
				}
				combineLatest.awaiter5.SourceOnCompleted(Completed5Delegate, combineLatest);
			}
		}

		private static void Completed6(object state)
		{
			_CombineLatest combineLatest = (_CombineLatest)state;
			combineLatest.running6 = false;
			try
			{
				if (combineLatest.awaiter6.GetResult())
				{
					combineLatest.hasCurrent6 = true;
					combineLatest.current6 = combineLatest.enumerator6.Current;
					goto IL_0074;
				}
				combineLatest.running6 = true;
				if (Interlocked.Increment(ref combineLatest.completedCount) != 15)
				{
					return;
				}
			}
			catch (Exception error)
			{
				combineLatest.running6 = true;
				combineLatest.completedCount = 15;
				combineLatest.completionSource.TrySetException(error);
				return;
			}
			combineLatest.completionSource.TrySetResult(result: false);
			return;
			IL_0074:
			if (!combineLatest.TrySetResult() && !combineLatest.syncRunning)
			{
				combineLatest.running6 = true;
				try
				{
					combineLatest.awaiter6 = combineLatest.enumerator6.MoveNextAsync().GetAwaiter();
				}
				catch (Exception error2)
				{
					combineLatest.completedCount = 15;
					combineLatest.completionSource.TrySetException(error2);
					return;
				}
				combineLatest.awaiter6.SourceOnCompleted(Completed6Delegate, combineLatest);
			}
		}

		private static void Completed7(object state)
		{
			_CombineLatest combineLatest = (_CombineLatest)state;
			combineLatest.running7 = false;
			try
			{
				if (combineLatest.awaiter7.GetResult())
				{
					combineLatest.hasCurrent7 = true;
					combineLatest.current7 = combineLatest.enumerator7.Current;
					goto IL_0074;
				}
				combineLatest.running7 = true;
				if (Interlocked.Increment(ref combineLatest.completedCount) != 15)
				{
					return;
				}
			}
			catch (Exception error)
			{
				combineLatest.running7 = true;
				combineLatest.completedCount = 15;
				combineLatest.completionSource.TrySetException(error);
				return;
			}
			combineLatest.completionSource.TrySetResult(result: false);
			return;
			IL_0074:
			if (!combineLatest.TrySetResult() && !combineLatest.syncRunning)
			{
				combineLatest.running7 = true;
				try
				{
					combineLatest.awaiter7 = combineLatest.enumerator7.MoveNextAsync().GetAwaiter();
				}
				catch (Exception error2)
				{
					combineLatest.completedCount = 15;
					combineLatest.completionSource.TrySetException(error2);
					return;
				}
				combineLatest.awaiter7.SourceOnCompleted(Completed7Delegate, combineLatest);
			}
		}

		private static void Completed8(object state)
		{
			_CombineLatest combineLatest = (_CombineLatest)state;
			combineLatest.running8 = false;
			try
			{
				if (combineLatest.awaiter8.GetResult())
				{
					combineLatest.hasCurrent8 = true;
					combineLatest.current8 = combineLatest.enumerator8.Current;
					goto IL_0074;
				}
				combineLatest.running8 = true;
				if (Interlocked.Increment(ref combineLatest.completedCount) != 15)
				{
					return;
				}
			}
			catch (Exception error)
			{
				combineLatest.running8 = true;
				combineLatest.completedCount = 15;
				combineLatest.completionSource.TrySetException(error);
				return;
			}
			combineLatest.completionSource.TrySetResult(result: false);
			return;
			IL_0074:
			if (!combineLatest.TrySetResult() && !combineLatest.syncRunning)
			{
				combineLatest.running8 = true;
				try
				{
					combineLatest.awaiter8 = combineLatest.enumerator8.MoveNextAsync().GetAwaiter();
				}
				catch (Exception error2)
				{
					combineLatest.completedCount = 15;
					combineLatest.completionSource.TrySetException(error2);
					return;
				}
				combineLatest.awaiter8.SourceOnCompleted(Completed8Delegate, combineLatest);
			}
		}

		private static void Completed9(object state)
		{
			_CombineLatest combineLatest = (_CombineLatest)state;
			combineLatest.running9 = false;
			try
			{
				if (combineLatest.awaiter9.GetResult())
				{
					combineLatest.hasCurrent9 = true;
					combineLatest.current9 = combineLatest.enumerator9.Current;
					goto IL_0074;
				}
				combineLatest.running9 = true;
				if (Interlocked.Increment(ref combineLatest.completedCount) != 15)
				{
					return;
				}
			}
			catch (Exception error)
			{
				combineLatest.running9 = true;
				combineLatest.completedCount = 15;
				combineLatest.completionSource.TrySetException(error);
				return;
			}
			combineLatest.completionSource.TrySetResult(result: false);
			return;
			IL_0074:
			if (!combineLatest.TrySetResult() && !combineLatest.syncRunning)
			{
				combineLatest.running9 = true;
				try
				{
					combineLatest.awaiter9 = combineLatest.enumerator9.MoveNextAsync().GetAwaiter();
				}
				catch (Exception error2)
				{
					combineLatest.completedCount = 15;
					combineLatest.completionSource.TrySetException(error2);
					return;
				}
				combineLatest.awaiter9.SourceOnCompleted(Completed9Delegate, combineLatest);
			}
		}

		private static void Completed10(object state)
		{
			_CombineLatest combineLatest = (_CombineLatest)state;
			combineLatest.running10 = false;
			try
			{
				if (combineLatest.awaiter10.GetResult())
				{
					combineLatest.hasCurrent10 = true;
					combineLatest.current10 = combineLatest.enumerator10.Current;
					goto IL_0074;
				}
				combineLatest.running10 = true;
				if (Interlocked.Increment(ref combineLatest.completedCount) != 15)
				{
					return;
				}
			}
			catch (Exception error)
			{
				combineLatest.running10 = true;
				combineLatest.completedCount = 15;
				combineLatest.completionSource.TrySetException(error);
				return;
			}
			combineLatest.completionSource.TrySetResult(result: false);
			return;
			IL_0074:
			if (!combineLatest.TrySetResult() && !combineLatest.syncRunning)
			{
				combineLatest.running10 = true;
				try
				{
					combineLatest.awaiter10 = combineLatest.enumerator10.MoveNextAsync().GetAwaiter();
				}
				catch (Exception error2)
				{
					combineLatest.completedCount = 15;
					combineLatest.completionSource.TrySetException(error2);
					return;
				}
				combineLatest.awaiter10.SourceOnCompleted(Completed10Delegate, combineLatest);
			}
		}

		private static void Completed11(object state)
		{
			_CombineLatest combineLatest = (_CombineLatest)state;
			combineLatest.running11 = false;
			try
			{
				if (combineLatest.awaiter11.GetResult())
				{
					combineLatest.hasCurrent11 = true;
					combineLatest.current11 = combineLatest.enumerator11.Current;
					goto IL_0074;
				}
				combineLatest.running11 = true;
				if (Interlocked.Increment(ref combineLatest.completedCount) != 15)
				{
					return;
				}
			}
			catch (Exception error)
			{
				combineLatest.running11 = true;
				combineLatest.completedCount = 15;
				combineLatest.completionSource.TrySetException(error);
				return;
			}
			combineLatest.completionSource.TrySetResult(result: false);
			return;
			IL_0074:
			if (!combineLatest.TrySetResult() && !combineLatest.syncRunning)
			{
				combineLatest.running11 = true;
				try
				{
					combineLatest.awaiter11 = combineLatest.enumerator11.MoveNextAsync().GetAwaiter();
				}
				catch (Exception error2)
				{
					combineLatest.completedCount = 15;
					combineLatest.completionSource.TrySetException(error2);
					return;
				}
				combineLatest.awaiter11.SourceOnCompleted(Completed11Delegate, combineLatest);
			}
		}

		private static void Completed12(object state)
		{
			_CombineLatest combineLatest = (_CombineLatest)state;
			combineLatest.running12 = false;
			try
			{
				if (combineLatest.awaiter12.GetResult())
				{
					combineLatest.hasCurrent12 = true;
					combineLatest.current12 = combineLatest.enumerator12.Current;
					goto IL_0074;
				}
				combineLatest.running12 = true;
				if (Interlocked.Increment(ref combineLatest.completedCount) != 15)
				{
					return;
				}
			}
			catch (Exception error)
			{
				combineLatest.running12 = true;
				combineLatest.completedCount = 15;
				combineLatest.completionSource.TrySetException(error);
				return;
			}
			combineLatest.completionSource.TrySetResult(result: false);
			return;
			IL_0074:
			if (!combineLatest.TrySetResult() && !combineLatest.syncRunning)
			{
				combineLatest.running12 = true;
				try
				{
					combineLatest.awaiter12 = combineLatest.enumerator12.MoveNextAsync().GetAwaiter();
				}
				catch (Exception error2)
				{
					combineLatest.completedCount = 15;
					combineLatest.completionSource.TrySetException(error2);
					return;
				}
				combineLatest.awaiter12.SourceOnCompleted(Completed12Delegate, combineLatest);
			}
		}

		private static void Completed13(object state)
		{
			_CombineLatest combineLatest = (_CombineLatest)state;
			combineLatest.running13 = false;
			try
			{
				if (combineLatest.awaiter13.GetResult())
				{
					combineLatest.hasCurrent13 = true;
					combineLatest.current13 = combineLatest.enumerator13.Current;
					goto IL_0074;
				}
				combineLatest.running13 = true;
				if (Interlocked.Increment(ref combineLatest.completedCount) != 15)
				{
					return;
				}
			}
			catch (Exception error)
			{
				combineLatest.running13 = true;
				combineLatest.completedCount = 15;
				combineLatest.completionSource.TrySetException(error);
				return;
			}
			combineLatest.completionSource.TrySetResult(result: false);
			return;
			IL_0074:
			if (!combineLatest.TrySetResult() && !combineLatest.syncRunning)
			{
				combineLatest.running13 = true;
				try
				{
					combineLatest.awaiter13 = combineLatest.enumerator13.MoveNextAsync().GetAwaiter();
				}
				catch (Exception error2)
				{
					combineLatest.completedCount = 15;
					combineLatest.completionSource.TrySetException(error2);
					return;
				}
				combineLatest.awaiter13.SourceOnCompleted(Completed13Delegate, combineLatest);
			}
		}

		private static void Completed14(object state)
		{
			_CombineLatest combineLatest = (_CombineLatest)state;
			combineLatest.running14 = false;
			try
			{
				if (combineLatest.awaiter14.GetResult())
				{
					combineLatest.hasCurrent14 = true;
					combineLatest.current14 = combineLatest.enumerator14.Current;
					goto IL_0074;
				}
				combineLatest.running14 = true;
				if (Interlocked.Increment(ref combineLatest.completedCount) != 15)
				{
					return;
				}
			}
			catch (Exception error)
			{
				combineLatest.running14 = true;
				combineLatest.completedCount = 15;
				combineLatest.completionSource.TrySetException(error);
				return;
			}
			combineLatest.completionSource.TrySetResult(result: false);
			return;
			IL_0074:
			if (!combineLatest.TrySetResult() && !combineLatest.syncRunning)
			{
				combineLatest.running14 = true;
				try
				{
					combineLatest.awaiter14 = combineLatest.enumerator14.MoveNextAsync().GetAwaiter();
				}
				catch (Exception error2)
				{
					combineLatest.completedCount = 15;
					combineLatest.completionSource.TrySetException(error2);
					return;
				}
				combineLatest.awaiter14.SourceOnCompleted(Completed14Delegate, combineLatest);
			}
		}

		private static void Completed15(object state)
		{
			_CombineLatest combineLatest = (_CombineLatest)state;
			combineLatest.running15 = false;
			try
			{
				if (combineLatest.awaiter15.GetResult())
				{
					combineLatest.hasCurrent15 = true;
					combineLatest.current15 = combineLatest.enumerator15.Current;
					goto IL_0074;
				}
				combineLatest.running15 = true;
				if (Interlocked.Increment(ref combineLatest.completedCount) != 15)
				{
					return;
				}
			}
			catch (Exception error)
			{
				combineLatest.running15 = true;
				combineLatest.completedCount = 15;
				combineLatest.completionSource.TrySetException(error);
				return;
			}
			combineLatest.completionSource.TrySetResult(result: false);
			return;
			IL_0074:
			if (!combineLatest.TrySetResult() && !combineLatest.syncRunning)
			{
				combineLatest.running15 = true;
				try
				{
					combineLatest.awaiter15 = combineLatest.enumerator15.MoveNextAsync().GetAwaiter();
				}
				catch (Exception error2)
				{
					combineLatest.completedCount = 15;
					combineLatest.completionSource.TrySetException(error2);
					return;
				}
				combineLatest.awaiter15.SourceOnCompleted(Completed15Delegate, combineLatest);
			}
		}

		private bool TrySetResult()
		{
			if (hasCurrent1 && hasCurrent2 && hasCurrent3 && hasCurrent4 && hasCurrent5 && hasCurrent6 && hasCurrent7 && hasCurrent8 && hasCurrent9 && hasCurrent10 && hasCurrent11 && hasCurrent12 && hasCurrent13 && hasCurrent14 && hasCurrent15)
			{
				result = resultSelector(current1, current2, current3, current4, current5, current6, current7, current8, current9, current10, current11, current12, current13, current14, current15);
				completionSource.TrySetResult(result: true);
				return true;
			}
			return false;
		}

		public async UniTask DisposeAsync()
		{
			if (enumerator1 != null)
			{
				await enumerator1.DisposeAsync();
			}
			if (enumerator2 != null)
			{
				await enumerator2.DisposeAsync();
			}
			if (enumerator3 != null)
			{
				await enumerator3.DisposeAsync();
			}
			if (enumerator4 != null)
			{
				await enumerator4.DisposeAsync();
			}
			if (enumerator5 != null)
			{
				await enumerator5.DisposeAsync();
			}
			if (enumerator6 != null)
			{
				await enumerator6.DisposeAsync();
			}
			if (enumerator7 != null)
			{
				await enumerator7.DisposeAsync();
			}
			if (enumerator8 != null)
			{
				await enumerator8.DisposeAsync();
			}
			if (enumerator9 != null)
			{
				await enumerator9.DisposeAsync();
			}
			if (enumerator10 != null)
			{
				await enumerator10.DisposeAsync();
			}
			if (enumerator11 != null)
			{
				await enumerator11.DisposeAsync();
			}
			if (enumerator12 != null)
			{
				await enumerator12.DisposeAsync();
			}
			if (enumerator13 != null)
			{
				await enumerator13.DisposeAsync();
			}
			if (enumerator14 != null)
			{
				await enumerator14.DisposeAsync();
			}
			if (enumerator15 != null)
			{
				await enumerator15.DisposeAsync();
			}
		}
	}

	private readonly IUniTaskAsyncEnumerable<T1> source1;

	private readonly IUniTaskAsyncEnumerable<T2> source2;

	private readonly IUniTaskAsyncEnumerable<T3> source3;

	private readonly IUniTaskAsyncEnumerable<T4> source4;

	private readonly IUniTaskAsyncEnumerable<T5> source5;

	private readonly IUniTaskAsyncEnumerable<T6> source6;

	private readonly IUniTaskAsyncEnumerable<T7> source7;

	private readonly IUniTaskAsyncEnumerable<T8> source8;

	private readonly IUniTaskAsyncEnumerable<T9> source9;

	private readonly IUniTaskAsyncEnumerable<T10> source10;

	private readonly IUniTaskAsyncEnumerable<T11> source11;

	private readonly IUniTaskAsyncEnumerable<T12> source12;

	private readonly IUniTaskAsyncEnumerable<T13> source13;

	private readonly IUniTaskAsyncEnumerable<T14> source14;

	private readonly IUniTaskAsyncEnumerable<T15> source15;

	private readonly Func<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13, T14, T15, TResult> resultSelector;

	public CombineLatest(IUniTaskAsyncEnumerable<T1> source1, IUniTaskAsyncEnumerable<T2> source2, IUniTaskAsyncEnumerable<T3> source3, IUniTaskAsyncEnumerable<T4> source4, IUniTaskAsyncEnumerable<T5> source5, IUniTaskAsyncEnumerable<T6> source6, IUniTaskAsyncEnumerable<T7> source7, IUniTaskAsyncEnumerable<T8> source8, IUniTaskAsyncEnumerable<T9> source9, IUniTaskAsyncEnumerable<T10> source10, IUniTaskAsyncEnumerable<T11> source11, IUniTaskAsyncEnumerable<T12> source12, IUniTaskAsyncEnumerable<T13> source13, IUniTaskAsyncEnumerable<T14> source14, IUniTaskAsyncEnumerable<T15> source15, Func<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13, T14, T15, TResult> resultSelector)
	{
		this.source1 = source1;
		this.source2 = source2;
		this.source3 = source3;
		this.source4 = source4;
		this.source5 = source5;
		this.source6 = source6;
		this.source7 = source7;
		this.source8 = source8;
		this.source9 = source9;
		this.source10 = source10;
		this.source11 = source11;
		this.source12 = source12;
		this.source13 = source13;
		this.source14 = source14;
		this.source15 = source15;
		this.resultSelector = resultSelector;
	}

	public IUniTaskAsyncEnumerator<TResult> GetAsyncEnumerator(CancellationToken cancellationToken = default(CancellationToken))
	{
		return new _CombineLatest(source1, source2, source3, source4, source5, source6, source7, source8, source9, source10, source11, source12, source13, source14, source15, resultSelector, cancellationToken);
	}
}
