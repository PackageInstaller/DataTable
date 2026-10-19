using System;
using System.Collections.Generic;
using Unity.VisualScripting.FullSerializer.Internal;
using UnityEngine;

namespace Unity.VisualScripting.FullSerializer;

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
				data.AsDictionary[Key_ObjectDefinition] = new fsData(id.ToString());
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
				fsData fsData2 = _pendingDefinitions[id];
				EnsureDictionary(fsData2);
				fsData2.AsDictionary[Key_ObjectDefinition] = new fsData(id.ToString());
				_pendingDefinitions.Remove(id);
			}
			else
			{
				_references.Add(id);
			}
			dict[Key_ObjectReference] = new fsData(id.ToString());
		}

		public void Clear()
		{
			_pendingDefinitions.Clear();
			_references.Clear();
		}
	}

	private readonly List<fsConverter> _availableConverters;

	private readonly Dictionary<Type, fsDirectConverter> _availableDirectConverters;

	private readonly List<fsObjectProcessor> _processors;

	private readonly fsCyclicReferenceManager _references;

	private readonly fsLazyCycleDefinitionWriter _lazyReferenceWriter;

	private readonly Dictionary<Type, Type> _abstractTypeRemap;

	private Dictionary<Type, fsBaseConverter> _cachedConverterTypeInstances;

	private Dictionary<Type, fsBaseConverter> _cachedConverters;

	private Dictionary<Type, List<fsObjectProcessor>> _cachedProcessors;

	public fsContext Context;

	public fsConfig Config;

	private static HashSet<string> _reservedKeywords;

	private static readonly string Key_ObjectReference;

	private static readonly string Key_ObjectDefinition;

	private static readonly string Key_InstanceType;

	private static readonly string Key_Version;

	private static readonly string Key_Content;

	internal static readonly string Key_UnitDefault;

	internal static readonly string Key_UnitPosition;

	internal static readonly string Key_UnitGuid;

	internal static readonly string Key_UnitFormerType;

	internal static readonly string Key_UnitFormerValue;

	internal static readonly string TypeName_Unit;

	private static readonly Type Type_Unit;

	internal static readonly string TypeName_MissingType;

	private static readonly Type Type_MissingType;

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
		_processors = new List<fsObjectProcessor>
		{
			new fsSerializationCallbackProcessor()
		};
		_processors.Add(new fsSerializationCallbackReceiverProcessor());
		_abstractTypeRemap = new Dictionary<Type, Type>();
		SetDefaultStorageType(typeof(ICollection<>), typeof(List<>));
		SetDefaultStorageType(typeof(IList<>), typeof(List<>));
		SetDefaultStorageType(typeof(IDictionary<, >), typeof(Dictionary<, >));
		Context = new fsContext();
		Config = new fsConfig();
		foreach (Type converter in fsConverterRegistrar.Converters)
		{
			AddConverter((fsBaseConverter)Activator.CreateInstance(converter));
		}
	}

	private void RemapAbstractStorageTypeToDefaultType(ref Type storageType)
	{
		if (!storageType.Resolve().IsInterface && !storageType.Resolve().IsAbstract)
		{
			return;
		}
		Type value2;
		if (storageType.Resolve().IsGenericType)
		{
			if (_abstractTypeRemap.TryGetValue(storageType.Resolve().GetGenericTypeDefinition(), out var value))
			{
				Type[] genericArguments = storageType.GetGenericArguments();
				storageType = value.Resolve().MakeGenericType(genericArguments);
			}
		}
		else if (_abstractTypeRemap.TryGetValue(storageType, out value2))
		{
			storageType = value2;
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

	public void SetDefaultStorageType(Type abstractType, Type defaultStorageType)
	{
		if (!abstractType.Resolve().IsInterface && !abstractType.Resolve().IsAbstract)
		{
			throw new ArgumentException("|abstractType| must be an interface or abstract type");
		}
		_abstractTypeRemap[abstractType] = defaultStorageType;
	}

	private List<fsObjectProcessor> GetProcessors(Type type)
	{
		fsObjectAttribute attribute = fsPortableReflection.GetAttribute<fsObjectAttribute>(type);
		List<fsObjectProcessor> value;
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
		try
		{
			Invoke_OnBeforeSerialize(processors, storageType, instance);
		}
		catch (Exception ex)
		{
			data = new fsData();
			return fsResult.Fail(ex.ToString());
		}
		if (instance == null)
		{
			data = new fsData();
			Invoke_OnAfterSerialize(processors, storageType, instance, ref data);
			return fsResult.Success;
		}
		fsResult result = InternalSerialize_1_ProcessCycles(storageType, overrideConverterType, instance, out data);
		try
		{
			Invoke_OnAfterSerialize(processors, storageType, instance, ref data);
		}
		catch (Exception ex2)
		{
			result += fsResult.Fail(ex2.ToString());
		}
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
		fsResult result = InternalSerialize_3_ProcessVersioning(overrideConverterType, instance, out data);
		if (result.Failed)
		{
			return result;
		}
		if (storageType != instance.GetType() && GetConverter(storageType, overrideConverterType).RequestInheritanceSupport(storageType))
		{
			Type type = instance.GetType();
			if (instance is UnityEngine.Object)
			{
				Type type2 = type;
				do
				{
					type = type2;
					type2 = type2.BaseType;
				}
				while (type2 != null && type != typeof(UnityEngine.Object) && storageType.IsAssignableFrom(type2));
			}
			EnsureDictionary(data);
			data.AsDictionary[Key_InstanceType] = new fsData(RuntimeCodebase.SerializeType(type));
		}
		return result;
	}

	private fsResult InternalSerialize_3_ProcessVersioning(Type overrideConverterType, object instance, out fsData data)
	{
		fsOption<fsVersionedType> versionedType = fsVersionManager.GetVersionedType(instance.GetType());
		if (versionedType.HasValue)
		{
			fsVersionedType value = versionedType.Value;
			fsResult result = InternalSerialize_4_Converter(overrideConverterType, instance, out data);
			if (result.Failed)
			{
				return result;
			}
			EnsureDictionary(data);
			data.AsDictionary[Key_Version] = new fsData(value.VersionString);
			return result;
		}
		return InternalSerialize_4_Converter(overrideConverterType, instance, out data);
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
		ConvertLegacyData(ref data);
		try
		{
			_references.Enter();
			fsResult result2 = InternalDeserialize_1_CycleReference(overrideConverterType, data, storageType, ref result, out var processors2);
			if (result2.Succeeded)
			{
				try
				{
					Invoke_OnAfterDeserialize(processors2, storageType, result);
				}
				catch (Exception ex)
				{
					result2 += fsResult.Fail(ex.ToString());
				}
			}
			return result2;
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
			int id = int.Parse(data.AsDictionary[Key_ObjectReference].AsString);
			result = _references.GetReferenceObject(id);
			processors = GetProcessors(result.GetType());
			return fsResult.Success;
		}
		return InternalDeserialize_2_Version(overrideConverterType, data, storageType, ref result, out processors);
	}

	private fsResult InternalDeserialize_2_Version(Type overrideConverterType, fsData data, Type storageType, ref object result, out List<fsObjectProcessor> processors)
	{
		if (IsVersioned(data))
		{
			string asString = data.AsDictionary[Key_Version].AsString;
			fsOption<fsVersionedType> versionedType = fsVersionManager.GetVersionedType(storageType);
			if (versionedType.HasValue && versionedType.Value.VersionString != asString)
			{
				fsResult success = fsResult.Success;
				success += fsVersionManager.GetVersionImportPath(asString, versionedType.Value, out var path);
				if (success.Failed)
				{
					processors = GetProcessors(storageType);
					return success;
				}
				success += InternalDeserialize_3_Inheritance(overrideConverterType, data, path[0].ModelType, ref result, out processors);
				if (success.Failed)
				{
					return success;
				}
				for (int i = 1; i < path.Count; i++)
				{
					result = path[i].Migrate(result);
				}
				if (IsObjectDefinition(data))
				{
					int id = int.Parse(data.AsDictionary[Key_ObjectDefinition].AsString);
					_references.AddReferenceWithId(id, result);
				}
				processors = GetProcessors(success.GetType());
				return success;
			}
		}
		return InternalDeserialize_3_Inheritance(overrideConverterType, data, storageType, ref result, out processors);
	}

	private fsResult InternalDeserialize_3_Inheritance(Type overrideConverterType, fsData data, Type storageType, ref object result, out List<fsObjectProcessor> processors)
	{
		fsResult deserializeResult = fsResult.Success;
		Type storageType2 = storageType;
		if (IsTypeSpecified(data))
		{
			storageType2 = GetDataType(ref data, storageType, ref deserializeResult);
		}
		RemapAbstractStorageTypeToDefaultType(ref storageType2);
		processors = GetProcessors(storageType2);
		if (deserializeResult.Failed)
		{
			return deserializeResult;
		}
		try
		{
			Invoke_OnBeforeDeserialize(processors, storageType, ref data);
		}
		catch (Exception ex)
		{
			return deserializeResult + fsResult.Fail(ex.ToString());
		}
		if (result == null || result.GetType() != storageType2)
		{
			result = GetConverter(storageType2, overrideConverterType).CreateInstance(data, storageType2);
		}
		try
		{
			Invoke_OnBeforeDeserializeAfterInstanceCreation(processors, storageType, result, ref data);
		}
		catch (Exception ex2)
		{
			return deserializeResult + fsResult.Fail(ex2.ToString());
		}
		return deserializeResult + InternalDeserialize_4_Cycles(overrideConverterType, data, storageType2, ref result);
	}

	private fsResult InternalDeserialize_4_Cycles(Type overrideConverterType, fsData data, Type resultType, ref object result)
	{
		if (IsObjectDefinition(data))
		{
			int id = int.Parse(data.AsDictionary[Key_ObjectDefinition].AsString);
			_references.AddReferenceWithId(id, result);
		}
		return InternalDeserialize_5_Converter(overrideConverterType, data, resultType, ref result);
	}

	private fsResult InternalDeserialize_5_Converter(Type overrideConverterType, fsData data, Type resultType, ref object result)
	{
		if (IsWrappedData(data))
		{
			data = data.AsDictionary[Key_Content];
		}
		return GetConverter(resultType, overrideConverterType).TryDeserialize(data, ref result, resultType);
	}

	private static Type GetDataType(ref fsData data, Type defaultType, ref fsResult deserializeResult)
	{
		Dictionary<string, fsData> asDictionary = data.AsDictionary;
		fsData fsData2 = asDictionary[Key_InstanceType];
		if (!fsData2.IsString)
		{
			deserializeResult.AddMessage(Key_InstanceType + " value must be a string (in " + data?.ToString() + ")");
			return defaultType;
		}
		string asString = fsData2.AsString;
		if (!RuntimeCodebase.TryDeserializeType(asString, out var type))
		{
			if (IsVisualScriptingUnit(data))
			{
				asDictionary[Key_UnitFormerValue] = new fsData(data.ToString());
				asDictionary[Key_UnitFormerType] = fsData2;
				asDictionary[Key_InstanceType] = new fsData(TypeName_MissingType);
				deserializeResult += fsResult.Warn("Type definition for '" + asString + "' is missing.\nConverted '" + asString + "' unit to '" + TypeName_MissingType + "'. Did you delete the type's script file?");
				return Type_MissingType;
			}
			deserializeResult += fsResult.Warn("Unable to find type: \"" + asString + "\"");
			return defaultType;
		}
		if (asString == TypeName_MissingType)
		{
			if (asDictionary.ContainsKey(Key_UnitFormerType) && IsVisualScriptingUnit(data))
			{
				string asString2 = asDictionary[Key_UnitFormerType].AsString;
				if (RuntimeCodebase.TryDeserializeType(asString2, out var type2))
				{
					if (defaultType.IsAssignableFrom(type2))
					{
						if (asDictionary.ContainsKey(Key_UnitFormerValue))
						{
							fsData value = asDictionary[Key_UnitPosition];
							data = fsJsonParser.Parse(asDictionary[Key_UnitFormerValue].AsString);
							asDictionary = data.AsDictionary;
							asDictionary[Key_UnitPosition] = value;
							deserializeResult += fsResult.Warn("Missing unit type '" + asString2 + "' was found.\nConverted '" + TypeName_MissingType + "' unit back to '" + asString2 + "'");
						}
						else
						{
							asDictionary[Key_InstanceType] = new fsData(asString2);
							deserializeResult += fsResult.Warn("Missing unit type '" + asString2 + "' was found.\nConverted '" + TypeName_MissingType + "' unit back to '" + asString2 + "'\nNo former state can be found. Reverting node to defaults.\n" + data);
						}
						return type2;
					}
					deserializeResult += fsResult.Warn("Missing unit type '" + asString2 + "' was found, but is not assignable to '" + defaultType.FullName + "'. Did you forget to inherit from '" + TypeName_Unit + "'?");
				}
				else
				{
					deserializeResult += fsResult.Warn("Type definition for '" + asString2 + "' unit is missing. Did you remove its script file?");
				}
			}
			else
			{
				deserializeResult += fsResult.Warn("Serialized '" + TypeName_MissingType + "' unit has an unrecognized format.");
			}
		}
		if (!defaultType.IsAssignableFrom(type))
		{
			if (IsVisualScriptingUnit(data))
			{
				asDictionary[Key_UnitFormerType] = fsData2;
				asDictionary[Key_InstanceType] = new fsData(TypeName_MissingType);
				deserializeResult += fsResult.Warn("Type '" + asString + "' is no longer assignable to '" + defaultType.FullName + "'. Did you remove inheritance from '" + TypeName_Unit + "'?\nConverted '" + asString + "' unit to '" + TypeName_MissingType + "'.");
				return Type_MissingType;
			}
			deserializeResult.AddMessage("Ignoring type specifier; a field/property of type " + defaultType?.ToString() + " cannot hold an instance of " + type);
			return defaultType;
		}
		return type;
	}

	private static void EnsureDictionary(fsData data)
	{
		if (!data.IsDictionary)
		{
			fsData value = data.Clone();
			data.BecomeDictionary();
			data.AsDictionary[Key_Content] = value;
		}
	}

	static fsSerializer()
	{
		Key_ObjectReference = fsGlobalConfig.InternalFieldPrefix + "ref";
		Key_ObjectDefinition = fsGlobalConfig.InternalFieldPrefix + "id";
		Key_InstanceType = fsGlobalConfig.InternalFieldPrefix + "type";
		Key_Version = fsGlobalConfig.InternalFieldPrefix + "version";
		Key_Content = fsGlobalConfig.InternalFieldPrefix + "content";
		Key_UnitDefault = "defaultValues";
		Key_UnitPosition = "position";
		Key_UnitGuid = "guid";
		Key_UnitFormerType = "formerType";
		Key_UnitFormerValue = "formerValue";
		TypeName_Unit = "Unity.VisualScripting.Unit";
		Type_Unit = RuntimeCodebase.DeserializeType(TypeName_Unit);
		TypeName_MissingType = "Unity.VisualScripting.MissingType";
		Type_MissingType = RuntimeCodebase.DeserializeType(TypeName_MissingType);
		_reservedKeywords = new HashSet<string> { Key_ObjectReference, Key_ObjectDefinition, Key_InstanceType, Key_Version, Key_Content };
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
		return data.AsDictionary.ContainsKey(Key_ObjectReference);
	}

	private static bool IsObjectDefinition(fsData data)
	{
		if (!data.IsDictionary)
		{
			return false;
		}
		return data.AsDictionary.ContainsKey(Key_ObjectDefinition);
	}

	private static bool IsVersioned(fsData data)
	{
		if (!data.IsDictionary)
		{
			return false;
		}
		return data.AsDictionary.ContainsKey(Key_Version);
	}

	private static bool IsTypeSpecified(fsData data)
	{
		if (!data.IsDictionary)
		{
			return false;
		}
		return data.AsDictionary.ContainsKey(Key_InstanceType);
	}

	private static bool IsWrappedData(fsData data)
	{
		if (!data.IsDictionary)
		{
			return false;
		}
		return data.AsDictionary.ContainsKey(Key_Content);
	}

	private static bool IsVisualScriptingUnit(fsData data)
	{
		if (!data.IsDictionary)
		{
			return false;
		}
		Dictionary<string, fsData> asDictionary = data.AsDictionary;
		if (asDictionary.ContainsKey(Key_UnitDefault) && asDictionary.ContainsKey(Key_UnitPosition) && asDictionary.ContainsKey(Key_UnitGuid) && asDictionary[Key_UnitPosition].AsDictionary.ContainsKey("x"))
		{
			return asDictionary[Key_UnitPosition].AsDictionary.ContainsKey("y");
		}
		return false;
	}

	public static void StripDeserializationMetadata(ref fsData data)
	{
		if (data.IsDictionary && data.AsDictionary.ContainsKey(Key_Content))
		{
			data = data.AsDictionary[Key_Content];
		}
		if (data.IsDictionary)
		{
			Dictionary<string, fsData> asDictionary = data.AsDictionary;
			asDictionary.Remove(Key_ObjectReference);
			asDictionary.Remove(Key_ObjectDefinition);
			asDictionary.Remove(Key_InstanceType);
			asDictionary.Remove(Key_Version);
		}
	}

	private static void ConvertLegacyData(ref fsData data)
	{
		if (!data.IsDictionary)
		{
			return;
		}
		Dictionary<string, fsData> asDictionary = data.AsDictionary;
		if (asDictionary.Count <= 2)
		{
			string key = "ReferenceId";
			string key2 = "SourceId";
			string key3 = "Data";
			string key4 = "Type";
			string key5 = "Data";
			if (asDictionary.Count == 2 && asDictionary.ContainsKey(key4) && asDictionary.ContainsKey(key5))
			{
				data = asDictionary[key5];
				EnsureDictionary(data);
				ConvertLegacyData(ref data);
				data.AsDictionary[Key_InstanceType] = asDictionary[key4];
			}
			else if (asDictionary.Count == 2 && asDictionary.ContainsKey(key2) && asDictionary.ContainsKey(key3))
			{
				data = asDictionary[key3];
				EnsureDictionary(data);
				ConvertLegacyData(ref data);
				data.AsDictionary[Key_ObjectDefinition] = asDictionary[key2];
			}
			else if (asDictionary.Count == 1 && asDictionary.ContainsKey(key))
			{
				data = fsData.CreateDictionary();
				data.AsDictionary[Key_ObjectReference] = asDictionary[key];
			}
		}
	}

	private static void Invoke_OnBeforeSerialize(List<fsObjectProcessor> processors, Type storageType, object instance)
	{
		for (int i = 0; i < processors.Count; i++)
		{
			processors[i].OnBeforeSerialize(storageType, instance);
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
	}
}
