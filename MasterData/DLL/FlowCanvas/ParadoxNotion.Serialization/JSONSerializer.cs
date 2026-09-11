using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.IO;
using ParadoxNotion.Serialization.FullSerializer;
using ParadoxNotion.Serialization.FullSerializer.Internal;
using UnityEngine;

namespace ParadoxNotion.Serialization;

public static class JSONSerializer
{
	private static Dictionary<string, fsData> cache = new Dictionary<string, fsData>();

	private static object serializerLock = new object();

	private static fsSerializer serializer = new fsSerializer();

	private static bool init = false;

	public static bool applicationPlaying = true;

	public static void ClearCache()
	{
		cache.Clear();
	}

	public static string Serialize(Type type, object value, bool pretyJson = false, List<UnityEngine.Object> objectReferences = null)
	{
		lock (serializerLock)
		{
			if (!init)
			{
				serializer.AddConverter(new fsUnityObjectConverter());
				init = true;
			}
			if (objectReferences != null)
			{
				objectReferences.Clear();
				serializer.Context.Set(objectReferences);
			}
			Type overrideConverterType = (typeof(UnityEngine.Object).RTIsAssignableFrom(type) ? typeof(fsReflectedConverter) : null);
			serializer.TrySerialize(type, overrideConverterType, value, out var data).AssertSuccess();
			if (pretyJson)
			{
				return fsJsonPrinter.PrettyJson(data);
			}
			return fsJsonPrinter.CompressedJson(data);
		}
	}

	public static T Deserialize<T>(string serializedState, List<UnityEngine.Object> objectReferences = null, T deserialized = default(T))
	{
		return (T)Deserialize(typeof(T), serializedState, objectReferences, deserialized);
	}

	public static object Deserialize(Type type, string serializedState, List<UnityEngine.Object> objectReferences = null, object deserialized = null)
	{
		lock (serializerLock)
		{
			if (!init)
			{
				serializer.AddConverter(new fsUnityObjectConverter());
				init = true;
			}
			if (objectReferences != null)
			{
				serializer.Context.Set(objectReferences);
			}
			fsData value = null;
			cache.TryGetValue(serializedState, out value);
			if (value == null)
			{
				value = fsJsonParser.Parse(serializedState);
				cache[serializedState] = value;
			}
			Type overrideConverterType = (typeof(UnityEngine.Object).RTIsAssignableFrom(type) ? typeof(fsReflectedConverter) : null);
			serializer.TryDeserialize(value, type, overrideConverterType, ref deserialized).AssertSuccess();
			return deserialized;
		}
	}

	public static T Clone<T>(T original, List<UnityEngine.Object> objectReferences = null)
	{
		return (T)Clone((object)original, objectReferences);
	}

	public static object Clone(object original, List<UnityEngine.Object> objectReferences = null)
	{
		Type type = original.GetType();
		string serializedState = Serialize(type, original, pretyJson: false, objectReferences);
		return Deserialize(type, serializedState, objectReferences);
	}

	public static void ShowData(string json, string name = "")
	{
		string contents = fsJsonPrinter.PrettyJson(fsJsonParser.Parse(json));
		string text = Path.GetTempPath() + (string.IsNullOrEmpty(name) ? Guid.NewGuid().ToString() : name) + ".json";
		File.WriteAllText(text, contents);
		Process.Start(text);
	}
}
