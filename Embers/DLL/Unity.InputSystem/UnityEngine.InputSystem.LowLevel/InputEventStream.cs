using Unity.Collections;
using Unity.Collections.LowLevel.Unsafe;

namespace UnityEngine.InputSystem.LowLevel;

internal struct InputEventStream
{
	private InputEventBuffer m_NativeBuffer;

	private unsafe InputEvent* m_CurrentNativeEventReadPtr;

	private unsafe InputEvent* m_CurrentNativeEventWritePtr;

	private int m_RemainingNativeEventCount;

	private readonly int m_MaxAppendedEvents;

	private InputEventBuffer m_AppendBuffer;

	private unsafe InputEvent* m_CurrentAppendEventReadPtr;

	private unsafe InputEvent* m_CurrentAppendEventWritePtr;

	private int m_RemainingAppendEventCount;

	private int m_NumEventsRetainedInBuffer;

	private bool m_IsOpen;

	public bool isOpen => m_IsOpen;

	public int remainingEventCount => m_RemainingNativeEventCount + m_RemainingAppendEventCount;

	public int numEventsRetainedInBuffer => m_NumEventsRetainedInBuffer;

	public unsafe InputEvent* currentEventPtr
	{
		get
		{
			if (m_RemainingNativeEventCount <= 0)
			{
				if (m_RemainingAppendEventCount <= 0)
				{
					return null;
				}
				return m_CurrentAppendEventReadPtr;
			}
			return m_CurrentNativeEventReadPtr;
		}
	}

	public unsafe uint numBytesRetainedInBuffer => (uint)((byte*)m_CurrentNativeEventWritePtr - (byte*)NativeArrayUnsafeUtility.GetUnsafeBufferPointerWithoutChecks(m_NativeBuffer.data));

	public unsafe InputEventStream(ref InputEventBuffer eventBuffer, int maxAppendedEvents)
	{
		m_CurrentNativeEventWritePtr = (m_CurrentNativeEventReadPtr = (InputEvent*)NativeArrayUnsafeUtility.GetUnsafeBufferPointerWithoutChecks(eventBuffer.data));
		m_NativeBuffer = eventBuffer;
		m_RemainingNativeEventCount = m_NativeBuffer.eventCount;
		m_NumEventsRetainedInBuffer = 0;
		m_CurrentAppendEventReadPtr = (m_CurrentAppendEventWritePtr = null);
		m_AppendBuffer = default(InputEventBuffer);
		m_RemainingAppendEventCount = 0;
		m_MaxAppendedEvents = maxAppendedEvents;
		m_IsOpen = true;
	}

	public unsafe void Close(ref InputEventBuffer eventBuffer)
	{
		if (m_NumEventsRetainedInBuffer > 0)
		{
			void* unsafeBufferPointerWithoutChecks = NativeArrayUnsafeUtility.GetUnsafeBufferPointerWithoutChecks(m_NativeBuffer.data);
			long num = (byte*)m_CurrentNativeEventWritePtr - (byte*)unsafeBufferPointerWithoutChecks;
			m_NativeBuffer = new InputEventBuffer((InputEvent*)unsafeBufferPointerWithoutChecks, m_NumEventsRetainedInBuffer, (int)num, (int)m_NativeBuffer.capacityInBytes);
		}
		else
		{
			m_NativeBuffer.Reset();
		}
		if (m_AppendBuffer.data.IsCreated)
		{
			m_AppendBuffer.Dispose();
		}
		eventBuffer = m_NativeBuffer;
		m_IsOpen = false;
	}

	public void CleanUpAfterException()
	{
		if (isOpen)
		{
			m_NativeBuffer.Reset();
			if (m_AppendBuffer.data.IsCreated)
			{
				m_AppendBuffer.Dispose();
			}
			m_IsOpen = false;
		}
	}

	public unsafe void Write(InputEvent* eventPtr)
	{
		if (m_AppendBuffer.eventCount >= m_MaxAppendedEvents)
		{
			Debug.LogError("Maximum number of queued events exceeded. Set the 'maxQueuedEventsPerUpdate' setting to a higher value if you need to queue more events than this. " + $"Current limit is '{m_MaxAppendedEvents}'.");
			return;
		}
		bool isCreated = m_AppendBuffer.data.IsCreated;
		byte* data = (byte*)m_AppendBuffer.bufferPtr.data;
		m_AppendBuffer.AppendEvent(eventPtr, 2048, Allocator.Temp);
		if (!isCreated)
		{
			m_CurrentAppendEventWritePtr = (m_CurrentAppendEventReadPtr = (InputEvent*)NativeArrayUnsafeUtility.GetUnsafeBufferPointerWithoutChecks(m_AppendBuffer.data));
		}
		else
		{
			byte* data2 = (byte*)m_AppendBuffer.bufferPtr.data;
			if (data != data2)
			{
				long num = (byte*)m_CurrentAppendEventWritePtr - data;
				long num2 = (byte*)m_CurrentAppendEventReadPtr - data;
				m_CurrentAppendEventWritePtr = (InputEvent*)(data2 + num);
				m_CurrentAppendEventReadPtr = (InputEvent*)(data2 + num2);
			}
		}
		m_RemainingAppendEventCount++;
	}

	public unsafe InputEvent* Advance(bool leaveEventInBuffer)
	{
		if (m_RemainingNativeEventCount > 0)
		{
			m_NativeBuffer.AdvanceToNextEvent(ref m_CurrentNativeEventReadPtr, ref m_CurrentNativeEventWritePtr, ref m_NumEventsRetainedInBuffer, ref m_RemainingNativeEventCount, leaveEventInBuffer);
		}
		else if (m_RemainingAppendEventCount > 0)
		{
			int num = 0;
			m_AppendBuffer.AdvanceToNextEvent(ref m_CurrentAppendEventReadPtr, ref m_CurrentAppendEventWritePtr, ref num, ref m_RemainingAppendEventCount, leaveEventInBuffer: false);
		}
		return currentEventPtr;
	}

	public unsafe InputEvent* Peek()
	{
		if (m_RemainingNativeEventCount > 1)
		{
			return InputEvent.GetNextInMemory(m_CurrentNativeEventReadPtr);
		}
		if (m_RemainingNativeEventCount == 1)
		{
			if (m_RemainingAppendEventCount <= 0)
			{
				return null;
			}
			return m_CurrentAppendEventReadPtr;
		}
		if (m_RemainingAppendEventCount > 1)
		{
			return InputEvent.GetNextInMemory(m_CurrentAppendEventReadPtr);
		}
		return null;
	}
}
