using System.Runtime.InteropServices;
using UnityEngine.InputSystem.Layouts;
using UnityEngine.InputSystem.Utilities;

namespace UnityEngine.InputSystem.LowLevel;

[StructLayout(LayoutKind.Explicit, Size = 56)]
public struct TouchState : IInputStateTypeInfo
{
	internal const int kSizeInBytes = 56;

	[FieldOffset(0)]
	[InputControl(displayName = "Touch ID", layout = "Integer", synthetic = true, dontReset = true)]
	public int touchId;

	[FieldOffset(4)]
	[InputControl(displayName = "Position", dontReset = true)]
	public Vector2 position;

	[FieldOffset(12)]
	[InputControl(displayName = "Delta", layout = "Delta")]
	public Vector2 delta;

	[FieldOffset(20)]
	[InputControl(displayName = "Pressure", layout = "Axis")]
	public float pressure;

	[FieldOffset(24)]
	[InputControl(displayName = "Radius")]
	public Vector2 radius;

	[FieldOffset(32)]
	[InputControl(name = "phase", displayName = "Touch Phase", layout = "TouchPhase", synthetic = true)]
	[InputControl(name = "press", displayName = "Touch Contact?", layout = "TouchPress", useStateFrom = "phase")]
	public byte phaseId;

	[FieldOffset(33)]
	[InputControl(name = "tapCount", displayName = "Tap Count", layout = "Integer")]
	public byte tapCount;

	[FieldOffset(34)]
	[InputControl(name = "displayIndex", displayName = "Display Index", layout = "Integer")]
	public byte displayIndex;

	[FieldOffset(35)]
	[InputControl(name = "indirectTouch", displayName = "Indirect Touch?", layout = "Button", bit = 0u, synthetic = true)]
	[InputControl(name = "tap", displayName = "Tap", layout = "Button", bit = 4u)]
	public byte flags;

	[FieldOffset(36)]
	internal uint updateStepCount;

	[FieldOffset(40)]
	[InputControl(displayName = "Start Time", layout = "Double", synthetic = true)]
	public double startTime;

	[FieldOffset(48)]
	[InputControl(displayName = "Start Position", synthetic = true)]
	public Vector2 startPosition;

	public static FourCC Format => new FourCC('T', 'O', 'U', 'C');

	public TouchPhase phase
	{
		get
		{
			return (TouchPhase)phaseId;
		}
		set
		{
			phaseId = (byte)value;
		}
	}

	public bool isNoneEndedOrCanceled
	{
		get
		{
			if (phase != TouchPhase.None && phase != TouchPhase.Ended)
			{
				return phase == TouchPhase.Canceled;
			}
			return true;
		}
	}

	public bool isInProgress
	{
		get
		{
			if (phase != TouchPhase.Began && phase != TouchPhase.Moved)
			{
				return phase == TouchPhase.Stationary;
			}
			return true;
		}
	}

	public bool isPrimaryTouch
	{
		get
		{
			return (flags & 8) != 0;
		}
		set
		{
			if (value)
			{
				flags |= 8;
			}
			else
			{
				flags &= 247;
			}
		}
	}

	internal bool isOrphanedPrimaryTouch
	{
		get
		{
			return (flags & 0x40) != 0;
		}
		set
		{
			if (value)
			{
				flags |= 64;
			}
			else
			{
				flags &= 191;
			}
		}
	}

	public bool isIndirectTouch
	{
		get
		{
			return (flags & 1) != 0;
		}
		set
		{
			if (value)
			{
				flags |= 1;
			}
			else
			{
				flags &= 254;
			}
		}
	}

	public bool isTap
	{
		get
		{
			return isTapPress;
		}
		set
		{
			isTapPress = value;
		}
	}

	internal bool isTapPress
	{
		get
		{
			return (flags & 0x10) != 0;
		}
		set
		{
			if (value)
			{
				flags |= 16;
			}
			else
			{
				flags &= 239;
			}
		}
	}

	internal bool isTapRelease
	{
		get
		{
			return (flags & 0x20) != 0;
		}
		set
		{
			if (value)
			{
				flags |= 32;
			}
			else
			{
				flags &= 223;
			}
		}
	}

	internal bool beganInSameFrame
	{
		get
		{
			return (flags & 0x80) != 0;
		}
		set
		{
			if (value)
			{
				flags |= 128;
			}
			else
			{
				flags &= 127;
			}
		}
	}

	public FourCC format => Format;

	public override string ToString()
	{
		return $"{{ id={touchId} phase={phase} pos={position} delta={delta} pressure={pressure} radius={radius} primary={isPrimaryTouch} }}";
	}
}
