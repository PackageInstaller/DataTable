using System.Dynamic.Utils;

namespace System.Linq.Expressions.Interpreter;

internal abstract class ExclusiveOrInstruction : Instruction
{
	private sealed class ExclusiveOrSByte : ExclusiveOrInstruction
	{
		public override int Run(InterpretedFrame frame)
		{
			object obj = frame.Pop();
			object obj2 = frame.Pop();
			if (obj == null || obj2 == null)
			{
				frame.Push(null);
				return 1;
			}
			frame.Push((sbyte)((sbyte)obj ^ (sbyte)obj2));
			return 1;
		}
	}

	private sealed class ExclusiveOrInt16 : ExclusiveOrInstruction
	{
		public override int Run(InterpretedFrame frame)
		{
			object obj = frame.Pop();
			object obj2 = frame.Pop();
			if (obj == null || obj2 == null)
			{
				frame.Push(null);
				return 1;
			}
			frame.Push((short)((short)obj ^ (short)obj2));
			return 1;
		}
	}

	private sealed class ExclusiveOrInt32 : ExclusiveOrInstruction
	{
		public override int Run(InterpretedFrame frame)
		{
			object obj = frame.Pop();
			object obj2 = frame.Pop();
			if (obj == null || obj2 == null)
			{
				frame.Push(null);
				return 1;
			}
			frame.Push((int)obj ^ (int)obj2);
			return 1;
		}
	}

	private sealed class ExclusiveOrInt64 : ExclusiveOrInstruction
	{
		public override int Run(InterpretedFrame frame)
		{
			object obj = frame.Pop();
			object obj2 = frame.Pop();
			if (obj == null || obj2 == null)
			{
				frame.Push(null);
				return 1;
			}
			frame.Push((long)obj ^ (long)obj2);
			return 1;
		}
	}

	private sealed class ExclusiveOrByte : ExclusiveOrInstruction
	{
		public override int Run(InterpretedFrame frame)
		{
			object obj = frame.Pop();
			object obj2 = frame.Pop();
			if (obj == null || obj2 == null)
			{
				frame.Push(null);
				return 1;
			}
			frame.Push((byte)((byte)obj ^ (byte)obj2));
			return 1;
		}
	}

	private sealed class ExclusiveOrUInt16 : ExclusiveOrInstruction
	{
		public override int Run(InterpretedFrame frame)
		{
			object obj = frame.Pop();
			object obj2 = frame.Pop();
			if (obj == null || obj2 == null)
			{
				frame.Push(null);
				return 1;
			}
			frame.Push((ushort)((ushort)obj ^ (ushort)obj2));
			return 1;
		}
	}

	private sealed class ExclusiveOrUInt32 : ExclusiveOrInstruction
	{
		public override int Run(InterpretedFrame frame)
		{
			object obj = frame.Pop();
			object obj2 = frame.Pop();
			if (obj == null || obj2 == null)
			{
				frame.Push(null);
				return 1;
			}
			frame.Push((uint)obj ^ (uint)obj2);
			return 1;
		}
	}

	private sealed class ExclusiveOrUInt64 : ExclusiveOrInstruction
	{
		public override int Run(InterpretedFrame frame)
		{
			object obj = frame.Pop();
			object obj2 = frame.Pop();
			if (obj == null || obj2 == null)
			{
				frame.Push(null);
				return 1;
			}
			frame.Push((ulong)obj ^ (ulong)obj2);
			return 1;
		}
	}

	private sealed class ExclusiveOrBoolean : ExclusiveOrInstruction
	{
		public override int Run(InterpretedFrame frame)
		{
			object obj = frame.Pop();
			object obj2 = frame.Pop();
			if (obj == null || obj2 == null)
			{
				frame.Push(null);
				return 1;
			}
			frame.Push((bool)obj ^ (bool)obj2);
			return 1;
		}
	}

	private static Instruction s_SByte;

	private static Instruction s_Int16;

	private static Instruction s_Int32;

	private static Instruction s_Int64;

	private static Instruction s_Byte;

	private static Instruction s_UInt16;

	private static Instruction s_UInt32;

	private static Instruction s_UInt64;

	private static Instruction s_Boolean;

	public override int ConsumedStack => 2;

	public override int ProducedStack => 1;

	public override string InstructionName => "ExclusiveOr";

	private ExclusiveOrInstruction()
	{
	}

	public static Instruction Create(Type type)
	{
		return type.GetNonNullableType().GetTypeCode() switch
		{
			TypeCode.SByte => s_SByte ?? (s_SByte = new ExclusiveOrSByte()), 
			TypeCode.Int16 => s_Int16 ?? (s_Int16 = new ExclusiveOrInt16()), 
			TypeCode.Int32 => s_Int32 ?? (s_Int32 = new ExclusiveOrInt32()), 
			TypeCode.Int64 => s_Int64 ?? (s_Int64 = new ExclusiveOrInt64()), 
			TypeCode.Byte => s_Byte ?? (s_Byte = new ExclusiveOrByte()), 
			TypeCode.UInt16 => s_UInt16 ?? (s_UInt16 = new ExclusiveOrUInt16()), 
			TypeCode.UInt32 => s_UInt32 ?? (s_UInt32 = new ExclusiveOrUInt32()), 
			TypeCode.UInt64 => s_UInt64 ?? (s_UInt64 = new ExclusiveOrUInt64()), 
			TypeCode.Boolean => s_Boolean ?? (s_Boolean = new ExclusiveOrBoolean()), 
			_ => throw ContractUtils.Unreachable, 
		};
	}
}
