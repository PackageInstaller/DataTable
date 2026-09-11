using System.Dynamic.Utils;

namespace System.Linq.Expressions.Interpreter;

internal abstract class LessThanOrEqualInstruction : Instruction
{
	private sealed class LessThanOrEqualSByte : LessThanOrEqualInstruction
	{
		public LessThanOrEqualSByte(object nullValue)
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
				frame.Push((sbyte)obj2 <= (sbyte)obj);
			}
			return 1;
		}
	}

	private sealed class LessThanOrEqualInt16 : LessThanOrEqualInstruction
	{
		public LessThanOrEqualInt16(object nullValue)
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
				frame.Push((short)obj2 <= (short)obj);
			}
			return 1;
		}
	}

	private sealed class LessThanOrEqualChar : LessThanOrEqualInstruction
	{
		public LessThanOrEqualChar(object nullValue)
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
				frame.Push((char)obj2 <= (char)obj);
			}
			return 1;
		}
	}

	private sealed class LessThanOrEqualInt32 : LessThanOrEqualInstruction
	{
		public LessThanOrEqualInt32(object nullValue)
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
				frame.Push((int)obj2 <= (int)obj);
			}
			return 1;
		}
	}

	private sealed class LessThanOrEqualInt64 : LessThanOrEqualInstruction
	{
		public LessThanOrEqualInt64(object nullValue)
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
				frame.Push((long)obj2 <= (long)obj);
			}
			return 1;
		}
	}

	private sealed class LessThanOrEqualByte : LessThanOrEqualInstruction
	{
		public LessThanOrEqualByte(object nullValue)
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
				frame.Push((byte)obj2 <= (byte)obj);
			}
			return 1;
		}
	}

	private sealed class LessThanOrEqualUInt16 : LessThanOrEqualInstruction
	{
		public LessThanOrEqualUInt16(object nullValue)
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
				frame.Push((ushort)obj2 <= (ushort)obj);
			}
			return 1;
		}
	}

	private sealed class LessThanOrEqualUInt32 : LessThanOrEqualInstruction
	{
		public LessThanOrEqualUInt32(object nullValue)
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
				frame.Push((uint)obj2 <= (uint)obj);
			}
			return 1;
		}
	}

	private sealed class LessThanOrEqualUInt64 : LessThanOrEqualInstruction
	{
		public LessThanOrEqualUInt64(object nullValue)
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
				frame.Push((ulong)obj2 <= (ulong)obj);
			}
			return 1;
		}
	}

	private sealed class LessThanOrEqualSingle : LessThanOrEqualInstruction
	{
		public LessThanOrEqualSingle(object nullValue)
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
				frame.Push((float)obj2 <= (float)obj);
			}
			return 1;
		}
	}

	private sealed class LessThanOrEqualDouble : LessThanOrEqualInstruction
	{
		public LessThanOrEqualDouble(object nullValue)
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
				frame.Push((double)obj2 <= (double)obj);
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

	public override string InstructionName => "LessThanOrEqual";

	private LessThanOrEqualInstruction(object nullValue)
	{
		_nullValue = nullValue;
	}

	public static Instruction Create(Type type, bool liftedToNull = false)
	{
		if (liftedToNull)
		{
			return type.GetNonNullableType().GetTypeCode() switch
			{
				TypeCode.SByte => s_liftedToNullSByte ?? (s_liftedToNullSByte = new LessThanOrEqualSByte(null)), 
				TypeCode.Int16 => s_liftedToNullInt16 ?? (s_liftedToNullInt16 = new LessThanOrEqualInt16(null)), 
				TypeCode.Char => s_liftedToNullChar ?? (s_liftedToNullChar = new LessThanOrEqualChar(null)), 
				TypeCode.Int32 => s_liftedToNullInt32 ?? (s_liftedToNullInt32 = new LessThanOrEqualInt32(null)), 
				TypeCode.Int64 => s_liftedToNullInt64 ?? (s_liftedToNullInt64 = new LessThanOrEqualInt64(null)), 
				TypeCode.Byte => s_liftedToNullByte ?? (s_liftedToNullByte = new LessThanOrEqualByte(null)), 
				TypeCode.UInt16 => s_liftedToNullUInt16 ?? (s_liftedToNullUInt16 = new LessThanOrEqualUInt16(null)), 
				TypeCode.UInt32 => s_liftedToNullUInt32 ?? (s_liftedToNullUInt32 = new LessThanOrEqualUInt32(null)), 
				TypeCode.UInt64 => s_liftedToNullUInt64 ?? (s_liftedToNullUInt64 = new LessThanOrEqualUInt64(null)), 
				TypeCode.Single => s_liftedToNullSingle ?? (s_liftedToNullSingle = new LessThanOrEqualSingle(null)), 
				TypeCode.Double => s_liftedToNullDouble ?? (s_liftedToNullDouble = new LessThanOrEqualDouble(null)), 
				_ => throw ContractUtils.Unreachable, 
			};
		}
		return type.GetNonNullableType().GetTypeCode() switch
		{
			TypeCode.SByte => s_SByte ?? (s_SByte = new LessThanOrEqualSByte(Utils.BoxedFalse)), 
			TypeCode.Int16 => s_Int16 ?? (s_Int16 = new LessThanOrEqualInt16(Utils.BoxedFalse)), 
			TypeCode.Char => s_Char ?? (s_Char = new LessThanOrEqualChar(Utils.BoxedFalse)), 
			TypeCode.Int32 => s_Int32 ?? (s_Int32 = new LessThanOrEqualInt32(Utils.BoxedFalse)), 
			TypeCode.Int64 => s_Int64 ?? (s_Int64 = new LessThanOrEqualInt64(Utils.BoxedFalse)), 
			TypeCode.Byte => s_Byte ?? (s_Byte = new LessThanOrEqualByte(Utils.BoxedFalse)), 
			TypeCode.UInt16 => s_UInt16 ?? (s_UInt16 = new LessThanOrEqualUInt16(Utils.BoxedFalse)), 
			TypeCode.UInt32 => s_UInt32 ?? (s_UInt32 = new LessThanOrEqualUInt32(Utils.BoxedFalse)), 
			TypeCode.UInt64 => s_UInt64 ?? (s_UInt64 = new LessThanOrEqualUInt64(Utils.BoxedFalse)), 
			TypeCode.Single => s_Single ?? (s_Single = new LessThanOrEqualSingle(Utils.BoxedFalse)), 
			TypeCode.Double => s_Double ?? (s_Double = new LessThanOrEqualDouble(Utils.BoxedFalse)), 
			_ => throw ContractUtils.Unreachable, 
		};
	}
}
