using System.Dynamic.Utils;

namespace System.Linq.Expressions.Interpreter;

internal abstract class DecrementInstruction : Instruction
{
	private sealed class DecrementInt16 : DecrementInstruction
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
				frame.Push((short)((short)obj - 1));
			}
			return 1;
		}
	}

	private sealed class DecrementInt32 : DecrementInstruction
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
				frame.Push((int)obj - 1);
			}
			return 1;
		}
	}

	private sealed class DecrementInt64 : DecrementInstruction
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
				frame.Push((long)obj - 1);
			}
			return 1;
		}
	}

	private sealed class DecrementUInt16 : DecrementInstruction
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
				frame.Push((ushort)((ushort)obj - 1));
			}
			return 1;
		}
	}

	private sealed class DecrementUInt32 : DecrementInstruction
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
				frame.Push((uint)obj - 1);
			}
			return 1;
		}
	}

	private sealed class DecrementUInt64 : DecrementInstruction
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
				frame.Push((ulong)obj - 1);
			}
			return 1;
		}
	}

	private sealed class DecrementSingle : DecrementInstruction
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
				frame.Push((float)obj - 1f);
			}
			return 1;
		}
	}

	private sealed class DecrementDouble : DecrementInstruction
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
				frame.Push((double)obj - 1.0);
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

	public override string InstructionName => "Decrement";

	private DecrementInstruction()
	{
	}

	public static Instruction Create(Type type)
	{
		return type.GetNonNullableType().GetTypeCode() switch
		{
			TypeCode.Int16 => s_Int16 ?? (s_Int16 = new DecrementInt16()), 
			TypeCode.Int32 => s_Int32 ?? (s_Int32 = new DecrementInt32()), 
			TypeCode.Int64 => s_Int64 ?? (s_Int64 = new DecrementInt64()), 
			TypeCode.UInt16 => s_UInt16 ?? (s_UInt16 = new DecrementUInt16()), 
			TypeCode.UInt32 => s_UInt32 ?? (s_UInt32 = new DecrementUInt32()), 
			TypeCode.UInt64 => s_UInt64 ?? (s_UInt64 = new DecrementUInt64()), 
			TypeCode.Single => s_Single ?? (s_Single = new DecrementSingle()), 
			TypeCode.Double => s_Double ?? (s_Double = new DecrementDouble()), 
			_ => throw ContractUtils.Unreachable, 
		};
	}
}
