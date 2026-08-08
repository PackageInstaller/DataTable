using System;

namespace UnityEngine.Rendering;

public struct StencilState : IEquatable<StencilState>
{
	private byte m_Enabled;

	private byte m_ReadMask;

	private byte m_WriteMask;

	private byte m_Padding;

	private byte m_CompareFunctionFront;

	private byte m_PassOperationFront;

	private byte m_FailOperationFront;

	private byte m_ZFailOperationFront;

	private byte m_CompareFunctionBack;

	private byte m_PassOperationBack;

	private byte m_FailOperationBack;

	private byte m_ZFailOperationBack;

	public static StencilState defaultValue => new StencilState(true, byte.MaxValue, byte.MaxValue, CompareFunction.Always, StencilOp.Keep, StencilOp.Keep, StencilOp.Keep);

	public bool enabled
	{
		set
		{
			m_Enabled = Convert.ToByte(value);
		}
	}

	public byte readMask
	{
		set
		{
			m_ReadMask = value;
		}
	}

	public byte writeMask
	{
		set
		{
			m_WriteMask = value;
		}
	}

	public CompareFunction compareFunctionFront
	{
		set
		{
			m_CompareFunctionFront = (byte)value;
		}
	}

	public StencilOp passOperationFront
	{
		set
		{
			m_PassOperationFront = (byte)value;
		}
	}

	public StencilOp failOperationFront
	{
		set
		{
			m_FailOperationFront = (byte)value;
		}
	}

	public StencilOp zFailOperationFront
	{
		set
		{
			m_ZFailOperationFront = (byte)value;
		}
	}

	public CompareFunction compareFunctionBack
	{
		set
		{
			m_CompareFunctionBack = (byte)value;
		}
	}

	public StencilOp passOperationBack
	{
		set
		{
			m_PassOperationBack = (byte)value;
		}
	}

	public StencilOp failOperationBack
	{
		set
		{
			m_FailOperationBack = (byte)value;
		}
	}

	public StencilOp zFailOperationBack
	{
		set
		{
			m_ZFailOperationBack = (byte)value;
		}
	}

	public StencilState(bool enabled = true, byte readMask = byte.MaxValue, byte writeMask = byte.MaxValue, CompareFunction compareFunction = CompareFunction.Always, StencilOp passOperation = StencilOp.Keep, StencilOp failOperation = StencilOp.Keep, StencilOp zFailOperation = StencilOp.Keep)
		: this(enabled, readMask, writeMask, compareFunction, passOperation, failOperation, zFailOperation, compareFunction, passOperation, failOperation, zFailOperation)
	{
	}

	public StencilState(bool enabled, byte readMask, byte writeMask, CompareFunction compareFunctionFront, StencilOp passOperationFront, StencilOp failOperationFront, StencilOp zFailOperationFront, CompareFunction compareFunctionBack, StencilOp passOperationBack, StencilOp failOperationBack, StencilOp zFailOperationBack)
	{
		m_Enabled = Convert.ToByte(enabled);
		m_ReadMask = readMask;
		m_WriteMask = writeMask;
		m_Padding = 0;
		m_CompareFunctionFront = (byte)compareFunctionFront;
		m_PassOperationFront = (byte)passOperationFront;
		m_FailOperationFront = (byte)failOperationFront;
		m_ZFailOperationFront = (byte)zFailOperationFront;
		m_CompareFunctionBack = (byte)compareFunctionBack;
		m_PassOperationBack = (byte)passOperationBack;
		m_FailOperationBack = (byte)failOperationBack;
		m_ZFailOperationBack = (byte)zFailOperationBack;
	}

	public void SetCompareFunction(CompareFunction value)
	{
		compareFunctionFront = value;
		compareFunctionBack = value;
	}

	public bool Equals(StencilState other)
	{
		return m_Enabled == other.m_Enabled && m_ReadMask == other.m_ReadMask && m_WriteMask == other.m_WriteMask && m_CompareFunctionFront == other.m_CompareFunctionFront && m_PassOperationFront == other.m_PassOperationFront && m_FailOperationFront == other.m_FailOperationFront && m_ZFailOperationFront == other.m_ZFailOperationFront && m_CompareFunctionBack == other.m_CompareFunctionBack && m_PassOperationBack == other.m_PassOperationBack && m_FailOperationBack == other.m_FailOperationBack && m_ZFailOperationBack == other.m_ZFailOperationBack;
	}

	public override bool Equals(object obj)
	{
		if (obj == null)
		{
			return false;
		}
		return obj is StencilState && Equals((StencilState)obj);
	}

	public override int GetHashCode()
	{
		int hashCode = m_Enabled.GetHashCode();
		hashCode = (hashCode * 397) ^ m_ReadMask.GetHashCode();
		hashCode = (hashCode * 397) ^ m_WriteMask.GetHashCode();
		hashCode = (hashCode * 397) ^ m_CompareFunctionFront.GetHashCode();
		hashCode = (hashCode * 397) ^ m_PassOperationFront.GetHashCode();
		hashCode = (hashCode * 397) ^ m_FailOperationFront.GetHashCode();
		hashCode = (hashCode * 397) ^ m_ZFailOperationFront.GetHashCode();
		hashCode = (hashCode * 397) ^ m_CompareFunctionBack.GetHashCode();
		hashCode = (hashCode * 397) ^ m_PassOperationBack.GetHashCode();
		hashCode = (hashCode * 397) ^ m_FailOperationBack.GetHashCode();
		return (hashCode * 397) ^ m_ZFailOperationBack.GetHashCode();
	}
}
