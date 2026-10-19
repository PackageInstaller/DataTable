using System;
using System.Threading;

namespace Cysharp.Threading.Tasks.Linq;

internal sealed class SelectManyAwaitWithCancellation<TSource, TCollection, TResult> : IUniTaskAsyncEnumerable<TResult>
{
	private sealed class _SelectManyAwaitWithCancellation : MoveNextSource, IUniTaskAsyncEnumerator<TResult>, IUniTaskAsyncDisposable
	{
		private static readonly Action<object> sourceMoveNextCoreDelegate = SourceMoveNextCore;

		private static readonly Action<object> selectedSourceMoveNextCoreDelegate = SeletedSourceMoveNextCore;

		private static readonly Action<object> selectedEnumeratorDisposeAsyncCoreDelegate = SelectedEnumeratorDisposeAsyncCore;

		private static readonly Action<object> selectorAwaitCoreDelegate = SelectorAwaitCore;

		private static readonly Action<object> resultSelectorAwaitCoreDelegate = ResultSelectorAwaitCore;

		private readonly IUniTaskAsyncEnumerable<TSource> source;

		private readonly Func<TSource, CancellationToken, UniTask<IUniTaskAsyncEnumerable<TCollection>>> selector1;

		private readonly Func<TSource, int, CancellationToken, UniTask<IUniTaskAsyncEnumerable<TCollection>>> selector2;

		private readonly Func<TSource, TCollection, CancellationToken, UniTask<TResult>> resultSelector;

		private CancellationToken cancellationToken;

		private TSource sourceCurrent;

		private int sourceIndex;

		private IUniTaskAsyncEnumerator<TSource> sourceEnumerator;

		private IUniTaskAsyncEnumerator<TCollection> selectedEnumerator;

		private UniTask<bool>.Awaiter sourceAwaiter;

		private UniTask<bool>.Awaiter selectedAwaiter;

		private UniTask.Awaiter selectedDisposeAsyncAwaiter;

		private UniTask<IUniTaskAsyncEnumerable<TCollection>>.Awaiter collectionSelectorAwaiter;

		private UniTask<TResult>.Awaiter resultSelectorAwaiter;

		public TResult Current { get; private set; }

		public _SelectManyAwaitWithCancellation(IUniTaskAsyncEnumerable<TSource> source, Func<TSource, CancellationToken, UniTask<IUniTaskAsyncEnumerable<TCollection>>> selector1, Func<TSource, int, CancellationToken, UniTask<IUniTaskAsyncEnumerable<TCollection>>> selector2, Func<TSource, TCollection, CancellationToken, UniTask<TResult>> resultSelector, CancellationToken cancellationToken)
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
			_SelectManyAwaitWithCancellation selectManyAwaitWithCancellation = (_SelectManyAwaitWithCancellation)state;
			if (!selectManyAwaitWithCancellation.TryGetResult(selectManyAwaitWithCancellation.sourceAwaiter, out var result))
			{
				return;
			}
			if (result)
			{
				try
				{
					selectManyAwaitWithCancellation.sourceCurrent = selectManyAwaitWithCancellation.sourceEnumerator.Current;
					if (selectManyAwaitWithCancellation.selector1 != null)
					{
						selectManyAwaitWithCancellation.collectionSelectorAwaiter = selectManyAwaitWithCancellation.selector1(selectManyAwaitWithCancellation.sourceCurrent, selectManyAwaitWithCancellation.cancellationToken).GetAwaiter();
					}
					else
					{
						selectManyAwaitWithCancellation.collectionSelectorAwaiter = selectManyAwaitWithCancellation.selector2(selectManyAwaitWithCancellation.sourceCurrent, checked(selectManyAwaitWithCancellation.sourceIndex++), selectManyAwaitWithCancellation.cancellationToken).GetAwaiter();
					}
					if (selectManyAwaitWithCancellation.collectionSelectorAwaiter.IsCompleted)
					{
						SelectorAwaitCore(selectManyAwaitWithCancellation);
					}
					else
					{
						selectManyAwaitWithCancellation.collectionSelectorAwaiter.SourceOnCompleted(selectorAwaitCoreDelegate, selectManyAwaitWithCancellation);
					}
					return;
				}
				catch (Exception error)
				{
					selectManyAwaitWithCancellation.completionSource.TrySetException(error);
					return;
				}
			}
			selectManyAwaitWithCancellation.completionSource.TrySetResult(result: false);
		}

		private static void SeletedSourceMoveNextCore(object state)
		{
			_SelectManyAwaitWithCancellation selectManyAwaitWithCancellation = (_SelectManyAwaitWithCancellation)state;
			if (!selectManyAwaitWithCancellation.TryGetResult(selectManyAwaitWithCancellation.selectedAwaiter, out var result))
			{
				return;
			}
			if (result)
			{
				try
				{
					selectManyAwaitWithCancellation.resultSelectorAwaiter = selectManyAwaitWithCancellation.resultSelector(selectManyAwaitWithCancellation.sourceCurrent, selectManyAwaitWithCancellation.selectedEnumerator.Current, selectManyAwaitWithCancellation.cancellationToken).GetAwaiter();
					if (selectManyAwaitWithCancellation.resultSelectorAwaiter.IsCompleted)
					{
						ResultSelectorAwaitCore(selectManyAwaitWithCancellation);
					}
					else
					{
						selectManyAwaitWithCancellation.resultSelectorAwaiter.SourceOnCompleted(resultSelectorAwaitCoreDelegate, selectManyAwaitWithCancellation);
					}
					return;
				}
				catch (Exception error)
				{
					selectManyAwaitWithCancellation.completionSource.TrySetException(error);
					return;
				}
			}
			try
			{
				selectManyAwaitWithCancellation.selectedDisposeAsyncAwaiter = selectManyAwaitWithCancellation.selectedEnumerator.DisposeAsync().GetAwaiter();
			}
			catch (Exception error2)
			{
				selectManyAwaitWithCancellation.completionSource.TrySetException(error2);
				return;
			}
			if (selectManyAwaitWithCancellation.selectedDisposeAsyncAwaiter.IsCompleted)
			{
				SelectedEnumeratorDisposeAsyncCore(selectManyAwaitWithCancellation);
			}
			else
			{
				selectManyAwaitWithCancellation.selectedDisposeAsyncAwaiter.SourceOnCompleted(selectedEnumeratorDisposeAsyncCoreDelegate, selectManyAwaitWithCancellation);
			}
		}

		private static void SelectedEnumeratorDisposeAsyncCore(object state)
		{
			_SelectManyAwaitWithCancellation selectManyAwaitWithCancellation = (_SelectManyAwaitWithCancellation)state;
			if (selectManyAwaitWithCancellation.TryGetResult(selectManyAwaitWithCancellation.selectedDisposeAsyncAwaiter))
			{
				selectManyAwaitWithCancellation.selectedEnumerator = null;
				selectManyAwaitWithCancellation.selectedAwaiter = default;
				selectManyAwaitWithCancellation.MoveNextSource();
			}
		}

		private static void SelectorAwaitCore(object state)
		{
			_SelectManyAwaitWithCancellation selectManyAwaitWithCancellation = (_SelectManyAwaitWithCancellation)state;
			if (selectManyAwaitWithCancellation.TryGetResult(selectManyAwaitWithCancellation.collectionSelectorAwaiter, out var result))
			{
				selectManyAwaitWithCancellation.selectedEnumerator = result.GetAsyncEnumerator(selectManyAwaitWithCancellation.cancellationToken);
				selectManyAwaitWithCancellation.MoveNextSelected();
			}
		}

		private static void ResultSelectorAwaitCore(object state)
		{
			_SelectManyAwaitWithCancellation selectManyAwaitWithCancellation = (_SelectManyAwaitWithCancellation)state;
			if (selectManyAwaitWithCancellation.TryGetResult(selectManyAwaitWithCancellation.resultSelectorAwaiter, out var result))
			{
				selectManyAwaitWithCancellation.Current = result;
				selectManyAwaitWithCancellation.completionSource.TrySetResult(result: true);
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

	private readonly Func<TSource, CancellationToken, UniTask<IUniTaskAsyncEnumerable<TCollection>>> selector1;

	private readonly Func<TSource, int, CancellationToken, UniTask<IUniTaskAsyncEnumerable<TCollection>>> selector2;

	private readonly Func<TSource, TCollection, CancellationToken, UniTask<TResult>> resultSelector;

	public SelectManyAwaitWithCancellation(IUniTaskAsyncEnumerable<TSource> source, Func<TSource, CancellationToken, UniTask<IUniTaskAsyncEnumerable<TCollection>>> selector, Func<TSource, TCollection, CancellationToken, UniTask<TResult>> resultSelector)
	{
		this.source = source;
		selector1 = selector;
		selector2 = null;
		this.resultSelector = resultSelector;
	}

	public SelectManyAwaitWithCancellation(IUniTaskAsyncEnumerable<TSource> source, Func<TSource, int, CancellationToken, UniTask<IUniTaskAsyncEnumerable<TCollection>>> selector, Func<TSource, TCollection, CancellationToken, UniTask<TResult>> resultSelector)
	{
		this.source = source;
		selector1 = null;
		selector2 = selector;
		this.resultSelector = resultSelector;
	}

	public IUniTaskAsyncEnumerator<TResult> GetAsyncEnumerator(CancellationToken cancellationToken = default(CancellationToken))
	{
		return new _SelectManyAwaitWithCancellation(source, selector1, selector2, resultSelector, cancellationToken);
	}
}
