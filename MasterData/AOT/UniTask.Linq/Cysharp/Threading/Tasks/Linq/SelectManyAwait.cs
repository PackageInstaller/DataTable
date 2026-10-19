using System;
using System.Threading;

namespace Cysharp.Threading.Tasks.Linq;

internal sealed class SelectManyAwait<TSource, TCollection, TResult> : IUniTaskAsyncEnumerable<TResult>
{
	private sealed class _SelectManyAwait : MoveNextSource, IUniTaskAsyncEnumerator<TResult>, IUniTaskAsyncDisposable
	{
		private static readonly Action<object> sourceMoveNextCoreDelegate = SourceMoveNextCore;

		private static readonly Action<object> selectedSourceMoveNextCoreDelegate = SeletedSourceMoveNextCore;

		private static readonly Action<object> selectedEnumeratorDisposeAsyncCoreDelegate = SelectedEnumeratorDisposeAsyncCore;

		private static readonly Action<object> selectorAwaitCoreDelegate = SelectorAwaitCore;

		private static readonly Action<object> resultSelectorAwaitCoreDelegate = ResultSelectorAwaitCore;

		private readonly IUniTaskAsyncEnumerable<TSource> source;

		private readonly Func<TSource, UniTask<IUniTaskAsyncEnumerable<TCollection>>> selector1;

		private readonly Func<TSource, int, UniTask<IUniTaskAsyncEnumerable<TCollection>>> selector2;

		private readonly Func<TSource, TCollection, UniTask<TResult>> resultSelector;

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

		public _SelectManyAwait(IUniTaskAsyncEnumerable<TSource> source, Func<TSource, UniTask<IUniTaskAsyncEnumerable<TCollection>>> selector1, Func<TSource, int, UniTask<IUniTaskAsyncEnumerable<TCollection>>> selector2, Func<TSource, TCollection, UniTask<TResult>> resultSelector, CancellationToken cancellationToken)
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
			_SelectManyAwait selectManyAwait = (_SelectManyAwait)state;
			if (!selectManyAwait.TryGetResult(selectManyAwait.sourceAwaiter, out var result))
			{
				return;
			}
			if (result)
			{
				try
				{
					selectManyAwait.sourceCurrent = selectManyAwait.sourceEnumerator.Current;
					if (selectManyAwait.selector1 != null)
					{
						selectManyAwait.collectionSelectorAwaiter = selectManyAwait.selector1(selectManyAwait.sourceCurrent).GetAwaiter();
					}
					else
					{
						selectManyAwait.collectionSelectorAwaiter = selectManyAwait.selector2(selectManyAwait.sourceCurrent, checked(selectManyAwait.sourceIndex++)).GetAwaiter();
					}
					if (selectManyAwait.collectionSelectorAwaiter.IsCompleted)
					{
						SelectorAwaitCore(selectManyAwait);
					}
					else
					{
						selectManyAwait.collectionSelectorAwaiter.SourceOnCompleted(selectorAwaitCoreDelegate, selectManyAwait);
					}
					return;
				}
				catch (Exception error)
				{
					selectManyAwait.completionSource.TrySetException(error);
					return;
				}
			}
			selectManyAwait.completionSource.TrySetResult(result: false);
		}

		private static void SeletedSourceMoveNextCore(object state)
		{
			_SelectManyAwait selectManyAwait = (_SelectManyAwait)state;
			if (!selectManyAwait.TryGetResult(selectManyAwait.selectedAwaiter, out var result))
			{
				return;
			}
			if (result)
			{
				try
				{
					selectManyAwait.resultSelectorAwaiter = selectManyAwait.resultSelector(selectManyAwait.sourceCurrent, selectManyAwait.selectedEnumerator.Current).GetAwaiter();
					if (selectManyAwait.resultSelectorAwaiter.IsCompleted)
					{
						ResultSelectorAwaitCore(selectManyAwait);
					}
					else
					{
						selectManyAwait.resultSelectorAwaiter.SourceOnCompleted(resultSelectorAwaitCoreDelegate, selectManyAwait);
					}
					return;
				}
				catch (Exception error)
				{
					selectManyAwait.completionSource.TrySetException(error);
					return;
				}
			}
			try
			{
				selectManyAwait.selectedDisposeAsyncAwaiter = selectManyAwait.selectedEnumerator.DisposeAsync().GetAwaiter();
			}
			catch (Exception error2)
			{
				selectManyAwait.completionSource.TrySetException(error2);
				return;
			}
			if (selectManyAwait.selectedDisposeAsyncAwaiter.IsCompleted)
			{
				SelectedEnumeratorDisposeAsyncCore(selectManyAwait);
			}
			else
			{
				selectManyAwait.selectedDisposeAsyncAwaiter.SourceOnCompleted(selectedEnumeratorDisposeAsyncCoreDelegate, selectManyAwait);
			}
		}

		private static void SelectedEnumeratorDisposeAsyncCore(object state)
		{
			_SelectManyAwait selectManyAwait = (_SelectManyAwait)state;
			if (selectManyAwait.TryGetResult(selectManyAwait.selectedDisposeAsyncAwaiter))
			{
				selectManyAwait.selectedEnumerator = null;
				selectManyAwait.selectedAwaiter = default;
				selectManyAwait.MoveNextSource();
			}
		}

		private static void SelectorAwaitCore(object state)
		{
			_SelectManyAwait selectManyAwait = (_SelectManyAwait)state;
			if (selectManyAwait.TryGetResult(selectManyAwait.collectionSelectorAwaiter, out var result))
			{
				selectManyAwait.selectedEnumerator = result.GetAsyncEnumerator(selectManyAwait.cancellationToken);
				selectManyAwait.MoveNextSelected();
			}
		}

		private static void ResultSelectorAwaitCore(object state)
		{
			_SelectManyAwait selectManyAwait = (_SelectManyAwait)state;
			if (selectManyAwait.TryGetResult(selectManyAwait.resultSelectorAwaiter, out var result))
			{
				selectManyAwait.Current = result;
				selectManyAwait.completionSource.TrySetResult(result: true);
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

	private readonly Func<TSource, UniTask<IUniTaskAsyncEnumerable<TCollection>>> selector1;

	private readonly Func<TSource, int, UniTask<IUniTaskAsyncEnumerable<TCollection>>> selector2;

	private readonly Func<TSource, TCollection, UniTask<TResult>> resultSelector;

	public SelectManyAwait(IUniTaskAsyncEnumerable<TSource> source, Func<TSource, UniTask<IUniTaskAsyncEnumerable<TCollection>>> selector, Func<TSource, TCollection, UniTask<TResult>> resultSelector)
	{
		this.source = source;
		selector1 = selector;
		selector2 = null;
		this.resultSelector = resultSelector;
	}

	public SelectManyAwait(IUniTaskAsyncEnumerable<TSource> source, Func<TSource, int, UniTask<IUniTaskAsyncEnumerable<TCollection>>> selector, Func<TSource, TCollection, UniTask<TResult>> resultSelector)
	{
		this.source = source;
		selector1 = null;
		selector2 = selector;
		this.resultSelector = resultSelector;
	}

	public IUniTaskAsyncEnumerator<TResult> GetAsyncEnumerator(CancellationToken cancellationToken = default(CancellationToken))
	{
		return new _SelectManyAwait(source, selector1, selector2, resultSelector, cancellationToken);
	}
}
