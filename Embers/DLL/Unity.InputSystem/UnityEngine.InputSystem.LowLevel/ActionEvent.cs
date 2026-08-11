using System;
using System.Runtime.InteropServices;
using UnityEngine.InputSystem.Utilities;

namespace UnityEngine.InputSystem.LowLevel;

[StructLayout(LayoutKind.Explicit, Size = 37)]
internal struct ActionEvent : IInputEventTypeInfo
{
	[FieldOffset(0)]
	public InputEvent baseEvent;

	[FieldOffset(20)]
	private ushort m_ControlIndex;

	[FieldOffset(22)]
	private ushort m_BindingIndex;

	[FieldOffset(24)]
	private ushort m_InteractionIndex;

	[FieldOffset(26)]
	private byte m_StateIndex;

	[FieldOffset(27)]
	private byte m_Phase;

	[FieldOffset(28)]
	private double m_StartTime;

	[FieldOffset(36)]
	public unsafe fixed byte m_ValueData[1];

	public static FourCC Type => new FourCC('A', 'C', 'T', 'N');

	public double startTime
	{
		get
		{
			return m_StartTime;
		}
		set
		{
			m_StartTime = value;
		}
	}

	public InputActionPhase phase
	{
		get
		{
			return (InputActionPhase)m_Phase;
		}
		set
		{
			m_Phase = (byte)value;
		}
	}

	public unsafe byte* valueData
	{
		get
		{
			fixed (byte* result = m_ValueData)
			{
				return result;
			}
		}
	}

	public int valueSizeInBytes => (int)(baseEvent.sizeInBytes - 20 - 16);

	public int stateIndex
	{
		get
		{
			return m_StateIndex;
		}
		set
		{
			if (value < 0 || value > 255)
			{
				throw new NotSupportedException("State count cannot exceed byte.MaxValue");
			}
			m_StateIndex = (byte)value;
		}
	}

	public int controlIndex
	{
		get
		{
			return m_ControlIndex;
		}
		set
		{
			if (value < 0 || value > 65535)
			{
				throw new NotSupportedException("Control count cannot exceed ushort.MaxValue");
			}
			m_ControlIndex = (ushort)value;
		}
	}

	public int bindingIndex
	{
		get
		{
			return m_BindingIndex;
		}
		set
		{
			if (value < 0 || value > 65535)
			{
				throw new NotSupportedException("Binding count cannot exceed ushort.MaxValue");
			}
			m_BindingIndex = (ushort)value;
		}
	}

	public int interactionIndex
	{
		get
		{
			if (m_InteractionIndex == ushort.MaxValue)
			{
				return -1;
			}
			return m_InteractionIndex;
		}
		set
		{
			if (value == -1)
			{
				m_InteractionIndex = ushort.MaxValue;
				return;
			}
			if (value < 0 || value >= 65535)
			{
				throw new NotSupportedException("Interaction count cannot exceed ushort.MaxValue-1");
			}
			m_InteractionIndex = (ushort)value;
		}
	}

	public FourCC typeStatic => Type;

	public unsafe InputEventPtr ToEventPtr()
	{
		fixed (ActionEvent* eventPtr = &this)
		{
			return new InputEventPtr((InputEvent*)eventPtr);
		}
	}

	public static int GetEventSizeWithValueSize(int valueSizeInBytes)
	{
		return 36 + valueSizeInBytes;
	}

	public unsafe static ActionEvent* From(InputEventPtr ptr)
	{
		if (!ptr.valid)
		{
			throw new ArgumentNullException("ptr");
		}
		if (!ptr.IsA<ActionEvent>())
		{
			throw new InvalidCastException($"Cannot cast event with type '{ptr.type}' into ActionEvent");
		}
		return (ActionEvent*)ptr.data;
	}
}
