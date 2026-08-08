using System;
using System.Collections.Generic;
using ParadoxNotion.Serialization.FullSerializer.Internal;
using ParadoxNotion.Services;
using UnityEngine;

namespace ParadoxNotion.Serialization.FullSerializer;

public class fsSerializer
{
	internal class fsLazyCycleDefinitionWriter
	{
		private Dictionary<int, fsData> _pendingDefinitions = new Dictionary<int, fsData>();

		private HashSet<int> _references = new HashSet<int>();

		public void WriteDefinition(int id, fsData data)
		{
			if (_references.Contains(id))
			{
				EnsureDictionary(data);
				data.AsDictionary["$id"] = new fsData(id.ToString());
			}
			else
			{
				_pendingDefinitions[id] = data;
			}
		}

		public void WriteReference(int id, Dictionary<string, fsData> dict)
		{
			if (_pendingDefinitions.ContainsKey(id))
			{
				fsData obj = _pendingDefinitions[id];
				EnsureDictionary(obj);
				obj.AsDictionary["$id"] = new fsData(id.ToString());
				_pendingDefinitions.Remove(id);
			}
			else
			{
				_references.Add(id);
			}
			dict["$ref"] = new fsData(id.ToString());
		}

		public void Clear()
		{
			_pendingDefinitions.Clear();
			_references.Clear();
		}
	}

	private static HashSet<string> _reservedKeywords;

	private const string Key_ObjectReference = "$ref";

	private const string Key_ObjectDefinition = "$id";

	private const string Key_InstanceType = "$type";

	private const string Key_Version = "$version";

	private const string Key_Content = "$content";

	private Dictionary<Type, fsBaseConverter> _cachedConverterTypeInstances;

	private Dictionary<Type, fsBaseConverter> _cachedConverters;

	private Dictionary<Type, List<fsObjectProcessor>> _cachedProcessors;

	private readonly List<fsConverter> _availableConverters;

	private readonly Dictionary<Type, fsDirectConverter> _availableDirectConverters;

	private readonly List<fsObjectProcessor> _processors;

	private readonly fsCyclicReferenceManager _references;

	private readonly fsLazyCycleDefinitionWriter _lazyReferenceWriter;

	public fsContext Context;

	public fsConfig Config;

	static fsSerializer()
	{
		_reservedKeywords = new HashSet<string> { "$ref", "$id", "$type", "$version", "$content" };
	}

	public static bool IsReservedKeyword(string key)
	{
		return _reservedKeywords.Contains(key);
	}

	private static bool IsObjectReference(fsData data)
	{
		if (!data.IsDictionary)
		{
			return false;
		}
		return data.AsDictionary.ContainsKey("$ref");
	}

	private static bool IsObjectDefinition(fsData data)
	{
		if (!data.IsDictionary)
		{
			return false;
		}
		return data.AsDictionary.ContainsKey("$id");
	}

	private static bool IsVersioned(fsData data)
	{
		if (!data.IsDictionary)
		{
			return false;
		}
		return data.AsDictionary.ContainsKey("$version");
	}

	private static bool IsTypeSpecified(fsData data)
	{
		if (!data.IsDictionary)
		{
			return false;
		}
		return data.AsDictionary.ContainsKey("$type");
	}

	private static bool IsWrappedData(fsData data)
	{
		if (!data.IsDictionary)
		{
			return false;
		}
		return data.AsDictionary.ContainsKey("$content");
	}

	public static void StripDeserializationMetadata(ref fsData data)
	{
		if (data.IsDictionary && data.AsDictionary.ContainsKey("$content"))
		{
			data = data.AsDictionary["$content"];
		}
		if (data.IsDictionary)
		{
			Dictionary<string, fsData> asDictionary = data.AsDictionary;
			asDictionary.Remove("$ref");
			asDictionary.Remove("$id");
			asDictionary.Remove("$type");
			asDictionary.Remove("$version");
		}
	}

	private static void Invoke_OnBeforeSerialize(List<fsObjectProcessor> processors, Type storageType, object instance)
	{
		for (int i = 0; i < processors.Count; i++)
		{
			processors[i].OnBeforeSerialize(storageType, instance);
		}
		if (instance is ISerializationCallbackReceiver && !(instance is UnityEngine.Object))
		{
			((ISerializationCallbackReceiver)instance).OnBeforeSerialize();
		}
	}

	private static void Invoke_OnAfterSerialize(List<fsObjectProcessor> processors, Type storageType, object instance, ref fsData data)
	{
		for (int num = processors.Count - 1; num >= 0; num--)
		{
			processors[num].OnAfterSerialize(storageType, instance, ref data);
		}
	}

	private static void Invoke_OnBeforeDeserialize(List<fsObjectProcessor> processors, Type storageType, ref fsData data)
	{
		for (int i = 0; i < processors.Count; i++)
		{
			processors[i].OnBeforeDeserialize(storageType, ref data);
		}
	}

	private static void Invoke_OnBeforeDeserializeAfterInstanceCreation(List<fsObjectProcessor> processors, Type storageType, object instance, ref fsData data)
	{
		for (int i = 0; i < processors.Count; i++)
		{
			processors[i].OnBeforeDeserializeAfterInstanceCreation(storageType, instance, ref data);
		}
	}

	private static void Invoke_OnAfterDeserialize(List<fsObjectProcessor> processors, Type storageType, object instance)
	{
		for (int num = processors.Count - 1; num >= 0; num--)
		{
			processors[num].OnAfterDeserialize(storageType, instance);
		}
		if (instance is ISerializationCallbackReceiver && !(instance is UnityEngine.Object))
		{
			((ISerializationCallbackReceiver)instance).OnAfterDeserialize();
		}
	}

	private static void EnsureDictionary(fsData data)
	{
		if (!data.IsDictionary)
		{
			fsData value = data.Clone();
			data.BecomeDictionary();
			data.AsDictionary["$content"] = value;
		}
	}

	public fsSerializer()
	{
		_cachedConverterTypeInstances = new Dictionary<Type, fsBaseConverter>();
		_cachedConverters = new Dictionary<Type, fsBaseConverter>();
		_cachedProcessors = new Dictionary<Type, List<fsObjectProcessor>>();
		_references = new fsCyclicReferenceManager();
		_lazyReferenceWriter = new fsLazyCycleDefinitionWriter();
		_availableConverters = new List<fsConverter>
		{
			new fsNullableConverter
			{
				Serializer = this
			},
			new fsGuidConverter
			{
				Serializer = this
			},
			new fsTypeConverter
			{
				Serializer = this
			},
			new fsDateConverter
			{
				Serializer = this
			},
			new fsEnumConverter
			{
				Serializer = this
			},
			new fsPrimitiveConverter
			{
				Serializer = this
			},
			new fsArrayConverter
			{
				Serializer = this
			},
			new fsDictionaryConverter
			{
				Serializer = this
			},
			new fsIEnumerableConverter
			{
				Serializer = this
			},
			new fsKeyValuePairConverter
			{
				Serializer = this
			},
			new fsWeakReferenceConverter
			{
				Serializer = this
			},
			new fsReflectedConverter
			{
				Serializer = this
			}
		};
		_availableDirectConverters = new Dictionary<Type, fsDirectConverter>();
		_processors = new List<fsObjectProcessor>();
		Context = new fsContext();
		Config = new fsConfig();
		foreach (Type converter in fsConverterRegistrar.Converters)
		{
			AddConverter((fsBaseConverter)Activator.CreateInstance(converter));
		}
	}

	public void AddProcessor(fsObjectProcessor processor)
	{
		_processors.Add(processor);
		_cachedProcessors = new Dictionary<Type, List<fsObjectProcessor>>();
	}

	public void RemoveProcessor<TProcessor>()
	{
		int num = 0;
		while (num < _processors.Count)
		{
			if (_processors[num] is TProcessor)
			{
				_processors.RemoveAt(num);
			}
			else
			{
				num++;
			}
		}
		_cachedProcessors = new Dictionary<Type, List<fsObjectProcessor>>();
	}

	private List<fsObjectProcessor> GetProcessors(Type type)
	{
		if (_cachedProcessors.TryGetValue(type, out var value))
		{
			return value;
		}
		fsObjectAttribute attribute = fsPortableReflection.GetAttribute<fsObjectAttribute>(type);
		if (attribute != null && attribute.Processor != null)
		{
			fsObjectProcessor item = (fsObjectProcessor)Activator.CreateInstance(attribute.Processor);
			value = new List<fsObjectProcessor>();
			value.Add(item);
			_cachedProcessors[type] = value;
		}
		else if (!_cachedProcessors.TryGetValue(type, out value))
		{
			value = new List<fsObjectProcessor>();
			for (int i = 0; i < _processors.Count; i++)
			{
				fsObjectProcessor fsObjectProcessor2 = _processors[i];
				if (fsObjectProcessor2.CanProcess(type))
				{
					value.Add(fsObjectProcessor2);
				}
			}
			_cachedProcessors[type] = value;
		}
		return value;
	}

	public void AddConverter(fsBaseConverter converter)
	{
		if (converter.Serializer != null)
		{
			throw new InvalidOperationException("Cannot add a single converter instance to multiple fsConverters -- please construct a new instance for " + converter);
		}
		if (converter is fsDirectConverter)
		{
			fsDirectConverter fsDirectConverter2 = (fsDirectConverter)converter;
			_availableDirectConverters[fsDirectConverter2.ModelType] = fsDirectConverter2;
		}
		else
		{
			if (!(converter is fsConverter))
			{
				throw new InvalidOperationException("Unable to add converter " + converter?.ToString() + "; the type association strategy is unknown. Please use either fsDirectConverter or fsConverter as your base type.");
			}
			_availableConverters.Insert(0, (fsConverter)converter);
		}
		converter.Serializer = this;
		_cachedConverters = new Dictionary<Type, fsBaseConverter>();
	}

	private fsBaseConverter GetConverter(Type type, Type overrideConverterType)
	{
		if (overrideConverterType != null)
		{
			if (!_cachedConverterTypeInstances.TryGetValue(overrideConverterType, out var value))
			{
				value = (fsBaseConverter)Activator.CreateInstance(overrideConverterType);
				value.Serializer = this;
				_cachedConverterTypeInstances[overrideConverterType] = value;
			}
			return value;
		}
		if (_cachedConverters.TryGetValue(type, out var value2))
		{
			return value2;
		}
		fsObjectAttribute attribute = fsPortableReflection.GetAttribute<fsObjectAttribute>(type);
		if (attribute != null && attribute.Converter != null)
		{
			value2 = (fsBaseConverter)Activator.CreateInstance(attribute.Converter);
			value2.Serializer = this;
			return _cachedConverters[type] = value2;
		}
		fsForwardAttribute attribute2 = fsPortableReflection.GetAttribute<fsForwardAttribute>(type);
		if (attribute2 != null)
		{
			value2 = new fsForwardConverter(attribute2);
			value2.Serializer = this;
			return _cachedConverters[type] = value2;
		}
		if (!_cachedConverters.TryGetValue(type, out value2))
		{
			if (_availableDirectConverters.ContainsKey(type))
			{
				value2 = _availableDirectConverters[type];
				return _cachedConverters[type] = value2;
			}
			for (int i = 0; i < _availableConverters.Count; i++)
			{
				if (_availableConverters[i].CanProcess(type))
				{
					value2 = _availableConverters[i];
					return _cachedConverters[type] = value2;
				}
			}
		}
		throw new InvalidOperationException("Internal error -- could not find a converter for " + type);
	}

	public fsResult TrySerialize<T>(T instance, out fsData data)
	{
		return TrySerialize(typeof(T), instance, out data);
	}

	public fsResult TryDeserialize<T>(fsData data, ref T instance)
	{
		object result = instance;
		fsResult result2 = TryDeserialize(data, typeof(T), ref result);
		if (result2.Succeeded)
		{
			instance = (T)result;
		}
		return result2;
	}

	public fsResult TrySerialize(Type storageType, object instance, out fsData data)
	{
		return TrySerialize(storageType, null, instance, out data);
	}

	public fsResult TrySerialize(Type storageType, Type overrideConverterType, object instance, out fsData data)
	{
		List<fsObjectProcessor> processors = GetProcessors((instance == null) ? storageType : instance.GetType());
		Invoke_OnBeforeSerialize(processors, storageType, instance);
		if (instance == null)
		{
			data = new fsData();
			Invoke_OnAfterSerialize(processors, storageType, instance, ref data);
			return fsResult.Success;
		}
		fsResult result = InternalSerialize_1_ProcessCycles(storageType, overrideConverterType, instance, out data);
		Invoke_OnAfterSerialize(processors, storageType, instance, ref data);
		return result;
	}

	private fsResult InternalSerialize_1_ProcessCycles(Type storageType, Type overrideConverterType, object instance, out fsData data)
	{
		try
		{
			_references.Enter();
			if (!GetConverter(instance.GetType(), overrideConverterType).RequestCycleSupport(instance.GetType()))
			{
				return InternalSerialize_2_Inheritance(storageType, overrideConverterType, instance, out data);
			}
			if (_references.IsReference(instance))
			{
				data = fsData.CreateDictionary();
				_lazyReferenceWriter.WriteReference(_references.GetReferenceId(instance), data.AsDictionary);
				return fsResult.Success;
			}
			_references.MarkSerialized(instance);
			fsResult result = InternalSerialize_2_Inheritance(storageType, overrideConverterType, instance, out data);
			if (result.Failed)
			{
				return result;
			}
			_lazyReferenceWriter.WriteDefinition(_references.GetReferenceId(instance), data);
			return result;
		}
		finally
		{
			if (_references.Exit())
			{
				_lazyReferenceWriter.Clear();
			}
		}
	}

	private fsResult InternalSerialize_2_Inheritance(Type storageType, Type overrideConverterType, object instance, out fsData data)
	{
		fsResult result = InternalSerialize_4_Converter(overrideConverterType, instance, out data);
		if (result.Failed)
		{
			return result;
		}
		if (storageType != instance.GetType() && GetConverter(storageType, overrideConverterType).RequestInheritanceSupport(storageType))
		{
			EnsureDictionary(data);
			data.AsDictionary["$type"] = new fsData(instance.GetType().FullName);
		}
		return result;
	}

	private fsResult InternalSerialize_4_Converter(Type overrideConverterType, object instance, out fsData data)
	{
		Type type = instance.GetType();
		return GetConverter(type, overrideConverterType).TrySerialize(instance, out data, type);
	}

	public fsResult TryDeserialize(fsData data, Type storageType, ref object result)
	{
		return TryDeserialize(data, storageType, null, ref result);
	}

	public fsResult TryDeserialize(fsData data, Type storageType, Type overrideConverterType, ref object result)
	{
		if (data.IsNull)
		{
			result = null;
			List<fsObjectProcessor> processors = GetProcessors(storageType);
			Invoke_OnBeforeDeserialize(processors, storageType, ref data);
			Invoke_OnAfterDeserialize(processors, storageType, null);
			return fsResult.Success;
		}
		try
		{
			_references.Enter();
			fsResult result2 = InternalDeserialize_1_CycleReference(overrideConverterType, data, storageType, ref result, out var processors2);
			if (result2.Succeeded)
			{
				Invoke_OnAfterDeserialize(processors2, storageType, result);
			}
			return result2;
		}
		catch (Exception ex)
		{
			ParadoxNotion.Services.Logger.LogException(ex, "Deserialization", result);
			return fsResult.Fail(ex.Message);
		}
		finally
		{
			_references.Exit();
		}
	}

	private fsResult InternalDeserialize_1_CycleReference(Type overrideConverterType, fsData data, Type storageType, ref object result, out List<fsObjectProcessor> processors)
	{
		if (IsObjectReference(data))
		{
			int id = int.Parse(data.AsDictionary["$ref"].AsString);
			result = _references.GetReferenceObject(id);
			processors = GetProcessors(result.GetType());
			return fsResult.Success;
		}
		return InternalDeserialize_3_Inheritance(overrideConverterType, data, storageType, ref result, out processors);
	}

	private fsResult InternalDeserialize_3_Inheritance(Type overrideConverterType, fsData data, Type storageType, ref object result, out List<fsObjectProcessor> processors)
	{
		fsResult success = fsResult.Success;
		processors = GetProcessors(storageType);
		Invoke_OnBeforeDeserialize(processors, storageType, ref data);
		Type type = storageType;
		if (IsTypeSpecified(data))
		{
			fsData fsData2 = data.AsDictionary["$type"];
			if (!fsData2.IsString)
			{
				success.AddMessage("$type value must be a string (in " + data?.ToString() + ")");
			}
			else
			{
				string asString = fsData2.AsString;
				Type type2 = fsTypeCache.GetType(asString, storageType);
				if (type2 == null)
				{
					success.AddMessage("Unable to locate specified type \"" + asString + "\"");
				}
				else if (!storageType.IsAssignableFrom(type2))
				{
					success.AddMessage("Ignoring type specifier; a field/property of type " + storageType?.ToString() + " cannot hold an instance of " + type2);
				}
				else
				{
					type = type2;
				}
			}
		}
		if (result == null || result.GetType() != type)
		{
			result = GetConverter(type, overrideConverterType).CreateInstance(data, type);
		}
		Invoke_OnBeforeDeserializeAfterInstanceCreation(processors, storageType, result, ref data);
		return success += InternalDeserialize_4_Cycles(overrideConverterType, data, type, ref result);
	}

	private fsResult InternalDeserialize_4_Cycles(Type overrideConverterType, fsData data, Type resultType, ref object result)
	{
		if (IsObjectDefinition(data))
		{
			int id = int.Parse(data.AsDictionary["$id"].AsString);
			_references.AddReferenceWithId(id, result);
		}
		return InternalDeserialize_5_Converter(overrideConverterType, data, resultType, ref result);
	}

	private fsResult InternalDeserialize_5_Converter(Type overrideConverterType, fsData data, Type resultType, ref object result)
	{
		if (IsWrappedData(data))
		{
			data = data.AsDictionary["$content"];
		}
		return GetConverter(resultType, overrideConverterType).TryDeserialize(data, ref result, resultType);
	}
}
