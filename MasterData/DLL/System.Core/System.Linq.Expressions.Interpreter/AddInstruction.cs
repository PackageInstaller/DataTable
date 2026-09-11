using System.Dynamic.Utils;

namespace System.Linq.Expressions.Interpreter;

internal abstract class AddInstruction : Instruction
{
	private sealed class AddInt16 : AddInstruction
	{
		public override int Run(InterpretedFrame frame)
		{
			int stackIndex = frame.StackIndex;
			object[] data = frame.Data;
			object obj = data[stackIndex - 2];
			if (obj != null)
			{
				object obj2 = data[stackIndex - 1];
				data[stackIndex - 2] = ((obj2 == null) ? null : ((object)(short)((short)obj + (short)obj2)));
			}
			frame.StackIndex = stackIndex - 1;
			return 1;
		}
	}

	private sealed class AddInt32 : AddInstruction
	{
		public override int Run(InterpretedFrame frame)
		{
			int stackIndex = frame.StackIndex;
			object[] data = frame.Data;
			object obj = data[stackIndex - 2];
			if (obj != null)
			{
				object obj2 = data[stackIndex - 1];
				data[stackIndex - 2] = ((obj2 == null) ? null : ScriptingRuntimeHelpers.Int32ToObject((int)obj + (int)obj2));
			}
			frame.StackIndex = stackIndex - 1;
			return 1;
		}
	}

	private sealed class AddInt64 : AddInstruction
	{
		public override int Run(InterpretedFrame frame)
		{
			int stackIndex = frame.StackIndex;
			object[] data = frame.Data;
			object obj = data[stackIndex - 2];
			if (obj != null)
			{
				object obj2 = data[stackIndex - 1];
				data[stackIndex - 2] = ((obj2 == null) ? null : ((object)((long)obj + (long)obj2)));
			}
			frame.StackIndex = stackIndex - 1;
			return 1;
		}
	}

	private sealed class AddUInt16 : AddInstruction
	{
		public override int Run(InterpretedFrame frame)
		{
			int stackIndex = frame.StackIndex;
			object[] data = frame.Data;
			object obj = data[stackIndex - 2];
			if (obj != null)
			{
				object obj2 = data[stackIndex - 1];
				data[stackIndex - 2] = ((obj2 == null) ? null : ((object)(ushort)((ushort)obj + (ushort)obj2)));
			}
			frame.StackIndex = stackIndex - 1;
			return 1;
		}
	}

	private sealed class AddUInt32 : AddInstruction
	{
		public override int Run(InterpretedFrame frame)
		{
			int stackIndex = frame.StackIndex;
			object[] data = frame.Data;
			object obj = data[stackIndex - 2];
			if (obj != null)
			{
				object obj2 = data[stackIndex - 1];
				data[stackIndex - 2] = ((obj2 == null) ? null : ((object)((uint)obj + (uint)obj2)));
			}
			frame.StackIndex = stackIndex - 1;
			return 1;
		}
	}

	private sealed class AddUInt64 : AddInstruction
	{
		public override int Run(InterpretedFrame frame)
		{
			int stackIndex = frame.StackIndex;
			object[] data = frame.Data;
			object obj = data[stackIndex - 2];
			if (obj != null)
			{
				object obj2 = data[stackIndex - 1];
				data[stackIndex - 2] = ((obj2 == null) ? null : ((object)((ulong)obj + (ulong)obj2)));
			}
			frame.StackIndex = stackIndex - 1;
			return 1;
		}
	}

	private sealed class AddSingle : AddInstruction
	{
		public override int Run(InterpretedFrame frame)
		{
			int stackIndex = frame.StackIndex;
			object[] data = frame.Data;
			object obj = data[stackIndex - 2];
			if (obj != null)
			{
				object obj2 = data[stackIndex - 1];
				data[stackIndex - 2] = ((obj2 == null) ? null : ((object)((float)obj + (float)obj2)));
			}
			frame.StackIndex = stackIndex - 1;
			return 1;
		}
	}

	private sealed class AddDouble : AddInstruction
	{
		public override int Run(InterpretedFrame frame)
		{
			int stackIndex = frame.StackIndex;
			object[] data = frame.Data;
			object obj = data[stackIndex - 2];
			if (obj != null)
			{
				object obj2 = data[stackIndex - 1];
				data[stackIndex - 2] = ((obj2 == null) ? null : ((object)((double)obj + (double)obj2)));
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

	public override string InstructionName => "Add";

	private AddInstruction()
	{
	}

	public static Instruction Create(Type type)
	{
		return type.GetNonNullableType().GetTypeCode() switch
		{
			TypeCode.Int16 => s_Int16 ?? (s_Int16 = new AddInt16()), 
			TypeCode.Int32 => s_Int32 ?? (s_Int32 = new AddInt32()), 
			TypeCode.Int64 => s_Int64 ?? (s_Int64 = new AddInt64()), 
			TypeCode.UInt16 => s_UInt16 ?? (s_UInt16 = new AddUInt16()), 
			TypeCode.UInt32 => s_UInt32 ?? (s_UInt32 = new AddUInt32()), 
			TypeCode.UInt64 => s_UInt64 ?? (s_UInt64 = new AddUInt64()), 
			TypeCode.Single => s_Single ?? (s_Single = new AddSingle()), 
			TypeCode.Double => s_Double ?? (s_Double = new AddDouble()), 
			_ => throw ContractUtils.Unreachable, 
		};
	}
}
