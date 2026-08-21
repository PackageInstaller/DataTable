using System.Dynamic.Utils;

namespace System.Linq.Expressions.Interpreter;

internal abstract class SubOvfInstruction : Instruction
{
	private sealed class SubOvfInt16 : SubOvfInstruction
	{
		public override int Run(InterpretedFrame frame)
		{
			int stackIndex = frame.StackIndex;
			object[] data = frame.Data;
			object obj = data[stackIndex - 2];
			if (obj != null)
			{
				object obj2 = data[stackIndex - 1];
				data[stackIndex - 2] = ((obj2 == null) ? null : ((object)checked((short)((short)obj - (short)obj2))));
			}
			frame.StackIndex = stackIndex - 1;
			return 1;
		}
	}

	private sealed class SubOvfInt32 : SubOvfInstruction
	{
		public override int Run(InterpretedFrame frame)
		{
			int stackIndex = frame.StackIndex;
			object[] data = frame.Data;
			object obj = data[stackIndex - 2];
			if (obj != null)
			{
				object obj2 = data[stackIndex - 1];
				data[stackIndex - 2] = ((obj2 == null) ? null : ScriptingRuntimeHelpers.Int32ToObject(checked((int)obj - (int)obj2)));
			}
			frame.StackIndex = stackIndex - 1;
			return 1;
		}
	}

	private sealed class SubOvfInt64 : SubOvfInstruction
	{
		public override int Run(InterpretedFrame frame)
		{
			int stackIndex = frame.StackIndex;
			object[] data = frame.Data;
			object obj = data[stackIndex - 2];
			if (obj != null)
			{
				object obj2 = data[stackIndex - 1];
				data[stackIndex - 2] = ((obj2 == null) ? null : ((object)checked((long)obj - (long)obj2)));
			}
			frame.StackIndex = stackIndex - 1;
			return 1;
		}
	}

	private sealed class SubOvfUInt16 : SubOvfInstruction
	{
		public override int Run(InterpretedFrame frame)
		{
			int stackIndex = frame.StackIndex;
			object[] data = frame.Data;
			object obj = data[stackIndex - 2];
			if (obj != null)
			{
				object obj2 = data[stackIndex - 1];
				data[stackIndex - 2] = ((obj2 == null) ? null : ((object)checked((ushort)((ushort)obj - (ushort)obj2))));
			}
			frame.StackIndex = stackIndex - 1;
			return 1;
		}
	}

	private sealed class SubOvfUInt32 : SubOvfInstruction
	{
		public override int Run(InterpretedFrame frame)
		{
			int stackIndex = frame.StackIndex;
			object[] data = frame.Data;
			object obj = data[stackIndex - 2];
			if (obj != null)
			{
				object obj2 = data[stackIndex - 1];
				data[stackIndex - 2] = ((obj2 == null) ? null : ((object)checked((uint)obj - (uint)obj2)));
			}
			frame.StackIndex = stackIndex - 1;
			return 1;
		}
	}

	private sealed class SubOvfUInt64 : SubOvfInstruction
	{
		public override int Run(InterpretedFrame frame)
		{
			int stackIndex = frame.StackIndex;
			object[] data = frame.Data;
			object obj = data[stackIndex - 2];
			if (obj != null)
			{
				object obj2 = data[stackIndex - 1];
				data[stackIndex - 2] = ((obj2 == null) ? null : ((object)checked((ulong)obj - (ulong)obj2)));
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

	public override int ConsumedStack => 2;

	public override int ProducedStack => 1;

	public override string InstructionName => "SubOvf";

	private SubOvfInstruction()
	{
	}

	public static Instruction Create(Type type)
	{
		return type.GetNonNullableType().GetTypeCode() switch
		{
			TypeCode.Int16 => s_Int16 ?? (s_Int16 = new SubOvfInt16()), 
			TypeCode.Int32 => s_Int32 ?? (s_Int32 = new SubOvfInt32()), 
			TypeCode.Int64 => s_Int64 ?? (s_Int64 = new SubOvfInt64()), 
			TypeCode.UInt16 => s_UInt16 ?? (s_UInt16 = new SubOvfUInt16()), 
			TypeCode.UInt32 => s_UInt32 ?? (s_UInt32 = new SubOvfUInt32()), 
			TypeCode.UInt64 => s_UInt64 ?? (s_UInt64 = new SubOvfUInt64()), 
			_ => SubInstruction.Create(type), 
		};
	}
}
