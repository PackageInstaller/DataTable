using System.Dynamic.Utils;

namespace System.Linq.Expressions.Interpreter;

internal abstract class NotInstruction : Instruction
{
	private sealed class NotBoolean : NotInstruction
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
				frame.Push(!(bool)obj);
			}
			return 1;
		}
	}

	private sealed class NotInt64 : NotInstruction
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
				frame.Push(~(long)obj);
			}
			return 1;
		}
	}

	private sealed class NotInt32 : NotInstruction
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
				frame.Push(~(int)obj);
			}
			return 1;
		}
	}

	private sealed class NotInt16 : NotInstruction
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
				frame.Push((short)(~(short)obj));
			}
			return 1;
		}
	}

	private sealed class NotUInt64 : NotInstruction
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
				frame.Push(~(ulong)obj);
			}
			return 1;
		}
	}

	private sealed class NotUInt32 : NotInstruction
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
				frame.Push(~(uint)obj);
			}
			return 1;
		}
	}

	private sealed class NotUInt16 : NotInstruction
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
				frame.Push((ushort)(~(ushort)obj));
			}
			return 1;
		}
	}

	private sealed class NotByte : NotInstruction
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
				frame.Push((byte)(~(byte)obj));
			}
			return 1;
		}
	}

	private sealed class NotSByte : NotInstruction
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
				frame.Push((sbyte)(~(sbyte)obj));
			}
			return 1;
		}
	}

	public static Instruction s_Boolean;

	public static Instruction s_Int64;

	public static Instruction s_Int32;

	public static Instruction s_Int16;

	public static Instruction s_UInt64;

	public static Instruction s_UInt32;

	public static Instruction s_UInt16;

	public static Instruction s_Byte;

	public static Instruction s_SByte;

	public override int ConsumedStack => 1;

	public override int ProducedStack => 1;

	public override string InstructionName => "Not";

	private NotInstruction()
	{
	}

	public static Instruction Create(Type type)
	{
		return type.GetNonNullableType().GetTypeCode() switch
		{
			TypeCode.Boolean => s_Boolean ?? (s_Boolean = new NotBoolean()), 
			TypeCode.Int64 => s_Int64 ?? (s_Int64 = new NotInt64()), 
			TypeCode.Int32 => s_Int32 ?? (s_Int32 = new NotInt32()), 
			TypeCode.Int16 => s_Int16 ?? (s_Int16 = new NotInt16()), 
			TypeCode.UInt64 => s_UInt64 ?? (s_UInt64 = new NotUInt64()), 
			TypeCode.UInt32 => s_UInt32 ?? (s_UInt32 = new NotUInt32()), 
			TypeCode.UInt16 => s_UInt16 ?? (s_UInt16 = new NotUInt16()), 
			TypeCode.Byte => s_Byte ?? (s_Byte = new NotByte()), 
			TypeCode.SByte => s_SByte ?? (s_SByte = new NotSByte()), 
			_ => throw ContractUtils.Unreachable, 
		};
	}
}
