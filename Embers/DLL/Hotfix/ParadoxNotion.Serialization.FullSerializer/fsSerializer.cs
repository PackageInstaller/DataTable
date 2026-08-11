using System;
using System.Collections.Generic;
using System.Linq;
using System.Reflection;
using ParadoxNotion.Serialization.FullSerializer.Internal;
using ParadoxNotion.Serialization.FullSerializer.Internal.DirectConverters;
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
				EnsureDictionary(ref data);
				data.AsDictionary["$id"] = new fsData(id.ToString());
			}
			else
			{
				_pendingDefinitions[id] = data;
			}
		}

		public void WriteReference(int id, Dictionary<string, fsData> dict)
		{
			if (_pendingDefinitions.TryGetValue(id, out var value))
			{
				EnsureDictionary(ref value);
				value.AsDictionary["$id"] = new fsData(id.ToString());
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

	public const string KEY_OBJECT_REFERENCE = "$ref";

	public const string KEY_OBJECT_DEFINITION = "$id";

	public const string KEY_INSTANCE_TYPE = "$type";

	public const string KEY_VERSION = "$version";

	public const string KEY_CONTENT = "$content";

	private Dictionary<Type, fsBaseConverter> _cachedOverrideConverterInstances;

	private Dictionary<Type, fsBaseConverter> _cachedConverters;

	private readonly List<fsConverter> _availableConverters;

	private readonly Dictionary<Type, fsDirectConverter> _availableDirectConverters;

	private readonly List<fsObjectProcessor> _processors;

	private Dictionary<Type, List<fsObjectProcessor>> _cachedProcessors;

	private fsCyclicReferenceManager _references;

	private fsLazyCycleDefinitionWriter _lazyReferenceWriter;

	private Stack<ISerializationCollector> _collectors;

	private int _collectableDepth;

	public List<UnityEngine.Object> ReferencesDatabase { get; set; }

	public bool IgnoreSerializeCycleReferences { get; set; }

	public event Action<object> onBeforeObjectSerialized;

	public event Action<object, fsData> onAfterObjectSerialized;

	public static bool IsReservedKeyword(string key)
	{
		return key switch
		{
			"$ref" => true, 
			"$id" => true, 
			"$type" => true, 
			"$version" => true, 
			"$content" => true, 
			_ => false, 
		};
	}

	public static void RemoveMetaData(ref fsData data)
	{
		if (data.IsDictionary)
		{
			data.AsDictionary.Remove("$ref");
			data.AsDictionary.Remove("$id");
			data.AsDictionary.Remove("$type");
			data.AsDictionary.Remove("$version");
			data.AsDictionary.Remove("$content");
		}
	}

	private static void EnsureDictionary(ref fsData data)
	{
		if (!data.IsDictionary)
		{
			fsData value = data.Clone();
			data.BecomeDictionary();
			data.AsDictionary["$content"] = value;
		}
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

	public fsSerializer()
	{
		_cachedOverrideConverterInstances = new Dictionary<Type, fsBaseConverter>();
		_cachedConverters = new Dictionary<Type, fsBaseConverter>();
		_cachedProcessors = new Dictionary<Type, List<fsObjectProcessor>>();
		_references = new fsCyclicReferenceManager();
		_lazyReferenceWriter = new fsLazyCycleDefinitionWriter();
		_collectors = new Stack<ISerializationCollector>();
		_availableConverters = new List<fsConverter>
		{
			new fsUnityObjectConverter
			{
				Serializer = this
			},
			new fsTypeConverter
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
			new fsListConverter
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
		AddConverter(new AnimationCurve_DirectConverter());
		AddConverter(new Bounds_DirectConverter());
		AddConverter(new GUIStyleState_DirectConverter());
		AddConverter(new GUIStyle_DirectConverter());
		AddConverter(new Gradient_DirectConverter());
		AddConverter(new Keyframe_DirectConverter());
		AddConverter(new LayerMask_DirectConverter());
		AddConverter(new RectOffset_DirectConverter());
		AddConverter(new Rect_DirectConverter());
		AddConverter(new Vector2Int_DirectConverter());
		AddConverter(new Vector3Int_DirectConverter());
	}

	public void PurgeTemporaryData()
	{
		_references.Clear();
		_lazyReferenceWriter.Clear();
		_collectors.Clear();
	}

	private List<fsObjectProcessor> GetProcessors(Type type)
	{
		if (_cachedProcessors.TryGetValue(type, out var value))
		{
			return value;
		}
		fsObjectAttribute fsObjectAttribute2 = type.RTGetAttribute<fsObjectAttribute>(inherited: true);
		if (fsObjectAttribute2 != null && fsObjectAttribute2.Processor != null)
		{
			fsObjectProcessor item = (fsObjectProcessor)Activator.CreateInstance(fsObjectAttribute2.Processor);
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
			if (!_cachedOverrideConverterInstances.TryGetValue(overrideConverterType, out var value))
			{
				value = (fsBaseConverter)Activator.CreateInstance(overrideConverterType);
				value.Serializer = this;
				_cachedOverrideConverterInstances[overrideConverterType] = value;
			}
			return value;
		}
		if (_cachedConverters.TryGetValue(type, out var value2))
		{
			return value2;
		}
		fsObjectAttribute fsObjectAttribute2 = type.RTGetAttribute<fsObjectAttribute>(inherited: true);
		if (fsObjectAttribute2 != null && fsObjectAttribute2.Converter != null)
		{
			value2 = (fsBaseConverter)Activator.CreateInstance(fsObjectAttribute2.Converter);
			value2.Serializer = this;
			return _cachedConverters[type] = value2;
		}
		fsForwardAttribute fsForwardAttribute2 = type.RTGetAttribute<fsForwardAttribute>(inherited: true);
		if (fsForwardAttribute2 != null)
		{
			value2 = new fsForwardConverter(fsForwardAttribute2);
			value2.Serializer = this;
			return _cachedConverters[type] = value2;
		}
		if (_availableDirectConverters.TryGetValue(type, out var value3))
		{
			return _cachedConverters[type] = value3;
		}
		for (int i = 0; i < _availableConverters.Count; i++)
		{
			if (_availableConverters[i].CanProcess(type))
			{
				return _cachedConverters[type] = _availableConverters[i];
			}
		}
		return _cachedConverters[type] = null;
	}

	public fsResult TrySerialize(Type storageType, object instance, out fsData data)
	{
		return TrySerialize(storageType, instance, out data, null);
	}

	public fsResult TrySerialize(Type storageType, object instance, out fsData data, Type overrideConverterType)
	{
		Type type = ((instance == null) ? storageType : instance.GetType());
		List<fsObjectProcessor> processors = GetProcessors(type);
		Invoke_OnBeforeSerialize(processors, storageType, instance);
		if (instance == null)
		{
			data = new fsData();
			Invoke_OnAfterSerialize(processors, storageType, instance, ref data);
			return fsResult.Success;
		}
		if (onBeforeObjectSerialized != null)
		{
			onBeforeObjectSerialized(instance);
		}
		fsResult result;
		try
		{
			_references.Enter();
			result = Internal_Serialize(storageType, instance, out data, overrideConverterType);
		}
		finally
		{
			if (_references.Exit())
			{
				_lazyReferenceWriter.Clear();
			}
		}
		TrySerializeVersioning(instance, ref data);
		Invoke_OnAfterSerialize(processors, storageType, instance, ref data);
		if (onAfterObjectSerialized != null)
		{
			onAfterObjectSerialized(instance, data);
		}
		return result;
	}

	private fsResult Internal_Serialize(Type storageType, object instance, out fsData data, Type overrideConverterType)
	{
		Type type = instance.GetType();
		fsBaseConverter converter = GetConverter(type, overrideConverterType);
		if (converter == null)
		{
			data = new fsData();
			return fsResult.Success;
		}
		bool flag = type.RTIsDefined<fsSerializeAsReference>(inherited: true);
		if (flag)
		{
			if (_references.IsReference(instance))
			{
				data = fsData.CreateDictionary();
				_lazyReferenceWriter.WriteReference(_references.GetReferenceId(instance), data.AsDictionary);
				return fsResult.Success;
			}
			_references.MarkSerialized(instance);
		}
		TryPush(instance);
		fsResult result = converter.TrySerialize(instance, out data, type);
		TryPop(instance);
		if (result.Failed)
		{
			return result;
		}
		if (storageType != type && GetConverter(storageType, overrideConverterType).RequestInheritanceSupport(storageType))
		{
			EnsureDictionary(ref data);
			data.AsDictionary["$type"] = new fsData(type.FullName);
		}
		if (flag)
		{
			_lazyReferenceWriter.WriteDefinition(_references.GetReferenceId(instance), data);
		}
		return result;
	}

	public fsResult TryDeserialize(fsData data, Type storageType, ref object result)
	{
		return TryDeserialize(data, storageType, ref result, null);
	}

	public fsResult TryDeserialize(fsData data, Type storageType, ref object result, Type overrideConverterType)
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
			return Internal_Deserialize(data, storageType, ref result, overrideConverterType);
		}
		finally
		{
			_references.Exit();
		}
	}

	private fsResult Internal_Deserialize(fsData data, Type storageType, ref object result, Type overrideConverterType)
	{
		if (IsObjectReference(data))
		{
			int id = int.Parse(data.AsDictionary["$ref"].AsString);
			result = _references.GetReferenceObject(id);
			return fsResult.Success;
		}
		fsResult success = fsResult.Success;
		Type type = ((result != null) ? result.GetType() : storageType);
		Type type2 = null;
		List<fsObjectProcessor> processors = GetProcessors(type);
		Invoke_OnBeforeDeserialize(processors, type, ref data);
		if (IsTypeSpecified(data))
		{
			fsData fsData2 = data.AsDictionary["$type"];
			if (!fsData2.IsString)
			{
				success.AddMessage(string.Format("{0} value must be a string", "$type"));
			}
			else
			{
				string asString = fsData2.AsString;
				Type type3 = ReflectionTools.GetType(asString, storageType);
				if (type3 == null)
				{
					success.AddMessage($"{asString} type can not be resolved");
				}
				else
				{
					fsMigrateToAttribute fsMigrateToAttribute2 = type3.RTGetAttribute<fsMigrateToAttribute>(inherited: true);
					if (fsMigrateToAttribute2 != null)
					{
						if (!typeof(IMigratable).IsAssignableFrom(fsMigrateToAttribute2.targetType))
						{
							throw new Exception("TargetType of [fsMigrateToAttribute] must implement IMigratable<T> with T being the target type");
						}
						type2 = type3;
						type3 = ((!type3.IsGenericType || !fsMigrateToAttribute2.targetType.IsGenericTypeDefinition) ? fsMigrateToAttribute2.targetType : fsMigrateToAttribute2.targetType.MakeGenericType(type3.GetGenericArguments()));
					}
					if (!storageType.IsAssignableFrom(type3))
					{
						success.AddMessage($"Ignoring type specifier. Field or type {storageType} can't hold and instance of type {type3}");
						success.AddMessage("storageType : " + storageType.FullName + "  Data : " + data.ToString());
					}
					else
					{
						type = type3;
					}
				}
			}
		}
		fsBaseConverter converter = GetConverter(type, overrideConverterType);
		if (converter == null)
		{
			return fsResult.Warn($"No Converter available for {type}");
		}
		if (result == null || result.GetType() != type)
		{
			result = converter.CreateInstance(data, type);
		}
		if (type2 != null)
		{
			object currentInstance = GetConverter(type2, null).CreateInstance(data, type2);
			TryDeserializeVersioning(ref currentInstance, ref data);
			TryDeserializeMigration(ref result, ref data, type2, currentInstance);
		}
		else
		{
			TryDeserializeVersioning(ref result, ref data);
		}
		Invoke_OnBeforeDeserializeAfterInstanceCreation(processors, type, result, ref data);
		if (IsObjectDefinition(data))
		{
			int id2 = int.Parse(data.AsDictionary["$id"].AsString);
			_references.AddReferenceWithId(id2, result);
		}
		if (IsWrappedData(data))
		{
			data = data.AsDictionary["$content"];
		}
		TryPush(result);
		success += converter.TryDeserialize(data, ref result, type);
		if (success.Succeeded)
		{
			Invoke_OnAfterDeserialize(processors, type, result);
		}
		TryPop(result);
		return success;
	}

	private void TryPush(object o)
	{
		if (o is ISerializationCollectable)
		{
			_collectableDepth++;
			if (_collectors.Count > 0)
			{
				_collectors.Peek().OnCollect((ISerializationCollectable)o, _collectableDepth);
			}
		}
		if (o is ISerializationCollector)
		{
			_collectableDepth = -1;
			ISerializationCollector parent = ((_collectors.Count > 0) ? _collectors.Peek() : null);
			_collectors.Push((ISerializationCollector)o);
			((ISerializationCollector)o).OnPush(parent);
		}
	}

	private void TryPop(object o)
	{
		if (o is ISerializationCollector)
		{
			_collectableDepth = 0;
			_collectors.Pop().OnPop((_collectors.Count > 0) ? _collectors.Peek() : null);
		}
		if (o is ISerializationCollectable)
		{
			_collectableDepth--;
		}
	}

	private void TrySerializeVersioning(object currentInstance, ref fsData data)
	{
		if (currentInstance is IMigratable && data.IsDictionary)
		{
			fsMigrateVersionsAttribute fsMigrateVersionsAttribute2 = currentInstance.GetType().RTGetAttribute<fsMigrateVersionsAttribute>(inherited: true);
			if (fsMigrateVersionsAttribute2 != null && fsMigrateVersionsAttribute2.previousTypes.Length != 0)
			{
				data.AsDictionary["$version"] = new fsData(fsMigrateVersionsAttribute2.previousTypes.Length);
			}
		}
	}

	private void TryDeserializeVersioning(ref object currentInstance, ref fsData currentData)
	{
		if (!(currentInstance is IMigratable) || !currentData.IsDictionary)
		{
			return;
		}
		Type type = currentInstance.GetType();
		int num = 0;
		if (currentData.AsDictionary.TryGetValue("$version", out var value))
		{
			num = (int)value.AsInt64;
		}
		fsMigrateVersionsAttribute fsMigrateVersionsAttribute2 = type.RTGetAttribute<fsMigrateVersionsAttribute>(inherited: true);
		if (fsMigrateVersionsAttribute2 != null)
		{
			Type[] previousTypes = fsMigrateVersionsAttribute2.previousTypes;
			if (previousTypes.Length > num)
			{
				Type previousType = previousTypes[num];
				TryDeserializeMigration(ref currentInstance, ref currentData, previousType, null);
			}
		}
	}

	private void TryDeserializeMigration(ref object currentInstance, ref fsData currentData, Type previousType, object previousInstance)
	{
		if (!(currentInstance is IMigratable) || !currentData.IsDictionary)
		{
			return;
		}
		Type type = currentInstance.GetType();
		if (type.IsGenericType && previousType.IsGenericTypeDefinition)
		{
			previousType = previousType.MakeGenericType(type.GetGenericArguments());
		}
		InterfaceMapping interfaceMap;
		try
		{
			interfaceMap = type.GetInterfaceMap(typeof(IMigratable<>).MakeGenericType(previousType));
		}
		catch (Exception ex)
		{
			throw new Exception("Type must implement IMigratable<T> for each one of the types specified in the [fsMigrateVersionsAttribute] or [fsMigrateToAttribute]\n" + ex.Message);
		}
		MethodInfo methodInfo = interfaceMap.InterfaceMethods.First((MethodInfo m) => m.Name == "Migrate");
		fsBaseConverter converter = GetConverter(previousType, null);
		if (previousInstance == null)
		{
			previousInstance = converter.CreateInstance(currentData, previousType);
		}
		converter.TryDeserialize(currentData, ref previousInstance, previousType).AssertSuccess();
		methodInfo.Invoke(currentInstance, ReflectionTools.SingleTempArgsArray(previousInstance));
		converter.TrySerialize(previousInstance, out var serialized, previousType).AssertSuccess();
		foreach (KeyValuePair<string, fsData> item in serialized.AsDictionary)
		{
			currentData.AsDictionary.Remove(item.Key);
		}
	}
}
