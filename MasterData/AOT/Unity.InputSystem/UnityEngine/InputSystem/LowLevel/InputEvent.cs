using System;
using System.Runtime.InteropServices;
using Unity.Collections.LowLevel.Unsafe;
using UnityEngine.InputSystem.Utilities;
using UnityEngineInternal.Input;

namespace UnityEngine.InputSystem.LowLevel;

[StructLayout(LayoutKind.Explicit, Pack = 1, Size = 20)]
public struct InputEvent
{
	private const uint kHandledMask = 2147483648u;

	private const uint kIdMask = 2147483647u;

	internal const int kBaseEventSize = 20;

	public const int InvalidEventId = 0;

	internal const int kAlignment = 4;

	[FieldOffset(0)]
	private NativeInputEvent m_Event;

	public FourCC type
	{
		get
		{
			return new FourCC((int)m_Event.type);
		}
		set
		{
			m_Event.type = (NativeInputEventType)(int)value;
		}
	}

	public uint sizeInBytes
	{
		get
		{
			return m_Event.sizeInBytes;
		}
		set
		{
			if (value > 65535)
			{
				throw new ArgumentException("Maximum event size is " + ushort.MaxValue, "value");
			}
			m_Event.sizeInBytes = (ushort)value;
		}
	}

	public int eventId
	{
		get
		{
			return (int)((long)m_Event.eventId & 0x7FFFFFFFL);
		}
		set
		{
			m_Event.eventId = value | (int)(m_Event.eventId & 0x80000000u);
		}
	}

	public int deviceId
	{
		get
		{
			return m_Event.deviceId;
		}
		set
		{
			m_Event.deviceId = (ushort)value;
		}
	}

	public double time
	{
		get
		{
			return m_Event.time - InputRuntime.s_CurrentTimeOffsetToRealtimeSinceStartup;
		}
		set
		{
			m_Event.time = value + InputRuntime.s_CurrentTimeOffsetToRealtimeSinceStartup;
		}
	}

	internal double internalTime
	{
		get
		{
			return m_Event.time;
		}
		set
		{
			m_Event.time = value;
		}
	}

	public bool handled
	{
		get
		{
			return (m_Event.eventId & 0x80000000u) == 2147483648u;
		}
		set
		{
			if (value)
			{
				m_Event.eventId = (int)(m_Event.eventId | 0x80000000u);
			}
			else
			{
				m_Event.eventId = (int)((long)m_Event.eventId & 0x7FFFFFFFL);
			}
		}
	}

	public InputEvent(FourCC type, int sizeInBytes, int deviceId, double time = -1.0)
	{
		if (time < 0.0)
		{
			time = InputRuntime.s_Instance.currentTime;
		}
		m_Event.type = (NativeInputEventType)(int)type;
		m_Event.sizeInBytes = (ushort)sizeInBytes;
		m_Event.deviceId = (ushort)deviceId;
		m_Event.time = time;
		m_Event.eventId = 0;
	}

	public override string ToString()
	{
		return $"id={eventId} type={type} device={deviceId} size={sizeInBytes} time={time}";
	}

	internal unsafe static InputEvent* GetNextInMemory(InputEvent* currentPtr)
	{
		uint num = currentPtr->sizeInBytes.AlignToMultipleOf(4u);
		return (InputEvent*)((byte*)currentPtr + num);
	}

	internal unsafe static InputEvent* GetNextInMemoryChecked(InputEvent* currentPtr, ref InputEventBuffer buffer)
	{
		uint num = currentPtr->sizeInBytes.AlignToMultipleOf(4u);
		InputEvent* ptr = (InputEvent*)((byte*)currentPtr + num);
		if (!buffer.Contains(ptr))
		{
			throw new InvalidOperationException($"Event '{new InputEventPtr(currentPtr)}' is last event in given buffer with size {buffer.sizeInBytes}");
		}
		return ptr;
	}

	public unsafe static bool Equals(InputEvent* first, InputEvent* second)
	{
		if (first == second)
		{
			return true;
		}
		if (first == null || second == null)
		{
			return false;
		}
		if (first->m_Event.sizeInBytes != second->m_Event.sizeInBytes)
		{
			return false;
		}
		return UnsafeUtility.MemCmp(first, second, first->m_Event.sizeInBytes) == 0;
	}
}
