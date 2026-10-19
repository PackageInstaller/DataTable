using System;
using System.Collections.Generic;
using System.Threading;

namespace Cysharp.Threading.Tasks.Linq;

internal class AsyncSelectorWithCancellationEnumerableSorter<TElement, TKey> : AsyncEnumerableSorter<TElement>
{
	private readonly Func<TElement, CancellationToken, UniTask<TKey>> keySelector;

	private readonly IComparer<TKey> comparer;

	private readonly bool descending;

	private readonly AsyncEnumerableSorter<TElement> next;

	private CancellationToken cancellationToken;

	private TKey[] keys;

	internal AsyncSelectorWithCancellationEnumerableSorter(Func<TElement, CancellationToken, UniTask<TKey>> keySelector, IComparer<TKey> comparer, bool descending, AsyncEnumerableSorter<TElement> next, CancellationToken cancellationToken)
	{
		this.keySelector = keySelector;
		this.comparer = comparer;
		this.descending = descending;
		this.next = next;
		this.cancellationToken = cancellationToken;
	}

	internal override async UniTask ComputeKeysAsync(TElement[] elements, int count)
	{
		keys = new TKey[count];
		for (int i = 0; i < count; i++)
		{
			TKey[] array = keys;
			int num = i;
			array[num] = await keySelector(elements[i], cancellationToken);
		}
		if (next != null)
		{
			await next.ComputeKeysAsync(elements, count);
		}
	}

	internal override int CompareKeys(int index1, int index2)
	{
		int num = comparer.Compare(keys[index1], keys[index2]);
		if (num == 0)
		{
			if (next == null)
			{
				return index1 - index2;
			}
			return next.CompareKeys(index1, index2);
		}
		if (!descending)
		{
			return num;
		}
		return -num;
	}
}
