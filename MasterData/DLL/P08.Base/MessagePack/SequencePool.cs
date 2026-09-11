using System;
using System.Buffers;
using System.Collections.Generic;
using Nerdbank.Streams;

namespace MessagePack;

public class SequencePool
{
	internal struct Rental : IDisposable
	{
		private readonly SequencePool owner;

		public Sequence<byte> Value { get; }

		internal Rental(SequencePool owner, Sequence<byte> value)
		{
			this.owner = owner;
			Value = value;
		}

		public void Dispose()
		{
			owner?.Return(Value);
		}
	}

	internal static readonly SequencePool Shared = new SequencePool();

	private const int MinimumSpanLength = 32768;

	private readonly int maxSize;

	private readonly Stack<Sequence<byte>> pool = new Stack<Sequence<byte>>();

	private readonly ArrayPool<byte> arrayPool;

	public SequencePool()
		: this(Environment.ProcessorCount * 2, ArrayPool<byte>.Create(81920, 100))
	{
	}

	public SequencePool(int maxSize)
		: this(maxSize, ArrayPool<byte>.Create(81920, 100))
	{
	}

	public SequencePool(int maxSize, ArrayPool<byte> arrayPool)
	{
		this.maxSize = maxSize;
		this.arrayPool = arrayPool;
	}

	internal Rental Rent()
	{
		lock (pool)
		{
			if (pool.Count > 0)
			{
				return new Rental(this, pool.Pop());
			}
		}
		return new Rental(this, new Sequence<byte>(arrayPool)
		{
			MinimumSpanLength = 32768
		});
	}

	private void Return(Sequence<byte> value)
	{
		value.Reset();
		lock (pool)
		{
			if (pool.Count < maxSize)
			{
				value.MinimumSpanLength = 32768;
				pool.Push(value);
			}
		}
	}
}
