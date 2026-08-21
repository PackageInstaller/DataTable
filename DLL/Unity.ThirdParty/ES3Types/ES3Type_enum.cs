using System;
using UnityEngine.Scripting;

namespace ES3Types;

[Preserve]
public class ES3Type_enum : ES3Type
{
	public static ES3Type Instance;

	private Type underlyingType;

	public ES3Type_enum(Type type)
		: base(type)
	{
		isPrimitive = true;
		isEnum = true;
		Instance = this;
		underlyingType = Enum.GetUnderlyingType(type);
	}

	public override void Write(object obj, ES3Writer writer)
	{
		if (underlyingType == typeof(int))
		{
			writer.WritePrimitive((int)obj);
			return;
		}
		if (underlyingType == typeof(bool))
		{
			writer.WritePrimitive((bool)obj);
			return;
		}
		if (underlyingType == typeof(byte))
		{
			writer.WritePrimitive((byte)obj);
			return;
		}
		if (underlyingType == typeof(char))
		{
			writer.WritePrimitive((char)obj);
			return;
		}
		if (underlyingType == typeof(decimal))
		{
			writer.WritePrimitive((decimal)obj);
			return;
		}
		if (underlyingType == typeof(double))
		{
			writer.WritePrimitive((double)obj);
			return;
		}
		if (underlyingType == typeof(float))
		{
			writer.WritePrimitive((float)obj);
			return;
		}
		if (underlyingType == typeof(long))
		{
			writer.WritePrimitive((long)obj);
			return;
		}
		if (underlyingType == typeof(sbyte))
		{
			writer.WritePrimitive((sbyte)obj);
			return;
		}
		if (underlyingType == typeof(short))
		{
			writer.WritePrimitive((short)obj);
			return;
		}
		if (underlyingType == typeof(uint))
		{
			writer.WritePrimitive((uint)obj);
			return;
		}
		if (underlyingType == typeof(ulong))
		{
			writer.WritePrimitive((ulong)obj);
			return;
		}
		if (underlyingType == typeof(ushort))
		{
			writer.WritePrimitive((ushort)obj);
			return;
		}
		throw new InvalidCastException("The underlying type " + underlyingType?.ToString() + " of Enum " + type?.ToString() + " is not supported");
	}

	public override object Read<T>(ES3Reader reader)
	{
		if (underlyingType == typeof(int))
		{
			return Enum.ToObject(type, reader.Read_int());
		}
		if (underlyingType == typeof(bool))
		{
			return Enum.ToObject(type, reader.Read_bool());
		}
		if (underlyingType == typeof(byte))
		{
			return Enum.ToObject(type, reader.Read_byte());
		}
		if (underlyingType == typeof(char))
		{
			return Enum.ToObject(type, reader.Read_char());
		}
		if (underlyingType == typeof(decimal))
		{
			return Enum.ToObject(type, reader.Read_decimal());
		}
		if (underlyingType == typeof(double))
		{
			return Enum.ToObject(type, reader.Read_double());
		}
		if (underlyingType == typeof(float))
		{
			return Enum.ToObject(type, reader.Read_float());
		}
		if (underlyingType == typeof(long))
		{
			return Enum.ToObject(type, reader.Read_long());
		}
		if (underlyingType == typeof(sbyte))
		{
			return Enum.ToObject(type, reader.Read_sbyte());
		}
		if (underlyingType == typeof(short))
		{
			return Enum.ToObject(type, reader.Read_short());
		}
		if (underlyingType == typeof(uint))
		{
			return Enum.ToObject(type, reader.Read_uint());
		}
		if (underlyingType == typeof(ulong))
		{
			return Enum.ToObject(type, reader.Read_ulong());
		}
		if (underlyingType == typeof(ushort))
		{
			return Enum.ToObject(type, reader.Read_ushort());
		}
		throw new InvalidCastException("The underlying type " + underlyingType?.ToString() + " of Enum " + type?.ToString() + " is not supported");
	}
}
