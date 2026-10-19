using System;
using System.Collections;
using System.Collections.Generic;
using System.Globalization;
using System.IO;
using System.Reflection;
using System.Security.Cryptography;
using System.Text;
using UnityEngine;

namespace Proxima;

public static class ProximaSerialization
{
	internal static readonly string VERSION = "1.0.0";

	private static List<Type> _nativeFlags = new List<Type> { typeof(RigidbodyConstraints) };

	public static string Serialize(object data, bool pretty = false)
	{
		MemoryStream memoryStream = FastJson.Serialize(data, pretty);
		if (memoryStream == null)
		{
			return null;
		}
		return Encoding.UTF8.GetString(memoryStream.GetBuffer(), 0, (int)memoryStream.Length);
	}

	internal static MemoryStream DataResponse(ProximaRequest request, object data)
	{
		return DataResponse(request.Id, data);
	}

	internal static MemoryStream DataResponse(string id, object data)
	{
		return FastJson.Serialize(new ProximaDataResponse
		{
			Id = id,
			Data = data
		});
	}

	internal static MemoryStream ErrorResponse(ProximaRequest request, string error)
	{
		return ErrorResponse(request.Id, error);
	}

	internal static MemoryStream ErrorResponse(string id, string error)
	{
		return FastJson.Serialize(new ProximaErrorResponse
		{
			Id = id,
			Error = error
		});
	}

	internal static string HashPassword(string password, string connectionId)
	{
		return Convert.ToBase64String(SHA256.Create().ComputeHash(Encoding.UTF8.GetBytes(password + connectionId)));
	}

	internal static ProximaInstanceHello CreateHello(string displayName, string password = "")
	{
		ProximaInstanceHello result = new ProximaInstanceHello
		{
			DisplayName = displayName,
			InstanceId = displayName.GetHashCode() + "_" + VERSION,
			ProductName = Application.productName,
			CompanyName = Application.companyName,
			Platform = Enum.GetName(typeof(RuntimePlatform), Application.platform),
			ProductVersion = Application.version,
			ProximaVersion = VERSION,
			ConnectionId = Guid.NewGuid().ToString()
		};
		if (!string.IsNullOrEmpty(password))
		{
			result.Password = HashPassword(password, result.ConnectionId);
		}
		return result;
	}

	private static bool TrySplitArray(string arrayString, out List<string> elements)
	{
		elements = null;
		if (arrayString.Length < 2)
		{
			return false;
		}
		if (arrayString[0] != '[')
		{
			return false;
		}
		if (arrayString[arrayString.Length - 1] != ']')
		{
			return false;
		}
		elements = new List<string>();
		int num = 0;
		bool flag = false;
		bool flag2 = false;
		StringBuilder stringBuilder = new StringBuilder();
		for (int i = 1; i < arrayString.Length - 1; i++)
		{
			char c = arrayString[i];
			if (!flag && num == 0 && c == ',')
			{
				elements.Add(stringBuilder.ToString());
				stringBuilder.Clear();
				continue;
			}
			stringBuilder.Append(c);
			if (flag2)
			{
				flag2 = false;
				continue;
			}
			switch (c)
			{
			case '\\':
				flag2 = true;
				break;
			case '"':
				flag = !flag;
				break;
			case '[':
				num++;
				break;
			case ']':
				num--;
				break;
			}
		}
		if (stringBuilder.Length > 0)
		{
			elements.Add(stringBuilder.ToString());
		}
		return true;
	}

	internal static IList MakeListOf(Type elementType)
	{
		return (IList)Activator.CreateInstance(typeof(List<>).MakeGenericType(elementType));
	}

	internal static IList MakeList(Type listType)
	{
		return MakeListOf(listType.GetGenericArguments()[0]);
	}

	internal static IList CopyList(IList list)
	{
		IList list2 = MakeList(list.GetType());
		foreach (object item in list)
		{
			list2.Add(item);
		}
		return list2;
	}

	internal static Array MakeArrayOf(Type elementType, int length)
	{
		return Array.CreateInstance(elementType, length);
	}

	internal static Array MakeArray(Type arrayType, int length)
	{
		return MakeArrayOf(arrayType.GetElementType(), length);
	}

	internal static Array CopyArray(Array array)
	{
		Array array2 = MakeArray(array.GetType(), array.Length);
		Array.Copy(array, array2, array.Length);
		return array2;
	}

	internal static Array ResizeArray(Array array, int size)
	{
		Array array2 = MakeArray(array.GetType(), size);
		Array.Copy(array, array2, Math.Min(array.Length, size));
		return array2;
	}

	private static bool TryDeserializeList(Type listType, string arrayString, out IList values)
	{
		if (!TrySplitArray(arrayString, out var elements))
		{
			values = null;
			return false;
		}
		Type type = listType.GetGenericArguments()[0];
		values = MakeListOf(type);
		for (int i = 0; i < elements.Count; i++)
		{
			if (!TryDeserialize(type, elements[i].Trim('"'), out var result))
			{
				values = null;
				return false;
			}
			values.Add(result);
		}
		return true;
	}

	private static bool TryDeserializeArray(Type elementType, string arrayString, out Array values)
	{
		if (!TrySplitArray(arrayString, out var elements))
		{
			values = null;
			return false;
		}
		values = MakeArrayOf(elementType, elements.Count);
		for (int i = 0; i < elements.Count; i++)
		{
			if (!TryDeserialize(elementType, elements[i].Trim('"'), out var result))
			{
				values = null;
				return false;
			}
			values.SetValue(result, i);
		}
		return true;
	}

	private static bool TryDeserializeArray<T>(string arrayString, out T[] values)
	{
		if (TryDeserializeArray(typeof(T), arrayString, out var values2))
		{
			values = (T[])values2;
			return true;
		}
		values = null;
		return false;
	}

	private static bool TryDeserializeArray<T>(string arrayString, int count, out T[] values)
	{
		if (!TryDeserializeArray<T>(arrayString, out values))
		{
			return false;
		}
		if (values.Length != count)
		{
			values = null;
			return false;
		}
		return true;
	}

	internal static bool TryDeserialize<T>(string value, out T result)
	{
		if (TryDeserialize(typeof(T), value, out var result2))
		{
			result = (T)result2;
			return true;
		}
		result = default;
		return false;
	}

	internal static bool TryDeserialize(Type type, string value, out object result)
	{
		if (type == typeof(string))
		{
			result = value;
			return true;
		}
		if (type == typeof(float))
		{
			if (float.TryParse(value, NumberStyles.Float, CultureInfo.InvariantCulture, out var result2))
			{
				result = result2;
				return true;
			}
		}
		else if (type == typeof(double))
		{
			if (double.TryParse(value, out var result3))
			{
				result = result3;
				return true;
			}
		}
		else if (type == typeof(byte))
		{
			if (byte.TryParse(value, out var result4))
			{
				result = result4;
				return true;
			}
		}
		else if (type == typeof(sbyte))
		{
			if (sbyte.TryParse(value, out var result5))
			{
				result = result5;
				return true;
			}
		}
		else if (type == typeof(short))
		{
			if (short.TryParse(value, out var result6))
			{
				result = result6;
				return true;
			}
		}
		else if (type == typeof(ushort))
		{
			if (ushort.TryParse(value, out var result7))
			{
				result = result7;
				return true;
			}
		}
		else if (type == typeof(int))
		{
			if (int.TryParse(value, out var result8))
			{
				result = result8;
				return true;
			}
		}
		else if (type == typeof(uint))
		{
			if (uint.TryParse(value, out var result9))
			{
				result = result9;
				return true;
			}
		}
		else if (type == typeof(long))
		{
			if (long.TryParse(value, out var result10))
			{
				result = result10;
				return true;
			}
		}
		else if (type == typeof(ulong))
		{
			if (ulong.TryParse(value, out var result11))
			{
				result = result11;
				return true;
			}
		}
		else
		{
			if (type == typeof(bool))
			{
				result = value == "true";
				return true;
			}
			IList values12;
			if (type == typeof(Vector2))
			{
				if (TryDeserializeArray<float>(value, 2, out var values))
				{
					result = new Vector2(values[0], values[1]);
					return true;
				}
			}
			else if (type == typeof(Vector3))
			{
				if (TryDeserializeArray<float>(value, 3, out var values2))
				{
					result = new Vector3(values2[0], values2[1], values2[2]);
					return true;
				}
			}
			else if (type == typeof(Vector4))
			{
				if (TryDeserializeArray<float>(value, 4, out var values3))
				{
					result = new Vector4(values3[0], values3[1], values3[2], values3[3]);
					return true;
				}
			}
			else if (type == typeof(Vector2Int))
			{
				if (TryDeserializeArray<int>(value, 2, out var values4))
				{
					result = new Vector2Int(values4[0], values4[1]);
					return true;
				}
			}
			else if (type == typeof(Vector3Int))
			{
				if (TryDeserializeArray<int>(value, 3, out var values5))
				{
					result = new Vector3Int(values5[0], values5[1], values5[2]);
					return true;
				}
			}
			else if (type == typeof(Quaternion))
			{
				if (TryDeserializeArray<float>(value, 3, out var values6))
				{
					result = Quaternion.Euler(values6[0], values6[1], values6[2]);
					return true;
				}
			}
			else if (type == typeof(Rect))
			{
				if (TryDeserializeArray<float>(value, 4, out var values7))
				{
					result = new Rect(values7[0], values7[1], values7[2], values7[3]);
					return true;
				}
			}
			else if (type == typeof(RectInt))
			{
				if (TryDeserializeArray<int>(value, 4, out var values8))
				{
					result = new RectInt(values8[0], values8[1], values8[2], values8[3]);
					return true;
				}
			}
			else if (type == typeof(Bounds))
			{
				if (TryDeserializeArray<float>(value, 6, out var values9))
				{
					result = new Bounds(new Vector3(values9[0], values9[1], values9[2]), new Vector3(values9[3], values9[4], values9[5]));
					return true;
				}
			}
			else if (type == typeof(BoundsInt))
			{
				if (TryDeserializeArray<int>(value, 6, out var values10))
				{
					result = new BoundsInt(new Vector3Int(values10[0], values10[1], values10[2]), new Vector3Int(values10[3], values10[4], values10[5]));
					return true;
				}
			}
			else if (type == typeof(Color))
			{
				if (ColorUtility.TryParseHtmlString(value, out var color))
				{
					result = color;
					return true;
				}
			}
			else if (type == typeof(LayerMask))
			{
				if (int.TryParse(value, out var result12))
				{
					result = new LayerMask
					{
						value = result12
					};
					return true;
				}
			}
			else if (type.IsEnum)
			{
				if (int.TryParse(value, out var result13))
				{
					result = result13;
					return true;
				}
			}
			else if (type.IsArray)
			{
				if (TryDeserializeArray(type.GetElementType(), value, out var values11))
				{
					result = values11;
					return true;
				}
			}
			else if (typeof(IList).IsAssignableFrom(type) && TryDeserializeList(type, value, out values12))
			{
				result = values12;
				return true;
			}
		}
		result = null;
		return false;
	}

	internal static object Deserialize(Type t, string value)
	{
		if (TryDeserialize(t, value, out var result))
		{
			return result;
		}
		throw new Exception("Failed to deserialize value: " + value + " as type: " + t.Name);
	}

	internal static T Deserialize<T>(string value)
	{
		return (T)Deserialize(typeof(T), value);
	}

	internal static string GetSerializedTypeName(Type propertyType)
	{
		if (propertyType.IsEnum)
		{
			StringBuilder stringBuilder = new StringBuilder();
			Array values = Enum.GetValues(propertyType);
			string[] enumNames = propertyType.GetEnumNames();
			Type underlyingType = Enum.GetUnderlyingType(propertyType);
			if (_nativeFlags.Contains(propertyType) || propertyType.GetCustomAttribute(typeof(FlagsAttribute)) != null)
			{
				stringBuilder.Append("Flags");
			}
			else
			{
				stringBuilder.Append("Enum");
			}
			if (values.Length > 0)
			{
				stringBuilder.Append(" ");
			}
			for (int i = 0; i < values.Length; i++)
			{
				if (i > 0)
				{
					stringBuilder.Append(",");
				}
				stringBuilder.Append(enumNames[i]);
				stringBuilder.Append(":");
				stringBuilder.Append(Convert.ChangeType(values.GetValue(i), underlyingType));
			}
			return stringBuilder.ToString();
		}
		if (propertyType.IsArray)
		{
			return "Array " + GetSerializedTypeName(propertyType.GetElementType());
		}
		if (typeof(IList).IsAssignableFrom(propertyType))
		{
			return "Array " + GetSerializedTypeName(propertyType.GetGenericArguments()[0]);
		}
		if (propertyType.IsSubclassOf(typeof(UnityEngine.Object)))
		{
			return "Object " + propertyType.Name;
		}
		return propertyType.Name;
	}
}
