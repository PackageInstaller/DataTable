using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.Serialization;
using Unity.VisualScripting.FullSerializer;
using UnityEngine;

namespace Unity.VisualScripting;

public static class Serialization
{
	public const string ConstructorWarning = "This parameterless constructor is only made public for serialization. Use another constructor instead.";

	private static readonly HashSet<SerializationOperation> freeOperations;

	private static readonly HashSet<SerializationOperation> busyOperations;

	private static readonly object @lock;

	private static readonly HashSet<ISerializationDepender> awaitingDependers;

	public static bool isUnitySerializing { get; set; }

	public static bool isCustomSerializing => busyOperations.Count > 0;

	public static bool isSerializing
	{
		get
		{
			if (!isUnitySerializing)
			{
				return isCustomSerializing;
			}
			return true;
		}
	}

	static Serialization()
	{
		@lock = new object();
		awaitingDependers = new HashSet<ISerializationDepender>();
		freeOperations = new HashSet<SerializationOperation>();
		busyOperations = new HashSet<SerializationOperation>();
	}

	private static SerializationOperation StartOperation()
	{
		lock (@lock)
		{
			if (freeOperations.Count == 0)
			{
				freeOperations.Add(new SerializationOperation());
			}
			SerializationOperation serializationOperation = freeOperations.First();
			freeOperations.Remove(serializationOperation);
			busyOperations.Add(serializationOperation);
			return serializationOperation;
		}
	}

	private static void EndOperation(SerializationOperation operation)
	{
		lock (@lock)
		{
			if (!busyOperations.Contains(operation))
			{
				throw new InvalidOperationException("Trying to finish an operation that isn't started.");
			}
			operation.Reset();
			busyOperations.Remove(operation);
			freeOperations.Add(operation);
		}
	}

	public static T CloneViaSerialization<T>(this T value, bool forceReflected = false)
	{
		return (T)value.Serialize(forceReflected).Deserialize(forceReflected);
	}

	public static void CloneViaSerializationInto<TSource, TDestination>(this TSource value, ref TDestination instance, bool forceReflected = false) where TDestination : TSource
	{
		object instance2 = instance;
		value.Serialize(forceReflected).DeserializeInto(ref instance2, forceReflected);
	}

	public static SerializationData Serialize(this object value, bool forceReflected = false)
	{
		SerializationOperation serializationOperation = StartOperation();
		try
		{
			string json = SerializeJson(serializationOperation.serializer, value, forceReflected);
			UnityEngine.Object[] objectReferences = serializationOperation.objectReferences.ToArray();
			return new SerializationData(json, objectReferences);
		}
		catch (Exception innerException)
		{
			throw new SerializationException("Serialization of '" + (value?.GetType().ToString() ?? "null") + "' failed.", innerException);
		}
		finally
		{
			EndOperation(serializationOperation);
		}
	}

	public static void DeserializeInto(this SerializationData data, ref object instance, bool forceReflected = false)
	{
		try
		{
			if (string.IsNullOrEmpty(data.json))
			{
				instance = null;
				return;
			}
			SerializationOperation serializationOperation = StartOperation();
			try
			{
				serializationOperation.objectReferences.AddRange(data.objectReferences);
				DeserializeJson(serializationOperation.serializer, data.json, ref instance, forceReflected);
			}
			finally
			{
				EndOperation(serializationOperation);
			}
		}
		catch (Exception innerException)
		{
			try
			{
				Debug.LogWarning(data.ToString("Deserialization Failure Data"), instance as UnityEngine.Object);
			}
			catch (Exception ex)
			{
				Debug.LogWarning("Failed to log deserialization failure data:\n" + ex, instance as UnityEngine.Object);
			}
			throw new SerializationException("Deserialization into '" + (instance?.GetType().ToString() ?? "null") + "' failed.", innerException);
		}
	}

	public static object Deserialize(this SerializationData data, bool forceReflected = false)
	{
		object instance = null;
		data.DeserializeInto(ref instance, forceReflected);
		return instance;
	}

	private static string SerializeJson(fsSerializer serializer, object instance, bool forceReflected)
	{
		using (ProfilingUtility.SampleBlock("SerializeJson"))
		{
			fsResult result = ((!forceReflected) ? serializer.TrySerialize(instance, out var data) : serializer.TrySerialize(instance.GetType(), typeof(fsReflectedConverter), instance, out data));
			HandleResult("Serialization", result, instance as UnityEngine.Object);
			return fsJsonPrinter.CompressedJson(data);
		}
	}

	private static fsResult DeserializeJsonUtil(fsSerializer serializer, string json, ref object instance, bool forceReflected)
	{
		fsData data = fsJsonParser.Parse(json);
		if (forceReflected)
		{
			return serializer.TryDeserialize(data, instance.GetType(), typeof(fsReflectedConverter), ref instance);
		}
		return serializer.TryDeserialize(data, ref instance);
	}

	private static void DeserializeJson(fsSerializer serializer, string json, ref object instance, bool forceReflected)
	{
		using (ProfilingUtility.SampleBlock("DeserializeJson"))
		{
			fsResult result = DeserializeJsonUtil(serializer, json, ref instance, forceReflected);
			HandleResult("Deserialization", result, instance as UnityEngine.Object);
		}
	}

	private static void HandleResult(string label, fsResult result, UnityEngine.Object context = null)
	{
		result.AssertSuccess();
		if (!result.HasWarnings)
		{
			return;
		}
		foreach (string rawMessage in result.RawMessages)
		{
			Debug.LogWarning("[" + label + "] " + rawMessage + "\n", context);
		}
	}

	public static string PrettyPrint(string json)
	{
		return fsJsonPrinter.PrettyJson(fsJsonParser.Parse(json));
	}

	public static void AwaitDependencies(ISerializationDepender depender)
	{
		awaitingDependers.Add(depender);
		CheckIfDependenciesMet(depender);
	}

	public static void NotifyDependencyDeserializing(ISerializationDependency dependency)
	{
		NotifyDependencyUnavailable(dependency);
	}

	public static void NotifyDependencyDeserialized(ISerializationDependency dependency)
	{
		NotifyDependencyAvailable(dependency);
	}

	public static void NotifyDependencyUnavailable(ISerializationDependency dependency)
	{
		dependency.IsDeserialized = false;
	}

	public static void NotifyDependencyAvailable(ISerializationDependency dependency)
	{
		dependency.IsDeserialized = true;
		ISerializationDepender[] array = awaitingDependers.ToArray();
		foreach (ISerializationDepender serializationDepender in array)
		{
			if (awaitingDependers.Contains(serializationDepender))
			{
				CheckIfDependenciesMet(serializationDepender);
			}
		}
	}

	private static void CheckIfDependenciesMet(ISerializationDepender depender)
	{
		bool flag = true;
		foreach (ISerializationDependency deserializationDependency in depender.deserializationDependencies)
		{
			if (!deserializationDependency.IsDeserialized)
			{
				flag = false;
				break;
			}
		}
		if (flag)
		{
			awaitingDependers.Remove(depender);
			depender.OnAfterDependenciesDeserialized();
		}
	}

	public static void LogStuckDependers()
	{
		if (awaitingDependers.Any())
		{
			string text = awaitingDependers.Count + " awaiting dependers: \n";
			foreach (ISerializationDepender awaitingDepender in awaitingDependers)
			{
				HashSet<object> hashSet = new HashSet<object>();
				foreach (ISerializationDependency deserializationDependency in awaitingDepender.deserializationDependencies)
				{
					if (!deserializationDependency.IsDeserialized)
					{
						hashSet.Add(deserializationDependency);
						break;
					}
				}
				text += $"{awaitingDepender} is missing {hashSet.ToCommaSeparatedString()}\n";
			}
			Debug.LogWarning(text);
		}
		else
		{
			Debug.Log("No stuck awaiting depender.");
		}
	}
}
