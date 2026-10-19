using System;
using System.Threading;

namespace Cysharp.Threading.Tasks.Linq;

internal sealed class SelectMany<TSource, TCollection, TResult> : IUniTaskAsyncEnumerable<TResult>
{
	private sealed class _SelectMany : MoveNextSource, IUniTaskAsyncEnumerator<TResult>, IUniTaskAsyncDisposable
	{
		private static readonly Action<object> sourceMoveNextCoreDelegate = SourceMoveNextCore;

		private static readonly Action<object> selectedSourceMoveNextCoreDelegate = SeletedSourceMoveNextCore;

		private static readonly Action<object> selectedEnumeratorDisposeAsyncCoreDelegate = SelectedEnumeratorDisposeAsyncCore;

		private readonly IUniTaskAsyncEnumerable<TSource> source;

		private readonly Func<TSource, IUniTaskAsyncEnumerable<TCollection>> selector1;

		private readonly Func<TSource, int, IUniTaskAsyncEnumerable<TCollection>> selector2;

		private readonly Func<TSource, TCollection, TResult> resultSelector;

		private CancellationToken cancellationToken;

		private TSource sourceCurrent;

		private int sourceIndex;

		private IUniTaskAsyncEnumerator<TSource> sourceEnumerator;

		private IUniTaskAsyncEnumerator<TCollection> selectedEnumerator;

		private UniTask<bool>.Awaiter sourceAwaiter;

		private UniTask<bool>.Awaiter selectedAwaiter;

		private UniTask.Awaiter selectedDisposeAsyncAwaiter;

		public TResult Current { get; private set; }

		public _SelectMany(IUniTaskAsyncEnumerable<TSource> source, Func<TSource, IUniTaskAsyncEnumerable<TCollection>> selector1, Func<TSource, int, IUniTaskAsyncEnumerable<TCollection>> selector2, Func<TSource, TCollection, TResult> resultSelector, CancellationToken cancellationToken)
		{
			this.source = source;
			this.selector1 = selector1;
			this.selector2 = selector2;
			this.resultSelector = resultSelector;
			this.cancellationToken = cancellationToken;
		}

		public UniTask<bool> MoveNextAsync()
		{
			completionSource.Reset();
			if (selectedEnumerator != null)
			{
				MoveNextSelected();
			}
			else
			{
				if (sourceEnumerator == null)
				{
					sourceEnumerator = source.GetAsyncEnumerator(cancellationToken);
				}
				MoveNextSource();
			}
			return new UniTask<bool>(this, completionSource.Version);
		}

		private void MoveNextSource()
		{
			try
			{
				sourceAwaiter = sourceEnumerator.MoveNextAsync().GetAwaiter();
			}
			catch (Exception error)
			{
				completionSource.TrySetException(error);
				return;
			}
			if (sourceAwaiter.IsCompleted)
			{
				SourceMoveNextCore(this);
			}
			else
			{
				sourceAwaiter.SourceOnCompleted(sourceMoveNextCoreDelegate, this);
			}
		}

		private void MoveNextSelected()
		{
			try
			{
				selectedAwaiter = selectedEnumerator.MoveNextAsync().GetAwaiter();
			}
			catch (Exception error)
			{
				completionSource.TrySetException(error);
				return;
			}
			if (selectedAwaiter.IsCompleted)
			{
				SeletedSourceMoveNextCore(this);
			}
			else
			{
				selectedAwaiter.SourceOnCompleted(selectedSourceMoveNextCoreDelegate, this);
			}
		}

		private static void SourceMoveNextCore(object state)
		{
			_SelectMany selectMany = (_SelectMany)state;
			if (!selectMany.TryGetResult(selectMany.sourceAwaiter, out var result))
			{
				return;
			}
			if (result)
			{
				try
				{
					selectMany.sourceCurrent = selectMany.sourceEnumerator.Current;
					if (selectMany.selector1 != null)
					{
						selectMany.selectedEnumerator = selectMany.selector1(selectMany.sourceCurrent).GetAsyncEnumerator(selectMany.cancellationToken);
					}
					else
					{
						selectMany.selectedEnumerator = selectMany.selector2(selectMany.sourceCurrent, checked(selectMany.sourceIndex++)).GetAsyncEnumerator(selectMany.cancellationToken);
					}
				}
				catch (Exception error)
				{
					selectMany.completionSource.TrySetException(error);
					return;
				}
				selectMany.MoveNextSelected();
			}
			else
			{
				selectMany.completionSource.TrySetResult(result: false);
			}
		}

		private static void SeletedSourceMoveNextCore(object state)
		{
			_SelectMany selectMany = (_SelectMany)state;
			if (!selectMany.TryGetResult(selectMany.selectedAwaiter, out var result))
			{
				return;
			}
			if (result)
			{
				try
				{
					selectMany.Current = selectMany.resultSelector(selectMany.sourceCurrent, selectMany.selectedEnumerator.Current);
				}
				catch (Exception error)
				{
					selectMany.completionSource.TrySetException(error);
					return;
				}
				selectMany.completionSource.TrySetResult(result: true);
				return;
			}
			try
			{
				selectMany.selectedDisposeAsyncAwaiter = selectMany.selectedEnumerator.DisposeAsync().GetAwaiter();
			}
			catch (Exception error2)
			{
				selectMany.completionSource.TrySetException(error2);
				return;
			}
			if (selectMany.selectedDisposeAsyncAwaiter.IsCompleted)
			{
				SelectedEnumeratorDisposeAsyncCore(selectMany);
			}
			else
			{
				selectMany.selectedDisposeAsyncAwaiter.SourceOnCompleted(selectedEnumeratorDisposeAsyncCoreDelegate, selectMany);
			}
		}

		private static void SelectedEnumeratorDisposeAsyncCore(object state)
		{
			_SelectMany selectMany = (_SelectMany)state;
			if (selectMany.TryGetResult(selectMany.selectedDisposeAsyncAwaiter))
			{
				selectMany.selectedEnumerator = null;
				selectMany.selectedAwaiter = default;
				selectMany.MoveNextSource();
			}
		}

		public async UniTask DisposeAsync()
		{
			if (selectedEnumerator != null)
			{
				await selectedEnumerator.DisposeAsync();
			}
			if (sourceEnumerator != null)
			{
				await sourceEnumerator.DisposeAsync();
			}
		}
	}

	private readonly IUniTaskAsyncEnumerable<TSource> source;

	private readonly Func<TSource, IUniTaskAsyncEnumerable<TCollection>> selector1;

	private readonly Func<TSource, int, IUniTaskAsyncEnumerable<TCollection>> selector2;

	private readonly Func<TSource, TCollection, TResult> resultSelector;

	public SelectMany(IUniTaskAsyncEnumerable<TSource> source, Func<TSource, IUniTaskAsyncEnumerable<TCollection>> selector, Func<TSource, TCollection, TResult> resultSelector)
	{
		this.source = source;
		selector1 = selector;
		selector2 = null;
		this.resultSelector = resultSelector;
	}

	public SelectMany(IUniTaskAsyncEnumerable<TSource> source, Func<TSource, int, IUniTaskAsyncEnumerable<TCollection>> selector, Func<TSource, TCollection, TResult> resultSelector)
	{
		this.source = source;
		selector1 = null;
		selector2 = selector;
		this.resultSelector = resultSelector;
	}

	public IUniTaskAsyncEnumerator<TResult> GetAsyncEnumerator(CancellationToken cancellationToken = default(CancellationToken))
	{
		return new _SelectMany(source, selector1, selector2, resultSelector, cancellationToken);
	}
}
