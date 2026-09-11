using System;
using System.Reflection;

namespace MessagePack.Internal;

public static class AutomataKeyGen
{
	public static readonly MethodInfo GetKeyMethod = typeof(AutomataKeyGen).GetRuntimeMethod("GetKey", new Type[1] { typeof(ReadOnlySpan<byte>).MakeByRefType() });

	public static ulong GetKey(ref ReadOnlySpan<byte> span)
	{
		ulong result;
		if (span.Length >= 8)
		{
			result = SafeBitConverter.ToUInt64(span);
			span = span.Slice(8);
		}
		else
		{
			switch (span.Length)
			{
			case 1:
				result = span[0];
				span = span.Slice(1);
				break;
			case 2:
				result = SafeBitConverter.ToUInt16(span);
				span = span.Slice(2);
				break;
			case 3:
			{
				byte num8 = span[0];
				ushort num9 = SafeBitConverter.ToUInt16(span.Slice(1));
				result = num8 | ((ulong)num9 << 8);
				span = span.Slice(3);
				break;
			}
			case 4:
				result = SafeBitConverter.ToUInt32(span);
				span = span.Slice(4);
				break;
			case 5:
			{
				byte num6 = span[0];
				uint num7 = SafeBitConverter.ToUInt32(span.Slice(1));
				result = num6 | ((ulong)num7 << 8);
				span = span.Slice(5);
				break;
			}
			case 6:
			{
				long num4 = SafeBitConverter.ToUInt16(span);
				ulong num5 = SafeBitConverter.ToUInt32(span.Slice(2));
				result = (ulong)num4 | (num5 << 16);
				span = span.Slice(6);
				break;
			}
			case 7:
			{
				byte num = span[0];
				ushort num2 = SafeBitConverter.ToUInt16(span.Slice(1));
				uint num3 = SafeBitConverter.ToUInt32(span.Slice(3));
				result = num | ((ulong)num2 << 8) | ((ulong)num3 << 24);
				span = span.Slice(7);
				break;
			}
			default:
				throw new MessagePackSerializationException("Not Supported Length");
			}
		}
		return result;
	}
}
