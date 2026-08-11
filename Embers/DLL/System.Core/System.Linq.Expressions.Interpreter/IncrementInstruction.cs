using System.Dynamic.Utils;

namespace System.Linq.Expressions.Interpreter;

internal abstract class IncrementInstruction : Instruction
{
	private sealed class IncrementInt16 : IncrementInstruction
	{
		public override int Run(InterpretedFrame frame)
		{
			object obj = frame.Pop();
			if (obj == null)
			{
				frame.Push(null);
			}
			else
			{
				frame.Push((short)(1 + (short)obj));
			}
			return 1;
		}
	}

	private sealed class IncrementInt32 : IncrementInstruction
	{
		public override int Run(InterpretedFrame frame)
		{
			object obj = frame.Pop();
			if (obj == null)
			{
				frame.Push(null);
			}
			else
			{
				frame.Push(1 + (int)obj);
			}
			return 1;
		}
	}

	private sealed class IncrementInt64 : IncrementInstruction
	{
		public override int Run(InterpretedFrame frame)
		{
			object obj = frame.Pop();
			if (obj == null)
			{
				frame.Push(null);
			}
			else
			{
				frame.Push(1 + (long)obj);
			}
			return 1;
		}
	}

	private sealed class IncrementUInt16 : IncrementInstruction
	{
		public override int Run(InterpretedFrame frame)
		{
			object obj = frame.Pop();
			if (obj == null)
			{
				frame.Push(null);
			}
			else
			{
				frame.Push((ushort)(1 + (ushort)obj));
			}
			return 1;
		}
	}

	private sealed class IncrementUInt32 : IncrementInstruction
	{
		public override int Run(InterpretedFrame frame)
		{
			object obj = frame.Pop();
			if (obj == null)
			{
				frame.Push(null);
			}
			else
			{
				frame.Push(1 + (uint)obj);
			}
			return 1;
		}
	}

	private sealed class IncrementUInt64 : IncrementInstruction
	{
		public override int Run(InterpretedFrame frame)
		{
			object obj = frame.Pop();
			if (obj == null)
			{
				frame.Push(null);
			}
			else
			{
				frame.Push(1 + (ulong)obj);
			}
			return 1;
		}
	}

	private sealed class IncrementSingle : IncrementInstruction
	{
		public override int Run(InterpretedFrame frame)
		{
			object obj = frame.Pop();
			if (obj == null)
			{
				frame.Push(null);
			}
			else
			{
				frame.Push(1f + (float)obj);
			}
			return 1;
		}
	}

	private sealed class IncrementDouble : IncrementInstruction
	{
		public override int Run(InterpretedFrame frame)
		{
			object obj = frame.Pop();
			if (obj == null)
			{
				frame.Push(null);
			}
			else
			{
				frame.Push(1.0 + (double)obj);
			}
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

	public override int ConsumedStack => 1;

	public override int ProducedStack => 1;

	public override string InstructionName => "Increment";

	private IncrementInstruction()
	{
	}

	public static Instruction Create(Type type)
	{
		return type.GetNonNullableType().GetTypeCode() switch
		{
			TypeCode.Int16 => s_Int16 ?? (s_Int16 = new IncrementInt16()), 
			TypeCode.Int32 => s_Int32 ?? (s_Int32 = new IncrementInt32()), 
			TypeCode.Int64 => s_Int64 ?? (s_Int64 = new IncrementInt64()), 
			TypeCode.UInt16 => s_UInt16 ?? (s_UInt16 = new IncrementUInt16()), 
			TypeCode.UInt32 => s_UInt32 ?? (s_UInt32 = new IncrementUInt32()), 
			TypeCode.UInt64 => s_UInt64 ?? (s_UInt64 = new IncrementUInt64()), 
			TypeCode.Single => s_Single ?? (s_Single = new IncrementSingle()), 
			TypeCode.Double => s_Double ?? (s_Double = new IncrementDouble()), 
			_ => throw ContractUtils.Unreachable, 
		};
	}
}
