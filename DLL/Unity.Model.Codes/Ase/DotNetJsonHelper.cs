using System;
using GameFramework;
using Newtonsoft.Json;

namespace Ase;

public class DotNetJsonHelper : Utility.Json.IJsonHelper
{
	public string ToJson(object obj)
	{
		return JsonConvert.SerializeObject(obj);
	}

	public T ToObject<T>(string json)
	{
		return JsonConvert.DeserializeObject<T>(json);
	}

	public object ToObject(Type objectType, string json)
	{
		throw new NotSupportedException("ToObject(Type objectType, string json)");
	}
}
