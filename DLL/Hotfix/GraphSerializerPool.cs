using System.Collections.Generic;
using ParadoxNotion.Serialization.FullSerializer;

public static class GraphSerializerPool
{
	private static Dictionary<fsDataType, Queue<string>> _stringPool = new Dictionary<fsDataType, Queue<string>>();

	public static string Acquire(fsDataType dataType)
	{
		_stringPool.TryGetValue(dataType, out var value);
		if (value == null)
		{
			value = new Queue<string>();
			_stringPool.Add(dataType, value);
			return TypeSwitchString(dataType);
		}
		if (value.Count == 0)
		{
			return TypeSwitchString(dataType);
		}
		return value.Dequeue();
	}

	public static void Release(string content)
	{
		fsDataType key = StringSwitchType(content);
		_stringPool.TryGetValue(key, out var value);
		if (value == null)
		{
			value = new Queue<string>();
			value.Enqueue(content);
			_stringPool.Add(key, value);
		}
		else
		{
			value.Enqueue(content);
		}
	}

	private static string TypeSwitchString(fsDataType dataType)
	{
		return dataType switch
		{
			fsDataType.Boolean => "Boolean", 
			fsDataType.Array => "Array", 
			fsDataType.Object => "Object", 
			fsDataType.Double => "Double", 
			fsDataType.Int64 => "Int64", 
			fsDataType.String => "String", 
			fsDataType.Null => "Null", 
			_ => null, 
		};
	}

	private static fsDataType StringSwitchType(string content)
	{
		return content switch
		{
			"Null" => fsDataType.Null, 
			"Array" => fsDataType.Array, 
			"Object" => fsDataType.Object, 
			"Double" => fsDataType.Double, 
			"Int64" => fsDataType.Int64, 
			"Boolean" => fsDataType.Boolean, 
			"String" => fsDataType.String, 
			_ => fsDataType.Null, 
		};
	}
}
