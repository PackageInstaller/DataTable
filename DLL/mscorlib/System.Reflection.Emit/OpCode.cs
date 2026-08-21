using System.Runtime.InteropServices;

namespace System.Reflection.Emit;

[ComVisible(true)]
public readonly struct OpCode : IEquatable<OpCode>
{
	internal readonly byte op1;

	internal readonly byte op2;

	private readonly byte push;

	private readonly byte pop;

	private readonly byte size;

	private readonly byte type;

	private readonly byte args;

	private readonly byte flow;

	public string Name
	{
		get
		{
			if (op1 == byte.MaxValue)
			{
				return OpCodeNames.names[op2];
			}
			return OpCodeNames.names[256 + op2];
		}
	}

	internal OpCode(int p, int q)
	{
		op1 = (byte)(p & 0xFF);
		op2 = (byte)((p >> 8) & 0xFF);
		push = (byte)((p >> 16) & 0xFF);
		pop = (byte)((p >> 24) & 0xFF);
		size = (byte)(q & 0xFF);
		type = (byte)((q >> 8) & 0xFF);
		args = (byte)((q >> 16) & 0xFF);
		flow = (byte)((q >> 24) & 0xFF);
	}

	public override int GetHashCode()
	{
		return Name.GetHashCode();
	}

	public override bool Equals(object obj)
	{
		if (obj == null || !(obj is OpCode opCode))
		{
			return false;
		}
		if (opCode.op1 == op1)
		{
			return opCode.op2 == op2;
		}
		return false;
	}

	public bool Equals(OpCode obj)
	{
		if (obj.op1 == op1)
		{
			return obj.op2 == op2;
		}
		return false;
	}

	public override string ToString()
	{
		return Name;
	}
}
