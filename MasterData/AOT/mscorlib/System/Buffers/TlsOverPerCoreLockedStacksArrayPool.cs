using System.Collections.Generic;
using System.Runtime.CompilerServices;
using System.Threading;
using Internal.Runtime.Augments;

namespace System.Buffers;

internal sealed class TlsOverPerCoreLockedStacksArrayPool<T> : ArrayPool<T>
{
	private enum MemoryPressure
	{
		Low,
		Medium,
		High
	}

	private sealed class PerCoreLockedStacks
	{
		private readonly LockedStack[] _perCoreStacks;

		public PerCoreLockedStacks()
		{
			LockedStack[] array = new LockedStack[Math.Min(Environment.ProcessorCount, 64)];
			for (int i = 0; i < array.Length; i++)
			{
				array[i] = new LockedStack();
			}
			_perCoreStacks = array;
		}

		[MethodImpl((MethodImplOptions)256)]
		public void TryPush(T[] array)
		{
			LockedStack[] perCoreStacks = _perCoreStacks;
			int num = RuntimeThread.GetCurrentProcessorId() % perCoreStacks.Length;
			for (int i = 0; i < perCoreStacks.Length; i++)
			{
				if (perCoreStacks[num].TryPush(array))
				{
					break;
				}
				if (++num == perCoreStacks.Length)
				{
					num = 0;
				}
			}
		}

		[MethodImpl((MethodImplOptions)256)]
		public T[] TryPop()
		{
			LockedStack[] perCoreStacks = _perCoreStacks;
			int num = RuntimeThread.GetCurrentProcessorId() % perCoreStacks.Length;
			for (int i = 0; i < perCoreStacks.Length; i++)
			{
				T[] result;
				if ((result = perCoreStacks[num].TryPop()) != null)
				{
					return result;
				}
				if (++num == perCoreStacks.Length)
				{
					num = 0;
				}
			}
			return null;
		}

		public bool Trim(uint tickCount, int id, MemoryPressure pressure, int[] bucketSizes)
		{
			LockedStack[] perCoreStacks = _perCoreStacks;
			for (int i = 0; i < perCoreStacks.Length; i++)
			{
				perCoreStacks[i].Trim(tickCount, id, pressure, bucketSizes[i]);
			}
			return true;
		}
	}

	private sealed class LockedStack
	{
		private readonly T[][] _arrays = new T[8][];

		private int _count;

		private uint _firstStackItemMS;

		[MethodImpl((MethodImplOptions)256)]
		public bool TryPush(T[] array)
		{
			bool result = false;
			Monitor.Enter(this);
			if (_count < 8)
			{
				if (TlsOverPerCoreLockedStacksArrayPool<T>.s_trimBuffers && _count == 0)
				{
					_firstStackItemMS = (uint)Environment.TickCount;
				}
				_arrays[_count++] = array;
				result = true;
			}
			Monitor.Exit(this);
			return result;
		}

		[MethodImpl((MethodImplOptions)256)]
		public T[] TryPop()
		{
			T[] result = null;
			Monitor.Enter(this);
			if (_count > 0)
			{
				result = _arrays[--_count];
				_arrays[_count] = null;
			}
			Monitor.Exit(this);
			return result;
		}

		public void Trim(uint tickCount, int id, MemoryPressure pressure, int bucketSize)
		{
			if (_count == 0)
			{
				return;
			}
			uint num = ((pressure == MemoryPressure.High) ? 10000u : 60000u);
			lock (this)
			{
				if ((_count <= 0 || _firstStackItemMS <= tickCount) && tickCount - _firstStackItemMS <= num)
				{
					return;
				}
				ArrayPoolEventSource log = ArrayPoolEventSource.Log;
				int num2 = 1;
				switch (pressure)
				{
				case MemoryPressure.High:
					num2 = 8;
					if (bucketSize > 16384)
					{
						num2++;
					}
					if (Unsafe.SizeOf<T>() > 16)
					{
						num2++;
					}
					if (Unsafe.SizeOf<T>() > 32)
					{
						num2++;
					}
					break;
				case MemoryPressure.Medium:
					num2 = 2;
					break;
				}
				while (_count > 0 && num2-- > 0)
				{
					T[] array = _arrays[--_count];
					_arrays[_count] = null;
					if (log.IsEnabled())
					{
						log.BufferTrimmed(array.GetHashCode(), array.Length, id);
					}
				}
				if (_count > 0 && _firstStackItemMS < 4294952295u)
				{
					_firstStackItemMS += 15000u;
				}
			}
		}
	}

	private readonly int[] _bucketArraySizes;

	private readonly PerCoreLockedStacks[] _buckets = new PerCoreLockedStacks[17];

	[ThreadStatic]
	private static T[][] t_tlsBuckets;

	private int _callbackCreated;

	private static readonly bool s_trimBuffers = GetTrimBuffers();

	private static readonly ConditionalWeakTable<T[][], object> s_allTlsBuckets = (s_trimBuffers ? new ConditionalWeakTable<T[][], object>() : null);

	private int Id => GetHashCode();

	public TlsOverPerCoreLockedStacksArrayPool()
	{
		int[] array = new int[17];
		for (int i = 0; i < array.Length; i++)
		{
			array[i] = Utilities.GetMaxSizeForBucket(i);
		}
		_bucketArraySizes = array;
	}

	private PerCoreLockedStacks CreatePerCoreLockedStacks(int bucketIndex)
	{
		PerCoreLockedStacks perCoreLockedStacks = new PerCoreLockedStacks();
		return Interlocked.CompareExchange(ref _buckets[bucketIndex], perCoreLockedStacks, null) ?? perCoreLockedStacks;
	}

	public override T[] Rent(int minimumLength)
	{
		if (minimumLength < 0)
		{
			throw new ArgumentOutOfRangeException("minimumLength");
		}
		if (minimumLength == 0)
		{
			return Array.Empty<T>();
		}
		ArrayPoolEventSource log = ArrayPoolEventSource.Log;
		int num = Utilities.SelectBucketIndex(minimumLength);
		T[] array2;
		if (num < _buckets.Length)
		{
			T[][] array = t_tlsBuckets;
			if (array != null)
			{
				array2 = array[num];
				if (array2 != null)
				{
					array[num] = null;
					if (log.IsEnabled())
					{
						log.BufferRented(array2.GetHashCode(), array2.Length, Id, num);
					}
					return array2;
				}
			}
			PerCoreLockedStacks perCoreLockedStacks = _buckets[num];
			if (perCoreLockedStacks != null)
			{
				array2 = perCoreLockedStacks.TryPop();
				if (array2 != null)
				{
					if (log.IsEnabled())
					{
						log.BufferRented(array2.GetHashCode(), array2.Length, Id, num);
					}
					return array2;
				}
			}
			array2 = new T[_bucketArraySizes[num]];
		}
		else
		{
			array2 = new T[minimumLength];
		}
		if (log.IsEnabled())
		{
			int hashCode = array2.GetHashCode();
			int bucketId = -1;
			log.BufferRented(hashCode, array2.Length, Id, bucketId);
			log.BufferAllocated(hashCode, array2.Length, Id, bucketId, (num >= _buckets.Length) ? ArrayPoolEventSource.BufferAllocatedReason.OverMaximumSize : ArrayPoolEventSource.BufferAllocatedReason.PoolExhausted);
		}
		return array2;
	}

	public override void Return(T[] array, bool clearArray = false)
	{
		if (array == null)
		{
			throw new ArgumentNullException("array");
		}
		int num = Utilities.SelectBucketIndex(array.Length);
		if (num < _buckets.Length)
		{
			if (clearArray)
			{
				Array.Clear(array, 0, array.Length);
			}
			if (array.Length != _bucketArraySizes[num])
			{
				throw new ArgumentException("The buffer is not associated with this pool and may not be returned to it.", "array");
			}
			T[][] array2 = t_tlsBuckets;
			if (array2 == null)
			{
				array2 = (t_tlsBuckets = new T[17][]);
				array2[num] = array;
				if (s_trimBuffers)
				{
					s_allTlsBuckets.Add(array2, null);
					if (Interlocked.Exchange(ref _callbackCreated, 1) != 1)
					{
						Gen2GcCallback.Register(Gen2GcCallbackFunc, this);
					}
				}
			}
			else
			{
				T[] array3 = array2[num];
				array2[num] = array;
				if (array3 != null)
				{
					(_buckets[num] ?? CreatePerCoreLockedStacks(num)).TryPush(array3);
				}
			}
		}
		ArrayPoolEventSource log = ArrayPoolEventSource.Log;
		if (log.IsEnabled())
		{
			log.BufferReturned(array.GetHashCode(), array.Length, Id);
		}
	}

	public bool Trim()
	{
		int tickCount = Environment.TickCount;
		MemoryPressure memoryPressure = GetMemoryPressure();
		ArrayPoolEventSource log = ArrayPoolEventSource.Log;
		if (log.IsEnabled())
		{
			log.BufferTrimPoll(tickCount, (int)memoryPressure);
		}
		PerCoreLockedStacks[] buckets = _buckets;
		for (int i = 0; i < buckets.Length; i++)
		{
			buckets[i]?.Trim((uint)tickCount, Id, memoryPressure, _bucketArraySizes);
		}
		if (memoryPressure == MemoryPressure.High)
		{
			if (log.IsEnabled())
			{
				foreach (KeyValuePair<T[][], object> item in (IEnumerable<KeyValuePair<T[][], object>>)s_allTlsBuckets)
				{
					T[][] key = item.Key;
					for (int j = 0; j < key.Length; j++)
					{
						T[] array = Interlocked.Exchange(ref key[j], null);
						if (array != null)
						{
							log.BufferTrimmed(array.GetHashCode(), array.Length, Id);
						}
					}
				}
			}
			else
			{
				foreach (KeyValuePair<T[][], object> item2 in (IEnumerable<KeyValuePair<T[][], object>>)s_allTlsBuckets)
				{
					T[][] key2 = item2.Key;
					Array.Clear(key2, 0, key2.Length);
				}
			}
		}
		return true;
	}

	private static bool Gen2GcCallbackFunc(object target)
	{
		return ((TlsOverPerCoreLockedStacksArrayPool<T>)target).Trim();
	}

	private static MemoryPressure GetMemoryPressure()
	{
		GC.GetMemoryInfo(out var highMemLoadThreshold, out var _, out var lastRecordedMemLoad, out var _, out var _);
		if ((double)lastRecordedMemLoad >= (double)highMemLoadThreshold * 0.9)
		{
			return MemoryPressure.High;
		}
		if ((double)lastRecordedMemLoad >= (double)highMemLoadThreshold * 0.7)
		{
			return MemoryPressure.Medium;
		}
		return MemoryPressure.Low;
	}

	private static bool GetTrimBuffers()
	{
		return true;
	}
}
