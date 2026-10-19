using System.Dynamic.Utils;

namespace System.Linq.Expressions.Interpreter;

internal abstract class OrInstruction : Instruction
{
	private sealed class OrSByte : OrInstruction
	{
		public override int Run(InterpretedFrame frame)
		{
			object obj = frame.Pop();
			object obj2 = frame.Pop();
			if (obj == null || obj2 == null)
			{
				frame.Push(null);
				return 1;
			}
			frame.Push((sbyte)((sbyte)obj | (sbyte)obj2));
			return 1;
		}
	}

	private sealed class OrInt16 : OrInstruction
	{
		public override int Run(InterpretedFrame frame)
		{
			object obj = frame.Pop();
			object obj2 = frame.Pop();
			if (obj == null || obj2 == null)
			{
				frame.Push(null);
				return 1;
			}
			frame.Push((short)((short)obj | (short)obj2));
			return 1;
		}
	}

	private sealed class OrInt32 : OrInstruction
	{
		public override int Run(InterpretedFrame frame)
		{
			object obj = frame.Pop();
			object obj2 = frame.Pop();
			if (obj == null || obj2 == null)
			{
				frame.Push(null);
				return 1;
			}
			frame.Push((int)obj | (int)obj2);
			return 1;
		}
	}

	private sealed class OrInt64 : OrInstruction
	{
		public override int Run(InterpretedFrame frame)
		{
			object obj = frame.Pop();
			object obj2 = frame.Pop();
			if (obj == null || obj2 == null)
			{
				frame.Push(null);
				return 1;
			}
			frame.Push((long)obj | (long)obj2);
			return 1;
		}
	}

	private sealed class OrByte : OrInstruction
	{
		public override int Run(InterpretedFrame frame)
		{
			object obj = frame.Pop();
			object obj2 = frame.Pop();
			if (obj == null || obj2 == null)
			{
				frame.Push(null);
				return 1;
			}
			frame.Push((byte)((byte)obj | (byte)obj2));
			return 1;
		}
	}

	private sealed class OrUInt16 : OrInstruction
	{
		public override int Run(InterpretedFrame frame)
		{
			object obj = frame.Pop();
			object obj2 = frame.Pop();
			if (obj == null || obj2 == null)
			{
				frame.Push(null);
				return 1;
			}
			frame.Push((ushort)((ushort)obj | (ushort)obj2));
			return 1;
		}
	}

	private sealed class OrUInt32 : OrInstruction
	{
		public override int Run(InterpretedFrame frame)
		{
			object obj = frame.Pop();
			object obj2 = frame.Pop();
			if (obj == null || obj2 == null)
			{
				frame.Push(null);
				return 1;
			}
			frame.Push((uint)obj | (uint)obj2);
			return 1;
		}
	}

	private sealed class OrUInt64 : OrInstruction
	{
		public override int Run(InterpretedFrame frame)
		{
			object obj = frame.Pop();
			object obj2 = frame.Pop();
			if (obj == null || obj2 == null)
			{
				frame.Push(null);
				return 1;
			}
			frame.Push((ulong)obj | (ulong)obj2);
			return 1;
		}
	}

	private sealed class OrBoolean : OrInstruction
	{
		public override int Run(InterpretedFrame frame)
		{
			object obj = frame.Pop();
			object obj2 = frame.Pop();
			if (obj2 == null)
			{
				if (obj == null)
				{
					frame.Push(null);
				}
				else
				{
					frame.Push(((bool)obj) ? Utils.BoxedTrue : null);
				}
				return 1;
			}
			if (obj == null)
			{
				frame.Push(((bool)obj2) ? Utils.BoxedTrue : null);
				return 1;
			}
			frame.Push((bool)obj2 | (bool)obj);
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

	private static Instruction s_Boolean;

	public override int ConsumedStack => 2;

	public override int ProducedStack => 1;

	public override string InstructionName => "Or";

	private OrInstruction()
	{
	}

	public static Instruction Create(Type type)
	{
		return type.GetNonNullableType().GetTypeCode() switch
		{
			TypeCode.SByte => s_SByte ?? (s_SByte = new OrSByte()), 
			TypeCode.Int16 => s_Int16 ?? (s_Int16 = new OrInt16()), 
			TypeCode.Int32 => s_Int32 ?? (s_Int32 = new OrInt32()), 
			TypeCode.Int64 => s_Int64 ?? (s_Int64 = new OrInt64()), 
			TypeCode.Byte => s_Byte ?? (s_Byte = new OrByte()), 
			TypeCode.UInt16 => s_UInt16 ?? (s_UInt16 = new OrUInt16()), 
			TypeCode.UInt32 => s_UInt32 ?? (s_UInt32 = new OrUInt32()), 
			TypeCode.UInt64 => s_UInt64 ?? (s_UInt64 = new OrUInt64()), 
			TypeCode.Boolean => s_Boolean ?? (s_Boolean = new OrBoolean()), 
			_ => throw ContractUtils.Unreachable, 
		};
	}
}
