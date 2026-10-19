using System;
using System.Collections;
using System.Collections.Generic;
using System.Globalization;
using System.IO;
using System.Reflection;
using System.Text;
using UnityEngine;

namespace Proxima;

internal class FastJson
{
	private static bool _pretty = false;

	private static MemoryStream _stream;

	public static Dictionary<Type, List<FieldInfo>> _typeToObjectFields = new Dictionary<Type, List<FieldInfo>>(100);

	public static MemoryStream Serialize(object data, bool pretty = false)
	{
		if (data == null)
		{
			return null;
		}
		_pretty = pretty;
		_stream = new MemoryStream(1024);
		try
		{
			SerializeRecursively(data.GetType(), data, quote: false);
			_stream.Position = 0L;
			return _stream;
		}
		catch (Exception exception)
		{
			Debug.LogException(exception);
			return null;
		}
	}

	private static void SerializeRecursively(Type type, object data, bool quote)
	{
		if (TrySerializeValue(type, data, quote))
		{
			return;
		}
		if (typeof(IList).IsAssignableFrom(type))
		{
			SerializeList(data);
			return;
		}
		if (type.IsArray)
		{
			SerializeArray(data);
			return;
		}
		if (type.IsSerializable)
		{
			SerializeObject(data);
			return;
		}
		if (typeof(IEnumerable).IsAssignableFrom(type))
		{
			SerializeEnumerable(data);
			return;
		}
		throw new Exception($"Unsupported type {type}");
	}

	private static bool TrySerializeValue(Type type, object data, bool quote)
	{
		if ((object)type != null)
		{
			if (type == typeof(bool))
			{
				SerializeBool(data);
			}
			else if (type == typeof(byte))
			{
				WriteUInt64((byte)data);
			}
			else if (type == typeof(sbyte))
			{
				WriteInt64((sbyte)data);
			}
			else if (type == typeof(short))
			{
				WriteInt64((short)data);
			}
			else if (type == typeof(ushort))
			{
				WriteUInt64((ushort)data);
			}
			else if (type == typeof(int))
			{
				WriteInt64((int)data);
			}
			else if (type == typeof(uint))
			{
				WriteUInt64((uint)data);
			}
			else if (type == typeof(long))
			{
				WriteInt64((long)data);
			}
			else if (type == typeof(ulong))
			{
				WriteUInt64((ulong)data);
			}
			else if (type == typeof(float))
			{
				SerializeFloat(data);
			}
			else if (type == typeof(double))
			{
				SerializeDouble(data);
			}
			else if (type == typeof(string))
			{
				SerializeString(data, quote);
			}
			else if (type == typeof(Vector2))
			{
				SerializeVector2(data);
			}
			else if (type == typeof(Vector3))
			{
				SerializeVector3(data);
			}
			else if (type == typeof(Vector4))
			{
				SerializeVector4(data);
			}
			else if (type == typeof(Vector2Int))
			{
				SerializeVector2Int(data);
			}
			else if (type == typeof(Vector3Int))
			{
				SerializeVector3Int(data);
			}
			else if (type == typeof(Quaternion))
			{
				SerializeQuaternion(data);
			}
			else if (type == typeof(Rect))
			{
				SerializeRect(data);
			}
			else if (type == typeof(RectInt))
			{
				SerializeRectInt(data);
			}
			else if (type == typeof(Bounds))
			{
				SerializeBounds(data);
			}
			else if (type == typeof(BoundsInt))
			{
				SerializeBoundsInt(data);
			}
			else if (type == typeof(Color))
			{
				SerializeColor(data, quote);
			}
			else if (type == typeof(LayerMask))
			{
				SerializeLayerMask(data);
			}
			else if (type.IsEnum)
			{
				SerializeEnum(data);
			}
			else
			{
				if (!type.IsSubclassOf(typeof(UnityEngine.Object)))
				{
					goto IL_0310;
				}
				SerializeUnityObject(type, data, quote);
			}
			return true;
		}
		goto IL_0310;
		IL_0310:
		return false;
	}

	private static void Write(char value)
	{
		_stream.WriteByte((byte)value);
	}

	private static void Write(string value, int offset, int count)
	{
		Encoding uTF = Encoding.UTF8;
		int num = (int)_stream.Length;
		_stream.SetLength(_stream.Length + uTF.GetMaxByteCount(count));
		int bytes = uTF.GetBytes(value, offset, count, _stream.GetBuffer(), num);
		_stream.SetLength(num + bytes);
		_stream.Seek(0L, SeekOrigin.End);
	}

	private static void Write(string value)
	{
		Write(value, 0, value.Length);
	}

	private static void SerializeBool(object data)
	{
		SerializeBool(data != null && (bool)data);
	}

	private static void SerializeBool(bool data)
	{
		if (data)
		{
			Write("true");
		}
		else
		{
			Write("false");
		}
	}

	private static void SerializeFloat(object data)
	{
		SerializeFloat((data != null) ? ((float)data) : 0f);
	}

	private static void SerializeFloat(float data)
	{
		if (float.IsNaN(data))
		{
			Write('0');
			return;
		}
		if (float.IsInfinity(data))
		{
			Write("\"Infinity\"");
			return;
		}
		if (float.IsNegativeInfinity(data))
		{
			Write("\"-Infinity\"");
			return;
		}
		float num = data;
		Write(num.ToString(CultureInfo.InvariantCulture));
	}

	private static void SerializeDouble(object data)
	{
		SerializeDouble((data != null) ? ((double)data) : 0.0);
	}

	private static void SerializeDouble(double data)
	{
		if (double.IsNaN(data))
		{
			Write('0');
			return;
		}
		if (double.IsInfinity(data))
		{
			Write("\"Infinity\"");
			return;
		}
		if (double.IsNegativeInfinity(data))
		{
			Write("\"-Infinity\"");
			return;
		}
		double num = data;
		Write(num.ToString(CultureInfo.InvariantCulture));
	}

	private static void SerializeString(object data, bool quote)
	{
		string text = (string)data;
		if (quote)
		{
			Write('"');
		}
		if (string.IsNullOrEmpty(text))
		{
			if (quote)
			{
				Write('"');
			}
			return;
		}
		int length = text.Length;
		bool flag = false;
		for (int i = 0; i < length; i++)
		{
			char c = text[i];
			if ((c >= '\0' && c <= '\u001f') || c == '"' || c == '\'' || c == '<' || c == '>' || c == '\\')
			{
				flag = true;
				break;
			}
		}
		if (!flag)
		{
			Write(text);
			if (quote)
			{
				Write('"');
			}
			return;
		}
		int num = 0;
		for (int j = 0; j < length; j++)
		{
			char c = text[j];
			string text2 = null;
			if ((c >= '\0' && c <= '\a') || c == '\v' || (c >= '\u000e' && c <= '\u001f') || c == '\'' || c == '<' || c == '>')
			{
				text2 = $"\\u{(int)c:x4}";
			}
			else
			{
				switch ((int)c)
				{
				case 8:
					text2 = "\\b";
					break;
				case 9:
					text2 = "\\t";
					break;
				case 10:
					text2 = "\\n";
					break;
				case 12:
					text2 = "\\f";
					break;
				case 13:
					text2 = "\\r";
					break;
				case 34:
					text2 = "\\\"";
					break;
				case 92:
					text2 = "\\\\";
					break;
				}
			}
			if (text2 != null)
			{
				if (num < j)
				{
					Write(text.Substring(num, j - num));
				}
				Write(text2);
				num = j + 1;
			}
		}
		if (num < length)
		{
			Write(text.Substring(num));
		}
		if (quote)
		{
			Write('"');
		}
	}

	private static void SerializeParams<T>(params T[] values)
	{
		SerializeList(values);
	}

	private static void SerializeVector2(object data)
	{
		Vector2 vector = ((data != null) ? ((Vector2)data) : Vector2.zero);
		SerializeParams<float>(vector.x, vector.y);
	}

	private static void SerializeVector3(object data)
	{
		Vector3 vector = ((data != null) ? ((Vector3)data) : Vector3.zero);
		SerializeParams<float>(vector.x, vector.y, vector.z);
	}

	private static void SerializeVector4(object data)
	{
		Vector4 vector = ((data != null) ? ((Vector4)data) : Vector4.zero);
		SerializeParams<float>(vector.x, vector.y, vector.z, vector.w);
	}

	private static void SerializeVector2Int(object data)
	{
		Vector2Int vector2Int = ((data != null) ? ((Vector2Int)data) : Vector2Int.zero);
		SerializeParams<int>(vector2Int.x, vector2Int.y);
	}

	private static void SerializeVector3Int(object data)
	{
		Vector3Int vector3Int = ((data != null) ? ((Vector3Int)data) : Vector3Int.zero);
		SerializeParams<int>(vector3Int.x, vector3Int.y, vector3Int.z);
	}

	private static void SerializeQuaternion(object data)
	{
		SerializeVector3((data != null) ? ((Quaternion)data).eulerAngles : Vector3.zero);
	}

	private static void SerializeRect(object data)
	{
		Rect rect = ((data != null) ? ((Rect)data) : Rect.zero);
		SerializeParams<float>(rect.x, rect.y, rect.width, rect.height);
	}

	private static void SerializeRectInt(object data)
	{
		RectInt rectInt = ((data != null) ? ((RectInt)data) : new RectInt(0, 0, 0, 0));
		SerializeParams<int>(rectInt.x, rectInt.y, rectInt.width, rectInt.height);
	}

	private static void SerializeBounds(object data)
	{
		Bounds bounds = ((data != null) ? ((Bounds)data) : new Bounds(Vector3.zero, Vector3.zero));
		SerializeParams<float>(bounds.center.x, bounds.center.y, bounds.center.z, bounds.size.x, bounds.size.y, bounds.size.z);
	}

	private static void SerializeBoundsInt(object data)
	{
		BoundsInt boundsInt = ((data != null) ? ((BoundsInt)data) : new BoundsInt(Vector3Int.zero, Vector3Int.zero));
		SerializeParams<int>(boundsInt.position.x, boundsInt.position.y, boundsInt.position.z, boundsInt.size.x, boundsInt.size.y, boundsInt.size.z);
	}

	private static void WriteHex(byte value)
	{
		byte b = (byte)(value >> 4);
		byte b2 = (byte)(value & 0xF);
		Write((char)((b < 10) ? (b + 48) : (b + 55)));
		Write((char)((b2 < 10) ? (b2 + 48) : (b2 + 55)));
	}

	private static void SerializeColor(object data, bool quote)
	{
		Color color = ((data != null) ? ((Color)data) : Color.black);
		if (quote)
		{
			Write('"');
		}
		Write('#');
		WriteHex((byte)(color.r * 255f));
		WriteHex((byte)(color.g * 255f));
		WriteHex((byte)(color.b * 255f));
		WriteHex((byte)(color.a * 255f));
		if (quote)
		{
			Write('"');
		}
	}

	private static void SerializeLayerMask(object data)
	{
		WriteInt64(((LayerMask)data).value);
	}

	private static void SerializeEnum(object data)
	{
		if (data == null)
		{
			Write('0');
			return;
		}
		Type underlyingType = Enum.GetUnderlyingType(data.GetType());
		Type type = underlyingType;
		if ((object)type != null)
		{
			if (type == typeof(byte))
			{
				WriteUInt64((byte)data);
				return;
			}
			if (type == typeof(sbyte))
			{
				WriteInt64((sbyte)data);
				return;
			}
			if (type == typeof(short))
			{
				WriteInt64((short)data);
				return;
			}
			if (type == typeof(ushort))
			{
				WriteUInt64((ushort)data);
				return;
			}
			if (type == typeof(int))
			{
				WriteInt64((int)data);
				return;
			}
			if (type == typeof(uint))
			{
				WriteUInt64((uint)data);
				return;
			}
			if (type == typeof(long))
			{
				WriteInt64((long)data);
				return;
			}
			if (type == typeof(ulong))
			{
				WriteUInt64((ulong)data);
				return;
			}
		}
		throw new Exception($"Unsupported enum type {underlyingType}");
	}

	private static void SerializeUnityObject(Type type, object data, bool quote)
	{
		UnityEngine.Object obj = (UnityEngine.Object)data;
		if (obj == null)
		{
			Write("null");
		}
		else
		{
			SerializeString(obj.name, quote);
		}
	}

	private static void SerializeList(object data)
	{
		IList list = (IList)data;
		Write('[');
		bool flag = true;
		Type elementType = list.GetType().GetElementType();
		for (int i = 0; i < list.Count; i++)
		{
			object obj = list[i];
			if (!flag)
			{
				if (_pretty)
				{
					Write(", ");
				}
				else
				{
					Write(',');
				}
			}
			SerializeRecursively((obj != null) ? obj.GetType() : elementType, obj, quote: true);
			flag = false;
		}
		Write(']');
	}

	private static void SerializeArray(object data)
	{
		Array array = (Array)data;
		Write('[');
		bool flag = true;
		Type elementType = array.GetType().GetElementType();
		for (int i = 0; i < array.Length; i++)
		{
			object value = array.GetValue(i);
			if (!flag)
			{
				if (_pretty)
				{
					Write(", ");
				}
				else
				{
					Write(',');
				}
			}
			SerializeRecursively((value != null) ? value.GetType() : elementType, value, quote: true);
			flag = false;
		}
		Write(']');
	}

	private static void SerializeEnumerable(object data)
	{
		IEnumerable enumerable = (IEnumerable)data;
		Write('[');
		bool flag = true;
		Type type = data.GetType().GetGenericArguments()[0];
		foreach (object item in enumerable)
		{
			if (!flag)
			{
				if (_pretty)
				{
					Write(", ");
				}
				else
				{
					Write(',');
				}
			}
			SerializeRecursively((item != null) ? item.GetType() : type, item, quote: true);
			flag = false;
		}
		Write(']');
	}

	private static void SerializeObject(object data)
	{
		if (data == null)
		{
			Write("null");
		}
		Type type = data.GetType();
		string text = JsonUtility.ToJson(data);
		if (!_typeToObjectFields.TryGetValue(type, out var value))
		{
			value = new List<FieldInfo>();
			FieldInfo[] fields = type.GetFields(BindingFlags.Instance | BindingFlags.Public);
			foreach (FieldInfo fieldInfo in fields)
			{
				if ((fieldInfo.FieldType == typeof(object) || fieldInfo.FieldType == typeof(object[])) && !Attribute.IsDefined(fieldInfo, typeof(NonSerializedAttribute)))
				{
					value.Add(fieldInfo);
				}
			}
			_typeToObjectFields.Add(type, value);
		}
		if (value.Count > 0)
		{
			Write(text, 0, text.Length - 1);
			foreach (FieldInfo item in value)
			{
				object value2 = item.GetValue(data);
				if (value2 == null)
				{
					continue;
				}
				SerializeIfAttribute customAttribute = item.GetCustomAttribute<SerializeIfAttribute>();
				if (customAttribute != null)
				{
					MethodInfo method = data.GetType().GetMethod(customAttribute.Method, BindingFlags.Instance | BindingFlags.Public | BindingFlags.NonPublic);
					if (method == null)
					{
						throw new Exception($"Method {customAttribute.Method} not found in {data.GetType()}");
					}
					if (!(bool)method.Invoke(data, null))
					{
						continue;
					}
				}
				if (text.Length > 2)
				{
					Write(',');
				}
				Write('"');
				Write(item.Name);
				Write("\":");
				SerializeRecursively(value2.GetType(), value2, quote: true);
			}
			Write('}');
		}
		else
		{
			Write(text);
		}
	}

	private static void WriteInt64(long data)
	{
		long num = data;
		if (num < 0)
		{
			if (num == long.MinValue)
			{
				Write("-9223372036854775808");
				return;
			}
			Write('-');
			num = -num;
		}
		WriteUInt64((ulong)num);
	}

	private static void WriteUInt64(ulong value)
	{
		long length = _stream.Length;
		byte[] buffer = _stream.GetBuffer();
		while (value > 9)
		{
			ulong num = value % 10;
			value /= 10;
			_stream.WriteByte((byte)(48 + num));
		}
		_stream.WriteByte((byte)(48 + value));
		long length2 = _stream.Length;
		for (int i = 0; i < (length2 - length) / 2; i++)
		{
			byte b = buffer[length + i];
			buffer[length + i] = buffer[length2 - i - 1];
			buffer[length2 - i - 1] = b;
		}
	}
}
