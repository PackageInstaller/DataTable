using System.Dynamic.Utils;

namespace System.Linq.Expressions.Interpreter;

internal abstract class NegateInstruction : Instruction
{
	private sealed class NegateInt16 : NegateInstruction
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
				frame.Push((short)(-(short)obj));
			}
			return 1;
		}
	}

	private sealed class NegateInt32 : NegateInstruction
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
				frame.Push(-(int)obj);
			}
			return 1;
		}
	}

	private sealed class NegateInt64 : NegateInstruction
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
				frame.Push(-(long)obj);
			}
			return 1;
		}
	}

	private sealed class NegateSingle : NegateInstruction
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
				frame.Push(0f - (float)obj);
			}
			return 1;
		}
	}

	private sealed class NegateDouble : NegateInstruction
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
				frame.Push(0.0 - (double)obj);
			}
			return 1;
		}
	}

	private static Instruction s_Int16;

	private static Instruction s_Int32;

	private static Instruction s_Int64;

	private static Instruction s_Single;

	private static Instruction s_Double;

	public override int ConsumedStack => 1;

	public override int ProducedStack => 1;

	public override string InstructionName => "Negate";

	private NegateInstruction()
	{
	}

	public static Instruction Create(Type type)
	{
		return type.GetNonNullableType().GetTypeCode() switch
		{
			TypeCode.Int16 => s_Int16 ?? (s_Int16 = new NegateInt16()), 
			TypeCode.Int32 => s_Int32 ?? (s_Int32 = new NegateInt32()), 
			TypeCode.Int64 => s_Int64 ?? (s_Int64 = new NegateInt64()), 
			TypeCode.Single => s_Single ?? (s_Single = new NegateSingle()), 
			TypeCode.Double => s_Double ?? (s_Double = new NegateDouble()), 
			_ => throw ContractUtils.Unreachable, 
		};
	}
}
