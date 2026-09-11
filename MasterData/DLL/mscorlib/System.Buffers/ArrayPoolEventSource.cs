using System.Diagnostics.Tracing;

namespace System.Buffers;

[EventSource(Guid = "0866B2B8-5CEF-5DB9-2612-0C0FFD814A44", Name = "System.Buffers.ArrayPoolEventSource")]
internal sealed class ArrayPoolEventSource : EventSource
{
	internal enum BufferAllocatedReason
	{
		Pooled,
		OverMaximumSize,
		PoolExhausted
	}

	internal static readonly ArrayPoolEventSource Log = new ArrayPoolEventSource();

	private ArrayPoolEventSource()
		: base(new Guid(140948152, 23791, 23993, 38, 18, 12, 15, 253, 129, 74, 68), "System.Buffers.ArrayPoolEventSource")
	{
	}

	[Event(1, Level = EventLevel.Verbose)]
	internal unsafe void BufferRented(int bufferId, int bufferSize, int poolId, int bucketId)
	{
		EventData* ptr = stackalloc EventData[4];
		ptr->Size = 4;
		ptr->DataPointer = (IntPtr)(&bufferId);
		ptr->Reserved = 0;
		ptr[1].Size = 4;
		ptr[1].DataPointer = (IntPtr)(&bufferSize);
		ptr[1].Reserved = 0;
		ptr[2].Size = 4;
		ptr[2].DataPointer = (IntPtr)(&poolId);
		ptr[2].Reserved = 0;
		ptr[3].Size = 4;
		ptr[3].DataPointer = (IntPtr)(&bucketId);
		ptr[3].Reserved = 0;
		WriteEventCore(1, 4, ptr);
	}

	[Event(2, Level = EventLevel.Informational)]
	internal unsafe void BufferAllocated(int bufferId, int bufferSize, int poolId, int bucketId, BufferAllocatedReason reason)
	{
		EventData* ptr = stackalloc EventData[5];
		ptr->Size = 4;
		ptr->DataPointer = (IntPtr)(&bufferId);
		ptr->Reserved = 0;
		ptr[1].Size = 4;
		ptr[1].DataPointer = (IntPtr)(&bufferSize);
		ptr[1].Reserved = 0;
		ptr[2].Size = 4;
		ptr[2].DataPointer = (IntPtr)(&poolId);
		ptr[2].Reserved = 0;
		ptr[3].Size = 4;
		ptr[3].DataPointer = (IntPtr)(&bucketId);
		ptr[3].Reserved = 0;
		ptr[4].Size = 4;
		ptr[4].DataPointer = (IntPtr)(&reason);
		ptr[4].Reserved = 0;
		WriteEventCore(2, 5, ptr);
	}

	[Event(3, Level = EventLevel.Verbose)]
	internal void BufferReturned(int bufferId, int bufferSize, int poolId)
	{
		WriteEvent(3, bufferId, bufferSize, poolId);
	}

	[Event(4, Level = EventLevel.Informational)]
	internal void BufferTrimmed(int bufferId, int bufferSize, int poolId)
	{
		WriteEvent(4, bufferId, bufferSize, poolId);
	}

	[Event(5, Level = EventLevel.Informational)]
	internal void BufferTrimPoll(int milliseconds, int pressure)
	{
		WriteEvent(5, milliseconds, pressure);
	}
}
