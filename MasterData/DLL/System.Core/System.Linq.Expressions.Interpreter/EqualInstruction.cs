using System.Dynamic.Utils;

namespace System.Linq.Expressions.Interpreter;

internal abstract class EqualInstruction : Instruction
{
	private sealed class EqualBoolean : EqualInstruction
	{
		public override int Run(InterpretedFrame frame)
		{
			object obj = frame.Pop();
			object obj2 = frame.Pop();
			if (obj2 == null)
			{
				frame.Push(obj == null);
			}
			else if (obj == null)
			{
				frame.Push(value: false);
			}
			else
			{
				frame.Push((bool)obj2 == (bool)obj);
			}
			return 1;
		}
	}

	private sealed class EqualSByte : EqualInstruction
	{
		public override int Run(InterpretedFrame frame)
		{
			object obj = frame.Pop();
			object obj2 = frame.Pop();
			if (obj2 == null)
			{
				frame.Push(obj == null);
			}
			else if (obj == null)
			{
				frame.Push(value: false);
			}
			else
			{
				frame.Push((sbyte)obj2 == (sbyte)obj);
			}
			return 1;
		}
	}

	private sealed class EqualInt16 : EqualInstruction
	{
		public override int Run(InterpretedFrame frame)
		{
			object obj = frame.Pop();
			object obj2 = frame.Pop();
			if (obj2 == null)
			{
				frame.Push(obj == null);
			}
			else if (obj == null)
			{
				frame.Push(value: false);
			}
			else
			{
				frame.Push((short)obj2 == (short)obj);
			}
			return 1;
		}
	}

	private sealed class EqualChar : EqualInstruction
	{
		public override int Run(InterpretedFrame frame)
		{
			object obj = frame.Pop();
			object obj2 = frame.Pop();
			if (obj2 == null)
			{
				frame.Push(obj == null);
			}
			else if (obj == null)
			{
				frame.Push(value: false);
			}
			else
			{
				frame.Push((char)obj2 == (char)obj);
			}
			return 1;
		}
	}

	private sealed class EqualInt32 : EqualInstruction
	{
		public override int Run(InterpretedFrame frame)
		{
			object obj = frame.Pop();
			object obj2 = frame.Pop();
			if (obj2 == null)
			{
				frame.Push(obj == null);
			}
			else if (obj == null)
			{
				frame.Push(value: false);
			}
			else
			{
				frame.Push((int)obj2 == (int)obj);
			}
			return 1;
		}
	}

	private sealed class EqualInt64 : EqualInstruction
	{
		public override int Run(InterpretedFrame frame)
		{
			object obj = frame.Pop();
			object obj2 = frame.Pop();
			if (obj2 == null)
			{
				frame.Push(obj == null);
			}
			else if (obj == null)
			{
				frame.Push(value: false);
			}
			else
			{
				frame.Push((long)obj2 == (long)obj);
			}
			return 1;
		}
	}

	private sealed class EqualByte : EqualInstruction
	{
		public override int Run(InterpretedFrame frame)
		{
			object obj = frame.Pop();
			object obj2 = frame.Pop();
			if (obj2 == null)
			{
				frame.Push(obj == null);
			}
			else if (obj == null)
			{
				frame.Push(value: false);
			}
			else
			{
				frame.Push((byte)obj2 == (byte)obj);
			}
			return 1;
		}
	}

	private sealed class EqualUInt16 : EqualInstruction
	{
		public override int Run(InterpretedFrame frame)
		{
			object obj = frame.Pop();
			object obj2 = frame.Pop();
			if (obj2 == null)
			{
				frame.Push(obj == null);
			}
			else if (obj == null)
			{
				frame.Push(value: false);
			}
			else
			{
				frame.Push((ushort)obj2 == (ushort)obj);
			}
			return 1;
		}
	}

	private sealed class EqualUInt32 : EqualInstruction
	{
		public override int Run(InterpretedFrame frame)
		{
			object obj = frame.Pop();
			object obj2 = frame.Pop();
			if (obj2 == null)
			{
				frame.Push(obj == null);
			}
			else if (obj == null)
			{
				frame.Push(value: false);
			}
			else
			{
				frame.Push((uint)obj2 == (uint)obj);
			}
			return 1;
		}
	}

	private sealed class EqualUInt64 : EqualInstruction
	{
		public override int Run(InterpretedFrame frame)
		{
			object obj = frame.Pop();
			object obj2 = frame.Pop();
			if (obj2 == null)
			{
				frame.Push(obj == null);
			}
			else if (obj == null)
			{
				frame.Push(value: false);
			}
			else
			{
				frame.Push((ulong)obj2 == (ulong)obj);
			}
			return 1;
		}
	}

	private sealed class EqualSingle : EqualInstruction
	{
		public override int Run(InterpretedFrame frame)
		{
			object obj = frame.Pop();
			object obj2 = frame.Pop();
			if (obj2 == null)
			{
				frame.Push(obj == null);
			}
			else if (obj == null)
			{
				frame.Push(value: false);
			}
			else
			{
				frame.Push((float)obj2 == (float)obj);
			}
			return 1;
		}
	}

	private sealed class EqualDouble : EqualInstruction
	{
		public override int Run(InterpretedFrame frame)
		{
			object obj = frame.Pop();
			object obj2 = frame.Pop();
			if (obj2 == null)
			{
				frame.Push(obj == null);
			}
			else if (obj == null)
			{
				frame.Push(value: false);
			}
			else
			{
				frame.Push((double)obj2 == (double)obj);
			}
			return 1;
		}
	}

	private sealed class EqualReference : EqualInstruction
	{
		public override int Run(InterpretedFrame frame)
		{
			frame.Push(frame.Pop() == frame.Pop());
			return 1;
		}
	}

	private sealed class EqualBooleanLiftedToNull : EqualInstruction
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
				frame.Push((bool)obj2 == (bool)obj);
			}
			return 1;
		}
	}

	private sealed class EqualSByteLiftedToNull : EqualInstruction
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
				frame.Push((sbyte)obj2 == (sbyte)obj);
			}
			return 1;
		}
	}

	private sealed class EqualInt16LiftedToNull : EqualInstruction
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
				frame.Push((short)obj2 == (short)obj);
			}
			return 1;
		}
	}

	private sealed class EqualCharLiftedToNull : EqualInstruction
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
				frame.Push((char)obj2 == (char)obj);
			}
			return 1;
		}
	}

	private sealed class EqualInt32LiftedToNull : EqualInstruction
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
				frame.Push((int)obj2 == (int)obj);
			}
			return 1;
		}
	}

	private sealed class EqualInt64LiftedToNull : EqualInstruction
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
				frame.Push((long)obj2 == (long)obj);
			}
			return 1;
		}
	}

	private sealed class EqualByteLiftedToNull : EqualInstruction
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
				frame.Push((byte)obj2 == (byte)obj);
			}
			return 1;
		}
	}

	private sealed class EqualUInt16LiftedToNull : EqualInstruction
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
				frame.Push((ushort)obj2 == (ushort)obj);
			}
			return 1;
		}
	}

	private sealed class EqualUInt32LiftedToNull : EqualInstruction
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
				frame.Push((uint)obj2 == (uint)obj);
			}
			return 1;
		}
	}

	private sealed class EqualUInt64LiftedToNull : EqualInstruction
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
				frame.Push((ulong)obj2 == (ulong)obj);
			}
			return 1;
		}
	}

	private sealed class EqualSingleLiftedToNull : EqualInstruction
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
				frame.Push((float)obj2 == (float)obj);
			}
			return 1;
		}
	}

	private sealed class EqualDoubleLiftedToNull : EqualInstruction
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
				frame.Push((double)obj2 == (double)obj);
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

	private static Instruction s_BooleanLiftedToNull;

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

	public override string InstructionName => "Equal";

	private EqualInstruction()
	{
	}

	public static Instruction Create(Type type, bool liftedToNull)
	{
		if (liftedToNull)
		{
			return type.GetNonNullableType().GetTypeCode() switch
			{
				TypeCode.Boolean => s_BooleanLiftedToNull ?? (s_BooleanLiftedToNull = new EqualBooleanLiftedToNull()), 
				TypeCode.SByte => s_SByteLiftedToNull ?? (s_SByteLiftedToNull = new EqualSByteLiftedToNull()), 
				TypeCode.Int16 => s_Int16LiftedToNull ?? (s_Int16LiftedToNull = new EqualInt16LiftedToNull()), 
				TypeCode.Char => s_CharLiftedToNull ?? (s_CharLiftedToNull = new EqualCharLiftedToNull()), 
				TypeCode.Int32 => s_Int32LiftedToNull ?? (s_Int32LiftedToNull = new EqualInt32LiftedToNull()), 
				TypeCode.Int64 => s_Int64LiftedToNull ?? (s_Int64LiftedToNull = new EqualInt64LiftedToNull()), 
				TypeCode.Byte => s_ByteLiftedToNull ?? (s_ByteLiftedToNull = new EqualByteLiftedToNull()), 
				TypeCode.UInt16 => s_UInt16LiftedToNull ?? (s_UInt16LiftedToNull = new EqualUInt16LiftedToNull()), 
				TypeCode.UInt32 => s_UInt32LiftedToNull ?? (s_UInt32LiftedToNull = new EqualUInt32LiftedToNull()), 
				TypeCode.UInt64 => s_UInt64LiftedToNull ?? (s_UInt64LiftedToNull = new EqualUInt64LiftedToNull()), 
				TypeCode.Single => s_SingleLiftedToNull ?? (s_SingleLiftedToNull = new EqualSingleLiftedToNull()), 
				_ => s_DoubleLiftedToNull ?? (s_DoubleLiftedToNull = new EqualDoubleLiftedToNull()), 
			};
		}
		return type.GetNonNullableType().GetTypeCode() switch
		{
			TypeCode.Boolean => s_Boolean ?? (s_Boolean = new EqualBoolean()), 
			TypeCode.SByte => s_SByte ?? (s_SByte = new EqualSByte()), 
			TypeCode.Int16 => s_Int16 ?? (s_Int16 = new EqualInt16()), 
			TypeCode.Char => s_Char ?? (s_Char = new EqualChar()), 
			TypeCode.Int32 => s_Int32 ?? (s_Int32 = new EqualInt32()), 
			TypeCode.Int64 => s_Int64 ?? (s_Int64 = new EqualInt64()), 
			TypeCode.Byte => s_Byte ?? (s_Byte = new EqualByte()), 
			TypeCode.UInt16 => s_UInt16 ?? (s_UInt16 = new EqualUInt16()), 
			TypeCode.UInt32 => s_UInt32 ?? (s_UInt32 = new EqualUInt32()), 
			TypeCode.UInt64 => s_UInt64 ?? (s_UInt64 = new EqualUInt64()), 
			TypeCode.Single => s_Single ?? (s_Single = new EqualSingle()), 
			TypeCode.Double => s_Double ?? (s_Double = new EqualDouble()), 
			_ => s_reference ?? (s_reference = new EqualReference()), 
		};
	}
}
