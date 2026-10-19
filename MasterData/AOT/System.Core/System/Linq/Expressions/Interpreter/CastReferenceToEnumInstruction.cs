using System.Dynamic.Utils;

namespace System.Linq.Expressions.Interpreter;

internal sealed class CastReferenceToEnumInstruction : CastInstruction
{
	private readonly Type _t;

	public CastReferenceToEnumInstruction(Type t)
	{
		_t = t;
	}

	public override int Run(InterpretedFrame frame)
	{
		object obj = frame.Pop();
		switch (_t.GetTypeCode())
		{
		case TypeCode.Int32:
			frame.Push(Enum.ToObject(_t, (int)obj));
			break;
		case TypeCode.Int64:
			frame.Push(Enum.ToObject(_t, (long)obj));
			break;
		case TypeCode.UInt32:
			frame.Push(Enum.ToObject(_t, (uint)obj));
			break;
		case TypeCode.UInt64:
			frame.Push(Enum.ToObject(_t, (ulong)obj));
			break;
		case TypeCode.Byte:
			frame.Push(Enum.ToObject(_t, (byte)obj));
			break;
		case TypeCode.SByte:
			frame.Push(Enum.ToObject(_t, (sbyte)obj));
			break;
		case TypeCode.Int16:
			frame.Push(Enum.ToObject(_t, (short)obj));
			break;
		case TypeCode.UInt16:
			frame.Push(Enum.ToObject(_t, (ushort)obj));
			break;
		case TypeCode.Char:
			frame.Push(Enum.ToObject(_t, (char)obj));
			break;
		default:
			frame.Push(Enum.ToObject(_t, (bool)obj));
			break;
		}
		return 1;
	}
}
