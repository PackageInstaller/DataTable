using System;
using System.Buffers;
using System.Collections.Generic;
using System.Runtime.InteropServices;

namespace MemoryPack.Internal;

internal sealed class ReusableReadOnlySequenceBuilder
{
	private class Segment : ReadOnlySequenceSegment<byte>
	{
		private bool returnToPool;

		public Segment()
		{
			returnToPool = false;
		}

		public void SetBuffer(ReadOnlyMemory<byte> buffer, bool returnToPool)
		{
			base.Memory = buffer;
			this.returnToPool = returnToPool;
		}

		public void Reset()
		{
			if (returnToPool && MemoryMarshal.TryGetArray(base.Memory, out var segment) && segment.Array != null)
			{
				ArrayPool<byte>.Shared.Return(segment.Array);
			}
			base.Memory = default(ReadOnlyMemory<byte>);
			base.RunningIndex = 0L;
			base.Next = null;
		}

		public void SetRunningIndexAndNext(long runningIndex, Segment? nextSegment)
		{
			base.RunningIndex = runningIndex;
			base.Next = nextSegment;
		}
	}

	private readonly Stack<Segment> segmentPool;

	private readonly List<Segment> list;

	public ReusableReadOnlySequenceBuilder()
	{
		list = new List<Segment>();
		segmentPool = new Stack<Segment>();
	}

	public void Add(ReadOnlyMemory<byte> buffer, bool returnToPool)
	{
		if (!segmentPool.TryPop(out Segment result))
		{
			result = new Segment();
		}
		result.SetBuffer(buffer, returnToPool);
		list.Add(result);
	}

	public bool TryGetSingleMemory(out ReadOnlyMemory<byte> memory)
	{
		if (list.Count == 1)
		{
			memory = list[0].Memory;
			return true;
		}
		memory = default(ReadOnlyMemory<byte>);
		return false;
	}

	public ReadOnlySequence<byte> Build()
	{
		if (this.list.Count == 0)
		{
			return ReadOnlySequence<byte>.Empty;
		}
		if (this.list.Count == 1)
		{
			return new ReadOnlySequence<byte>(this.list[0].Memory);
		}
		long num = 0L;
		List<Segment> list = this.list;
		for (int i = 0; i < list.Count; i++)
		{
			Segment nextSegment = ((i < list.Count - 1) ? list[i + 1] : null);
			list[i].SetRunningIndexAndNext(num, nextSegment);
			num += list[i].Memory.Length;
		}
		Segment startSegment = list[0];
		Segment segment = list[list.Count - 1];
		return new ReadOnlySequence<byte>(startSegment, 0, segment, segment.Memory.Length);
	}

	public void Reset()
	{
		foreach (Segment item in list)
		{
			item.Reset();
			segmentPool.Push(item);
		}
		list.Clear();
	}
}
