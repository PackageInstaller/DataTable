#define ENABLE_ERROR_AND_ABOVE_LOG
using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.IO;
using GameFramework;
using Newtonsoft.Json;
using ParadoxNotion.Serialization.FullSerializer;
using ParadoxNotion.Serialization.FullSerializer.Internal;
using ParadoxNotion.Services;
using UnityEngine;

namespace ParadoxNotion.Serialization;

public static class JSONSerializer
{
	private static object serializerLock;

	private static fsSerializer serializer;

	private static Dictionary<string, fsData> _jsonDataCache;

	private static Dictionary<GraphByteData, fsData> _byteDataCache;

	static JSONSerializer()
	{
		serializerLock = new object();
		FlushMem();
	}

	public static void FlushMem()
	{
		serializer = new fsSerializer();
		_jsonDataCache = new Dictionary<string, fsData>();
		_byteDataCache = new Dictionary<GraphByteData, fsData>();
		fsMetaType.FlushMem();
	}

	public static void ClearCache()
	{
		_jsonDataCache?.Clear();
		_byteDataCache?.Clear();
	}

	[RuntimeInitializeOnLoadMethod(RuntimeInitializeLoadType.SubsystemRegistration)]
	private static void __FlushDataCache()
	{
		_jsonDataCache = new Dictionary<string, fsData>();
		_byteDataCache = new Dictionary<GraphByteData, fsData>();
	}

	public static string Serialize(Type type, object instance, GraphByteData graphByteData, List<UnityEngine.Object> references = null, bool pretyJson = false)
	{
		lock (serializerLock)
		{
			serializer.PurgeTemporaryData();
			serializer.ReferencesDatabase = references;
			Type overrideConverterType = (typeof(UnityEngine.Object).RTIsAssignableFrom(type) ? typeof(fsReflectedConverter) : null);
			_ = serializer.TrySerialize(type, instance, out var data, overrideConverterType).AssertSuccess().HasWarnings;
			serializer.ReferencesDatabase = null;
			if (graphByteData != null)
			{
				graphByteData.Clear();
				fsJsonPrinter.ToByte(data, graphByteData);
				if (Threader.applicationIsPlaying || Application.isPlaying)
				{
					_byteDataCache[graphByteData] = data;
				}
			}
			else
			{
				Log.Error("行为树二进制序列化失败：没有字节数据!");
			}
			return null;
		}
	}

	public static string Serialize(Type type, object instance, List<UnityEngine.Object> references = null, bool pretyJson = false)
	{
		lock (serializerLock)
		{
			serializer.PurgeTemporaryData();
			serializer.ReferencesDatabase = references;
			Type overrideConverterType = (typeof(UnityEngine.Object).RTIsAssignableFrom(type) ? typeof(fsReflectedConverter) : null);
			_ = serializer.TrySerialize(type, instance, out var data, overrideConverterType).AssertSuccess().HasWarnings;
			serializer.ReferencesDatabase = null;
			string text = fsJsonPrinter.ToJson(data, pretyJson);
			if (Threader.applicationIsPlaying || Application.isPlaying)
			{
				_jsonDataCache[text] = data;
			}
			return text;
		}
	}

	public static void ByteSerialize(Type type, object instance, GraphByteData byteData, List<UnityEngine.Object> references = null)
	{
		lock (serializerLock)
		{
			serializer.PurgeTemporaryData();
			serializer.ReferencesDatabase = references;
			Type overrideConverterType = (typeof(UnityEngine.Object).RTIsAssignableFrom(type) ? typeof(fsReflectedConverter) : null);
			_ = serializer.TrySerialize(type, instance, out var data, overrideConverterType).AssertSuccess().HasWarnings;
			serializer.ReferencesDatabase = null;
			if (byteData != null)
			{
				fsJsonPrinter.ToByte(data, byteData);
				if (Threader.applicationIsPlaying || Application.isPlaying)
				{
					_byteDataCache[byteData] = data;
				}
			}
		}
	}

	public static T Deserialize<T>(string json, GraphByteData graphByteData, List<UnityEngine.Object> references = null)
	{
		return (T)Internal_Deserialize(typeof(T), json, graphByteData, references, null);
	}

	public static T JsonDeserialize<T>(string json, List<UnityEngine.Object> references = null)
	{
		return (T)Internal_Deserialize(typeof(T), json, references, null);
	}

	public static T JsonDeserialize<T>(T instance, string json, List<UnityEngine.Object> references = null)
	{
		return (T)Internal_Deserialize(typeof(T), json, references, instance);
	}

	public static T ByteDeserialize<T>(T instance, GraphByteData graphByteData, List<UnityEngine.Object> references = null)
	{
		return (T)Internal_Deserialize(typeof(T), graphByteData, references, instance);
	}

	public static T ByteDeserialize<T>(GraphByteData graphByteData, List<UnityEngine.Object> references = null)
	{
		return (T)Internal_Deserialize(typeof(T), graphByteData, references, null);
	}

	public static object Deserialize(Type type, string json, List<UnityEngine.Object> references = null)
	{
		return Internal_Deserialize(type, json, references, null);
	}

	public static T TryDeserializeOverwrite<T>(T instance, string json, GraphByteData graphByteData, List<UnityEngine.Object> references = null) where T : class
	{
		return (T)Internal_Deserialize(typeof(T), json, graphByteData, references, instance);
	}

	private static object Internal_Deserialize(Type type, string json, GraphByteData graphByteData, List<UnityEngine.Object> references, object instance)
	{
		lock (serializerLock)
		{
			serializer.PurgeTemporaryData();
			fsData value = null;
			if (Threader.applicationIsPlaying)
			{
				if (!_byteDataCache.TryGetValue(graphByteData, out value))
				{
					value = (_byteDataCache[graphByteData] = fsJsonParser.ByteParse(graphByteData));
				}
				else
				{
					ThreadLogger.Instance?.SafeLog("从_byteDataCache缓存中拿出的Data...");
				}
			}
			else if (graphByteData != null)
			{
				value = fsJsonParser.ByteParse(graphByteData);
			}
			else
			{
				ThreadLogger.Instance?.SafeLog("行为树反序列化失败: 缺少字节数据!");
			}
			serializer.ReferencesDatabase = references;
			Type overrideConverterType = ((instance is UnityEngine.Object) ? typeof(fsReflectedConverter) : null);
			fsResult fsResult2 = serializer.TryDeserialize(value, type, ref instance, overrideConverterType).AssertSuccess();
			if (fsResult2.HasWarnings)
			{
				ThreadLogger.Instance?.SafeLog(fsResult2.ToString());
			}
			serializer.ReferencesDatabase = null;
			return instance;
		}
	}

	private static object Internal_Deserialize(Type type, string json, List<UnityEngine.Object> references, object instance)
	{
		lock (serializerLock)
		{
			serializer.PurgeTemporaryData();
			fsData value = null;
			if (Threader.applicationIsPlaying)
			{
				if (!_jsonDataCache.TryGetValue(json, out value))
				{
					value = (_jsonDataCache[json] = fsJsonParser.Parse(json));
				}
			}
			else
			{
				value = fsJsonParser.Parse(json);
			}
			serializer.ReferencesDatabase = references;
			Type overrideConverterType = ((instance is UnityEngine.Object) ? typeof(fsReflectedConverter) : null);
			_ = serializer.TryDeserialize(value, type, ref instance, overrideConverterType).AssertSuccess().HasWarnings;
			serializer.ReferencesDatabase = null;
			return instance;
		}
	}

	private static object Internal_Deserialize(Type type, GraphByteData byteData, List<UnityEngine.Object> references, object instance)
	{
		lock (serializerLock)
		{
			serializer.PurgeTemporaryData();
			fsData value = null;
			if (Threader.applicationIsPlaying)
			{
				if (!_byteDataCache.TryGetValue(byteData, out value))
				{
					value = (_byteDataCache[byteData] = fsJsonParser.ByteParse(byteData));
				}
			}
			else if (byteData != null)
			{
				value = fsJsonParser.ByteParse(byteData);
			}
			serializer.ReferencesDatabase = references;
			Type overrideConverterType = ((instance is UnityEngine.Object) ? typeof(fsReflectedConverter) : null);
			_ = serializer.TryDeserialize(value, type, ref instance, overrideConverterType).AssertSuccess().HasWarnings;
			serializer.ReferencesDatabase = null;
			return instance;
		}
	}

	public static void SerializeAndExecuteNoCycles(Type type, object instance, Action<object, fsData> call)
	{
		lock (serializerLock)
		{
			serializer.IgnoreSerializeCycleReferences = true;
			serializer.onAfterObjectSerialized += call;
			try
			{
				GraphByteData graphByteData = new GraphByteData();
				Serialize(type, instance, graphByteData);
			}
			finally
			{
				serializer.IgnoreSerializeCycleReferences = false;
				serializer.onAfterObjectSerialized -= call;
			}
		}
	}

	public static void SerializeAndExecuteNoCycles(Type type, object instance, Action<object> beforeCall, Action<object, fsData> afterCall)
	{
		lock (serializerLock)
		{
			serializer.IgnoreSerializeCycleReferences = true;
			serializer.onBeforeObjectSerialized += beforeCall;
			serializer.onAfterObjectSerialized += afterCall;
			try
			{
				GraphByteData graphByteData = new GraphByteData();
				Serialize(type, instance, graphByteData);
			}
			finally
			{
				serializer.IgnoreSerializeCycleReferences = false;
				serializer.onBeforeObjectSerialized -= beforeCall;
				serializer.onAfterObjectSerialized -= afterCall;
			}
		}
	}

	public static T Clone<T>(T original)
	{
		return (T)Clone((object)original);
	}

	public static object Clone(object original)
	{
		Type type = original.GetType();
		List<UnityEngine.Object> references = new List<UnityEngine.Object>();
		string json = Serialize(type, original, references);
		return Deserialize(type, json, references);
	}

	public static void ShowData(GraphByteData byteData, string fileName = "")
	{
		string contents = JsonConvert.SerializeObject(byteData);
		string text = Path.GetTempPath() + (string.IsNullOrEmpty(fileName) ? Guid.NewGuid().ToString() : fileName) + ".json";
		File.WriteAllText(text, contents);
		Process.Start(text);
	}

	public static string PrettifyJson(string json)
	{
		return fsJsonPrinter.PrettyJson(fsJsonParser.Parse(json));
	}
}
