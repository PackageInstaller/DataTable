using System.Dynamic.Utils;

namespace System.Linq.Expressions.Interpreter;

internal abstract class GreaterThanOrEqualInstruction : Instruction
{
	private sealed class GreaterThanOrEqualSByte : GreaterThanOrEqualInstruction
	{
		public GreaterThanOrEqualSByte(object nullValue)
			: base(nullValue)
		{
		}

		public override int Run(InterpretedFrame frame)
		{
			object obj = frame.Pop();
			object obj2 = frame.Pop();
			if (obj2 == null || obj == null)
			{
				frame.Push(_nullValue);
			}
			else
			{
				frame.Push((sbyte)obj2 >= (sbyte)obj);
			}
			return 1;
		}
	}

	private sealed class GreaterThanOrEqualInt16 : GreaterThanOrEqualInstruction
	{
		public GreaterThanOrEqualInt16(object nullValue)
			: base(nullValue)
		{
		}

		public override int Run(InterpretedFrame frame)
		{
			object obj = frame.Pop();
			object obj2 = frame.Pop();
			if (obj2 == null || obj == null)
			{
				frame.Push(_nullValue);
			}
			else
			{
				frame.Push((short)obj2 >= (short)obj);
			}
			return 1;
		}
	}

	private sealed class GreaterThanOrEqualChar : GreaterThanOrEqualInstruction
	{
		public GreaterThanOrEqualChar(object nullValue)
			: base(nullValue)
		{
		}

		public override int Run(InterpretedFrame frame)
		{
			object obj = frame.Pop();
			object obj2 = frame.Pop();
			if (obj2 == null || obj == null)
			{
				frame.Push(_nullValue);
			}
			else
			{
				frame.Push((char)obj2 >= (char)obj);
			}
			return 1;
		}
	}

	private sealed class GreaterThanOrEqualInt32 : GreaterThanOrEqualInstruction
	{
		public GreaterThanOrEqualInt32(object nullValue)
			: base(nullValue)
		{
		}

		public override int Run(InterpretedFrame frame)
		{
			object obj = frame.Pop();
			object obj2 = frame.Pop();
			if (obj2 == null || obj == null)
			{
				frame.Push(_nullValue);
			}
			else
			{
				frame.Push((int)obj2 >= (int)obj);
			}
			return 1;
		}
	}

	private sealed class GreaterThanOrEqualInt64 : GreaterThanOrEqualInstruction
	{
		public GreaterThanOrEqualInt64(object nullValue)
			: base(nullValue)
		{
		}

		public override int Run(InterpretedFrame frame)
		{
			object obj = frame.Pop();
			object obj2 = frame.Pop();
			if (obj2 == null || obj == null)
			{
				frame.Push(_nullValue);
			}
			else
			{
				frame.Push((long)obj2 >= (long)obj);
			}
			return 1;
		}
	}

	private sealed class GreaterThanOrEqualByte : GreaterThanOrEqualInstruction
	{
		public GreaterThanOrEqualByte(object nullValue)
			: base(nullValue)
		{
		}

		public override int Run(InterpretedFrame frame)
		{
			object obj = frame.Pop();
			object obj2 = frame.Pop();
			if (obj2 == null || obj == null)
			{
				frame.Push(_nullValue);
			}
			else
			{
				frame.Push((byte)obj2 >= (byte)obj);
			}
			return 1;
		}
	}

	private sealed class GreaterThanOrEqualUInt16 : GreaterThanOrEqualInstruction
	{
		public GreaterThanOrEqualUInt16(object nullValue)
			: base(nullValue)
		{
		}

		public override int Run(InterpretedFrame frame)
		{
			object obj = frame.Pop();
			object obj2 = frame.Pop();
			if (obj2 == null || obj == null)
			{
				frame.Push(_nullValue);
			}
			else
			{
				frame.Push((ushort)obj2 >= (ushort)obj);
			}
			return 1;
		}
	}

	private sealed class GreaterThanOrEqualUInt32 : GreaterThanOrEqualInstruction
	{
		public GreaterThanOrEqualUInt32(object nullValue)
			: base(nullValue)
		{
		}

		public override int Run(InterpretedFrame frame)
		{
			object obj = frame.Pop();
			object obj2 = frame.Pop();
			if (obj2 == null || obj == null)
			{
				frame.Push(_nullValue);
			}
			else
			{
				frame.Push((uint)obj2 >= (uint)obj);
			}
			return 1;
		}
	}

	private sealed class GreaterThanOrEqualUInt64 : GreaterThanOrEqualInstruction
	{
		public GreaterThanOrEqualUInt64(object nullValue)
			: base(nullValue)
		{
		}

		public override int Run(InterpretedFrame frame)
		{
			object obj = frame.Pop();
			object obj2 = frame.Pop();
			if (obj2 == null || obj == null)
			{
				frame.Push(_nullValue);
			}
			else
			{
				frame.Push((ulong)obj2 >= (ulong)obj);
			}
			return 1;
		}
	}

	private sealed class GreaterThanOrEqualSingle : GreaterThanOrEqualInstruction
	{
		public GreaterThanOrEqualSingle(object nullValue)
			: base(nullValue)
		{
		}

		public override int Run(InterpretedFrame frame)
		{
			object obj = frame.Pop();
			object obj2 = frame.Pop();
			if (obj2 == null || obj == null)
			{
				frame.Push(_nullValue);
			}
			else
			{
				frame.Push((float)obj2 >= (float)obj);
			}
			return 1;
		}
	}

	private sealed class GreaterThanOrEqualDouble : GreaterThanOrEqualInstruction
	{
		public GreaterThanOrEqualDouble(object nullValue)
			: base(nullValue)
		{
		}

		public override int Run(InterpretedFrame frame)
		{
			object obj = frame.Pop();
			object obj2 = frame.Pop();
			if (obj2 == null || obj == null)
			{
				frame.Push(_nullValue);
			}
			else
			{
				frame.Push((double)obj2 >= (double)obj);
			}
			return 1;
		}
	}

	private readonly object _nullValue;

	private static Instruction s_SByte;

	private static Instruction s_Int16;

	private static Instruction s_Char;

	private static Instruction s_Int32;

	private static Instruction s_Int64;

	private static Instruction s_Byte;

	private static Instruction s_UInt16;

	private static Instruction s_UInt32;

	private static Instruction s_UInt64;

	private static Instruction s_Single;

	private static Instruction s_Double;

	private static Instruction s_liftedToNullSByte;

	private static Instruction s_liftedToNullInt16;

	private static Instruction s_liftedToNullChar;

	private static Instruction s_liftedToNullInt32;

	private static Instruction s_liftedToNullInt64;

	private static Instruction s_liftedToNullByte;

	private static Instruction s_liftedToNullUInt16;

	private static Instruction s_liftedToNullUInt32;

	private static Instruction s_liftedToNullUInt64;

	private static Instruction s_liftedToNullSingle;

	private static Instruction s_liftedToNullDouble;

	public override int ConsumedStack => 2;

	public override int ProducedStack => 1;

	public override string InstructionName => "GreaterThanOrEqual";

	private GreaterThanOrEqualInstruction(object nullValue)
	{
		_nullValue = nullValue;
	}

	public static Instruction Create(Type type, bool liftedToNull = false)
	{
		if (liftedToNull)
		{
			return type.GetNonNullableType().GetTypeCode() switch
			{
				TypeCode.SByte => s_liftedToNullSByte ?? (s_liftedToNullSByte = new GreaterThanOrEqualSByte(null)), 
				TypeCode.Int16 => s_liftedToNullInt16 ?? (s_liftedToNullInt16 = new GreaterThanOrEqualInt16(null)), 
				TypeCode.Char => s_liftedToNullChar ?? (s_liftedToNullChar = new GreaterThanOrEqualChar(null)), 
				TypeCode.Int32 => s_liftedToNullInt32 ?? (s_liftedToNullInt32 = new GreaterThanOrEqualInt32(null)), 
				TypeCode.Int64 => s_liftedToNullInt64 ?? (s_liftedToNullInt64 = new GreaterThanOrEqualInt64(null)), 
				TypeCode.Byte => s_liftedToNullByte ?? (s_liftedToNullByte = new GreaterThanOrEqualByte(null)), 
				TypeCode.UInt16 => s_liftedToNullUInt16 ?? (s_liftedToNullUInt16 = new GreaterThanOrEqualUInt16(null)), 
				TypeCode.UInt32 => s_liftedToNullUInt32 ?? (s_liftedToNullUInt32 = new GreaterThanOrEqualUInt32(null)), 
				TypeCode.UInt64 => s_liftedToNullUInt64 ?? (s_liftedToNullUInt64 = new GreaterThanOrEqualUInt64(null)), 
				TypeCode.Single => s_liftedToNullSingle ?? (s_liftedToNullSingle = new GreaterThanOrEqualSingle(null)), 
				TypeCode.Double => s_liftedToNullDouble ?? (s_liftedToNullDouble = new GreaterThanOrEqualDouble(null)), 
				_ => throw ContractUtils.Unreachable, 
			};
		}
		return type.GetNonNullableType().GetTypeCode() switch
		{
			TypeCode.SByte => s_SByte ?? (s_SByte = new GreaterThanOrEqualSByte(Utils.BoxedFalse)), 
			TypeCode.Int16 => s_Int16 ?? (s_Int16 = new GreaterThanOrEqualInt16(Utils.BoxedFalse)), 
			TypeCode.Char => s_Char ?? (s_Char = new GreaterThanOrEqualChar(Utils.BoxedFalse)), 
			TypeCode.Int32 => s_Int32 ?? (s_Int32 = new GreaterThanOrEqualInt32(Utils.BoxedFalse)), 
			TypeCode.Int64 => s_Int64 ?? (s_Int64 = new GreaterThanOrEqualInt64(Utils.BoxedFalse)), 
			TypeCode.Byte => s_Byte ?? (s_Byte = new GreaterThanOrEqualByte(Utils.BoxedFalse)), 
			TypeCode.UInt16 => s_UInt16 ?? (s_UInt16 = new GreaterThanOrEqualUInt16(Utils.BoxedFalse)), 
			TypeCode.UInt32 => s_UInt32 ?? (s_UInt32 = new GreaterThanOrEqualUInt32(Utils.BoxedFalse)), 
			TypeCode.UInt64 => s_UInt64 ?? (s_UInt64 = new GreaterThanOrEqualUInt64(Utils.BoxedFalse)), 
			TypeCode.Single => s_Single ?? (s_Single = new GreaterThanOrEqualSingle(Utils.BoxedFalse)), 
			TypeCode.Double => s_Double ?? (s_Double = new GreaterThanOrEqualDouble(Utils.BoxedFalse)), 
			_ => throw ContractUtils.Unreachable, 
		};
	}
}
