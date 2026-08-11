using System;

namespace Cysharp.Threading.Tasks.Internal;

internal static class StateTuple
{
	public static StateTuple<T1> Create<T1>(T1 item1)
	{
		return StatePool<T1>.Create(item1);
	}

	public static StateTuple<T1, T2> Create<T1, T2>(T1 item1, T2 item2)
	{
		return StatePool<T1, T2>.Create(item1, item2);
	}

	public static StateTuple<T1, T2, T3> Create<T1, T2, T3>(T1 item1, T2 item2, T3 item3)
	{
		return StatePool<T1, T2, T3>.Create(item1, item2, item3);
	}
}
internal class StateTuple<T1> : IDisposable
{
	public T1 Item1;

	public void Deconstruct(out T1 item1)
	{
		item1 = Item1;
	}

	public void Dispose()
	{
		StatePool<T1>.Return(this);
	}
}
internal class StateTuple<T1, T2> : IDisposable
{
	public T1 Item1;

	public T2 Item2;

	public void Deconstruct(out T1 item1, out T2 item2)
	{
		item1 = Item1;
		item2 = Item2;
	}

	public void Dispose()
	{
		StatePool<T1, T2>.Return(this);
	}
}
internal class StateTuple<T1, T2, T3> : IDisposable
{
	public T1 Item1;

	public T2 Item2;

	public T3 Item3;

	public void Deconstruct(out T1 item1, out T2 item2, out T3 item3)
	{
		item1 = Item1;
		item2 = Item2;
		item3 = Item3;
	}

	public void Dispose()
	{
		StatePool<T1, T2, T3>.Return(this);
	}
}
