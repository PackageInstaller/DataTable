using System.Dynamic.Utils;

namespace System.Linq.Expressions.Interpreter;

internal abstract class NegateCheckedInstruction : Instruction
{
	private sealed class NegateCheckedInt32 : NegateCheckedInstruction
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
				frame.Push(checked(-(int)obj));
			}
			return 1;
		}
	}

	private sealed class NegateCheckedInt16 : NegateCheckedInstruction
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
				frame.Push(checked((short)(-(short)obj)));
			}
			return 1;
		}
	}

	private sealed class NegateCheckedInt64 : NegateCheckedInstruction
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
				frame.Push(checked(-(long)obj));
			}
			return 1;
		}
	}

	private static Instruction s_Int16;

	private static Instruction s_Int32;

	private static Instruction s_Int64;

	public override int ConsumedStack => 1;

	public override int ProducedStack => 1;

	public override string InstructionName => "NegateChecked";

	private NegateCheckedInstruction()
	{
	}

	public static Instruction Create(Type type)
	{
		return type.GetNonNullableType().GetTypeCode() switch
		{
			TypeCode.Int16 => s_Int16 ?? (s_Int16 = new NegateCheckedInt16()), 
			TypeCode.Int32 => s_Int32 ?? (s_Int32 = new NegateCheckedInt32()), 
			TypeCode.Int64 => s_Int64 ?? (s_Int64 = new NegateCheckedInt64()), 
			_ => NegateInstruction.Create(type), 
		};
	}
}
