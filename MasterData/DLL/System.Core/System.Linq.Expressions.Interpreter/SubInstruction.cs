using System.Dynamic.Utils;

namespace System.Linq.Expressions.Interpreter;

internal abstract class SubInstruction : Instruction
{
	private sealed class SubInt16 : SubInstruction
	{
		public override int Run(InterpretedFrame frame)
		{
			int stackIndex = frame.StackIndex;
			object[] data = frame.Data;
			object obj = data[stackIndex - 2];
			if (obj != null)
			{
				object obj2 = data[stackIndex - 1];
				data[stackIndex - 2] = ((obj2 == null) ? null : ((object)(short)((short)obj - (short)obj2)));
			}
			frame.StackIndex = stackIndex - 1;
			return 1;
		}
	}

	private sealed class SubInt32 : SubInstruction
	{
		public override int Run(InterpretedFrame frame)
		{
			int stackIndex = frame.StackIndex;
			object[] data = frame.Data;
			object obj = data[stackIndex - 2];
			if (obj != null)
			{
				object obj2 = data[stackIndex - 1];
				data[stackIndex - 2] = ((obj2 == null) ? null : ScriptingRuntimeHelpers.Int32ToObject((int)obj - (int)obj2));
			}
			frame.StackIndex = stackIndex - 1;
			return 1;
		}
	}

	private sealed class SubInt64 : SubInstruction
	{
		public override int Run(InterpretedFrame frame)
		{
			int stackIndex = frame.StackIndex;
			object[] data = frame.Data;
			object obj = data[stackIndex - 2];
			if (obj != null)
			{
				object obj2 = data[stackIndex - 1];
				data[stackIndex - 2] = ((obj2 == null) ? null : ((object)((long)obj - (long)obj2)));
			}
			frame.StackIndex = stackIndex - 1;
			return 1;
		}
	}

	private sealed class SubUInt16 : SubInstruction
	{
		public override int Run(InterpretedFrame frame)
		{
			int stackIndex = frame.StackIndex;
			object[] data = frame.Data;
			object obj = data[stackIndex - 2];
			if (obj != null)
			{
				object obj2 = data[stackIndex - 1];
				data[stackIndex - 2] = ((obj2 == null) ? null : ((object)(ushort)((ushort)obj - (ushort)obj2)));
			}
			frame.StackIndex = stackIndex - 1;
			return 1;
		}
	}

	private sealed class SubUInt32 : SubInstruction
	{
		public override int Run(InterpretedFrame frame)
		{
			int stackIndex = frame.StackIndex;
			object[] data = frame.Data;
			object obj = data[stackIndex - 2];
			if (obj != null)
			{
				object obj2 = data[stackIndex - 1];
				data[stackIndex - 2] = ((obj2 == null) ? null : ((object)((uint)obj - (uint)obj2)));
			}
			frame.StackIndex = stackIndex - 1;
			return 1;
		}
	}

	private sealed class SubUInt64 : SubInstruction
	{
		public override int Run(InterpretedFrame frame)
		{
			int stackIndex = frame.StackIndex;
			object[] data = frame.Data;
			object obj = data[stackIndex - 2];
			if (obj != null)
			{
				object obj2 = data[stackIndex - 1];
				data[stackIndex - 2] = ((obj2 == null) ? null : ((object)((ulong)obj - (ulong)obj2)));
			}
			frame.StackIndex = stackIndex - 1;
			return 1;
		}
	}

	private sealed class SubSingle : SubInstruction
	{
		public override int Run(InterpretedFrame frame)
		{
			int stackIndex = frame.StackIndex;
			object[] data = frame.Data;
			object obj = data[stackIndex - 2];
			if (obj != null)
			{
				object obj2 = data[stackIndex - 1];
				data[stackIndex - 2] = ((obj2 == null) ? null : ((object)((float)obj - (float)obj2)));
			}
			frame.StackIndex = stackIndex - 1;
			return 1;
		}
	}

	private sealed class SubDouble : SubInstruction
	{
		public override int Run(InterpretedFrame frame)
		{
			int stackIndex = frame.StackIndex;
			object[] data = frame.Data;
			object obj = data[stackIndex - 2];
			if (obj != null)
			{
				object obj2 = data[stackIndex - 1];
				data[stackIndex - 2] = ((obj2 == null) ? null : ((object)((double)obj - (double)obj2)));
			}
			frame.StackIndex = stackIndex - 1;
			return 1;
		}
	}

	private static Instruction s_Int16;

	private static Instruction s_Int32;

	private static Instruction s_Int64;

	private static Instruction s_UInt16;

	private static Instruction s_UInt32;

	private static Instruction s_UInt64;

	private static Instruction s_Single;

	private static Instruction s_Double;

	public override int ConsumedStack => 2;

	public override int ProducedStack => 1;

	public override string InstructionName => "Sub";

	private SubInstruction()
	{
	}

	public static Instruction Create(Type type)
	{
		return type.GetNonNullableType().GetTypeCode() switch
		{
			TypeCode.Int16 => s_Int16 ?? (s_Int16 = new SubInt16()), 
			TypeCode.Int32 => s_Int32 ?? (s_Int32 = new SubInt32()), 
			TypeCode.Int64 => s_Int64 ?? (s_Int64 = new SubInt64()), 
			TypeCode.UInt16 => s_UInt16 ?? (s_UInt16 = new SubUInt16()), 
			TypeCode.UInt32 => s_UInt32 ?? (s_UInt32 = new SubUInt32()), 
			TypeCode.UInt64 => s_UInt64 ?? (s_UInt64 = new SubUInt64()), 
			TypeCode.Single => s_Single ?? (s_Single = new SubSingle()), 
			TypeCode.Double => s_Double ?? (s_Double = new SubDouble()), 
			_ => throw ContractUtils.Unreachable, 
		};
	}
}
