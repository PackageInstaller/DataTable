using System.Dynamic.Utils;

namespace System.Linq.Expressions.Interpreter;

internal abstract class LeftShiftInstruction : Instruction
{
	private sealed class LeftShiftSByte : LeftShiftInstruction
	{
		public override int Run(InterpretedFrame frame)
		{
			object obj = frame.Pop();
			object obj2 = frame.Pop();
			if (obj2 == null || obj == null)
			{
				frame.Push(null);
			}
			else
			{
				frame.Push((sbyte)((sbyte)obj2 << (int)obj));
			}
			return 1;
		}
	}

	private sealed class LeftShiftInt16 : LeftShiftInstruction
	{
		public override int Run(InterpretedFrame frame)
		{
			object obj = frame.Pop();
			object obj2 = frame.Pop();
			if (obj2 == null || obj == null)
			{
				frame.Push(null);
			}
			else
			{
				frame.Push((short)((short)obj2 << (int)obj));
			}
			return 1;
		}
	}

	private sealed class LeftShiftInt32 : LeftShiftInstruction
	{
		public override int Run(InterpretedFrame frame)
		{
			object obj = frame.Pop();
			object obj2 = frame.Pop();
			if (obj2 == null || obj == null)
			{
				frame.Push(null);
			}
			else
			{
				frame.Push((int)obj2 << (int)obj);
			}
			return 1;
		}
	}

	private sealed class LeftShiftInt64 : LeftShiftInstruction
	{
		public override int Run(InterpretedFrame frame)
		{
			object obj = frame.Pop();
			object obj2 = frame.Pop();
			if (obj2 == null || obj == null)
			{
				frame.Push(null);
			}
			else
			{
				frame.Push((long)obj2 << (int)obj);
			}
			return 1;
		}
	}

	private sealed class LeftShiftByte : LeftShiftInstruction
	{
		public override int Run(InterpretedFrame frame)
		{
			object obj = frame.Pop();
			object obj2 = frame.Pop();
			if (obj2 == null || obj == null)
			{
				frame.Push(null);
			}
			else
			{
				frame.Push((byte)((byte)obj2 << (int)obj));
			}
			return 1;
		}
	}

	private sealed class LeftShiftUInt16 : LeftShiftInstruction
	{
		public override int Run(InterpretedFrame frame)
		{
			object obj = frame.Pop();
			object obj2 = frame.Pop();
			if (obj2 == null || obj == null)
			{
				frame.Push(null);
			}
			else
			{
				frame.Push((ushort)((ushort)obj2 << (int)obj));
			}
			return 1;
		}
	}

	private sealed class LeftShiftUInt32 : LeftShiftInstruction
	{
		public override int Run(InterpretedFrame frame)
		{
			object obj = frame.Pop();
			object obj2 = frame.Pop();
			if (obj2 == null || obj == null)
			{
				frame.Push(null);
			}
			else
			{
				frame.Push((uint)obj2 << (int)obj);
			}
			return 1;
		}
	}

	private sealed class LeftShiftUInt64 : LeftShiftInstruction
	{
		public override int Run(InterpretedFrame frame)
		{
			object obj = frame.Pop();
			object obj2 = frame.Pop();
			if (obj2 == null || obj == null)
			{
				frame.Push(null);
			}
			else
			{
				frame.Push((ulong)obj2 << (int)obj);
			}
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

	public override int ConsumedStack => 2;

	public override int ProducedStack => 1;

	public override string InstructionName => "LeftShift";

	private LeftShiftInstruction()
	{
	}

	public static Instruction Create(Type type)
	{
		return type.GetNonNullableType().GetTypeCode() switch
		{
			TypeCode.SByte => s_SByte ?? (s_SByte = new LeftShiftSByte()), 
			TypeCode.Int16 => s_Int16 ?? (s_Int16 = new LeftShiftInt16()), 
			TypeCode.Int32 => s_Int32 ?? (s_Int32 = new LeftShiftInt32()), 
			TypeCode.Int64 => s_Int64 ?? (s_Int64 = new LeftShiftInt64()), 
			TypeCode.Byte => s_Byte ?? (s_Byte = new LeftShiftByte()), 
			TypeCode.UInt16 => s_UInt16 ?? (s_UInt16 = new LeftShiftUInt16()), 
			TypeCode.UInt32 => s_UInt32 ?? (s_UInt32 = new LeftShiftUInt32()), 
			TypeCode.UInt64 => s_UInt64 ?? (s_UInt64 = new LeftShiftUInt64()), 
			_ => throw ContractUtils.Unreachable, 
		};
	}
}
