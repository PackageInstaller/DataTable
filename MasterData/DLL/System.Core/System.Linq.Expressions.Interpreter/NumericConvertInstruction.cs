using System.Dynamic.Utils;

namespace System.Linq.Expressions.Interpreter;

internal abstract class NumericConvertInstruction : Instruction
{
	internal sealed class Unchecked : NumericConvertInstruction
	{
		public override string InstructionName => "UncheckedConvert";

		public Unchecked(TypeCode from, TypeCode to, bool isLiftedToNull)
			: base(from, to, isLiftedToNull)
		{
		}

		protected override object Convert(object obj)
		{
			return _from switch
			{
				TypeCode.Boolean => ConvertInt32(((bool)obj) ? 1 : 0), 
				TypeCode.Byte => ConvertInt32((byte)obj), 
				TypeCode.SByte => ConvertInt32((sbyte)obj), 
				TypeCode.Int16 => ConvertInt32((short)obj), 
				TypeCode.Char => ConvertInt32((char)obj), 
				TypeCode.Int32 => ConvertInt32((int)obj), 
				TypeCode.Int64 => ConvertInt64((long)obj), 
				TypeCode.UInt16 => ConvertInt32((ushort)obj), 
				TypeCode.UInt32 => ConvertInt64((uint)obj), 
				TypeCode.UInt64 => ConvertUInt64((ulong)obj), 
				TypeCode.Single => ConvertDouble((float)obj), 
				TypeCode.Double => ConvertDouble((double)obj), 
				_ => throw ContractUtils.Unreachable, 
			};
		}

		private object ConvertInt32(int obj)
		{
			return _to switch
			{
				TypeCode.Byte => (byte)obj, 
				TypeCode.SByte => (sbyte)obj, 
				TypeCode.Int16 => (short)obj, 
				TypeCode.Char => (char)obj, 
				TypeCode.Int32 => obj, 
				TypeCode.Int64 => (long)obj, 
				TypeCode.UInt16 => (ushort)obj, 
				TypeCode.UInt32 => (uint)obj, 
				TypeCode.UInt64 => (ulong)obj, 
				TypeCode.Single => (float)obj, 
				TypeCode.Double => (double)obj, 
				TypeCode.Decimal => (decimal)obj, 
				TypeCode.Boolean => obj != 0, 
				_ => throw ContractUtils.Unreachable, 
			};
		}

		private object ConvertInt64(long obj)
		{
			return _to switch
			{
				TypeCode.Byte => (byte)obj, 
				TypeCode.SByte => (sbyte)obj, 
				TypeCode.Int16 => (short)obj, 
				TypeCode.Char => (char)obj, 
				TypeCode.Int32 => (int)obj, 
				TypeCode.Int64 => obj, 
				TypeCode.UInt16 => (ushort)obj, 
				TypeCode.UInt32 => (uint)obj, 
				TypeCode.UInt64 => (ulong)obj, 
				TypeCode.Single => (float)obj, 
				TypeCode.Double => (double)obj, 
				TypeCode.Decimal => (decimal)obj, 
				_ => throw ContractUtils.Unreachable, 
			};
		}

		private object ConvertUInt64(ulong obj)
		{
			return _to switch
			{
				TypeCode.Byte => (byte)obj, 
				TypeCode.SByte => (sbyte)obj, 
				TypeCode.Int16 => (short)obj, 
				TypeCode.Char => (char)obj, 
				TypeCode.Int32 => (int)obj, 
				TypeCode.Int64 => (long)obj, 
				TypeCode.UInt16 => (ushort)obj, 
				TypeCode.UInt32 => (uint)obj, 
				TypeCode.UInt64 => obj, 
				TypeCode.Single => (float)obj, 
				TypeCode.Double => (double)obj, 
				TypeCode.Decimal => (decimal)obj, 
				_ => throw ContractUtils.Unreachable, 
			};
		}

		private object ConvertDouble(double obj)
		{
			return _to switch
			{
				TypeCode.Byte => (byte)obj, 
				TypeCode.SByte => (sbyte)obj, 
				TypeCode.Int16 => (short)obj, 
				TypeCode.Char => (char)obj, 
				TypeCode.Int32 => (int)obj, 
				TypeCode.Int64 => (long)obj, 
				TypeCode.UInt16 => (ushort)obj, 
				TypeCode.UInt32 => (uint)obj, 
				TypeCode.UInt64 => (ulong)obj, 
				TypeCode.Single => (float)obj, 
				TypeCode.Double => obj, 
				TypeCode.Decimal => (decimal)obj, 
				_ => throw ContractUtils.Unreachable, 
			};
		}
	}

	internal sealed class Checked : NumericConvertInstruction
	{
		public override string InstructionName => "CheckedConvert";

		public Checked(TypeCode from, TypeCode to, bool isLiftedToNull)
			: base(from, to, isLiftedToNull)
		{
		}

		protected override object Convert(object obj)
		{
			return _from switch
			{
				TypeCode.Boolean => ConvertInt32(((bool)obj) ? 1 : 0), 
				TypeCode.Byte => ConvertInt32((byte)obj), 
				TypeCode.SByte => ConvertInt32((sbyte)obj), 
				TypeCode.Int16 => ConvertInt32((short)obj), 
				TypeCode.Char => ConvertInt32((char)obj), 
				TypeCode.Int32 => ConvertInt32((int)obj), 
				TypeCode.Int64 => ConvertInt64((long)obj), 
				TypeCode.UInt16 => ConvertInt32((ushort)obj), 
				TypeCode.UInt32 => ConvertInt64((uint)obj), 
				TypeCode.UInt64 => ConvertUInt64((ulong)obj), 
				TypeCode.Single => ConvertDouble((float)obj), 
				TypeCode.Double => ConvertDouble((double)obj), 
				_ => throw ContractUtils.Unreachable, 
			};
		}

		private object ConvertInt32(int obj)
		{
			checked
			{
				return _to switch
				{
					TypeCode.Byte => (byte)obj, 
					TypeCode.SByte => (sbyte)obj, 
					TypeCode.Int16 => (short)obj, 
					TypeCode.Char => unchecked((char)checked((ushort)obj)), 
					TypeCode.Int32 => obj, 
					TypeCode.Int64 => unchecked((long)obj), 
					TypeCode.UInt16 => (ushort)obj, 
					TypeCode.UInt32 => (uint)obj, 
					TypeCode.UInt64 => (ulong)obj, 
					TypeCode.Single => (float)obj, 
					TypeCode.Double => (double)obj, 
					TypeCode.Decimal => (decimal)obj, 
					TypeCode.Boolean => obj != 0, 
					_ => throw ContractUtils.Unreachable, 
				};
			}
		}

		private object ConvertInt64(long obj)
		{
			checked
			{
				return _to switch
				{
					TypeCode.Byte => (byte)obj, 
					TypeCode.SByte => (sbyte)obj, 
					TypeCode.Int16 => (short)obj, 
					TypeCode.Char => unchecked((char)checked((ushort)obj)), 
					TypeCode.Int32 => (int)obj, 
					TypeCode.Int64 => obj, 
					TypeCode.UInt16 => (ushort)obj, 
					TypeCode.UInt32 => (uint)obj, 
					TypeCode.UInt64 => (ulong)obj, 
					TypeCode.Single => (float)obj, 
					TypeCode.Double => (double)obj, 
					TypeCode.Decimal => (decimal)obj, 
					_ => throw ContractUtils.Unreachable, 
				};
			}
		}

		private object ConvertUInt64(ulong obj)
		{
			checked
			{
				return _to switch
				{
					TypeCode.Byte => (byte)obj, 
					TypeCode.SByte => (sbyte)obj, 
					TypeCode.Int16 => (short)obj, 
					TypeCode.Char => unchecked((char)checked((ushort)obj)), 
					TypeCode.Int32 => (int)obj, 
					TypeCode.Int64 => (long)obj, 
					TypeCode.UInt16 => (ushort)obj, 
					TypeCode.UInt32 => (uint)obj, 
					TypeCode.UInt64 => obj, 
					TypeCode.Single => (float)obj, 
					TypeCode.Double => (double)obj, 
					TypeCode.Decimal => (decimal)obj, 
					_ => throw ContractUtils.Unreachable, 
				};
			}
		}

		private object ConvertDouble(double obj)
		{
			checked
			{
				return _to switch
				{
					TypeCode.Byte => (byte)obj, 
					TypeCode.SByte => (sbyte)obj, 
					TypeCode.Int16 => (short)obj, 
					TypeCode.Char => unchecked((char)checked((ushort)obj)), 
					TypeCode.Int32 => (int)obj, 
					TypeCode.Int64 => (long)obj, 
					TypeCode.UInt16 => (ushort)obj, 
					TypeCode.UInt32 => (uint)obj, 
					TypeCode.UInt64 => (ulong)obj, 
					TypeCode.Single => (float)obj, 
					TypeCode.Double => obj, 
					TypeCode.Decimal => (decimal)obj, 
					_ => throw ContractUtils.Unreachable, 
				};
			}
		}
	}

	internal sealed class ToUnderlying : NumericConvertInstruction
	{
		public override string InstructionName => "ConvertToUnderlying";

		public ToUnderlying(TypeCode to, bool isLiftedToNull)
			: base(to, to, isLiftedToNull)
		{
		}

		protected override object Convert(object obj)
		{
			return _to switch
			{
				TypeCode.Boolean => (bool)obj, 
				TypeCode.Byte => (byte)obj, 
				TypeCode.SByte => (sbyte)obj, 
				TypeCode.Int16 => (short)obj, 
				TypeCode.Char => (char)obj, 
				TypeCode.Int32 => (int)obj, 
				TypeCode.Int64 => (long)obj, 
				TypeCode.UInt16 => (ushort)obj, 
				TypeCode.UInt32 => (uint)obj, 
				TypeCode.UInt64 => (ulong)obj, 
				_ => throw ContractUtils.Unreachable, 
			};
		}
	}

	internal readonly TypeCode _from;

	internal readonly TypeCode _to;

	private readonly bool _isLiftedToNull;

	public override string InstructionName => "NumericConvert";

	public override int ConsumedStack => 1;

	public override int ProducedStack => 1;

	protected NumericConvertInstruction(TypeCode from, TypeCode to, bool isLiftedToNull)
	{
		_from = from;
		_to = to;
		_isLiftedToNull = isLiftedToNull;
	}

	public sealed override int Run(InterpretedFrame frame)
	{
		object obj = frame.Pop();
		object value;
		if (obj == null)
		{
			if (!_isLiftedToNull)
			{
				return ((int?)obj).Value;
			}
			value = null;
		}
		else
		{
			value = Convert(obj);
		}
		frame.Push(value);
		return 1;
	}

	protected abstract object Convert(object obj);

	public override string ToString()
	{
		return InstructionName + "(" + _from.ToString() + "->" + _to.ToString() + ")";
	}
}
