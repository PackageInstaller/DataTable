using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using System.Threading;
using Cysharp.Threading.Tasks.Internal;

namespace Cysharp.Threading.Tasks.Linq;

internal static class ToLookup
{
	private class Lookup<TKey, TElement> : ILookup<TKey, TElement>, IEnumerable<IGrouping<TKey, TElement>>, IEnumerable
	{
		private static readonly Lookup<TKey, TElement> empty = new Lookup<TKey, TElement>(new Dictionary<TKey, Grouping<TKey, TElement>>());

		private readonly Dictionary<TKey, Grouping<TKey, TElement>> dict;

		public IEnumerable<TElement> this[TKey key]
		{
			get
			{
				if (!dict.TryGetValue(key, out var value))
				{
					return Enumerable.Empty<TElement>();
				}
				return value;
			}
		}

		private Lookup(Dictionary<TKey, Grouping<TKey, TElement>> dict)
		{
			this.dict = dict;
		}

		public static Lookup<TKey, TElement> CreateEmpty()
		{
			return empty;
		}

		public static Lookup<TKey, TElement> Create(ArraySegment<TElement> source, Func<TElement, TKey> keySelector, IEqualityComparer<TKey> comparer)
		{
			Dictionary<TKey, Grouping<TKey, TElement>> dictionary = new Dictionary<TKey, Grouping<TKey, TElement>>(comparer);
			TElement[] array = source.Array;
			int count = source.Count;
			for (int i = source.Offset; i < count; i++)
			{
				TKey key = keySelector(array[i]);
				if (!dictionary.TryGetValue(key, out var value))
				{
					value = (dictionary[key] = new Grouping<TKey, TElement>(key));
				}
				value.Add(array[i]);
			}
			return new Lookup<TKey, TElement>(dictionary);
		}

		public static Lookup<TKey, TElement> Create<TSource>(ArraySegment<TSource> source, Func<TSource, TKey> keySelector, Func<TSource, TElement> elementSelector, IEqualityComparer<TKey> comparer)
		{
			Dictionary<TKey, Grouping<TKey, TElement>> dictionary = new Dictionary<TKey, Grouping<TKey, TElement>>(comparer);
			TSource[] array = source.Array;
			int count = source.Count;
			for (int i = source.Offset; i < count; i++)
			{
				TKey key = keySelector(array[i]);
				TElement value = elementSelector(array[i]);
				if (!dictionary.TryGetValue(key, out var value2))
				{
					value2 = (dictionary[key] = new Grouping<TKey, TElement>(key));
				}
				value2.Add(value);
			}
			return new Lookup<TKey, TElement>(dictionary);
		}

		public static async UniTask<Lookup<TKey, TElement>> CreateAsync(ArraySegment<TElement> source, Func<TElement, UniTask<TKey>> keySelector, IEqualityComparer<TKey> comparer)
		{
			Dictionary<TKey, Grouping<TKey, TElement>> dict = new Dictionary<TKey, Grouping<TKey, TElement>>(comparer);
			TElement[] arr = source.Array;
			int c = source.Count;
			for (int i = source.Offset; i < c; i++)
			{
				TKey key = await keySelector(arr[i]);
				if (!dict.TryGetValue(key, out var value))
				{
					value = (dict[key] = new Grouping<TKey, TElement>(key));
				}
				value.Add(arr[i]);
			}
			return new Lookup<TKey, TElement>(dict);
		}

		public static async UniTask<Lookup<TKey, TElement>> CreateAsync<TSource>(ArraySegment<TSource> source, Func<TSource, UniTask<TKey>> keySelector, Func<TSource, UniTask<TElement>> elementSelector, IEqualityComparer<TKey> comparer)
		{
			Dictionary<TKey, Grouping<TKey, TElement>> dict = new Dictionary<TKey, Grouping<TKey, TElement>>(comparer);
			TSource[] arr = source.Array;
			int c = source.Count;
			for (int i = source.Offset; i < c; i++)
			{
				TKey key = await keySelector(arr[i]);
				TElement value = await elementSelector(arr[i]);
				if (!dict.TryGetValue(key, out var value2))
				{
					value2 = (dict[key] = new Grouping<TKey, TElement>(key));
				}
				value2.Add(value);
			}
			return new Lookup<TKey, TElement>(dict);
		}

		public static async UniTask<Lookup<TKey, TElement>> CreateAsync(ArraySegment<TElement> source, Func<TElement, CancellationToken, UniTask<TKey>> keySelector, IEqualityComparer<TKey> comparer, CancellationToken cancellationToken)
		{
			Dictionary<TKey, Grouping<TKey, TElement>> dict = new Dictionary<TKey, Grouping<TKey, TElement>>(comparer);
			TElement[] arr = source.Array;
			int c = source.Count;
			for (int i = source.Offset; i < c; i++)
			{
				TKey key = await keySelector(arr[i], cancellationToken);
				if (!dict.TryGetValue(key, out var value))
				{
					value = (dict[key] = new Grouping<TKey, TElement>(key));
				}
				value.Add(arr[i]);
			}
			return new Lookup<TKey, TElement>(dict);
		}

		public static async UniTask<Lookup<TKey, TElement>> CreateAsync<TSource>(ArraySegment<TSource> source, Func<TSource, CancellationToken, UniTask<TKey>> keySelector, Func<TSource, CancellationToken, UniTask<TElement>> elementSelector, IEqualityComparer<TKey> comparer, CancellationToken cancellationToken)
		{
			Dictionary<TKey, Grouping<TKey, TElement>> dict = new Dictionary<TKey, Grouping<TKey, TElement>>(comparer);
			TSource[] arr = source.Array;
			int c = source.Count;
			for (int i = source.Offset; i < c; i++)
			{
				TKey key = await keySelector(arr[i], cancellationToken);
				TElement value = await elementSelector(arr[i], cancellationToken);
				if (!dict.TryGetValue(key, out var value2))
				{
					value2 = (dict[key] = new Grouping<TKey, TElement>(key));
				}
				value2.Add(value);
			}
			return new Lookup<TKey, TElement>(dict);
		}

		public IEnumerator<IGrouping<TKey, TElement>> GetEnumerator()
		{
			return dict.Values.GetEnumerator();
		}

		IEnumerator IEnumerable.GetEnumerator()
		{
			return dict.Values.GetEnumerator();
		}
	}

	private class Grouping<TKey, TElement> : IGrouping<TKey, TElement>, IEnumerable<TElement>, IEnumerable
	{
		private readonly List<TElement> elements;

		public TKey Key { get; private set; }

		public Grouping(TKey key)
		{
			Key = key;
			elements = new List<TElement>();
		}

		public void Add(TElement value)
		{
			elements.Add(value);
		}

		public IEnumerator<TElement> GetEnumerator()
		{
			return elements.GetEnumerator();
		}

		IEnumerator IEnumerable.GetEnumerator()
		{
			return elements.GetEnumerator();
		}

		public override string ToString()
		{
			return "Key: " + Key?.ToString() + ", Count: " + elements.Count;
		}
	}

	internal static async UniTask<ILookup<TKey, TSource>> ToLookupAsync<TSource, TKey>(IUniTaskAsyncEnumerable<TSource> source, Func<TSource, TKey> keySelector, IEqualityComparer<TKey> comparer, CancellationToken cancellationToken)
	{
		ArrayPool<TSource> pool = ArrayPool<TSource>.Shared;
		TSource[] array = pool.Rent(16);
		IUniTaskAsyncEnumerator<TSource> e = source.GetAsyncEnumerator(cancellationToken);
		ILookup<TKey, TSource> result;
		try
		{
			int i = 0;
			while (await e.MoveNextAsync())
			{
				ArrayPoolUtil.EnsureCapacity(ref array, i, pool);
				array[i++] = e.Current;
			}
			result = ((i != 0) ? Lookup<TKey, TSource>.Create(new ArraySegment<TSource>(array, 0, i), keySelector, comparer) : Lookup<TKey, TSource>.CreateEmpty());
		}
		finally
		{
			pool.Return(array, !RuntimeHelpersAbstraction.IsWellKnownNoReferenceContainsType<TSource>());
			if (e != null)
			{
				await e.DisposeAsync();
			}
		}
		return result;
	}

	internal static async UniTask<ILookup<TKey, TElement>> ToLookupAsync<TSource, TKey, TElement>(IUniTaskAsyncEnumerable<TSource> source, Func<TSource, TKey> keySelector, Func<TSource, TElement> elementSelector, IEqualityComparer<TKey> comparer, CancellationToken cancellationToken)
	{
		ArrayPool<TSource> pool = ArrayPool<TSource>.Shared;
		TSource[] array = pool.Rent(16);
		IUniTaskAsyncEnumerator<TSource> e = null;
		ILookup<TKey, TElement> result;
		try
		{
			e = source.GetAsyncEnumerator(cancellationToken);
			int i = 0;
			while (await e.MoveNextAsync())
			{
				ArrayPoolUtil.EnsureCapacity(ref array, i, pool);
				array[i++] = e.Current;
			}
			result = ((i != 0) ? Lookup<TKey, TElement>.Create(new ArraySegment<TSource>(array, 0, i), keySelector, elementSelector, comparer) : Lookup<TKey, TElement>.CreateEmpty());
		}
		finally
		{
			pool.Return(array, !RuntimeHelpersAbstraction.IsWellKnownNoReferenceContainsType<TSource>());
			if (e != null)
			{
				await e.DisposeAsync();
			}
		}
		return result;
	}

	internal static async UniTask<ILookup<TKey, TSource>> ToLookupAwaitAsync<TSource, TKey>(IUniTaskAsyncEnumerable<TSource> source, Func<TSource, UniTask<TKey>> keySelector, IEqualityComparer<TKey> comparer, CancellationToken cancellationToken)
	{
		ArrayPool<TSource> pool = ArrayPool<TSource>.Shared;
		TSource[] array = pool.Rent(16);
		IUniTaskAsyncEnumerator<TSource> e = null;
		ILookup<TKey, TSource> result;
		try
		{
			e = source.GetAsyncEnumerator(cancellationToken);
			int i = 0;
			while (await e.MoveNextAsync())
			{
				ArrayPoolUtil.EnsureCapacity(ref array, i, pool);
				array[i++] = e.Current;
			}
			result = ((i != 0) ? (await Lookup<TKey, TSource>.CreateAsync(new ArraySegment<TSource>(array, 0, i), keySelector, comparer)) : Lookup<TKey, TSource>.CreateEmpty());
		}
		finally
		{
			pool.Return(array, !RuntimeHelpersAbstraction.IsWellKnownNoReferenceContainsType<TSource>());
			if (e != null)
			{
				await e.DisposeAsync();
			}
		}
		return result;
	}

	internal static async UniTask<ILookup<TKey, TElement>> ToLookupAwaitAsync<TSource, TKey, TElement>(IUniTaskAsyncEnumerable<TSource> source, Func<TSource, UniTask<TKey>> keySelector, Func<TSource, UniTask<TElement>> elementSelector, IEqualityComparer<TKey> comparer, CancellationToken cancellationToken)
	{
		ArrayPool<TSource> pool = ArrayPool<TSource>.Shared;
		TSource[] array = pool.Rent(16);
		IUniTaskAsyncEnumerator<TSource> e = null;
		ILookup<TKey, TElement> result;
		try
		{
			e = source.GetAsyncEnumerator(cancellationToken);
			int i = 0;
			while (await e.MoveNextAsync())
			{
				ArrayPoolUtil.EnsureCapacity(ref array, i, pool);
				array[i++] = e.Current;
			}
			result = ((i != 0) ? (await Lookup<TKey, TElement>.CreateAsync(new ArraySegment<TSource>(array, 0, i), keySelector, elementSelector, comparer)) : Lookup<TKey, TElement>.CreateEmpty());
		}
		finally
		{
			pool.Return(array, !RuntimeHelpersAbstraction.IsWellKnownNoReferenceContainsType<TSource>());
			if (e != null)
			{
				await e.DisposeAsync();
			}
		}
		return result;
	}

	internal static async UniTask<ILookup<TKey, TSource>> ToLookupAwaitWithCancellationAsync<TSource, TKey>(IUniTaskAsyncEnumerable<TSource> source, Func<TSource, CancellationToken, UniTask<TKey>> keySelector, IEqualityComparer<TKey> comparer, CancellationToken cancellationToken)
	{
		ArrayPool<TSource> pool = ArrayPool<TSource>.Shared;
		TSource[] array = pool.Rent(16);
		IUniTaskAsyncEnumerator<TSource> e = null;
		ILookup<TKey, TSource> result;
		try
		{
			e = source.GetAsyncEnumerator(cancellationToken);
			int i = 0;
			while (await e.MoveNextAsync())
			{
				ArrayPoolUtil.EnsureCapacity(ref array, i, pool);
				array[i++] = e.Current;
			}
			result = ((i != 0) ? (await Lookup<TKey, TSource>.CreateAsync(new ArraySegment<TSource>(array, 0, i), keySelector, comparer, cancellationToken)) : Lookup<TKey, TSource>.CreateEmpty());
		}
		finally
		{
			pool.Return(array, !RuntimeHelpersAbstraction.IsWellKnownNoReferenceContainsType<TSource>());
			if (e != null)
			{
				await e.DisposeAsync();
			}
		}
		return result;
	}

	internal static async UniTask<ILookup<TKey, TElement>> ToLookupAwaitWithCancellationAsync<TSource, TKey, TElement>(IUniTaskAsyncEnumerable<TSource> source, Func<TSource, CancellationToken, UniTask<TKey>> keySelector, Func<TSource, CancellationToken, UniTask<TElement>> elementSelector, IEqualityComparer<TKey> comparer, CancellationToken cancellationToken)
	{
		ArrayPool<TSource> pool = ArrayPool<TSource>.Shared;
		TSource[] array = pool.Rent(16);
		IUniTaskAsyncEnumerator<TSource> e = null;
		ILookup<TKey, TElement> result;
		try
		{
			e = source.GetAsyncEnumerator(cancellationToken);
			int i = 0;
			while (await e.MoveNextAsync())
			{
				ArrayPoolUtil.EnsureCapacity(ref array, i, pool);
				array[i++] = e.Current;
			}
			result = ((i != 0) ? (await Lookup<TKey, TElement>.CreateAsync(new ArraySegment<TSource>(array, 0, i), keySelector, elementSelector, comparer, cancellationToken)) : Lookup<TKey, TElement>.CreateEmpty());
		}
		finally
		{
			pool.Return(array, !RuntimeHelpersAbstraction.IsWellKnownNoReferenceContainsType<TSource>());
			if (e != null)
			{
				await e.DisposeAsync();
			}
		}
		return result;
	}
}
