using System.Dynamic.Utils;

namespace System.Linq.Expressions.Interpreter;

internal abstract class CastInstruction : Instruction
{
	private sealed class CastInstructionT<T> : CastInstruction
	{
		public override int Run(InterpretedFrame frame)
		{
			object obj = frame.Pop();
			frame.Push((T)obj);
			return 1;
		}
	}

	private abstract class CastInstructionNoT : CastInstruction
	{
		private sealed class Ref : CastInstructionNoT
		{
			public Ref(Type t)
				: base(t)
			{
			}

			protected override void ConvertNull(InterpretedFrame frame)
			{
				frame.Push(null);
			}
		}

		private sealed class Value : CastInstructionNoT
		{
			public Value(Type t)
				: base(t)
			{
			}

			protected override void ConvertNull(InterpretedFrame frame)
			{
				throw new NullReferenceException();
			}
		}

		private readonly Type _t;

		protected CastInstructionNoT(Type t)
		{
			_t = t;
		}

		public new static CastInstruction Create(Type t)
		{
			if (t.IsValueType && !t.IsNullableType())
			{
				return new Value(t);
			}
			return new Ref(t);
		}

		public override int Run(InterpretedFrame frame)
		{
			object obj = frame.Pop();
			if (obj != null)
			{
				Type type = obj.GetType();
				if (!type.HasReferenceConversionTo(_t) && !type.HasIdentityPrimitiveOrNullableConversionTo(_t))
				{
					throw new InvalidCastException();
				}
				if (!_t.IsAssignableFrom(type))
				{
					throw new InvalidCastException();
				}
				frame.Push(obj);
			}
			else
			{
				ConvertNull(frame);
			}
			return 1;
		}

		protected abstract void ConvertNull(InterpretedFrame frame);
	}

	private static CastInstruction s_Boolean;

	private static CastInstruction s_Byte;

	private static CastInstruction s_Char;

	private static CastInstruction s_DateTime;

	private static CastInstruction s_Decimal;

	private static CastInstruction s_Double;

	private static CastInstruction s_Int16;

	private static CastInstruction s_Int32;

	private static CastInstruction s_Int64;

	private static CastInstruction s_SByte;

	private static CastInstruction s_Single;

	private static CastInstruction s_String;

	private static CastInstruction s_UInt16;

	private static CastInstruction s_UInt32;

	private static CastInstruction s_UInt64;

	public override int ConsumedStack => 1;

	public override int ProducedStack => 1;

	public override string InstructionName => "Cast";

	public static Instruction Create(Type t)
	{
		return t.GetTypeCode() switch
		{
			TypeCode.Boolean => s_Boolean ?? (s_Boolean = new CastInstructionT<bool>()), 
			TypeCode.Byte => s_Byte ?? (s_Byte = new CastInstructionT<byte>()), 
			TypeCode.Char => s_Char ?? (s_Char = new CastInstructionT<char>()), 
			TypeCode.DateTime => s_DateTime ?? (s_DateTime = new CastInstructionT<DateTime>()), 
			TypeCode.Decimal => s_Decimal ?? (s_Decimal = new CastInstructionT<decimal>()), 
			TypeCode.Double => s_Double ?? (s_Double = new CastInstructionT<double>()), 
			TypeCode.Int16 => s_Int16 ?? (s_Int16 = new CastInstructionT<short>()), 
			TypeCode.Int32 => s_Int32 ?? (s_Int32 = new CastInstructionT<int>()), 
			TypeCode.Int64 => s_Int64 ?? (s_Int64 = new CastInstructionT<long>()), 
			TypeCode.SByte => s_SByte ?? (s_SByte = new CastInstructionT<sbyte>()), 
			TypeCode.Single => s_Single ?? (s_Single = new CastInstructionT<float>()), 
			TypeCode.String => s_String ?? (s_String = new CastInstructionT<string>()), 
			TypeCode.UInt16 => s_UInt16 ?? (s_UInt16 = new CastInstructionT<ushort>()), 
			TypeCode.UInt32 => s_UInt32 ?? (s_UInt32 = new CastInstructionT<uint>()), 
			TypeCode.UInt64 => s_UInt64 ?? (s_UInt64 = new CastInstructionT<ulong>()), 
			_ => CastInstructionNoT.Create(t), 
		};
	}
}
