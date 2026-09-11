using System.Dynamic.Utils;

namespace System.Linq.Expressions.Interpreter;

internal abstract class RightShiftInstruction : Instruction
{
	private sealed class RightShiftSByte : RightShiftInstruction
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
				frame.Push((sbyte)((sbyte)obj2 >> (int)obj));
			}
			return 1;
		}
	}

	private sealed class RightShiftInt16 : RightShiftInstruction
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
				frame.Push((short)((short)obj2 >> (int)obj));
			}
			return 1;
		}
	}

	private sealed class RightShiftInt32 : RightShiftInstruction
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
				frame.Push((int)obj2 >> (int)obj);
			}
			return 1;
		}
	}

	private sealed class RightShiftInt64 : RightShiftInstruction
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
				frame.Push((long)obj2 >> (int)obj);
			}
			return 1;
		}
	}

	private sealed class RightShiftByte : RightShiftInstruction
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
				frame.Push((byte)((byte)obj2 >> (int)obj));
			}
			return 1;
		}
	}

	private sealed class RightShiftUInt16 : RightShiftInstruction
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
				frame.Push((ushort)((ushort)obj2 >> (int)obj));
			}
			return 1;
		}
	}

	private sealed class RightShiftUInt32 : RightShiftInstruction
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
				frame.Push((uint)obj2 >> (int)obj);
			}
			return 1;
		}
	}

	private sealed class RightShiftUInt64 : RightShiftInstruction
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
				frame.Push((ulong)obj2 >> (int)obj);
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

	public override string InstructionName => "RightShift";

	private RightShiftInstruction()
	{
	}

	public static Instruction Create(Type type)
	{
		return type.GetNonNullableType().GetTypeCode() switch
		{
			TypeCode.SByte => s_SByte ?? (s_SByte = new RightShiftSByte()), 
			TypeCode.Int16 => s_Int16 ?? (s_Int16 = new RightShiftInt16()), 
			TypeCode.Int32 => s_Int32 ?? (s_Int32 = new RightShiftInt32()), 
			TypeCode.Int64 => s_Int64 ?? (s_Int64 = new RightShiftInt64()), 
			TypeCode.Byte => s_Byte ?? (s_Byte = new RightShiftByte()), 
			TypeCode.UInt16 => s_UInt16 ?? (s_UInt16 = new RightShiftUInt16()), 
			TypeCode.UInt32 => s_UInt32 ?? (s_UInt32 = new RightShiftUInt32()), 
			TypeCode.UInt64 => s_UInt64 ?? (s_UInt64 = new RightShiftUInt64()), 
			_ => throw ContractUtils.Unreachable, 
		};
	}
}
