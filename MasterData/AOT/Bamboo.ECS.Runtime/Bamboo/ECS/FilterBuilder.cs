using System;
using System.Collections.Generic;

namespace Bamboo.ECS;

public class FilterBuilder
{
	private static readonly Stack<FilterBuilder> _pool = new Stack<FilterBuilder>(16);

	private World? _world;

	private ulong _allMask;

	private ulong _anyMask;

	private ulong _noneMask;

	public static FilterBuilder GetOne(World world)
	{
		FilterBuilder filterBuilder = ((_pool.Count > 0) ? _pool.Pop() : new FilterBuilder());
		filterBuilder.Init(world);
		return filterBuilder;
	}

	private static void ReturnOne(FilterBuilder builder)
	{
		_pool.Push(builder);
	}

	internal FilterBuilder()
	{
	}

	internal void Init(World world)
	{
		_world = world ?? throw new ArgumentNullException("world");
	}

	public FilterBuilder All<T>() where T : IComponent
	{
		_allMask |= ComponentTypeCache<T>.Mask;
		return this;
	}

	public FilterBuilder All<T1, T2>() where T1 : IComponent where T2 : IComponent
	{
		_allMask |= ComponentTypeCache<T1>.Mask;
		_allMask |= ComponentTypeCache<T2>.Mask;
		return this;
	}

	public FilterBuilder All<T1, T2, T3>() where T1 : IComponent where T2 : IComponent where T3 : IComponent
	{
		_allMask |= ComponentTypeCache<T1>.Mask;
		_allMask |= ComponentTypeCache<T2>.Mask;
		_allMask |= ComponentTypeCache<T3>.Mask;
		return this;
	}

	public FilterBuilder All<T1, T2, T3, T4>() where T1 : IComponent where T2 : IComponent where T3 : IComponent where T4 : IComponent
	{
		_allMask |= ComponentTypeCache<T1>.Mask;
		_allMask |= ComponentTypeCache<T2>.Mask;
		_allMask |= ComponentTypeCache<T3>.Mask;
		_allMask |= ComponentTypeCache<T4>.Mask;
		return this;
	}

	public FilterBuilder All<T1, T2, T3, T4, T5>() where T1 : IComponent where T2 : IComponent where T3 : IComponent where T4 : IComponent where T5 : IComponent
	{
		_allMask |= ComponentTypeCache<T1>.Mask;
		_allMask |= ComponentTypeCache<T2>.Mask;
		_allMask |= ComponentTypeCache<T3>.Mask;
		_allMask |= ComponentTypeCache<T4>.Mask;
		_allMask |= ComponentTypeCache<T5>.Mask;
		return this;
	}

	public FilterBuilder All<T1, T2, T3, T4, T5, T6>() where T1 : IComponent where T2 : IComponent where T3 : IComponent where T4 : IComponent where T5 : IComponent where T6 : IComponent
	{
		_allMask |= ComponentTypeCache<T1>.Mask;
		_allMask |= ComponentTypeCache<T2>.Mask;
		_allMask |= ComponentTypeCache<T3>.Mask;
		_allMask |= ComponentTypeCache<T4>.Mask;
		_allMask |= ComponentTypeCache<T5>.Mask;
		_allMask |= ComponentTypeCache<T6>.Mask;
		return this;
	}

	public FilterBuilder All<T1, T2, T3, T4, T5, T6, T7>() where T1 : IComponent where T2 : IComponent where T3 : IComponent where T4 : IComponent where T5 : IComponent where T6 : IComponent where T7 : IComponent
	{
		_allMask |= ComponentTypeCache<T1>.Mask;
		_allMask |= ComponentTypeCache<T2>.Mask;
		_allMask |= ComponentTypeCache<T3>.Mask;
		_allMask |= ComponentTypeCache<T4>.Mask;
		_allMask |= ComponentTypeCache<T5>.Mask;
		_allMask |= ComponentTypeCache<T6>.Mask;
		_allMask |= ComponentTypeCache<T7>.Mask;
		return this;
	}

	public FilterBuilder All<T1, T2, T3, T4, T5, T6, T7, T8>() where T1 : IComponent where T2 : IComponent where T3 : IComponent where T4 : IComponent where T5 : IComponent where T6 : IComponent where T7 : IComponent where T8 : IComponent
	{
		_allMask |= ComponentTypeCache<T1>.Mask;
		_allMask |= ComponentTypeCache<T2>.Mask;
		_allMask |= ComponentTypeCache<T3>.Mask;
		_allMask |= ComponentTypeCache<T4>.Mask;
		_allMask |= ComponentTypeCache<T5>.Mask;
		_allMask |= ComponentTypeCache<T6>.Mask;
		_allMask |= ComponentTypeCache<T7>.Mask;
		_allMask |= ComponentTypeCache<T8>.Mask;
		return this;
	}

	public FilterBuilder All<T1, T2, T3, T4, T5, T6, T7, T8, T9>() where T1 : IComponent where T2 : IComponent where T3 : IComponent where T4 : IComponent where T5 : IComponent where T6 : IComponent where T7 : IComponent where T8 : IComponent where T9 : IComponent
	{
		_allMask |= ComponentTypeCache<T1>.Mask;
		_allMask |= ComponentTypeCache<T2>.Mask;
		_allMask |= ComponentTypeCache<T3>.Mask;
		_allMask |= ComponentTypeCache<T4>.Mask;
		_allMask |= ComponentTypeCache<T5>.Mask;
		_allMask |= ComponentTypeCache<T6>.Mask;
		_allMask |= ComponentTypeCache<T7>.Mask;
		_allMask |= ComponentTypeCache<T8>.Mask;
		_allMask |= ComponentTypeCache<T9>.Mask;
		return this;
	}

	public FilterBuilder Any<T>() where T : IComponent
	{
		_anyMask |= ComponentTypeCache<T>.Mask;
		return this;
	}

	public FilterBuilder Any<T1, T2>() where T1 : IComponent where T2 : IComponent
	{
		_anyMask |= ComponentTypeCache<T1>.Mask;
		_anyMask |= ComponentTypeCache<T2>.Mask;
		return this;
	}

	public FilterBuilder Any<T1, T2, T3>() where T1 : IComponent where T2 : IComponent where T3 : IComponent
	{
		_anyMask |= ComponentTypeCache<T1>.Mask;
		_anyMask |= ComponentTypeCache<T2>.Mask;
		_anyMask |= ComponentTypeCache<T3>.Mask;
		return this;
	}

	public FilterBuilder Any<T1, T2, T3, T4>() where T1 : IComponent where T2 : IComponent where T3 : IComponent where T4 : IComponent
	{
		_anyMask |= ComponentTypeCache<T1>.Mask;
		_anyMask |= ComponentTypeCache<T2>.Mask;
		_anyMask |= ComponentTypeCache<T3>.Mask;
		_anyMask |= ComponentTypeCache<T4>.Mask;
		return this;
	}

	public FilterBuilder Any<T1, T2, T3, T4, T5>() where T1 : IComponent where T2 : IComponent where T3 : IComponent where T4 : IComponent where T5 : IComponent
	{
		_anyMask |= ComponentTypeCache<T1>.Mask;
		_anyMask |= ComponentTypeCache<T2>.Mask;
		_anyMask |= ComponentTypeCache<T3>.Mask;
		_anyMask |= ComponentTypeCache<T4>.Mask;
		_anyMask |= ComponentTypeCache<T5>.Mask;
		return this;
	}

	public FilterBuilder Any<T1, T2, T3, T4, T5, T6>() where T1 : IComponent where T2 : IComponent where T3 : IComponent where T4 : IComponent where T5 : IComponent where T6 : IComponent
	{
		_anyMask |= ComponentTypeCache<T1>.Mask;
		_anyMask |= ComponentTypeCache<T2>.Mask;
		_anyMask |= ComponentTypeCache<T3>.Mask;
		_anyMask |= ComponentTypeCache<T4>.Mask;
		_anyMask |= ComponentTypeCache<T5>.Mask;
		_anyMask |= ComponentTypeCache<T6>.Mask;
		return this;
	}

	public FilterBuilder Any<T1, T2, T3, T4, T5, T6, T7>() where T1 : IComponent where T2 : IComponent where T3 : IComponent where T4 : IComponent where T5 : IComponent where T6 : IComponent where T7 : IComponent
	{
		_anyMask |= ComponentTypeCache<T1>.Mask;
		_anyMask |= ComponentTypeCache<T2>.Mask;
		_anyMask |= ComponentTypeCache<T3>.Mask;
		_anyMask |= ComponentTypeCache<T4>.Mask;
		_anyMask |= ComponentTypeCache<T5>.Mask;
		_anyMask |= ComponentTypeCache<T6>.Mask;
		_anyMask |= ComponentTypeCache<T7>.Mask;
		return this;
	}

	public FilterBuilder Any<T1, T2, T3, T4, T5, T6, T7, T8>() where T1 : IComponent where T2 : IComponent where T3 : IComponent where T4 : IComponent where T5 : IComponent where T6 : IComponent where T7 : IComponent where T8 : IComponent
	{
		_anyMask |= ComponentTypeCache<T1>.Mask;
		_anyMask |= ComponentTypeCache<T2>.Mask;
		_anyMask |= ComponentTypeCache<T3>.Mask;
		_anyMask |= ComponentTypeCache<T4>.Mask;
		_anyMask |= ComponentTypeCache<T5>.Mask;
		_anyMask |= ComponentTypeCache<T6>.Mask;
		_anyMask |= ComponentTypeCache<T7>.Mask;
		_anyMask |= ComponentTypeCache<T8>.Mask;
		return this;
	}

	public FilterBuilder Any<T1, T2, T3, T4, T5, T6, T7, T8, T9>() where T1 : IComponent where T2 : IComponent where T3 : IComponent where T4 : IComponent where T5 : IComponent where T6 : IComponent where T7 : IComponent where T8 : IComponent where T9 : IComponent
	{
		_anyMask |= ComponentTypeCache<T1>.Mask;
		_anyMask |= ComponentTypeCache<T2>.Mask;
		_anyMask |= ComponentTypeCache<T3>.Mask;
		_anyMask |= ComponentTypeCache<T4>.Mask;
		_anyMask |= ComponentTypeCache<T5>.Mask;
		_anyMask |= ComponentTypeCache<T6>.Mask;
		_anyMask |= ComponentTypeCache<T7>.Mask;
		_anyMask |= ComponentTypeCache<T8>.Mask;
		_anyMask |= ComponentTypeCache<T9>.Mask;
		return this;
	}

	public FilterBuilder None<T>() where T : IComponent
	{
		_noneMask |= ComponentTypeCache<T>.Mask;
		return this;
	}

	public FilterBuilder None<T1, T2>() where T1 : IComponent where T2 : IComponent
	{
		_noneMask |= ComponentTypeCache<T1>.Mask;
		_noneMask |= ComponentTypeCache<T2>.Mask;
		return this;
	}

	public FilterBuilder None<T1, T2, T3>() where T1 : IComponent where T2 : IComponent where T3 : IComponent
	{
		_noneMask |= ComponentTypeCache<T1>.Mask;
		_noneMask |= ComponentTypeCache<T2>.Mask;
		_noneMask |= ComponentTypeCache<T3>.Mask;
		return this;
	}

	public FilterBuilder None<T1, T2, T3, T4>() where T1 : IComponent where T2 : IComponent where T3 : IComponent where T4 : IComponent
	{
		_noneMask |= ComponentTypeCache<T1>.Mask;
		_noneMask |= ComponentTypeCache<T2>.Mask;
		_noneMask |= ComponentTypeCache<T3>.Mask;
		_noneMask |= ComponentTypeCache<T4>.Mask;
		return this;
	}

	public FilterBuilder None<T1, T2, T3, T4, T5>() where T1 : IComponent where T2 : IComponent where T3 : IComponent where T4 : IComponent where T5 : IComponent
	{
		_noneMask |= ComponentTypeCache<T1>.Mask;
		_noneMask |= ComponentTypeCache<T2>.Mask;
		_noneMask |= ComponentTypeCache<T3>.Mask;
		_noneMask |= ComponentTypeCache<T4>.Mask;
		_noneMask |= ComponentTypeCache<T5>.Mask;
		return this;
	}

	public FilterBuilder None<T1, T2, T3, T4, T5, T6>() where T1 : IComponent where T2 : IComponent where T3 : IComponent where T4 : IComponent where T5 : IComponent where T6 : IComponent
	{
		_noneMask |= ComponentTypeCache<T1>.Mask;
		_noneMask |= ComponentTypeCache<T2>.Mask;
		_noneMask |= ComponentTypeCache<T3>.Mask;
		_noneMask |= ComponentTypeCache<T4>.Mask;
		_noneMask |= ComponentTypeCache<T5>.Mask;
		_noneMask |= ComponentTypeCache<T6>.Mask;
		return this;
	}

	public FilterBuilder None<T1, T2, T3, T4, T5, T6, T7>() where T1 : IComponent where T2 : IComponent where T3 : IComponent where T4 : IComponent where T5 : IComponent where T6 : IComponent where T7 : IComponent
	{
		_noneMask |= ComponentTypeCache<T1>.Mask;
		_noneMask |= ComponentTypeCache<T2>.Mask;
		_noneMask |= ComponentTypeCache<T3>.Mask;
		_noneMask |= ComponentTypeCache<T4>.Mask;
		_noneMask |= ComponentTypeCache<T5>.Mask;
		_noneMask |= ComponentTypeCache<T6>.Mask;
		_noneMask |= ComponentTypeCache<T7>.Mask;
		return this;
	}

	public FilterBuilder None<T1, T2, T3, T4, T5, T6, T7, T8>() where T1 : IComponent where T2 : IComponent where T3 : IComponent where T4 : IComponent where T5 : IComponent where T6 : IComponent where T7 : IComponent where T8 : IComponent
	{
		_noneMask |= ComponentTypeCache<T1>.Mask;
		_noneMask |= ComponentTypeCache<T2>.Mask;
		_noneMask |= ComponentTypeCache<T3>.Mask;
		_noneMask |= ComponentTypeCache<T4>.Mask;
		_noneMask |= ComponentTypeCache<T5>.Mask;
		_noneMask |= ComponentTypeCache<T6>.Mask;
		_noneMask |= ComponentTypeCache<T7>.Mask;
		_noneMask |= ComponentTypeCache<T8>.Mask;
		return this;
	}

	public FilterBuilder None<T1, T2, T3, T4, T5, T6, T7, T8, T9>() where T1 : IComponent where T2 : IComponent where T3 : IComponent where T4 : IComponent where T5 : IComponent where T6 : IComponent where T7 : IComponent where T8 : IComponent where T9 : IComponent
	{
		_noneMask |= ComponentTypeCache<T1>.Mask;
		_noneMask |= ComponentTypeCache<T2>.Mask;
		_noneMask |= ComponentTypeCache<T3>.Mask;
		_noneMask |= ComponentTypeCache<T4>.Mask;
		_noneMask |= ComponentTypeCache<T5>.Mask;
		_noneMask |= ComponentTypeCache<T6>.Mask;
		_noneMask |= ComponentTypeCache<T7>.Mask;
		_noneMask |= ComponentTypeCache<T8>.Mask;
		_noneMask |= ComponentTypeCache<T9>.Mask;
		return this;
	}

	public Filter Build()
	{
		if (_world == null)
		{
			throw new InvalidOperationException("FilterBuilder is not bound to any World.");
		}
		Filter result = new Filter(_world, _allMask, _anyMask, _noneMask);
		Reset();
		return result;
	}

	private void Reset()
	{
		_allMask = 0uL;
		_anyMask = 0uL;
		_noneMask = 0uL;
		_world = null;
		ReturnOne(this);
	}
}
