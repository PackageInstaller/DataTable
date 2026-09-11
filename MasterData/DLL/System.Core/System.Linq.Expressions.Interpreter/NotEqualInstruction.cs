using System.Dynamic.Utils;

namespace System.Linq.Expressions.Interpreter;

internal abstract class NotEqualInstruction : Instruction
{
	private sealed class NotEqualBoolean : NotEqualInstruction
	{
		public override int Run(InterpretedFrame frame)
		{
			object obj = frame.Pop();
			object obj2 = frame.Pop();
			if (obj2 == null)
			{
				frame.Push(obj != null);
			}
			else if (obj == null)
			{
				frame.Push(value: true);
			}
			else
			{
				frame.Push((bool)obj2 != (bool)obj);
			}
			return 1;
		}
	}

	private sealed class NotEqualSByte : NotEqualInstruction
	{
		public override int Run(InterpretedFrame frame)
		{
			object obj = frame.Pop();
			object obj2 = frame.Pop();
			if (obj2 == null)
			{
				frame.Push(obj != null);
			}
			else if (obj == null)
			{
				frame.Push(value: true);
			}
			else
			{
				frame.Push((sbyte)obj2 != (sbyte)obj);
			}
			return 1;
		}
	}

	private sealed class NotEqualInt16 : NotEqualInstruction
	{
		public override int Run(InterpretedFrame frame)
		{
			object obj = frame.Pop();
			object obj2 = frame.Pop();
			if (obj2 == null)
			{
				frame.Push(obj != null);
			}
			else if (obj == null)
			{
				frame.Push(value: true);
			}
			else
			{
				frame.Push((short)obj2 != (short)obj);
			}
			return 1;
		}
	}

	private sealed class NotEqualChar : NotEqualInstruction
	{
		public override int Run(InterpretedFrame frame)
		{
			object obj = frame.Pop();
			object obj2 = frame.Pop();
			if (obj2 == null)
			{
				frame.Push(obj != null);
			}
			else if (obj == null)
			{
				frame.Push(value: true);
			}
			else
			{
				frame.Push((char)obj2 != (char)obj);
			}
			return 1;
		}
	}

	private sealed class NotEqualInt32 : NotEqualInstruction
	{
		public override int Run(InterpretedFrame frame)
		{
			object obj = frame.Pop();
			object obj2 = frame.Pop();
			if (obj2 == null)
			{
				frame.Push(obj != null);
			}
			else if (obj == null)
			{
				frame.Push(value: true);
			}
			else
			{
				frame.Push((int)obj2 != (int)obj);
			}
			return 1;
		}
	}

	private sealed class NotEqualInt64 : NotEqualInstruction
	{
		public override int Run(InterpretedFrame frame)
		{
			object obj = frame.Pop();
			object obj2 = frame.Pop();
			if (obj2 == null)
			{
				frame.Push(obj != null);
			}
			else if (obj == null)
			{
				frame.Push(value: true);
			}
			else
			{
				frame.Push((long)obj2 != (long)obj);
			}
			return 1;
		}
	}

	private sealed class NotEqualByte : NotEqualInstruction
	{
		public override int Run(InterpretedFrame frame)
		{
			object obj = frame.Pop();
			object obj2 = frame.Pop();
			if (obj2 == null)
			{
				frame.Push(obj != null);
			}
			else if (obj == null)
			{
				frame.Push(value: true);
			}
			else
			{
				frame.Push((byte)obj2 != (byte)obj);
			}
			return 1;
		}
	}

	private sealed class NotEqualUInt16 : NotEqualInstruction
	{
		public override int Run(InterpretedFrame frame)
		{
			object obj = frame.Pop();
			object obj2 = frame.Pop();
			if (obj2 == null)
			{
				frame.Push(obj != null);
			}
			else if (obj == null)
			{
				frame.Push(value: true);
			}
			else
			{
				frame.Push((ushort)obj2 != (ushort)obj);
			}
			return 1;
		}
	}

	private sealed class NotEqualUInt32 : NotEqualInstruction
	{
		public override int Run(InterpretedFrame frame)
		{
			object obj = frame.Pop();
			object obj2 = frame.Pop();
			if (obj2 == null)
			{
				frame.Push(obj != null);
			}
			else if (obj == null)
			{
				frame.Push(value: true);
			}
			else
			{
				frame.Push((uint)obj2 != (uint)obj);
			}
			return 1;
		}
	}

	private sealed class NotEqualUInt64 : NotEqualInstruction
	{
		public override int Run(InterpretedFrame frame)
		{
			object obj = frame.Pop();
			object obj2 = frame.Pop();
			if (obj2 == null)
			{
				frame.Push(obj != null);
			}
			else if (obj == null)
			{
				frame.Push(value: true);
			}
			else
			{
				frame.Push((ulong)obj2 != (ulong)obj);
			}
			return 1;
		}
	}

	private sealed class NotEqualSingle : NotEqualInstruction
	{
		public override int Run(InterpretedFrame frame)
		{
			object obj = frame.Pop();
			object obj2 = frame.Pop();
			if (obj2 == null)
			{
				frame.Push(obj != null);
			}
			else if (obj == null)
			{
				frame.Push(value: true);
			}
			else
			{
				frame.Push((float)obj2 != (float)obj);
			}
			return 1;
		}
	}

	private sealed class NotEqualDouble : NotEqualInstruction
	{
		public override int Run(InterpretedFrame frame)
		{
			object obj = frame.Pop();
			object obj2 = frame.Pop();
			if (obj2 == null)
			{
				frame.Push(obj != null);
			}
			else if (obj == null)
			{
				frame.Push(value: true);
			}
			else
			{
				frame.Push((double)obj2 != (double)obj);
			}
			return 1;
		}
	}

	private sealed class NotEqualReference : NotEqualInstruction
	{
		public override int Run(InterpretedFrame frame)
		{
			frame.Push(frame.Pop() != frame.Pop());
			return 1;
		}
	}

	private sealed class NotEqualSByteLiftedToNull : NotEqualInstruction
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
				frame.Push((sbyte)obj2 != (sbyte)obj);
			}
			return 1;
		}
	}

	private sealed class NotEqualInt16LiftedToNull : NotEqualInstruction
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
				frame.Push((short)obj2 != (short)obj);
			}
			return 1;
		}
	}

	private sealed class NotEqualCharLiftedToNull : NotEqualInstruction
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
				frame.Push((char)obj2 != (char)obj);
			}
			return 1;
		}
	}

	private sealed class NotEqualInt32LiftedToNull : NotEqualInstruction
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
				frame.Push((int)obj2 != (int)obj);
			}
			return 1;
		}
	}

	private sealed class NotEqualInt64LiftedToNull : NotEqualInstruction
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
				frame.Push((long)obj2 != (long)obj);
			}
			return 1;
		}
	}

	private sealed class NotEqualByteLiftedToNull : NotEqualInstruction
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
				frame.Push((byte)obj2 != (byte)obj);
			}
			return 1;
		}
	}

	private sealed class NotEqualUInt16LiftedToNull : NotEqualInstruction
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
				frame.Push((ushort)obj2 != (ushort)obj);
			}
			return 1;
		}
	}

	private sealed class NotEqualUInt32LiftedToNull : NotEqualInstruction
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
				frame.Push((uint)obj2 != (uint)obj);
			}
			return 1;
		}
	}

	private sealed class NotEqualUInt64LiftedToNull : NotEqualInstruction
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
				frame.Push((ulong)obj2 != (ulong)obj);
			}
			return 1;
		}
	}

	private sealed class NotEqualSingleLiftedToNull : NotEqualInstruction
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
				frame.Push((float)obj2 != (float)obj);
			}
			return 1;
		}
	}

	private sealed class NotEqualDoubleLiftedToNull : NotEqualInstruction
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
				frame.Push((double)obj2 != (double)obj);
			}
			return 1;
		}
	}

	private static Instruction s_reference;

	private static Instruction s_Boolean;

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

	private static Instruction s_SByteLiftedToNull;

	private static Instruction s_Int16LiftedToNull;

	private static Instruction s_CharLiftedToNull;

	private static Instruction s_Int32LiftedToNull;

	private static Instruction s_Int64LiftedToNull;

	private static Instruction s_ByteLiftedToNull;

	private static Instruction s_UInt16LiftedToNull;

	private static Instruction s_UInt32LiftedToNull;

	private static Instruction s_UInt64LiftedToNull;

	private static Instruction s_SingleLiftedToNull;

	private static Instruction s_DoubleLiftedToNull;

	public override int ConsumedStack => 2;

	public override int ProducedStack => 1;

	public override string InstructionName => "NotEqual";

	private NotEqualInstruction()
	{
	}

	public static Instruction Create(Type type, bool liftedToNull)
	{
		if (liftedToNull)
		{
			return type.GetNonNullableType().GetTypeCode() switch
			{
				TypeCode.Boolean => ExclusiveOrInstruction.Create(type), 
				TypeCode.SByte => s_SByteLiftedToNull ?? (s_SByteLiftedToNull = new NotEqualSByteLiftedToNull()), 
				TypeCode.Int16 => s_Int16LiftedToNull ?? (s_Int16LiftedToNull = new NotEqualInt16LiftedToNull()), 
				TypeCode.Char => s_CharLiftedToNull ?? (s_CharLiftedToNull = new NotEqualCharLiftedToNull()), 
				TypeCode.Int32 => s_Int32LiftedToNull ?? (s_Int32LiftedToNull = new NotEqualInt32LiftedToNull()), 
				TypeCode.Int64 => s_Int64LiftedToNull ?? (s_Int64LiftedToNull = new NotEqualInt64LiftedToNull()), 
				TypeCode.Byte => s_ByteLiftedToNull ?? (s_ByteLiftedToNull = new NotEqualByteLiftedToNull()), 
				TypeCode.UInt16 => s_UInt16LiftedToNull ?? (s_UInt16LiftedToNull = new NotEqualUInt16LiftedToNull()), 
				TypeCode.UInt32 => s_UInt32LiftedToNull ?? (s_UInt32LiftedToNull = new NotEqualUInt32LiftedToNull()), 
				TypeCode.UInt64 => s_UInt64LiftedToNull ?? (s_UInt64LiftedToNull = new NotEqualUInt64LiftedToNull()), 
				TypeCode.Single => s_SingleLiftedToNull ?? (s_SingleLiftedToNull = new NotEqualSingleLiftedToNull()), 
				_ => s_DoubleLiftedToNull ?? (s_DoubleLiftedToNull = new NotEqualDoubleLiftedToNull()), 
			};
		}
		return type.GetNonNullableType().GetTypeCode() switch
		{
			TypeCode.Boolean => s_Boolean ?? (s_Boolean = new NotEqualBoolean()), 
			TypeCode.SByte => s_SByte ?? (s_SByte = new NotEqualSByte()), 
			TypeCode.Int16 => s_Int16 ?? (s_Int16 = new NotEqualInt16()), 
			TypeCode.Char => s_Char ?? (s_Char = new NotEqualChar()), 
			TypeCode.Int32 => s_Int32 ?? (s_Int32 = new NotEqualInt32()), 
			TypeCode.Int64 => s_Int64 ?? (s_Int64 = new NotEqualInt64()), 
			TypeCode.Byte => s_Byte ?? (s_Byte = new NotEqualByte()), 
			TypeCode.UInt16 => s_UInt16 ?? (s_UInt16 = new NotEqualUInt16()), 
			TypeCode.UInt32 => s_UInt32 ?? (s_UInt32 = new NotEqualUInt32()), 
			TypeCode.UInt64 => s_UInt64 ?? (s_UInt64 = new NotEqualUInt64()), 
			TypeCode.Single => s_Single ?? (s_Single = new NotEqualSingle()), 
			TypeCode.Double => s_Double ?? (s_Double = new NotEqualDouble()), 
			_ => s_reference ?? (s_reference = new NotEqualReference()), 
		};
	}
}
