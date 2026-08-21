using System.Collections;
using System.Collections.Generic;
using System.Threading;

namespace System.Linq;

public static class Enumerable
{
	private abstract class Iterator<TSource> : IEnumerable<TSource>, IEnumerable, IEnumerator<TSource>, IDisposable, IEnumerator
	{
		private int threadId;

		internal int state;

		internal TSource current;

		public TSource Current => current;

		object IEnumerator.Current => Current;

		public Iterator()
		{
			threadId = Thread.CurrentThread.ManagedThreadId;
		}

		public abstract Iterator<TSource> Clone();

		public virtual void Dispose()
		{
			current = default(TSource);
			state = -1;
		}

		public IEnumerator<TSource> GetEnumerator()
		{
			if (threadId == Thread.CurrentThread.ManagedThreadId && state == 0)
			{
				state = 1;
				return this;
			}
			Iterator<TSource> iterator = Clone();
			iterator.state = 1;
			return iterator;
		}

		public abstract bool MoveNext();

		public abstract IEnumerable<TResult> Select<TResult>(Func<TSource, TResult> selector);

		public abstract IEnumerable<TSource> Where(Func<TSource, bool> predicate);

		IEnumerator IEnumerable.GetEnumerator()
		{
			return GetEnumerator();
		}

		void IEnumerator.Reset()
		{
			throw new NotImplementedException();
		}
	}

	private class WhereEnumerableIterator<TSource> : Iterator<TSource>
	{
		private IEnumerable<TSource> source;

		private Func<TSource, bool> predicate;

		private IEnumerator<TSource> enumerator;

		public WhereEnumerableIterator(IEnumerable<TSource> source, Func<TSource, bool> predicate)
		{
			this.source = source;
			this.predicate = predicate;
		}

		public override Iterator<TSource> Clone()
		{
			return new WhereEnumerableIterator<TSource>(source, predicate);
		}

		public override void Dispose()
		{
			if (enumerator != null)
			{
				enumerator.Dispose();
			}
			enumerator = null;
			base.Dispose();
		}

		public override bool MoveNext()
		{
			int num = state;
			if (num != 1)
			{
				if (num != 2)
				{
					goto IL_0061;
				}
			}
			else
			{
				enumerator = source.GetEnumerator();
				state = 2;
			}
			while (enumerator.MoveNext())
			{
				TSource arg = enumerator.Current;
				if (predicate(arg))
				{
					current = arg;
					return true;
				}
			}
			Dispose();
			goto IL_0061;
			IL_0061:
			return false;
		}

		public override IEnumerable<TResult> Select<TResult>(Func<TSource, TResult> selector)
		{
			return new WhereSelectEnumerableIterator<TSource, TResult>(source, predicate, selector);
		}

		public override IEnumerable<TSource> Where(Func<TSource, bool> predicate)
		{
			return new WhereEnumerableIterator<TSource>(source, CombinePredicates(this.predicate, predicate));
		}
	}

	private class WhereArrayIterator<TSource> : Iterator<TSource>
	{
		private TSource[] source;

		private Func<TSource, bool> predicate;

		private int index;

		public WhereArrayIterator(TSource[] source, Func<TSource, bool> predicate)
		{
			this.source = source;
			this.predicate = predicate;
		}

		public override Iterator<TSource> Clone()
		{
			return new WhereArrayIterator<TSource>(source, predicate);
		}

		public override bool MoveNext()
		{
			if (state == 1)
			{
				while (index < source.Length)
				{
					TSource arg = source[index];
					index++;
					if (predicate(arg))
					{
						current = arg;
						return true;
					}
				}
				Dispose();
			}
			return false;
		}

		public override IEnumerable<TResult> Select<TResult>(Func<TSource, TResult> selector)
		{
			return new WhereSelectArrayIterator<TSource, TResult>(source, predicate, selector);
		}

		public override IEnumerable<TSource> Where(Func<TSource, bool> predicate)
		{
			return new WhereArrayIterator<TSource>(source, CombinePredicates(this.predicate, predicate));
		}
	}

	private class WhereListIterator<TSource> : Iterator<TSource>
	{
		private List<TSource> source;

		private Func<TSource, bool> predicate;

		private List<TSource>.Enumerator enumerator;

		public WhereListIterator(List<TSource> source, Func<TSource, bool> predicate)
		{
			this.source = source;
			this.predicate = predicate;
		}

		public override Iterator<TSource> Clone()
		{
			return new WhereListIterator<TSource>(source, predicate);
		}

		public override bool MoveNext()
		{
			int num = state;
			if (num != 1)
			{
				if (num != 2)
				{
					goto IL_0061;
				}
			}
			else
			{
				enumerator = source.GetEnumerator();
				state = 2;
			}
			while (enumerator.MoveNext())
			{
				TSource arg = enumerator.Current;
				if (predicate(arg))
				{
					current = arg;
					return true;
				}
			}
			Dispose();
			goto IL_0061;
			IL_0061:
			return false;
		}

		public override IEnumerable<TResult> Select<TResult>(Func<TSource, TResult> selector)
		{
			return new WhereSelectListIterator<TSource, TResult>(source, predicate, selector);
		}

		public override IEnumerable<TSource> Where(Func<TSource, bool> predicate)
		{
			return new WhereListIterator<TSource>(source, CombinePredicates(this.predicate, predicate));
		}
	}

	private class WhereSelectEnumerableIterator<TSource, TResult> : Iterator<TResult>
	{
		private IEnumerable<TSource> source;

		private Func<TSource, bool> predicate;

		private Func<TSource, TResult> selector;

		private IEnumerator<TSource> enumerator;

		public WhereSelectEnumerableIterator(IEnumerable<TSource> source, Func<TSource, bool> predicate, Func<TSource, TResult> selector)
		{
			this.source = source;
			this.predicate = predicate;
			this.selector = selector;
		}

		public override Iterator<TResult> Clone()
		{
			return new WhereSelectEnumerableIterator<TSource, TResult>(source, predicate, selector);
		}

		public override void Dispose()
		{
			if (enumerator != null)
			{
				enumerator.Dispose();
			}
			enumerator = null;
			base.Dispose();
		}

		public override bool MoveNext()
		{
			int num = state;
			if (num != 1)
			{
				if (num != 2)
				{
					goto IL_0074;
				}
			}
			else
			{
				enumerator = source.GetEnumerator();
				state = 2;
			}
			while (enumerator.MoveNext())
			{
				TSource arg = enumerator.Current;
				if (predicate == null || predicate(arg))
				{
					current = selector(arg);
					return true;
				}
			}
			Dispose();
			goto IL_0074;
			IL_0074:
			return false;
		}

		public override IEnumerable<TResult2> Select<TResult2>(Func<TResult, TResult2> selector)
		{
			return new WhereSelectEnumerableIterator<TSource, TResult2>(source, predicate, CombineSelectors(this.selector, selector));
		}

		public override IEnumerable<TResult> Where(Func<TResult, bool> predicate)
		{
			return new WhereEnumerableIterator<TResult>(this, predicate);
		}
	}

	private class WhereSelectArrayIterator<TSource, TResult> : Iterator<TResult>
	{
		private TSource[] source;

		private Func<TSource, bool> predicate;

		private Func<TSource, TResult> selector;

		private int index;

		public WhereSelectArrayIterator(TSource[] source, Func<TSource, bool> predicate, Func<TSource, TResult> selector)
		{
			this.source = source;
			this.predicate = predicate;
			this.selector = selector;
		}

		public override Iterator<TResult> Clone()
		{
			return new WhereSelectArrayIterator<TSource, TResult>(source, predicate, selector);
		}

		public override bool MoveNext()
		{
			if (state == 1)
			{
				while (index < source.Length)
				{
					TSource arg = source[index];
					index++;
					if (predicate == null || predicate(arg))
					{
						current = selector(arg);
						return true;
					}
				}
				Dispose();
			}
			return false;
		}

		public override IEnumerable<TResult2> Select<TResult2>(Func<TResult, TResult2> selector)
		{
			return new WhereSelectArrayIterator<TSource, TResult2>(source, predicate, CombineSelectors(this.selector, selector));
		}

		public override IEnumerable<TResult> Where(Func<TResult, bool> predicate)
		{
			return new WhereEnumerableIterator<TResult>(this, predicate);
		}
	}

	private class WhereSelectListIterator<TSource, TResult> : Iterator<TResult>
	{
		private List<TSource> source;

		private Func<TSource, bool> predicate;

		private Func<TSource, TResult> selector;

		private List<TSource>.Enumerator enumerator;

		public WhereSelectListIterator(List<TSource> source, Func<TSource, bool> predicate, Func<TSource, TResult> selector)
		{
			this.source = source;
			this.predicate = predicate;
			this.selector = selector;
		}

		public override Iterator<TResult> Clone()
		{
			return new WhereSelectListIterator<TSource, TResult>(source, predicate, selector);
		}

		public override bool MoveNext()
		{
			int num = state;
			if (num != 1)
			{
				if (num != 2)
				{
					goto IL_0074;
				}
			}
			else
			{
				enumerator = source.GetEnumerator();
				state = 2;
			}
			while (enumerator.MoveNext())
			{
				TSource arg = enumerator.Current;
				if (predicate == null || predicate(arg))
				{
					current = selector(arg);
					return true;
				}
			}
			Dispose();
			goto IL_0074;
			IL_0074:
			return false;
		}

		public override IEnumerable<TResult2> Select<TResult2>(Func<TResult, TResult2> selector)
		{
			return new WhereSelectListIterator<TSource, TResult2>(source, predicate, CombineSelectors(this.selector, selector));
		}

		public override IEnumerable<TResult> Where(Func<TResult, bool> predicate)
		{
			return new WhereEnumerableIterator<TResult>(this, predicate);
		}
	}

	public static IEnumerable<TSource> Where<TSource>(this IEnumerable<TSource> source, Func<TSource, bool> predicate)
	{
		if (source == null)
		{
			throw Error.ArgumentNull("source");
		}
		if (predicate == null)
		{
			throw Error.ArgumentNull("predicate");
		}
		if (source is Iterator<TSource>)
		{
			return ((Iterator<TSource>)source).Where(predicate);
		}
		if (source is TSource[])
		{
			return new WhereArrayIterator<TSource>((TSource[])source, predicate);
		}
		if (source is List<TSource>)
		{
			return new WhereListIterator<TSource>((List<TSource>)source, predicate);
		}
		return new WhereEnumerableIterator<TSource>(source, predicate);
	}

	public static IEnumerable<TSource> Where<TSource>(this IEnumerable<TSource> source, Func<TSource, int, bool> predicate)
	{
		if (source == null)
		{
			throw Error.ArgumentNull("source");
		}
		if (predicate == null)
		{
			throw Error.ArgumentNull("predicate");
		}
		return WhereIterator(source, predicate);
	}

	private static IEnumerable<TSource> WhereIterator<TSource>(IEnumerable<TSource> source, Func<TSource, int, bool> predicate)
	{
		int index = -1;
		foreach (TSource item in source)
		{
			index = checked(index + 1);
			if (predicate(item, index))
			{
				yield return item;
			}
		}
	}

	public static IEnumerable<TResult> Select<TSource, TResult>(this IEnumerable<TSource> source, Func<TSource, TResult> selector)
	{
		if (source == null)
		{
			throw Error.ArgumentNull("source");
		}
		if (selector == null)
		{
			throw Error.ArgumentNull("selector");
		}
		if (source is Iterator<TSource>)
		{
			return ((Iterator<TSource>)source).Select(selector);
		}
		if (source is TSource[])
		{
			return new WhereSelectArrayIterator<TSource, TResult>((TSource[])source, null, selector);
		}
		if (source is List<TSource>)
		{
			return new WhereSelectListIterator<TSource, TResult>((List<TSource>)source, null, selector);
		}
		return new WhereSelectEnumerableIterator<TSource, TResult>(source, null, selector);
	}

	public static IEnumerable<TResult> Select<TSource, TResult>(this IEnumerable<TSource> source, Func<TSource, int, TResult> selector)
	{
		if (source == null)
		{
			throw Error.ArgumentNull("source");
		}
		if (selector == null)
		{
			throw Error.ArgumentNull("selector");
		}
		return SelectIterator(source, selector);
	}

	private static IEnumerable<TResult> SelectIterator<TSource, TResult>(IEnumerable<TSource> source, Func<TSource, int, TResult> selector)
	{
		int index = -1;
		foreach (TSource item in source)
		{
			index = checked(index + 1);
			yield return selector(item, index);
		}
	}

	private static Func<TSource, bool> CombinePredicates<TSource>(Func<TSource, bool> predicate1, Func<TSource, bool> predicate2)
	{
		return (TSource x) => predicate1(x) && predicate2(x);
	}

	private static Func<TSource, TResult> CombineSelectors<TSource, TMiddle, TResult>(Func<TSource, TMiddle> selector1, Func<TMiddle, TResult> selector2)
	{
		return (TSource x) => selector2(selector1(x));
	}

	public static IEnumerable<TResult> SelectMany<TSource, TResult>(this IEnumerable<TSource> source, Func<TSource, IEnumerable<TResult>> selector)
	{
		if (source == null)
		{
			throw Error.ArgumentNull("source");
		}
		if (selector == null)
		{
			throw Error.ArgumentNull("selector");
		}
		return SelectManyIterator(source, selector);
	}

	private static IEnumerable<TResult> SelectManyIterator<TSource, TResult>(IEnumerable<TSource> source, Func<TSource, IEnumerable<TResult>> selector)
	{
		foreach (TSource item in source)
		{
			foreach (TResult item2 in selector(item))
			{
				yield return item2;
			}
		}
	}

	public static IEnumerable<TResult> SelectMany<TSource, TResult>(this IEnumerable<TSource> source, Func<TSource, int, IEnumerable<TResult>> selector)
	{
		if (source == null)
		{
			throw Error.ArgumentNull("source");
		}
		if (selector == null)
		{
			throw Error.ArgumentNull("selector");
		}
		return SelectManyIterator(source, selector);
	}

	private static IEnumerable<TResult> SelectManyIterator<TSource, TResult>(IEnumerable<TSource> source, Func<TSource, int, IEnumerable<TResult>> selector)
	{
		int index = -1;
		foreach (TSource item in source)
		{
			index = checked(index + 1);
			foreach (TResult item2 in selector(item, index))
			{
				yield return item2;
			}
		}
	}

	public static IEnumerable<TResult> SelectMany<TSource, TCollection, TResult>(this IEnumerable<TSource> source, Func<TSource, int, IEnumerable<TCollection>> collectionSelector, Func<TSource, TCollection, TResult> resultSelector)
	{
		if (source == null)
		{
			throw Error.ArgumentNull("source");
		}
		if (collectionSelector == null)
		{
			throw Error.ArgumentNull("collectionSelector");
		}
		if (resultSelector == null)
		{
			throw Error.ArgumentNull("resultSelector");
		}
		return SelectManyIterator(source, collectionSelector, resultSelector);
	}

	private static IEnumerable<TResult> SelectManyIterator<TSource, TCollection, TResult>(IEnumerable<TSource> source, Func<TSource, int, IEnumerable<TCollection>> collectionSelector, Func<TSource, TCollection, TResult> resultSelector)
	{
		int index = -1;
		foreach (TSource element in source)
		{
			index = checked(index + 1);
			foreach (TCollection item in collectionSelector(element, index))
			{
				yield return resultSelector(element, item);
			}
		}
	}

	public static IEnumerable<TResult> SelectMany<TSource, TCollection, TResult>(this IEnumerable<TSource> source, Func<TSource, IEnumerable<TCollection>> collectionSelector, Func<TSource, TCollection, TResult> resultSelector)
	{
		if (source == null)
		{
			throw Error.ArgumentNull("source");
		}
		if (collectionSelector == null)
		{
			throw Error.ArgumentNull("collectionSelector");
		}
		if (resultSelector == null)
		{
			throw Error.ArgumentNull("resultSelector");
		}
		return SelectManyIterator(source, collectionSelector, resultSelector);
	}

	private static IEnumerable<TResult> SelectManyIterator<TSource, TCollection, TResult>(IEnumerable<TSource> source, Func<TSource, IEnumerable<TCollection>> collectionSelector, Func<TSource, TCollection, TResult> resultSelector)
	{
		foreach (TSource element in source)
		{
			foreach (TCollection item in collectionSelector(element))
			{
				yield return resultSelector(element, item);
			}
		}
	}

	public static IEnumerable<TSource> Take<TSource>(this IEnumerable<TSource> source, int count)
	{
		if (source == null)
		{
			throw Error.ArgumentNull("source");
		}
		return TakeIterator(source, count);
	}

	private static IEnumerable<TSource> TakeIterator<TSource>(IEnumerable<TSource> source, int count)
	{
		if (count <= 0)
		{
			yield break;
		}
		foreach (TSource item in source)
		{
			yield return item;
			int num = count - 1;
			count = num;
			if (num == 0)
			{
				break;
			}
		}
	}

	public static IEnumerable<TSource> TakeWhile<TSource>(this IEnumerable<TSource> source, Func<TSource, bool> predicate)
	{
		if (source == null)
		{
			throw Error.ArgumentNull("source");
		}
		if (predicate == null)
		{
			throw Error.ArgumentNull("predicate");
		}
		return TakeWhileIterator(source, predicate);
	}

	private static IEnumerable<TSource> TakeWhileIterator<TSource>(IEnumerable<TSource> source, Func<TSource, bool> predicate)
	{
		foreach (TSource item in source)
		{
			if (!predicate(item))
			{
				break;
			}
			yield return item;
		}
	}

	public static IEnumerable<TSource> TakeWhile<TSource>(this IEnumerable<TSource> source, Func<TSource, int, bool> predicate)
	{
		if (source == null)
		{
			throw Error.ArgumentNull("source");
		}
		if (predicate == null)
		{
			throw Error.ArgumentNull("predicate");
		}
		return TakeWhileIterator(source, predicate);
	}

	private static IEnumerable<TSource> TakeWhileIterator<TSource>(IEnumerable<TSource> source, Func<TSource, int, bool> predicate)
	{
		int index = -1;
		foreach (TSource item in source)
		{
			index = checked(index + 1);
			if (!predicate(item, index))
			{
				break;
			}
			yield return item;
		}
	}

	public static IEnumerable<TSource> Skip<TSource>(this IEnumerable<TSource> source, int count)
	{
		if (source == null)
		{
			throw Error.ArgumentNull("source");
		}
		return SkipIterator(source, count);
	}

	private static IEnumerable<TSource> SkipIterator<TSource>(IEnumerable<TSource> source, int count)
	{
		using IEnumerator<TSource> e = source.GetEnumerator();
		while (count > 0 && e.MoveNext())
		{
			count--;
		}
		if (count <= 0)
		{
			while (e.MoveNext())
			{
				yield return e.Current;
			}
		}
	}

	public static IEnumerable<TSource> SkipWhile<TSource>(this IEnumerable<TSource> source, Func<TSource, bool> predicate)
	{
		if (source == null)
		{
			throw Error.ArgumentNull("source");
		}
		if (predicate == null)
		{
			throw Error.ArgumentNull("predicate");
		}
		return SkipWhileIterator(source, predicate);
	}

	private static IEnumerable<TSource> SkipWhileIterator<TSource>(IEnumerable<TSource> source, Func<TSource, bool> predicate)
	{
		bool yielding = false;
		foreach (TSource item in source)
		{
			if (!yielding && !predicate(item))
			{
				yielding = true;
			}
			if (yielding)
			{
				yield return item;
			}
		}
	}

	public static IEnumerable<TSource> SkipWhile<TSource>(this IEnumerable<TSource> source, Func<TSource, int, bool> predicate)
	{
		if (source == null)
		{
			throw Error.ArgumentNull("source");
		}
		if (predicate == null)
		{
			throw Error.ArgumentNull("predicate");
		}
		return SkipWhileIterator(source, predicate);
	}

	private static IEnumerable<TSource> SkipWhileIterator<TSource>(IEnumerable<TSource> source, Func<TSource, int, bool> predicate)
	{
		int index = -1;
		bool yielding = false;
		foreach (TSource item in source)
		{
			index = checked(index + 1);
			if (!yielding && !predicate(item, index))
			{
				yielding = true;
			}
			if (yielding)
			{
				yield return item;
			}
		}
	}

	public static IEnumerable<TResult> Join<TOuter, TInner, TKey, TResult>(this IEnumerable<TOuter> outer, IEnumerable<TInner> inner, Func<TOuter, TKey> outerKeySelector, Func<TInner, TKey> innerKeySelector, Func<TOuter, TInner, TResult> resultSelector)
	{
		if (outer == null)
		{
			throw Error.ArgumentNull("outer");
		}
		if (inner == null)
		{
			throw Error.ArgumentNull("inner");
		}
		if (outerKeySelector == null)
		{
			throw Error.ArgumentNull("outerKeySelector");
		}
		if (innerKeySelector == null)
		{
			throw Error.ArgumentNull("innerKeySelector");
		}
		if (resultSelector == null)
		{
			throw Error.ArgumentNull("resultSelector");
		}
		return JoinIterator(outer, inner, outerKeySelector, innerKeySelector, resultSelector, null);
	}

	public static IEnumerable<TResult> Join<TOuter, TInner, TKey, TResult>(this IEnumerable<TOuter> outer, IEnumerable<TInner> inner, Func<TOuter, TKey> outerKeySelector, Func<TInner, TKey> innerKeySelector, Func<TOuter, TInner, TResult> resultSelector, IEqualityComparer<TKey> comparer)
	{
		if (outer == null)
		{
			throw Error.ArgumentNull("outer");
		}
		if (inner == null)
		{
			throw Error.ArgumentNull("inner");
		}
		if (outerKeySelector == null)
		{
			throw Error.ArgumentNull("outerKeySelector");
		}
		if (innerKeySelector == null)
		{
			throw Error.ArgumentNull("innerKeySelector");
		}
		if (resultSelector == null)
		{
			throw Error.ArgumentNull("resultSelector");
		}
		return JoinIterator(outer, inner, outerKeySelector, innerKeySelector, resultSelector, comparer);
	}

	private static IEnumerable<TResult> JoinIterator<TOuter, TInner, TKey, TResult>(IEnumerable<TOuter> outer, IEnumerable<TInner> inner, Func<TOuter, TKey> outerKeySelector, Func<TInner, TKey> innerKeySelector, Func<TOuter, TInner, TResult> resultSelector, IEqualityComparer<TKey> comparer)
	{
		Lookup<TKey, TInner> lookup = Lookup<TKey, TInner>.CreateForJoin(inner, innerKeySelector, comparer);
		foreach (TOuter item in outer)
		{
			Lookup<TKey, TInner>.Grouping g = lookup.GetGrouping(outerKeySelector(item), create: false);
			if (g != null)
			{
				for (int i = 0; i < g.count; i++)
				{
					yield return resultSelector(item, g.elements[i]);
				}
			}
		}
	}

	public static IEnumerable<TResult> GroupJoin<TOuter, TInner, TKey, TResult>(this IEnumerable<TOuter> outer, IEnumerable<TInner> inner, Func<TOuter, TKey> outerKeySelector, Func<TInner, TKey> innerKeySelector, Func<TOuter, IEnumerable<TInner>, TResult> resultSelector)
	{
		if (outer == null)
		{
			throw Error.ArgumentNull("outer");
		}
		if (inner == null)
		{
			throw Error.ArgumentNull("inner");
		}
		if (outerKeySelector == null)
		{
			throw Error.ArgumentNull("outerKeySelector");
		}
		if (innerKeySelector == null)
		{
			throw Error.ArgumentNull("innerKeySelector");
		}
		if (resultSelector == null)
		{
			throw Error.ArgumentNull("resultSelector");
		}
		return GroupJoinIterator(outer, inner, outerKeySelector, innerKeySelector, resultSelector, null);
	}

	public static IEnumerable<TResult> GroupJoin<TOuter, TInner, TKey, TResult>(this IEnumerable<TOuter> outer, IEnumerable<TInner> inner, Func<TOuter, TKey> outerKeySelector, Func<TInner, TKey> innerKeySelector, Func<TOuter, IEnumerable<TInner>, TResult> resultSelector, IEqualityComparer<TKey> comparer)
	{
		if (outer == null)
		{
			throw Error.ArgumentNull("outer");
		}
		if (inner == null)
		{
			throw Error.ArgumentNull("inner");
		}
		if (outerKeySelector == null)
		{
			throw Error.ArgumentNull("outerKeySelector");
		}
		if (innerKeySelector == null)
		{
			throw Error.ArgumentNull("innerKeySelector");
		}
		if (resultSelector == null)
		{
			throw Error.ArgumentNull("resultSelector");
		}
		return GroupJoinIterator(outer, inner, outerKeySelector, innerKeySelector, resultSelector, comparer);
	}

	private static IEnumerable<TResult> GroupJoinIterator<TOuter, TInner, TKey, TResult>(IEnumerable<TOuter> outer, IEnumerable<TInner> inner, Func<TOuter, TKey> outerKeySelector, Func<TInner, TKey> innerKeySelector, Func<TOuter, IEnumerable<TInner>, TResult> resultSelector, IEqualityComparer<TKey> comparer)
	{
		Lookup<TKey, TInner> lookup = Lookup<TKey, TInner>.CreateForJoin(inner, innerKeySelector, comparer);
		foreach (TOuter item in outer)
		{
			yield return resultSelector(item, lookup[outerKeySelector(item)]);
		}
	}

	public static IOrderedEnumerable<TSource> OrderBy<TSource, TKey>(this IEnumerable<TSource> source, Func<TSource, TKey> keySelector)
	{
		return new OrderedEnumerable<TSource, TKey>(source, keySelector, null, descending: false);
	}

	public static IOrderedEnumerable<TSource> OrderBy<TSource, TKey>(this IEnumerable<TSource> source, Func<TSource, TKey> keySelector, IComparer<TKey> comparer)
	{
		return new OrderedEnumerable<TSource, TKey>(source, keySelector, comparer, descending: false);
	}

	public static IOrderedEnumerable<TSource> OrderByDescending<TSource, TKey>(this IEnumerable<TSource> source, Func<TSource, TKey> keySelector)
	{
		return new OrderedEnumerable<TSource, TKey>(source, keySelector, null, descending: true);
	}

	public static IOrderedEnumerable<TSource> OrderByDescending<TSource, TKey>(this IEnumerable<TSource> source, Func<TSource, TKey> keySelector, IComparer<TKey> comparer)
	{
		return new OrderedEnumerable<TSource, TKey>(source, keySelector, comparer, descending: true);
	}

	public static IOrderedEnumerable<TSource> ThenBy<TSource, TKey>(this IOrderedEnumerable<TSource> source, Func<TSource, TKey> keySelector)
	{
		if (source == null)
		{
			throw Error.ArgumentNull("source");
		}
		return source.CreateOrderedEnumerable(keySelector, null, descending: false);
	}

	public static IOrderedEnumerable<TSource> ThenBy<TSource, TKey>(this IOrderedEnumerable<TSource> source, Func<TSource, TKey> keySelector, IComparer<TKey> comparer)
	{
		if (source == null)
		{
			throw Error.ArgumentNull("source");
		}
		return source.CreateOrderedEnumerable(keySelector, comparer, descending: false);
	}

	public static IOrderedEnumerable<TSource> ThenByDescending<TSource, TKey>(this IOrderedEnumerable<TSource> source, Func<TSource, TKey> keySelector)
	{
		if (source == null)
		{
			throw Error.ArgumentNull("source");
		}
		return source.CreateOrderedEnumerable(keySelector, null, descending: true);
	}

	public static IOrderedEnumerable<TSource> ThenByDescending<TSource, TKey>(this IOrderedEnumerable<TSource> source, Func<TSource, TKey> keySelector, IComparer<TKey> comparer)
	{
		if (source == null)
		{
			throw Error.ArgumentNull("source");
		}
		return source.CreateOrderedEnumerable(keySelector, comparer, descending: true);
	}

	public static IEnumerable<IGrouping<TKey, TSource>> GroupBy<TSource, TKey>(this IEnumerable<TSource> source, Func<TSource, TKey> keySelector)
	{
		return new GroupedEnumerable<TSource, TKey, TSource>(source, keySelector, IdentityFunction<TSource>.Instance, null);
	}

	public static IEnumerable<IGrouping<TKey, TSource>> GroupBy<TSource, TKey>(this IEnumerable<TSource> source, Func<TSource, TKey> keySelector, IEqualityComparer<TKey> comparer)
	{
		return new GroupedEnumerable<TSource, TKey, TSource>(source, keySelector, IdentityFunction<TSource>.Instance, comparer);
	}

	public static IEnumerable<IGrouping<TKey, TElement>> GroupBy<TSource, TKey, TElement>(this IEnumerable<TSource> source, Func<TSource, TKey> keySelector, Func<TSource, TElement> elementSelector)
	{
		return new GroupedEnumerable<TSource, TKey, TElement>(source, keySelector, elementSelector, null);
	}

	public static IEnumerable<IGrouping<TKey, TElement>> GroupBy<TSource, TKey, TElement>(this IEnumerable<TSource> source, Func<TSource, TKey> keySelector, Func<TSource, TElement> elementSelector, IEqualityComparer<TKey> comparer)
	{
		return new GroupedEnumerable<TSource, TKey, TElement>(source, keySelector, elementSelector, comparer);
	}

	public static IEnumerable<TResult> GroupBy<TSource, TKey, TResult>(this IEnumerable<TSource> source, Func<TSource, TKey> keySelector, Func<TKey, IEnumerable<TSource>, TResult> resultSelector)
	{
		return new GroupedEnumerable<TSource, TKey, TSource, TResult>(source, keySelector, IdentityFunction<TSource>.Instance, resultSelector, null);
	}

	public static IEnumerable<TResult> GroupBy<TSource, TKey, TElement, TResult>(this IEnumerable<TSource> source, Func<TSource, TKey> keySelector, Func<TSource, TElement> elementSelector, Func<TKey, IEnumerable<TElement>, TResult> resultSelector)
	{
		return new GroupedEnumerable<TSource, TKey, TElement, TResult>(source, keySelector, elementSelector, resultSelector, null);
	}

	public static IEnumerable<TResult> GroupBy<TSource, TKey, TResult>(this IEnumerable<TSource> source, Func<TSource, TKey> keySelector, Func<TKey, IEnumerable<TSource>, TResult> resultSelector, IEqualityComparer<TKey> comparer)
	{
		return new GroupedEnumerable<TSource, TKey, TSource, TResult>(source, keySelector, IdentityFunction<TSource>.Instance, resultSelector, comparer);
	}

	public static IEnumerable<TResult> GroupBy<TSource, TKey, TElement, TResult>(this IEnumerable<TSource> source, Func<TSource, TKey> keySelector, Func<TSource, TElement> elementSelector, Func<TKey, IEnumerable<TElement>, TResult> resultSelector, IEqualityComparer<TKey> comparer)
	{
		return new GroupedEnumerable<TSource, TKey, TElement, TResult>(source, keySelector, elementSelector, resultSelector, comparer);
	}

	public static IEnumerable<TSource> Concat<TSource>(this IEnumerable<TSource> first, IEnumerable<TSource> second)
	{
		if (first == null)
		{
			throw Error.ArgumentNull("first");
		}
		if (second == null)
		{
			throw Error.ArgumentNull("second");
		}
		return ConcatIterator(first, second);
	}

	private static IEnumerable<TSource> ConcatIterator<TSource>(IEnumerable<TSource> first, IEnumerable<TSource> second)
	{
		foreach (TSource item in first)
		{
			yield return item;
		}
		foreach (TSource item2 in second)
		{
			yield return item2;
		}
	}

	public static IEnumerable<TSource> Append<TSource>(this IEnumerable<TSource> source, TSource element)
	{
		if (source == null)
		{
			throw Error.ArgumentNull("source");
		}
		return AppendIterator(source, element);
	}

	private static IEnumerable<TSource> AppendIterator<TSource>(IEnumerable<TSource> source, TSource element)
	{
		foreach (TSource item in source)
		{
			yield return item;
		}
		yield return element;
	}

	public static IEnumerable<TSource> Prepend<TSource>(this IEnumerable<TSource> source, TSource element)
	{
		if (source == null)
		{
			throw Error.ArgumentNull("source");
		}
		return PrependIterator(source, element);
	}

	private static IEnumerable<TSource> PrependIterator<TSource>(IEnumerable<TSource> source, TSource element)
	{
		yield return element;
		foreach (TSource item in source)
		{
			yield return item;
		}
	}

	public static IEnumerable<TResult> Zip<TFirst, TSecond, TResult>(this IEnumerable<TFirst> first, IEnumerable<TSecond> second, Func<TFirst, TSecond, TResult> resultSelector)
	{
		if (first == null)
		{
			throw Error.ArgumentNull("first");
		}
		if (second == null)
		{
			throw Error.ArgumentNull("second");
		}
		if (resultSelector == null)
		{
			throw Error.ArgumentNull("resultSelector");
		}
		return ZipIterator(first, second, resultSelector);
	}

	private static IEnumerable<TResult> ZipIterator<TFirst, TSecond, TResult>(IEnumerable<TFirst> first, IEnumerable<TSecond> second, Func<TFirst, TSecond, TResult> resultSelector)
	{
		using IEnumerator<TFirst> e1 = first.GetEnumerator();
		using IEnumerator<TSecond> e2 = second.GetEnumerator();
		while (e1.MoveNext() && e2.MoveNext())
		{
			yield return resultSelector(e1.Current, e2.Current);
		}
	}

	public static IEnumerable<TSource> Distinct<TSource>(this IEnumerable<TSource> source)
	{
		if (source == null)
		{
			throw Error.ArgumentNull("source");
		}
		return DistinctIterator(source, null);
	}

	public static IEnumerable<TSource> Distinct<TSource>(this IEnumerable<TSource> source, IEqualityComparer<TSource> comparer)
	{
		if (source == null)
		{
			throw Error.ArgumentNull("source");
		}
		return DistinctIterator(source, comparer);
	}

	private static IEnumerable<TSource> DistinctIterator<TSource>(IEnumerable<TSource> source, IEqualityComparer<TSource> comparer)
	{
		Set<TSource> set = new Set<TSource>(comparer);
		foreach (TSource item in source)
		{
			if (set.Add(item))
			{
				yield return item;
			}
		}
	}

	public static IEnumerable<TSource> Union<TSource>(this IEnumerable<TSource> first, IEnumerable<TSource> second)
	{
		if (first == null)
		{
			throw Error.ArgumentNull("first");
		}
		if (second == null)
		{
			throw Error.ArgumentNull("second");
		}
		return UnionIterator(first, second, null);
	}

	public static IEnumerable<TSource> Union<TSource>(this IEnumerable<TSource> first, IEnumerable<TSource> second, IEqualityComparer<TSource> comparer)
	{
		if (first == null)
		{
			throw Error.ArgumentNull("first");
		}
		if (second == null)
		{
			throw Error.ArgumentNull("second");
		}
		return UnionIterator(first, second, comparer);
	}

	private static IEnumerable<TSource> UnionIterator<TSource>(IEnumerable<TSource> first, IEnumerable<TSource> second, IEqualityComparer<TSource> comparer)
	{
		Set<TSource> set = new Set<TSource>(comparer);
		foreach (TSource item in first)
		{
			if (set.Add(item))
			{
				yield return item;
			}
		}
		foreach (TSource item2 in second)
		{
			if (set.Add(item2))
			{
				yield return item2;
			}
		}
	}

	public static IEnumerable<TSource> Intersect<TSource>(this IEnumerable<TSource> first, IEnumerable<TSource> second)
	{
		if (first == null)
		{
			throw Error.ArgumentNull("first");
		}
		if (second == null)
		{
			throw Error.ArgumentNull("second");
		}
		return IntersectIterator(first, second, null);
	}

	public static IEnumerable<TSource> Intersect<TSource>(this IEnumerable<TSource> first, IEnumerable<TSource> second, IEqualityComparer<TSource> comparer)
	{
		if (first == null)
		{
			throw Error.ArgumentNull("first");
		}
		if (second == null)
		{
			throw Error.ArgumentNull("second");
		}
		return IntersectIterator(first, second, comparer);
	}

	private static IEnumerable<TSource> IntersectIterator<TSource>(IEnumerable<TSource> first, IEnumerable<TSource> second, IEqualityComparer<TSource> comparer)
	{
		Set<TSource> set = new Set<TSource>(comparer);
		foreach (TSource item in second)
		{
			set.Add(item);
		}
		foreach (TSource item2 in first)
		{
			if (set.Remove(item2))
			{
				yield return item2;
			}
		}
	}

	public static IEnumerable<TSource> Except<TSource>(this IEnumerable<TSource> first, IEnumerable<TSource> second)
	{
		if (first == null)
		{
			throw Error.ArgumentNull("first");
		}
		if (second == null)
		{
			throw Error.ArgumentNull("second");
		}
		return ExceptIterator(first, second, null);
	}

	public static IEnumerable<TSource> Except<TSource>(this IEnumerable<TSource> first, IEnumerable<TSource> second, IEqualityComparer<TSource> comparer)
	{
		if (first == null)
		{
			throw Error.ArgumentNull("first");
		}
		if (second == null)
		{
			throw Error.ArgumentNull("second");
		}
		return ExceptIterator(first, second, comparer);
	}

	private static IEnumerable<TSource> ExceptIterator<TSource>(IEnumerable<TSource> first, IEnumerable<TSource> second, IEqualityComparer<TSource> comparer)
	{
		Set<TSource> set = new Set<TSource>(comparer);
		foreach (TSource item in second)
		{
			set.Add(item);
		}
		foreach (TSource item2 in first)
		{
			if (set.Add(item2))
			{
				yield return item2;
			}
		}
	}

	public static IEnumerable<TSource> Reverse<TSource>(this IEnumerable<TSource> source)
	{
		if (source == null)
		{
			throw Error.ArgumentNull("source");
		}
		return ReverseIterator(source);
	}

	private static IEnumerable<TSource> ReverseIterator<TSource>(IEnumerable<TSource> source)
	{
		Buffer<TSource> buffer = new Buffer<TSource>(source);
		for (int i = buffer.count - 1; i >= 0; i--)
		{
			yield return buffer.items[i];
		}
	}

	public static bool SequenceEqual<TSource>(this IEnumerable<TSource> first, IEnumerable<TSource> second)
	{
		return first.SequenceEqual(second, null);
	}

	public static bool SequenceEqual<TSource>(this IEnumerable<TSource> first, IEnumerable<TSource> second, IEqualityComparer<TSource> comparer)
	{
		if (comparer == null)
		{
			comparer = EqualityComparer<TSource>.Default;
		}
		if (first == null)
		{
			throw Error.ArgumentNull("first");
		}
		if (second == null)
		{
			throw Error.ArgumentNull("second");
		}
		using (IEnumerator<TSource> enumerator = first.GetEnumerator())
		{
			using IEnumerator<TSource> enumerator2 = second.GetEnumerator();
			while (enumerator.MoveNext())
			{
				if (!enumerator2.MoveNext() || !comparer.Equals(enumerator.Current, enumerator2.Current))
				{
					return false;
				}
			}
			if (enumerator2.MoveNext())
			{
				return false;
			}
		}
		return true;
	}

	public static IEnumerable<TSource> AsEnumerable<TSource>(this IEnumerable<TSource> source)
	{
		return source;
	}

	public static TSource[] ToArray<TSource>(this IEnumerable<TSource> source)
	{
		if (source == null)
		{
			throw Error.ArgumentNull("source");
		}
		return new Buffer<TSource>(source).ToArray();
	}

	public static List<TSource> ToList<TSource>(this IEnumerable<TSource> source)
	{
		if (source == null)
		{
			throw Error.ArgumentNull("source");
		}
		return new List<TSource>(source);
	}

	public static Dictionary<TKey, TSource> ToDictionary<TSource, TKey>(this IEnumerable<TSource> source, Func<TSource, TKey> keySelector)
	{
		return source.ToDictionary(keySelector, IdentityFunction<TSource>.Instance, null);
	}

	public static Dictionary<TKey, TSource> ToDictionary<TSource, TKey>(this IEnumerable<TSource> source, Func<TSource, TKey> keySelector, IEqualityComparer<TKey> comparer)
	{
		return source.ToDictionary(keySelector, IdentityFunction<TSource>.Instance, comparer);
	}

	public static Dictionary<TKey, TElement> ToDictionary<TSource, TKey, TElement>(this IEnumerable<TSource> source, Func<TSource, TKey> keySelector, Func<TSource, TElement> elementSelector)
	{
		return source.ToDictionary(keySelector, elementSelector, null);
	}

	public static Dictionary<TKey, TElement> ToDictionary<TSource, TKey, TElement>(this IEnumerable<TSource> source, Func<TSource, TKey> keySelector, Func<TSource, TElement> elementSelector, IEqualityComparer<TKey> comparer)
	{
		if (source == null)
		{
			throw Error.ArgumentNull("source");
		}
		if (keySelector == null)
		{
			throw Error.ArgumentNull("keySelector");
		}
		if (elementSelector == null)
		{
			throw Error.ArgumentNull("elementSelector");
		}
		Dictionary<TKey, TElement> dictionary = new Dictionary<TKey, TElement>(comparer);
		foreach (TSource item in source)
		{
			dictionary.Add(keySelector(item), elementSelector(item));
		}
		return dictionary;
	}

	public static ILookup<TKey, TSource> ToLookup<TSource, TKey>(this IEnumerable<TSource> source, Func<TSource, TKey> keySelector)
	{
		return Lookup<TKey, TSource>.Create(source, keySelector, IdentityFunction<TSource>.Instance, null);
	}

	public static ILookup<TKey, TSource> ToLookup<TSource, TKey>(this IEnumerable<TSource> source, Func<TSource, TKey> keySelector, IEqualityComparer<TKey> comparer)
	{
		return Lookup<TKey, TSource>.Create(source, keySelector, IdentityFunction<TSource>.Instance, comparer);
	}

	public static ILookup<TKey, TElement> ToLookup<TSource, TKey, TElement>(this IEnumerable<TSource> source, Func<TSource, TKey> keySelector, Func<TSource, TElement> elementSelector)
	{
		return Lookup<TKey, TElement>.Create(source, keySelector, elementSelector, null);
	}

	public static ILookup<TKey, TElement> ToLookup<TSource, TKey, TElement>(this IEnumerable<TSource> source, Func<TSource, TKey> keySelector, Func<TSource, TElement> elementSelector, IEqualityComparer<TKey> comparer)
	{
		return Lookup<TKey, TElement>.Create(source, keySelector, elementSelector, comparer);
	}

	public static IEnumerable<TSource> DefaultIfEmpty<TSource>(this IEnumerable<TSource> source)
	{
		return source.DefaultIfEmpty(default(TSource));
	}

	public static IEnumerable<TSource> DefaultIfEmpty<TSource>(this IEnumerable<TSource> source, TSource defaultValue)
	{
		if (source == null)
		{
			throw Error.ArgumentNull("source");
		}
		return DefaultIfEmptyIterator(source, defaultValue);
	}

	private static IEnumerable<TSource> DefaultIfEmptyIterator<TSource>(IEnumerable<TSource> source, TSource defaultValue)
	{
		using IEnumerator<TSource> e = source.GetEnumerator();
		if (e.MoveNext())
		{
			do
			{
				yield return e.Current;
			}
			while (e.MoveNext());
		}
		else
		{
			yield return defaultValue;
		}
	}

	public static IEnumerable<TResult> OfType<TResult>(this IEnumerable source)
	{
		if (source == null)
		{
			throw Error.ArgumentNull("source");
		}
		return OfTypeIterator<TResult>(source);
	}

	private static IEnumerable<TResult> OfTypeIterator<TResult>(IEnumerable source)
	{
		foreach (object item in source)
		{
			if (item is TResult)
			{
				yield return (TResult)item;
			}
		}
	}

	public static IEnumerable<TResult> Cast<TResult>(this IEnumerable source)
	{
		if (source is IEnumerable<TResult> result)
		{
			return result;
		}
		if (source == null)
		{
			throw Error.ArgumentNull("source");
		}
		return CastIterator<TResult>(source);
	}

	private static IEnumerable<TResult> CastIterator<TResult>(IEnumerable source)
	{
		foreach (object item in source)
		{
			yield return (TResult)item;
		}
	}

	public static TSource First<TSource>(this IEnumerable<TSource> source)
	{
		if (source == null)
		{
			throw Error.ArgumentNull("source");
		}
		if (source is IList<TSource> list)
		{
			if (list.Count > 0)
			{
				return list[0];
			}
		}
		else
		{
			using IEnumerator<TSource> enumerator = source.GetEnumerator();
			if (enumerator.MoveNext())
			{
				return enumerator.Current;
			}
		}
		throw Error.NoElements();
	}

	public static TSource First<TSource>(this IEnumerable<TSource> source, Func<TSource, bool> predicate)
	{
		if (source == null)
		{
			throw Error.ArgumentNull("source");
		}
		if (predicate == null)
		{
			throw Error.ArgumentNull("predicate");
		}
		foreach (TSource item in source)
		{
			if (predicate(item))
			{
				return item;
			}
		}
		throw Error.NoMatch();
	}

	public static TSource FirstOrDefault<TSource>(this IEnumerable<TSource> source)
	{
		if (source == null)
		{
			throw Error.ArgumentNull("source");
		}
		if (source is IList<TSource> list)
		{
			if (list.Count > 0)
			{
				return list[0];
			}
		}
		else
		{
			using IEnumerator<TSource> enumerator = source.GetEnumerator();
			if (enumerator.MoveNext())
			{
				return enumerator.Current;
			}
		}
		return default(TSource);
	}

	public static TSource FirstOrDefault<TSource>(this IEnumerable<TSource> source, Func<TSource, bool> predicate)
	{
		if (source == null)
		{
			throw Error.ArgumentNull("source");
		}
		if (predicate == null)
		{
			throw Error.ArgumentNull("predicate");
		}
		foreach (TSource item in source)
		{
			if (predicate(item))
			{
				return item;
			}
		}
		return default(TSource);
	}

	public static TSource Last<TSource>(this IEnumerable<TSource> source)
	{
		if (source == null)
		{
			throw Error.ArgumentNull("source");
		}
		if (source is IList<TSource> { Count: var count } list)
		{
			if (count > 0)
			{
				return list[count - 1];
			}
		}
		else
		{
			using IEnumerator<TSource> enumerator = source.GetEnumerator();
			if (enumerator.MoveNext())
			{
				TSource current;
				do
				{
					current = enumerator.Current;
				}
				while (enumerator.MoveNext());
				return current;
			}
		}
		throw Error.NoElements();
	}

	public static TSource Last<TSource>(this IEnumerable<TSource> source, Func<TSource, bool> predicate)
	{
		if (source == null)
		{
			throw Error.ArgumentNull("source");
		}
		if (predicate == null)
		{
			throw Error.ArgumentNull("predicate");
		}
		TSource result = default(TSource);
		bool flag = false;
		foreach (TSource item in source)
		{
			if (predicate(item))
			{
				result = item;
				flag = true;
			}
		}
		if (flag)
		{
			return result;
		}
		throw Error.NoMatch();
	}

	public static TSource LastOrDefault<TSource>(this IEnumerable<TSource> source)
	{
		if (source == null)
		{
			throw Error.ArgumentNull("source");
		}
		if (source is IList<TSource> { Count: var count } list)
		{
			if (count > 0)
			{
				return list[count - 1];
			}
		}
		else
		{
			using IEnumerator<TSource> enumerator = source.GetEnumerator();
			if (enumerator.MoveNext())
			{
				TSource current;
				do
				{
					current = enumerator.Current;
				}
				while (enumerator.MoveNext());
				return current;
			}
		}
		return default(TSource);
	}

	public static TSource LastOrDefault<TSource>(this IEnumerable<TSource> source, Func<TSource, bool> predicate)
	{
		if (source == null)
		{
			throw Error.ArgumentNull("source");
		}
		if (predicate == null)
		{
			throw Error.ArgumentNull("predicate");
		}
		TSource result = default(TSource);
		foreach (TSource item in source)
		{
			if (predicate(item))
			{
				result = item;
			}
		}
		return result;
	}

	public static TSource Single<TSource>(this IEnumerable<TSource> source)
	{
		if (source == null)
		{
			throw Error.ArgumentNull("source");
		}
		if (source is IList<TSource> { Count: var count } list)
		{
			switch (count)
			{
			case 0:
				throw Error.NoElements();
			case 1:
				return list[0];
			}
		}
		else
		{
			using IEnumerator<TSource> enumerator = source.GetEnumerator();
			if (!enumerator.MoveNext())
			{
				throw Error.NoElements();
			}
			TSource current = enumerator.Current;
			if (!enumerator.MoveNext())
			{
				return current;
			}
		}
		throw Error.MoreThanOneElement();
	}

	public static TSource Single<TSource>(this IEnumerable<TSource> source, Func<TSource, bool> predicate)
	{
		if (source == null)
		{
			throw Error.ArgumentNull("source");
		}
		if (predicate == null)
		{
			throw Error.ArgumentNull("predicate");
		}
		TSource val = default(TSource);
		long num = 0L;
		foreach (TSource item in source)
		{
			if (predicate(item))
			{
				val = item;
				num = checked(num + 1);
			}
		}
		return num switch
		{
			0L => throw Error.NoMatch(), 
			1L => val, 
			_ => throw Error.MoreThanOneMatch(), 
		};
	}

	public static TSource SingleOrDefault<TSource>(this IEnumerable<TSource> source)
	{
		if (source == null)
		{
			throw Error.ArgumentNull("source");
		}
		if (source is IList<TSource> { Count: var count } list)
		{
			switch (count)
			{
			case 0:
				return default(TSource);
			case 1:
				return list[0];
			}
		}
		else
		{
			using IEnumerator<TSource> enumerator = source.GetEnumerator();
			if (!enumerator.MoveNext())
			{
				return default(TSource);
			}
			TSource current = enumerator.Current;
			if (!enumerator.MoveNext())
			{
				return current;
			}
		}
		throw Error.MoreThanOneElement();
	}

	public static TSource SingleOrDefault<TSource>(this IEnumerable<TSource> source, Func<TSource, bool> predicate)
	{
		if (source == null)
		{
			throw Error.ArgumentNull("source");
		}
		if (predicate == null)
		{
			throw Error.ArgumentNull("predicate");
		}
		TSource val = default(TSource);
		long num = 0L;
		foreach (TSource item in source)
		{
			if (predicate(item))
			{
				val = item;
				num = checked(num + 1);
			}
		}
		return num switch
		{
			0L => default(TSource), 
			1L => val, 
			_ => throw Error.MoreThanOneMatch(), 
		};
	}

	public static TSource ElementAt<TSource>(this IEnumerable<TSource> source, int index)
	{
		if (source == null)
		{
			throw Error.ArgumentNull("source");
		}
		if (source is IList<TSource> list)
		{
			return list[index];
		}
		if (index < 0)
		{
			throw Error.ArgumentOutOfRange("index");
		}
		using IEnumerator<TSource> enumerator = source.GetEnumerator();
		while (enumerator.MoveNext())
		{
			if (index == 0)
			{
				return enumerator.Current;
			}
			index--;
		}
		throw Error.ArgumentOutOfRange("index");
	}

	public static TSource ElementAtOrDefault<TSource>(this IEnumerable<TSource> source, int index)
	{
		if (source == null)
		{
			throw Error.ArgumentNull("source");
		}
		if (index >= 0)
		{
			if (source is IList<TSource> list)
			{
				if (index < list.Count)
				{
					return list[index];
				}
			}
			else
			{
				using IEnumerator<TSource> enumerator = source.GetEnumerator();
				while (enumerator.MoveNext())
				{
					if (index == 0)
					{
						return enumerator.Current;
					}
					index--;
				}
			}
		}
		return default(TSource);
	}

	public static IEnumerable<int> Range(int start, int count)
	{
		long num = (long)start + (long)count - 1;
		if (count < 0 || num > int.MaxValue)
		{
			throw Error.ArgumentOutOfRange("count");
		}
		return RangeIterator(start, count);
	}

	private static IEnumerable<int> RangeIterator(int start, int count)
	{
		for (int i = 0; i < count; i++)
		{
			yield return start + i;
		}
	}

	public static IEnumerable<TResult> Repeat<TResult>(TResult element, int count)
	{
		if (count < 0)
		{
			throw Error.ArgumentOutOfRange("count");
		}
		return RepeatIterator(element, count);
	}

	private static IEnumerable<TResult> RepeatIterator<TResult>(TResult element, int count)
	{
		for (int i = 0; i < count; i++)
		{
			yield return element;
		}
	}

	public static IEnumerable<TResult> Empty<TResult>()
	{
		return EmptyEnumerable<TResult>.Instance;
	}

	public static bool Any<TSource>(this IEnumerable<TSource> source)
	{
		if (source == null)
		{
			throw Error.ArgumentNull("source");
		}
		using (IEnumerator<TSource> enumerator = source.GetEnumerator())
		{
			if (enumerator.MoveNext())
			{
				return true;
			}
		}
		return false;
	}

	public static bool Any<TSource>(this IEnumerable<TSource> source, Func<TSource, bool> predicate)
	{
		if (source == null)
		{
			throw Error.ArgumentNull("source");
		}
		if (predicate == null)
		{
			throw Error.ArgumentNull("predicate");
		}
		foreach (TSource item in source)
		{
			if (predicate(item))
			{
				return true;
			}
		}
		return false;
	}

	public static bool All<TSource>(this IEnumerable<TSource> source, Func<TSource, bool> predicate)
	{
		if (source == null)
		{
			throw Error.ArgumentNull("source");
		}
		if (predicate == null)
		{
			throw Error.ArgumentNull("predicate");
		}
		foreach (TSource item in source)
		{
			if (!predicate(item))
			{
				return false;
			}
		}
		return true;
	}

	public static int Count<TSource>(this IEnumerable<TSource> source)
	{
		if (source == null)
		{
			throw Error.ArgumentNull("source");
		}
		if (source is ICollection<TSource> collection)
		{
			return collection.Count;
		}
		if (source is ICollection collection2)
		{
			return collection2.Count;
		}
		int num = 0;
		using IEnumerator<TSource> enumerator = source.GetEnumerator();
		while (enumerator.MoveNext())
		{
			num = checked(num + 1);
		}
		return num;
	}

	public static int Count<TSource>(this IEnumerable<TSource> source, Func<TSource, bool> predicate)
	{
		if (source == null)
		{
			throw Error.ArgumentNull("source");
		}
		if (predicate == null)
		{
			throw Error.ArgumentNull("predicate");
		}
		int num = 0;
		foreach (TSource item in source)
		{
			if (predicate(item))
			{
				num = checked(num + 1);
			}
		}
		return num;
	}

	public static long LongCount<TSource>(this IEnumerable<TSource> source)
	{
		if (source == null)
		{
			throw Error.ArgumentNull("source");
		}
		long num = 0L;
		using IEnumerator<TSource> enumerator = source.GetEnumerator();
		while (enumerator.MoveNext())
		{
			num = checked(num + 1);
		}
		return num;
	}

	public static long LongCount<TSource>(this IEnumerable<TSource> source, Func<TSource, bool> predicate)
	{
		if (source == null)
		{
			throw Error.ArgumentNull("source");
		}
		if (predicate == null)
		{
			throw Error.ArgumentNull("predicate");
		}
		long num = 0L;
		foreach (TSource item in source)
		{
			if (predicate(item))
			{
				num = checked(num + 1);
			}
		}
		return num;
	}

	public static bool Contains<TSource>(this IEnumerable<TSource> source, TSource value)
	{
		if (source is ICollection<TSource> collection)
		{
			return collection.Contains(value);
		}
		return source.Contains(value, null);
	}

	public static bool Contains<TSource>(this IEnumerable<TSource> source, TSource value, IEqualityComparer<TSource> comparer)
	{
		if (comparer == null)
		{
			comparer = EqualityComparer<TSource>.Default;
		}
		if (source == null)
		{
			throw Error.ArgumentNull("source");
		}
		foreach (TSource item in source)
		{
			if (comparer.Equals(item, value))
			{
				return true;
			}
		}
		return false;
	}

	public static TSource Aggregate<TSource>(this IEnumerable<TSource> source, Func<TSource, TSource, TSource> func)
	{
		if (source == null)
		{
			throw Error.ArgumentNull("source");
		}
		if (func == null)
		{
			throw Error.ArgumentNull("func");
		}
		using IEnumerator<TSource> enumerator = source.GetEnumerator();
		if (!enumerator.MoveNext())
		{
			throw Error.NoElements();
		}
		TSource val = enumerator.Current;
		while (enumerator.MoveNext())
		{
			val = func(val, enumerator.Current);
		}
		return val;
	}

	public static TAccumulate Aggregate<TSource, TAccumulate>(this IEnumerable<TSource> source, TAccumulate seed, Func<TAccumulate, TSource, TAccumulate> func)
	{
		if (source == null)
		{
			throw Error.ArgumentNull("source");
		}
		if (func == null)
		{
			throw Error.ArgumentNull("func");
		}
		TAccumulate val = seed;
		foreach (TSource item in source)
		{
			val = func(val, item);
		}
		return val;
	}

	public static TResult Aggregate<TSource, TAccumulate, TResult>(this IEnumerable<TSource> source, TAccumulate seed, Func<TAccumulate, TSource, TAccumulate> func, Func<TAccumulate, TResult> resultSelector)
	{
		if (source == null)
		{
			throw Error.ArgumentNull("source");
		}
		if (func == null)
		{
			throw Error.ArgumentNull("func");
		}
		if (resultSelector == null)
		{
			throw Error.ArgumentNull("resultSelector");
		}
		TAccumulate val = seed;
		foreach (TSource item in source)
		{
			val = func(val, item);
		}
		return resultSelector(val);
	}

	public static int Sum(this IEnumerable<int> source)
	{
		if (source == null)
		{
			throw Error.ArgumentNull("source");
		}
		int num = 0;
		foreach (int item in source)
		{
			num = checked(num + item);
		}
		return num;
	}

	public static int? Sum(this IEnumerable<int?> source)
	{
		if (source == null)
		{
			throw Error.ArgumentNull("source");
		}
		int num = 0;
		foreach (int? item in source)
		{
			if (item.HasValue)
			{
				num = checked(num + item.GetValueOrDefault());
			}
		}
		return num;
	}

	public static long Sum(this IEnumerable<long> source)
	{
		if (source == null)
		{
			throw Error.ArgumentNull("source");
		}
		long num = 0L;
		foreach (long item in source)
		{
			num = checked(num + item);
		}
		return num;
	}

	public static long? Sum(this IEnumerable<long?> source)
	{
		if (source == null)
		{
			throw Error.ArgumentNull("source");
		}
		long num = 0L;
		foreach (long? item in source)
		{
			if (item.HasValue)
			{
				num = checked(num + item.GetValueOrDefault());
			}
		}
		return num;
	}

	public static float Sum(this IEnumerable<float> source)
	{
		if (source == null)
		{
			throw Error.ArgumentNull("source");
		}
		double num = 0.0;
		foreach (float item in source)
		{
			num += (double)item;
		}
		return (float)num;
	}

	public static float? Sum(this IEnumerable<float?> source)
	{
		if (source == null)
		{
			throw Error.ArgumentNull("source");
		}
		double num = 0.0;
		foreach (float? item in source)
		{
			if (item.HasValue)
			{
				num += (double)item.GetValueOrDefault();
			}
		}
		return (float)num;
	}

	public static double Sum(this IEnumerable<double> source)
	{
		if (source == null)
		{
			throw Error.ArgumentNull("source");
		}
		double num = 0.0;
		foreach (double item in source)
		{
			num += item;
		}
		return num;
	}

	public static double? Sum(this IEnumerable<double?> source)
	{
		if (source == null)
		{
			throw Error.ArgumentNull("source");
		}
		double num = 0.0;
		foreach (double? item in source)
		{
			if (item.HasValue)
			{
				num += item.GetValueOrDefault();
			}
		}
		return num;
	}

	public static decimal Sum(this IEnumerable<decimal> source)
	{
		if (source == null)
		{
			throw Error.ArgumentNull("source");
		}
		decimal result = 0m;
		foreach (decimal item in source)
		{
			result += item;
		}
		return result;
	}

	public static decimal? Sum(this IEnumerable<decimal?> source)
	{
		if (source == null)
		{
			throw Error.ArgumentNull("source");
		}
		decimal value = 0m;
		foreach (decimal? item in source)
		{
			if (item.HasValue)
			{
				value += item.GetValueOrDefault();
			}
		}
		return value;
	}

	public static int Sum<TSource>(this IEnumerable<TSource> source, Func<TSource, int> selector)
	{
		return source.Select(selector).Sum();
	}

	public static int? Sum<TSource>(this IEnumerable<TSource> source, Func<TSource, int?> selector)
	{
		return source.Select(selector).Sum();
	}

	public static long Sum<TSource>(this IEnumerable<TSource> source, Func<TSource, long> selector)
	{
		return source.Select(selector).Sum();
	}

	public static long? Sum<TSource>(this IEnumerable<TSource> source, Func<TSource, long?> selector)
	{
		return source.Select(selector).Sum();
	}

	public static float Sum<TSource>(this IEnumerable<TSource> source, Func<TSource, float> selector)
	{
		return source.Select(selector).Sum();
	}

	public static float? Sum<TSource>(this IEnumerable<TSource> source, Func<TSource, float?> selector)
	{
		return source.Select(selector).Sum();
	}

	public static double Sum<TSource>(this IEnumerable<TSource> source, Func<TSource, double> selector)
	{
		return source.Select(selector).Sum();
	}

	public static double? Sum<TSource>(this IEnumerable<TSource> source, Func<TSource, double?> selector)
	{
		return source.Select(selector).Sum();
	}

	public static decimal Sum<TSource>(this IEnumerable<TSource> source, Func<TSource, decimal> selector)
	{
		return source.Select(selector).Sum();
	}

	public static decimal? Sum<TSource>(this IEnumerable<TSource> source, Func<TSource, decimal?> selector)
	{
		return source.Select(selector).Sum();
	}

	public static int Min(this IEnumerable<int> source)
	{
		if (source == null)
		{
			throw Error.ArgumentNull("source");
		}
		int num = 0;
		bool flag = false;
		foreach (int item in source)
		{
			if (flag)
			{
				if (item < num)
				{
					num = item;
				}
			}
			else
			{
				num = item;
				flag = true;
			}
		}
		if (flag)
		{
			return num;
		}
		throw Error.NoElements();
	}

	public static int? Min(this IEnumerable<int?> source)
	{
		if (source == null)
		{
			throw Error.ArgumentNull("source");
		}
		int? num = null;
		foreach (int? item in source)
		{
			if (!num.HasValue || item < num)
			{
				num = item;
			}
		}
		return num;
	}

	public static long Min(this IEnumerable<long> source)
	{
		if (source == null)
		{
			throw Error.ArgumentNull("source");
		}
		long num = 0L;
		bool flag = false;
		foreach (long item in source)
		{
			if (flag)
			{
				if (item < num)
				{
					num = item;
				}
			}
			else
			{
				num = item;
				flag = true;
			}
		}
		if (flag)
		{
			return num;
		}
		throw Error.NoElements();
	}

	public static long? Min(this IEnumerable<long?> source)
	{
		if (source == null)
		{
			throw Error.ArgumentNull("source");
		}
		long? num = null;
		foreach (long? item in source)
		{
			if (!num.HasValue || item < num)
			{
				num = item;
			}
		}
		return num;
	}

	public static float Min(this IEnumerable<float> source)
	{
		if (source == null)
		{
			throw Error.ArgumentNull("source");
		}
		float num = 0f;
		bool flag = false;
		foreach (float item in source)
		{
			if (flag)
			{
				if (item < num || float.IsNaN(item))
				{
					num = item;
				}
			}
			else
			{
				num = item;
				flag = true;
			}
		}
		if (flag)
		{
			return num;
		}
		throw Error.NoElements();
	}

	public static float? Min(this IEnumerable<float?> source)
	{
		if (source == null)
		{
			throw Error.ArgumentNull("source");
		}
		float? num = null;
		foreach (float? item in source)
		{
			if (item.HasValue && (!num.HasValue || item < num || float.IsNaN(item.Value)))
			{
				num = item;
			}
		}
		return num;
	}

	public static double Min(this IEnumerable<double> source)
	{
		if (source == null)
		{
			throw Error.ArgumentNull("source");
		}
		double num = 0.0;
		bool flag = false;
		foreach (double item in source)
		{
			if (flag)
			{
				if (item < num || double.IsNaN(item))
				{
					num = item;
				}
			}
			else
			{
				num = item;
				flag = true;
			}
		}
		if (flag)
		{
			return num;
		}
		throw Error.NoElements();
	}

	public static double? Min(this IEnumerable<double?> source)
	{
		if (source == null)
		{
			throw Error.ArgumentNull("source");
		}
		double? num = null;
		foreach (double? item in source)
		{
			if (item.HasValue && (!num.HasValue || item < num || double.IsNaN(item.Value)))
			{
				num = item;
			}
		}
		return num;
	}

	public static decimal Min(this IEnumerable<decimal> source)
	{
		if (source == null)
		{
			throw Error.ArgumentNull("source");
		}
		decimal num = 0m;
		bool flag = false;
		foreach (decimal item in source)
		{
			if (flag)
			{
				if (item < num)
				{
					num = item;
				}
			}
			else
			{
				num = item;
				flag = true;
			}
		}
		if (flag)
		{
			return num;
		}
		throw Error.NoElements();
	}

	public static decimal? Min(this IEnumerable<decimal?> source)
	{
		if (source == null)
		{
			throw Error.ArgumentNull("source");
		}
		decimal? num = null;
		foreach (decimal? item in source)
		{
			if (!num.HasValue || item < num)
			{
				num = item;
			}
		}
		return num;
	}

	public static TSource Min<TSource>(this IEnumerable<TSource> source)
	{
		if (source == null)
		{
			throw Error.ArgumentNull("source");
		}
		Comparer<TSource> comparer = Comparer<TSource>.Default;
		TSource val = default(TSource);
		if (val == null)
		{
			foreach (TSource item in source)
			{
				if (item != null && (val == null || comparer.Compare(item, val) < 0))
				{
					val = item;
				}
			}
			return val;
		}
		bool flag = false;
		foreach (TSource item2 in source)
		{
			if (flag)
			{
				if (comparer.Compare(item2, val) < 0)
				{
					val = item2;
				}
			}
			else
			{
				val = item2;
				flag = true;
			}
		}
		if (flag)
		{
			return val;
		}
		throw Error.NoElements();
	}

	public static int Min<TSource>(this IEnumerable<TSource> source, Func<TSource, int> selector)
	{
		return source.Select(selector).Min();
	}

	public static int? Min<TSource>(this IEnumerable<TSource> source, Func<TSource, int?> selector)
	{
		return source.Select(selector).Min();
	}

	public static long Min<TSource>(this IEnumerable<TSource> source, Func<TSource, long> selector)
	{
		return source.Select(selector).Min();
	}

	public static long? Min<TSource>(this IEnumerable<TSource> source, Func<TSource, long?> selector)
	{
		return source.Select(selector).Min();
	}

	public static float Min<TSource>(this IEnumerable<TSource> source, Func<TSource, float> selector)
	{
		return source.Select(selector).Min();
	}

	public static float? Min<TSource>(this IEnumerable<TSource> source, Func<TSource, float?> selector)
	{
		return source.Select(selector).Min();
	}

	public static double Min<TSource>(this IEnumerable<TSource> source, Func<TSource, double> selector)
	{
		return source.Select(selector).Min();
	}

	public static double? Min<TSource>(this IEnumerable<TSource> source, Func<TSource, double?> selector)
	{
		return source.Select(selector).Min();
	}

	public static decimal Min<TSource>(this IEnumerable<TSource> source, Func<TSource, decimal> selector)
	{
		return source.Select(selector).Min();
	}

	public static decimal? Min<TSource>(this IEnumerable<TSource> source, Func<TSource, decimal?> selector)
	{
		return source.Select(selector).Min();
	}

	public static TResult Min<TSource, TResult>(this IEnumerable<TSource> source, Func<TSource, TResult> selector)
	{
		return source.Select(selector).Min();
	}

	public static int Max(this IEnumerable<int> source)
	{
		if (source == null)
		{
			throw Error.ArgumentNull("source");
		}
		int num = 0;
		bool flag = false;
		foreach (int item in source)
		{
			if (flag)
			{
				if (item > num)
				{
					num = item;
				}
			}
			else
			{
				num = item;
				flag = true;
			}
		}
		if (flag)
		{
			return num;
		}
		throw Error.NoElements();
	}

	public static int? Max(this IEnumerable<int?> source)
	{
		if (source == null)
		{
			throw Error.ArgumentNull("source");
		}
		int? num = null;
		foreach (int? item in source)
		{
			if (!num.HasValue || item > num)
			{
				num = item;
			}
		}
		return num;
	}

	public static long Max(this IEnumerable<long> source)
	{
		if (source == null)
		{
			throw Error.ArgumentNull("source");
		}
		long num = 0L;
		bool flag = false;
		foreach (long item in source)
		{
			if (flag)
			{
				if (item > num)
				{
					num = item;
				}
			}
			else
			{
				num = item;
				flag = true;
			}
		}
		if (flag)
		{
			return num;
		}
		throw Error.NoElements();
	}

	public static long? Max(this IEnumerable<long?> source)
	{
		if (source == null)
		{
			throw Error.ArgumentNull("source");
		}
		long? num = null;
		foreach (long? item in source)
		{
			if (!num.HasValue || item > num)
			{
				num = item;
			}
		}
		return num;
	}

	public static double Max(this IEnumerable<double> source)
	{
		if (source == null)
		{
			throw Error.ArgumentNull("source");
		}
		double num = 0.0;
		bool flag = false;
		foreach (double item in source)
		{
			if (flag)
			{
				if (item > num || double.IsNaN(num))
				{
					num = item;
				}
			}
			else
			{
				num = item;
				flag = true;
			}
		}
		if (flag)
		{
			return num;
		}
		throw Error.NoElements();
	}

	public static double? Max(this IEnumerable<double?> source)
	{
		if (source == null)
		{
			throw Error.ArgumentNull("source");
		}
		double? num = null;
		foreach (double? item in source)
		{
			if (item.HasValue && (!num.HasValue || item > num || double.IsNaN(num.Value)))
			{
				num = item;
			}
		}
		return num;
	}

	public static float Max(this IEnumerable<float> source)
	{
		if (source == null)
		{
			throw Error.ArgumentNull("source");
		}
		float num = 0f;
		bool flag = false;
		foreach (float item in source)
		{
			if (flag)
			{
				if (item > num || double.IsNaN(num))
				{
					num = item;
				}
			}
			else
			{
				num = item;
				flag = true;
			}
		}
		if (flag)
		{
			return num;
		}
		throw Error.NoElements();
	}

	public static float? Max(this IEnumerable<float?> source)
	{
		if (source == null)
		{
			throw Error.ArgumentNull("source");
		}
		float? num = null;
		foreach (float? item in source)
		{
			if (item.HasValue && (!num.HasValue || item > num || float.IsNaN(num.Value)))
			{
				num = item;
			}
		}
		return num;
	}

	public static decimal Max(this IEnumerable<decimal> source)
	{
		if (source == null)
		{
			throw Error.ArgumentNull("source");
		}
		decimal num = 0m;
		bool flag = false;
		foreach (decimal item in source)
		{
			if (flag)
			{
				if (item > num)
				{
					num = item;
				}
			}
			else
			{
				num = item;
				flag = true;
			}
		}
		if (flag)
		{
			return num;
		}
		throw Error.NoElements();
	}

	public static decimal? Max(this IEnumerable<decimal?> source)
	{
		if (source == null)
		{
			throw Error.ArgumentNull("source");
		}
		decimal? num = null;
		foreach (decimal? item in source)
		{
			if (!num.HasValue || item > num)
			{
				num = item;
			}
		}
		return num;
	}

	public static TSource Max<TSource>(this IEnumerable<TSource> source)
	{
		if (source == null)
		{
			throw Error.ArgumentNull("source");
		}
		Comparer<TSource> comparer = Comparer<TSource>.Default;
		TSource val = default(TSource);
		if (val == null)
		{
			foreach (TSource item in source)
			{
				if (item != null && (val == null || comparer.Compare(item, val) > 0))
				{
					val = item;
				}
			}
			return val;
		}
		bool flag = false;
		foreach (TSource item2 in source)
		{
			if (flag)
			{
				if (comparer.Compare(item2, val) > 0)
				{
					val = item2;
				}
			}
			else
			{
				val = item2;
				flag = true;
			}
		}
		if (flag)
		{
			return val;
		}
		throw Error.NoElements();
	}

	public static int Max<TSource>(this IEnumerable<TSource> source, Func<TSource, int> selector)
	{
		return source.Select(selector).Max();
	}

	public static int? Max<TSource>(this IEnumerable<TSource> source, Func<TSource, int?> selector)
	{
		return source.Select(selector).Max();
	}

	public static long Max<TSource>(this IEnumerable<TSource> source, Func<TSource, long> selector)
	{
		return source.Select(selector).Max();
	}

	public static long? Max<TSource>(this IEnumerable<TSource> source, Func<TSource, long?> selector)
	{
		return source.Select(selector).Max();
	}

	public static float Max<TSource>(this IEnumerable<TSource> source, Func<TSource, float> selector)
	{
		return source.Select(selector).Max();
	}

	public static float? Max<TSource>(this IEnumerable<TSource> source, Func<TSource, float?> selector)
	{
		return source.Select(selector).Max();
	}

	public static double Max<TSource>(this IEnumerable<TSource> source, Func<TSource, double> selector)
	{
		return source.Select(selector).Max();
	}

	public static double? Max<TSource>(this IEnumerable<TSource> source, Func<TSource, double?> selector)
	{
		return source.Select(selector).Max();
	}

	public static decimal Max<TSource>(this IEnumerable<TSource> source, Func<TSource, decimal> selector)
	{
		return source.Select(selector).Max();
	}

	public static decimal? Max<TSource>(this IEnumerable<TSource> source, Func<TSource, decimal?> selector)
	{
		return source.Select(selector).Max();
	}

	public static TResult Max<TSource, TResult>(this IEnumerable<TSource> source, Func<TSource, TResult> selector)
	{
		return source.Select(selector).Max();
	}

	public static double Average(this IEnumerable<int> source)
	{
		if (source == null)
		{
			throw Error.ArgumentNull("source");
		}
		long num = 0L;
		long num2 = 0L;
		checked
		{
			foreach (int item in source)
			{
				num += item;
				num2++;
			}
			if (num2 > 0)
			{
				return (double)num / (double)num2;
			}
			throw Error.NoElements();
		}
	}

	public static double? Average(this IEnumerable<int?> source)
	{
		if (source == null)
		{
			throw Error.ArgumentNull("source");
		}
		long num = 0L;
		long num2 = 0L;
		checked
		{
			foreach (int? item in source)
			{
				if (item.HasValue)
				{
					num += item.GetValueOrDefault();
					num2++;
				}
			}
			if (num2 > 0)
			{
				return (double)num / (double)num2;
			}
			return null;
		}
	}

	public static double Average(this IEnumerable<long> source)
	{
		if (source == null)
		{
			throw Error.ArgumentNull("source");
		}
		long num = 0L;
		long num2 = 0L;
		checked
		{
			foreach (long item in source)
			{
				num += item;
				num2++;
			}
			if (num2 > 0)
			{
				return (double)num / (double)num2;
			}
			throw Error.NoElements();
		}
	}

	public static double? Average(this IEnumerable<long?> source)
	{
		if (source == null)
		{
			throw Error.ArgumentNull("source");
		}
		long num = 0L;
		long num2 = 0L;
		checked
		{
			foreach (long? item in source)
			{
				if (item.HasValue)
				{
					num += item.GetValueOrDefault();
					num2++;
				}
			}
			if (num2 > 0)
			{
				return (double)num / (double)num2;
			}
			return null;
		}
	}

	public static float Average(this IEnumerable<float> source)
	{
		if (source == null)
		{
			throw Error.ArgumentNull("source");
		}
		double num = 0.0;
		long num2 = 0L;
		foreach (float item in source)
		{
			num += (double)item;
			num2 = checked(num2 + 1);
		}
		if (num2 > 0)
		{
			return (float)(num / (double)num2);
		}
		throw Error.NoElements();
	}

	public static float? Average(this IEnumerable<float?> source)
	{
		if (source == null)
		{
			throw Error.ArgumentNull("source");
		}
		double num = 0.0;
		long num2 = 0L;
		foreach (float? item in source)
		{
			if (item.HasValue)
			{
				num += (double)item.GetValueOrDefault();
				num2 = checked(num2 + 1);
			}
		}
		if (num2 > 0)
		{
			return (float)(num / (double)num2);
		}
		return null;
	}

	public static double Average(this IEnumerable<double> source)
	{
		if (source == null)
		{
			throw Error.ArgumentNull("source");
		}
		double num = 0.0;
		long num2 = 0L;
		foreach (double item in source)
		{
			num += item;
			num2 = checked(num2 + 1);
		}
		if (num2 > 0)
		{
			return num / (double)num2;
		}
		throw Error.NoElements();
	}

	public static double? Average(this IEnumerable<double?> source)
	{
		if (source == null)
		{
			throw Error.ArgumentNull("source");
		}
		double num = 0.0;
		long num2 = 0L;
		foreach (double? item in source)
		{
			if (item.HasValue)
			{
				num += item.GetValueOrDefault();
				num2 = checked(num2 + 1);
			}
		}
		if (num2 > 0)
		{
			return num / (double)num2;
		}
		return null;
	}

	public static decimal Average(this IEnumerable<decimal> source)
	{
		if (source == null)
		{
			throw Error.ArgumentNull("source");
		}
		decimal num = 0m;
		long num2 = 0L;
		foreach (decimal item in source)
		{
			num += item;
			num2 = checked(num2 + 1);
		}
		if (num2 > 0)
		{
			return num / (decimal)num2;
		}
		throw Error.NoElements();
	}

	public static decimal? Average(this IEnumerable<decimal?> source)
	{
		if (source == null)
		{
			throw Error.ArgumentNull("source");
		}
		decimal num = 0m;
		long num2 = 0L;
		foreach (decimal? item in source)
		{
			if (item.HasValue)
			{
				num += item.GetValueOrDefault();
				num2 = checked(num2 + 1);
			}
		}
		if (num2 > 0)
		{
			return num / (decimal)num2;
		}
		return null;
	}

	public static double Average<TSource>(this IEnumerable<TSource> source, Func<TSource, int> selector)
	{
		return source.Select(selector).Average();
	}

	public static double? Average<TSource>(this IEnumerable<TSource> source, Func<TSource, int?> selector)
	{
		return source.Select(selector).Average();
	}

	public static double Average<TSource>(this IEnumerable<TSource> source, Func<TSource, long> selector)
	{
		return source.Select(selector).Average();
	}

	public static double? Average<TSource>(this IEnumerable<TSource> source, Func<TSource, long?> selector)
	{
		return source.Select(selector).Average();
	}

	public static float Average<TSource>(this IEnumerable<TSource> source, Func<TSource, float> selector)
	{
		return source.Select(selector).Average();
	}

	public static float? Average<TSource>(this IEnumerable<TSource> source, Func<TSource, float?> selector)
	{
		return source.Select(selector).Average();
	}

	public static double Average<TSource>(this IEnumerable<TSource> source, Func<TSource, double> selector)
	{
		return source.Select(selector).Average();
	}

	public static double? Average<TSource>(this IEnumerable<TSource> source, Func<TSource, double?> selector)
	{
		return source.Select(selector).Average();
	}

	public static decimal Average<TSource>(this IEnumerable<TSource> source, Func<TSource, decimal> selector)
	{
		return source.Select(selector).Average();
	}

	public static decimal? Average<TSource>(this IEnumerable<TSource> source, Func<TSource, decimal?> selector)
	{
		return source.Select(selector).Average();
	}

	public static IEnumerable<TSource> SkipLast<TSource>(this IEnumerable<TSource> source, int count)
	{
		if (source == null)
		{
			throw Error.ArgumentNull("source");
		}
		if (count <= 0)
		{
			return source.Skip(0);
		}
		return SkipLastIterator(source, count);
	}

	private static IEnumerable<TSource> SkipLastIterator<TSource>(IEnumerable<TSource> source, int count)
	{
		Queue<TSource> queue = new Queue<TSource>();
		using IEnumerator<TSource> e = source.GetEnumerator();
		while (e.MoveNext())
		{
			if (queue.Count == count)
			{
				do
				{
					yield return queue.Dequeue();
					queue.Enqueue(e.Current);
				}
				while (e.MoveNext());
				break;
			}
			queue.Enqueue(e.Current);
		}
	}

	public static IEnumerable<TSource> TakeLast<TSource>(this IEnumerable<TSource> source, int count)
	{
		if (source == null)
		{
			throw Error.ArgumentNull("source");
		}
		if (count <= 0)
		{
			return EmptyEnumerable<TSource>.Instance;
		}
		return TakeLastIterator(source, count);
	}

	private static IEnumerable<TSource> TakeLastIterator<TSource>(IEnumerable<TSource> source, int count)
	{
		Queue<TSource> queue;
		using (IEnumerator<TSource> enumerator = source.GetEnumerator())
		{
			if (!enumerator.MoveNext())
			{
				yield break;
			}
			queue = new Queue<TSource>();
			queue.Enqueue(enumerator.Current);
			while (enumerator.MoveNext())
			{
				if (queue.Count < count)
				{
					queue.Enqueue(enumerator.Current);
					continue;
				}
				do
				{
					queue.Dequeue();
					queue.Enqueue(enumerator.Current);
				}
				while (enumerator.MoveNext());
				break;
			}
		}
		do
		{
			yield return queue.Dequeue();
		}
		while (queue.Count > 0);
	}

	public static HashSet<TSource> ToHashSet<TSource>(this IEnumerable<TSource> source)
	{
		return source.ToHashSet(null);
	}

	public static HashSet<TSource> ToHashSet<TSource>(this IEnumerable<TSource> source, IEqualityComparer<TSource> comparer)
	{
		if (source == null)
		{
			throw Error.ArgumentNull("source");
		}
		return new HashSet<TSource>(source, comparer);
	}
}
