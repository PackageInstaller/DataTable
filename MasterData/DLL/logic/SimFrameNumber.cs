using System;

public class SimFrameNumber : IComparable<SimFrameNumber>, IEquatable<SimFrameNumber>
{
	public static readonly SimFrameNumber First = new SimFrameNumber(1u);

	public static readonly SimFrameNumber Invalid = new SimFrameNumber(uint.MaxValue);

	private const uint kFirstFrameNumber = 1u;

	private const uint kFrameNumberZero = 0u;

	public static readonly SimFrameNumber MaximumValue = new SimFrameNumber(uint.MaxValue);

	private static object sLockIDCreation = new object();

	private static uint sNextFrameNumber = 1u;

	public static readonly SimFrameNumber Zero = new SimFrameNumber(0u);

	public uint FrameNumber { get; private set; }

	[Obsolete("For serialization only.")]
	public SimFrameNumber()
	{
	}

	private SimFrameNumber(uint newFrameNumber)
	{
		FrameNumber = newFrameNumber;
	}

	public int CompareTo(SimFrameNumber other)
	{
		return FrameNumber.CompareTo(other.FrameNumber);
	}

	internal static SimFrameNumber CreateSimFrameNumber()
	{
		lock (sLockIDCreation)
		{
			return new SimFrameNumber(sNextFrameNumber++);
		}
	}

	internal static SimFrameNumber CreateSimFrameNumber(uint newFrameNumber)
	{
		return new SimFrameNumber(newFrameNumber);
	}

	public bool Equals(SimFrameNumber id)
	{
		if (id != null)
		{
			return FrameNumber == id.FrameNumber;
		}
		return false;
	}

	public override bool Equals(object obj)
	{
		if (obj is SimFrameNumber)
		{
			return Equals((SimFrameNumber)obj);
		}
		return false;
	}

	public override int GetHashCode()
	{
		return (int)FrameNumber;
	}

	public static SimFrameNumber operator +(SimFrameNumber other, uint val)
	{
		return new SimFrameNumber(other.FrameNumber + val);
	}

	public static bool operator >(SimFrameNumber lhs, SimFrameNumber rhs)
	{
		if (rhs != null)
		{
			return lhs.FrameNumber > rhs.FrameNumber;
		}
		return false;
	}

	public static bool operator >=(SimFrameNumber lhs, SimFrameNumber rhs)
	{
		if (rhs != null)
		{
			return lhs.FrameNumber >= rhs.FrameNumber;
		}
		return false;
	}

	public static bool operator <(SimFrameNumber lhs, SimFrameNumber rhs)
	{
		if (rhs != null)
		{
			return lhs.FrameNumber < rhs.FrameNumber;
		}
		return false;
	}

	public static bool operator <=(SimFrameNumber lhs, SimFrameNumber rhs)
	{
		if (rhs != null)
		{
			return lhs.FrameNumber <= rhs.FrameNumber;
		}
		return false;
	}

	public static SimFrameNumber operator -(SimFrameNumber other, uint val)
	{
		return new SimFrameNumber(other.FrameNumber - val);
	}

	public static void ResetFrameCounter()
	{
		sNextFrameNumber = 1u;
	}

	public override string ToString()
	{
		if (this != Invalid)
		{
			return FrameNumber.ToString();
		}
		return "Frame INVALID";
	}
}
