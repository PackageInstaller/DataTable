using System.Runtime.InteropServices;
using Config;

[StructLayout(LayoutKind.Explicit)]
public struct SimVar
{
	[FieldOffset(0)]
	public bool boolVar;

	[FieldOffset(0)]
	public int intVar;

	[FieldOffset(0)]
	public Int3 int3Var;

	[FieldOffset(0)]
	public Int2 int2Var;

	[FieldOffset(0)]
	public Int IntVar;

	[FieldOffset(0)]
	public long longVar;

	public static SimVar NULL;

	public static implicit operator SimVar(int ob)
	{
		return new SimVar
		{
			intVar = ob
		};
	}

	public static implicit operator int(SimVar var)
	{
		return var.intVar;
	}

	public static implicit operator SimVar(long ob)
	{
		return new SimVar
		{
			longVar = ob
		};
	}

	public static implicit operator long(SimVar var)
	{
		return var.longVar;
	}

	public static implicit operator SimVar(Int3 ob)
	{
		return new SimVar
		{
			int3Var = ob
		};
	}

	public static implicit operator Int3(SimVar var)
	{
		return var.int3Var;
	}

	public static implicit operator SimVar(RoleType ob)
	{
		return new SimVar
		{
			intVar = (int)ob
		};
	}

	public static implicit operator RoleType(SimVar var)
	{
		return (RoleType)var.intVar;
	}

	public static implicit operator SimVar(Int2 ob)
	{
		return new SimVar
		{
			int2Var = ob
		};
	}

	public static implicit operator Int2(SimVar var)
	{
		return var.int2Var;
	}

	public static implicit operator SimVar(Int ob)
	{
		return new SimVar
		{
			IntVar = ob
		};
	}

	public static implicit operator Int(SimVar var)
	{
		return var.IntVar;
	}

	public static implicit operator SimVar(bool ob)
	{
		return new SimVar
		{
			boolVar = ob
		};
	}

	public static implicit operator bool(SimVar var)
	{
		return var.boolVar;
	}

	public static implicit operator SimVar(VFactor ob)
	{
		return new SimVar
		{
			intVar = ((Int)ob).i
		};
	}

	public static implicit operator VFactor(SimVar var)
	{
		return new VFactor(var.intVar, 1000L);
	}

	public static bool operator ==(SimVar lhs, bool rhs)
	{
		return lhs.boolVar == rhs;
	}

	public static bool operator !=(SimVar lhs, bool rhs)
	{
		return lhs.boolVar != rhs;
	}

	public static bool operator ==(SimVar lhs, Int3 rhs)
	{
		return lhs.int3Var == rhs;
	}

	public static bool operator !=(SimVar lhs, Int3 rhs)
	{
		return lhs.int3Var != rhs;
	}

	public static bool operator ==(SimVar lhs, int rhs)
	{
		return lhs.intVar == rhs;
	}

	public static bool operator !=(SimVar lhs, int rhs)
	{
		return lhs.intVar != rhs;
	}

	public static bool operator ==(SimVar lhs, long rhs)
	{
		return lhs.longVar == rhs;
	}

	public static bool operator !=(SimVar lhs, long rhs)
	{
		return lhs.longVar != rhs;
	}

	public static bool operator ==(SimVar lhs, Int rhs)
	{
		return lhs.IntVar == rhs;
	}

	public static bool operator !=(SimVar lhs, Int rhs)
	{
		return lhs.IntVar != rhs;
	}

	public static bool operator ==(SimVar lhs, Int2 rhs)
	{
		return lhs.int2Var == rhs;
	}

	public static bool operator !=(SimVar lhs, Int2 rhs)
	{
		return lhs.int2Var != rhs;
	}

	public override bool Equals(object obj)
	{
		if (obj is int)
		{
			return intVar == (int)obj;
		}
		if (obj is bool)
		{
			return boolVar == (bool)obj;
		}
		if (obj is Int3)
		{
			return int3Var == (Int3)obj;
		}
		if (obj is Int2)
		{
			return int2Var == (Int2)obj;
		}
		if (obj is long)
		{
			return longVar == (long)obj;
		}
		return false;
	}

	public override int GetHashCode()
	{
		return intVar.GetHashCode() * 23 + boolVar.GetHashCode() * 23 * 23 + int3Var.GetHashCode();
	}

	public override string ToString()
	{
		return intVar.ToString();
	}
}
