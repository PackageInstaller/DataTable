using System;
using System.Collections;
using System.Collections.Generic;
using Unity.Collections;
using Unity.Collections.LowLevel.Unsafe;
using UnityEngine.InputSystem.Utilities;

namespace UnityEngine.InputSystem.LowLevel;

public struct InputEventBuffer : IEnumerable<InputEventPtr>, IEnumerable, IDisposable, ICloneable
{
	private unsafe struct Enumerator(InputEventBuffer buffer) : IEnumerator<InputEventPtr>, IEnumerator, IDisposable
	{
		private unsafe readonly InputEvent* m_Buffer = buffer.bufferPtr;

		private readonly int m_EventCount = buffer.m_EventCount;

		private unsafe InputEvent* m_CurrentEvent = null;

		private int m_CurrentIndex = 0;

		public unsafe InputEventPtr Current => m_CurrentEvent;

		object IEnumerator.Current => Current;

		public unsafe bool MoveNext()
		{
			if (m_CurrentIndex == m_EventCount)
			{
				return false;
			}
			if (m_CurrentEvent == null)
			{
				m_CurrentEvent = m_Buffer;
				return m_CurrentEvent != null;
			}
			m_CurrentIndex++;
			if (m_CurrentIndex == m_EventCount)
			{
				return false;
			}
			m_CurrentEvent = InputEvent.GetNextInMemory(m_CurrentEvent);
			return true;
		}

		public unsafe void Reset()
		{
			m_CurrentEvent = null;
			m_CurrentIndex = 0;
		}

		public void Dispose()
		{
		}
	}

	public const long BufferSizeUnknown = -1L;

	private NativeArray<byte> m_Buffer;

	private long m_SizeInBytes;

	private int m_EventCount;

	private bool m_WeOwnTheBuffer;

	public int eventCount => m_EventCount;

	public long sizeInBytes => m_SizeInBytes;

	public long capacityInBytes
	{
		get
		{
			if (!m_Buffer.IsCreated)
			{
				return 0L;
			}
			return m_Buffer.Length;
		}
	}

	public NativeArray<byte> data => m_Buffer;

	public unsafe InputEventPtr bufferPtr => (InputEvent*)NativeArrayUnsafeUtility.GetUnsafeBufferPointerWithoutChecks(m_Buffer);

	public unsafe InputEventBuffer(InputEvent* eventPtr, int eventCount, int sizeInBytes = -1, int capacityInBytes = -1)
	{
		this = default(InputEventBuffer);
		if (eventPtr == null && eventCount != 0)
		{
			throw new ArgumentException("eventPtr is NULL but eventCount is != 0", "eventCount");
		}
		if (capacityInBytes != 0 && capacityInBytes < sizeInBytes)
		{
			throw new ArgumentException($"capacity({capacityInBytes}) cannot be smaller than size({sizeInBytes})", "capacityInBytes");
		}
		if (eventPtr != null)
		{
			if (capacityInBytes < 0)
			{
				capacityInBytes = sizeInBytes;
			}
			m_Buffer = NativeArrayUnsafeUtility.ConvertExistingDataToNativeArray<byte>(eventPtr, (capacityInBytes > 0) ? capacityInBytes : 0, Allocator.None);
			m_SizeInBytes = ((sizeInBytes >= 0) ? sizeInBytes : (-1));
			m_EventCount = eventCount;
			m_WeOwnTheBuffer = false;
		}
	}

	public InputEventBuffer(NativeArray<byte> buffer, int eventCount, int sizeInBytes = -1, bool transferNativeArrayOwnership = false)
	{
		if (eventCount > 0 && !buffer.IsCreated)
		{
			throw new ArgumentException("buffer has no data but eventCount is > 0", "eventCount");
		}
		if (sizeInBytes > buffer.Length)
		{
			throw new ArgumentOutOfRangeException("sizeInBytes");
		}
		m_Buffer = buffer;
		m_WeOwnTheBuffer = transferNativeArrayOwnership;
		m_SizeInBytes = ((sizeInBytes >= 0) ? sizeInBytes : buffer.Length);
		m_EventCount = eventCount;
	}

	public unsafe void AppendEvent(InputEvent* eventPtr, int capacityIncrementInBytes = 2048, Allocator allocator = Allocator.Persistent)
	{
		if (eventPtr == null)
		{
			throw new ArgumentNullException("eventPtr");
		}
		uint num = eventPtr->sizeInBytes;
		UnsafeUtility.MemCpy(AllocateEvent((int)num, capacityIncrementInBytes, allocator), eventPtr, num);
	}

	public unsafe InputEvent* AllocateEvent(int sizeInBytes, int capacityIncrementInBytes = 2048, Allocator allocator = Allocator.Persistent)
	{
		if (sizeInBytes < 20)
		{
			throw new ArgumentException($"sizeInBytes must be >= sizeof(InputEvent) == {20} (was {sizeInBytes})", "sizeInBytes");
		}
		int num = sizeInBytes.AlignToMultipleOf(4);
		long num2 = m_SizeInBytes + num;
		if (capacityInBytes < num2)
		{
			long num3 = num2.AlignToMultipleOf(capacityIncrementInBytes);
			if (num3 > int.MaxValue)
			{
				throw new NotImplementedException("NativeArray long support");
			}
			NativeArray<byte> nativeArray = new NativeArray<byte>((int)num3, allocator);
			if (m_Buffer.IsCreated)
			{
				UnsafeUtility.MemCpy(nativeArray.GetUnsafePtr(), NativeArrayUnsafeUtility.GetUnsafeBufferPointerWithoutChecks(m_Buffer), this.sizeInBytes);
				if (m_WeOwnTheBuffer)
				{
					m_Buffer.Dispose();
				}
			}
			m_Buffer = nativeArray;
			m_WeOwnTheBuffer = true;
		}
		InputEvent* ptr = (InputEvent*)((byte*)NativeArrayUnsafeUtility.GetUnsafeBufferPointerWithoutChecks(m_Buffer) + m_SizeInBytes);
		ptr->sizeInBytes = (uint)sizeInBytes;
		m_SizeInBytes += num;
		m_EventCount++;
		return ptr;
	}

	public unsafe bool Contains(InputEvent* eventPtr)
	{
		if (eventPtr == null)
		{
			return false;
		}
		if (sizeInBytes == 0L)
		{
			return false;
		}
		void* unsafeBufferPointerWithoutChecks = NativeArrayUnsafeUtility.GetUnsafeBufferPointerWithoutChecks(data);
		if (eventPtr < unsafeBufferPointerWithoutChecks)
		{
			return false;
		}
		if (sizeInBytes != -1 && eventPtr >= (byte*)unsafeBufferPointerWithoutChecks + sizeInBytes)
		{
			return false;
		}
		return true;
	}

	public void Reset()
	{
		m_EventCount = 0;
		if (m_SizeInBytes != -1)
		{
			m_SizeInBytes = 0L;
		}
	}

	internal unsafe void AdvanceToNextEvent(ref InputEvent* currentReadPos, ref InputEvent* currentWritePos, ref int numEventsRetainedInBuffer, ref int numRemainingEvents, bool leaveEventInBuffer)
	{
		InputEvent* ptr = currentReadPos;
		if (numRemainingEvents > 1)
		{
			ptr = InputEvent.GetNextInMemory(currentReadPos);
		}
		if (leaveEventInBuffer)
		{
			uint num = currentReadPos->sizeInBytes;
			if (currentReadPos != currentWritePos)
			{
				UnsafeUtility.MemMove(currentWritePos, currentReadPos, num);
			}
			currentWritePos = (InputEvent*)((byte*)currentWritePos + num.AlignToMultipleOf(4u));
			numEventsRetainedInBuffer++;
		}
		currentReadPos = ptr;
		numRemainingEvents--;
	}

	public IEnumerator<InputEventPtr> GetEnumerator()
	{
		return new Enumerator(this);
	}

	IEnumerator IEnumerable.GetEnumerator()
	{
		return GetEnumerator();
	}

	public void Dispose()
	{
		if (m_WeOwnTheBuffer)
		{
			m_Buffer.Dispose();
			m_WeOwnTheBuffer = false;
			m_SizeInBytes = 0L;
			m_EventCount = 0;
		}
	}

	public InputEventBuffer Clone()
	{
		InputEventBuffer result = default(InputEventBuffer);
		if (m_Buffer.IsCreated)
		{
			result.m_Buffer = new NativeArray<byte>(m_Buffer.Length, Allocator.Persistent);
			result.m_Buffer.CopyFrom(m_Buffer);
			result.m_WeOwnTheBuffer = true;
		}
		result.m_SizeInBytes = m_SizeInBytes;
		result.m_EventCount = m_EventCount;
		return result;
	}

	object ICloneable.Clone()
	{
		return Clone();
	}
}
