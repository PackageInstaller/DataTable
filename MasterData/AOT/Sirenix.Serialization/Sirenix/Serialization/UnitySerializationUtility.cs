using System;
using System.Collections.Generic;
using System.IO;
using System.Reflection;
using System.Runtime.CompilerServices;
using System.Runtime.Serialization;
using System.Text;
using Sirenix.Serialization.Utilities;
using Sirenix.Utilities;
using UnityEngine;
using UnityEngine.Events;

namespace Sirenix.Serialization;

public static class UnitySerializationUtility
{
	private struct CachedSerializationBackendResult
	{
		public bool HasCalculatedSerializeUnityFieldsTrueResult;

		public bool HasCalculatedSerializeUnityFieldsFalseResult;

		public bool SerializeUnityFieldsTrueResult;

		public bool SerializeUnityFieldsFalseResult;
	}

	public static readonly Type SerializeReferenceAttributeType = typeof(SerializeField).Assembly.GetType("UnityEngine.SerializeReference");

	private static readonly Assembly String_Assembly = typeof(string).Assembly;

	private static readonly Assembly HashSet_Assembly = typeof(HashSet<>).Assembly;

	private static readonly Assembly LinkedList_Assembly = typeof(LinkedList<>).Assembly;

	private static readonly Dictionary<MemberInfo, Sirenix.Serialization.Utilities.WeakValueGetter> UnityMemberGetters = new Dictionary<MemberInfo, Sirenix.Serialization.Utilities.WeakValueGetter>();

	private static readonly Dictionary<MemberInfo, Sirenix.Serialization.Utilities.WeakValueSetter> UnityMemberSetters = new Dictionary<MemberInfo, Sirenix.Serialization.Utilities.WeakValueSetter>();

	private static readonly Dictionary<MemberInfo, bool> UnityWillSerializeMembersCache = new Dictionary<MemberInfo, bool>();

	private static readonly Dictionary<Type, bool> UnityWillSerializeTypesCache = new Dictionary<Type, bool>();

	private static readonly HashSet<Type> UnityNeverSerializesTypes = new HashSet<Type> { typeof(Coroutine) };

	private static readonly HashSet<string> UnityNeverSerializesTypeNames = new HashSet<string> { "UnityEngine.AnimationState" };

	private static readonly ISerializationPolicy UnityPolicy = SerializationPolicies.Unity;

	private static readonly ISerializationPolicy EverythingPolicy = SerializationPolicies.Everything;

	private static readonly ISerializationPolicy StrictPolicy = SerializationPolicies.Strict;

	private static readonly Dictionary<MemberInfo, CachedSerializationBackendResult> OdinWillSerializeCache_UnityPolicy = new Dictionary<MemberInfo, CachedSerializationBackendResult>(Sirenix.Serialization.Utilities.ReferenceEqualityComparer<MemberInfo>.Default);

	private static readonly Dictionary<MemberInfo, CachedSerializationBackendResult> OdinWillSerializeCache_EverythingPolicy = new Dictionary<MemberInfo, CachedSerializationBackendResult>(Sirenix.Serialization.Utilities.ReferenceEqualityComparer<MemberInfo>.Default);

	private static readonly Dictionary<MemberInfo, CachedSerializationBackendResult> OdinWillSerializeCache_StrictPolicy = new Dictionary<MemberInfo, CachedSerializationBackendResult>(Sirenix.Serialization.Utilities.ReferenceEqualityComparer<MemberInfo>.Default);

	private static readonly Dictionary<ISerializationPolicy, Dictionary<MemberInfo, CachedSerializationBackendResult>> OdinWillSerializeCache_CustomPolicies = new Dictionary<ISerializationPolicy, Dictionary<MemberInfo, CachedSerializationBackendResult>>(Sirenix.Serialization.Utilities.ReferenceEqualityComparer<ISerializationPolicy>.Default);

	public static bool OdinWillSerialize(MemberInfo member, bool serializeUnityFields, ISerializationPolicy policy = null)
	{
		Dictionary<MemberInfo, CachedSerializationBackendResult> value;
		if (policy == null || policy == UnityPolicy)
		{
			value = OdinWillSerializeCache_UnityPolicy;
		}
		else if (policy == EverythingPolicy)
		{
			value = OdinWillSerializeCache_EverythingPolicy;
		}
		else if (policy == StrictPolicy)
		{
			value = OdinWillSerializeCache_StrictPolicy;
		}
		else
		{
			lock (OdinWillSerializeCache_CustomPolicies)
			{
				if (!OdinWillSerializeCache_CustomPolicies.TryGetValue(policy, out value))
				{
					value = new Dictionary<MemberInfo, CachedSerializationBackendResult>(Sirenix.Serialization.Utilities.ReferenceEqualityComparer<MemberInfo>.Default);
					OdinWillSerializeCache_CustomPolicies.Add(policy, value);
				}
			}
		}
		lock (value)
		{
			if (!value.TryGetValue(member, out var value2))
			{
				value2 = default;
				if (serializeUnityFields)
				{
					value2.SerializeUnityFieldsTrueResult = CalculateOdinWillSerialize(member, serializeUnityFields, policy ?? UnityPolicy);
					value2.HasCalculatedSerializeUnityFieldsTrueResult = true;
				}
				else
				{
					value2.SerializeUnityFieldsFalseResult = CalculateOdinWillSerialize(member, serializeUnityFields, policy ?? UnityPolicy);
					value2.HasCalculatedSerializeUnityFieldsFalseResult = true;
				}
				value.Add(member, value2);
			}
			else if (serializeUnityFields && !value2.HasCalculatedSerializeUnityFieldsTrueResult)
			{
				value2.SerializeUnityFieldsTrueResult = CalculateOdinWillSerialize(member, serializeUnityFields, policy ?? UnityPolicy);
				value2.HasCalculatedSerializeUnityFieldsTrueResult = true;
				value[member] = value2;
			}
			else if (!serializeUnityFields && !value2.HasCalculatedSerializeUnityFieldsFalseResult)
			{
				value2.SerializeUnityFieldsFalseResult = CalculateOdinWillSerialize(member, serializeUnityFields, policy ?? UnityPolicy);
				value2.HasCalculatedSerializeUnityFieldsFalseResult = true;
				value[member] = value2;
			}
			return serializeUnityFields ? value2.SerializeUnityFieldsTrueResult : value2.SerializeUnityFieldsFalseResult;
		}
	}

	private static bool CalculateOdinWillSerialize(MemberInfo member, bool serializeUnityFields, ISerializationPolicy policy)
	{
		if (member.DeclaringType == typeof(UnityEngine.Object))
		{
			return false;
		}
		if (!policy.ShouldSerializeMember(member))
		{
			return false;
		}
		if (member is FieldInfo && member.IsDefined(typeof(OdinSerializeAttribute), inherit: true))
		{
			return true;
		}
		if (serializeUnityFields)
		{
			return true;
		}
		try
		{
			if (SerializeReferenceAttributeType != null && member.IsDefined(SerializeReferenceAttributeType, inherit: true))
			{
				return false;
			}
		}
		catch
		{
		}
		if (GuessIfUnityWillSerialize(member))
		{
			return false;
		}
		return true;
	}

	public static bool GuessIfUnityWillSerialize(MemberInfo member)
	{
		if (member == null)
		{
			throw new ArgumentNullException("member");
		}
		bool value;
		lock (UnityWillSerializeMembersCache)
		{
			if (!UnityWillSerializeMembersCache.TryGetValue(member, out value))
			{
				value = GuessIfUnityWillSerializePrivate(member);
				UnityWillSerializeMembersCache[member] = value;
			}
		}
		return value;
	}

	private static bool GuessIfUnityWillSerializePrivate(MemberInfo member)
	{
		FieldInfo fieldInfo = member as FieldInfo;
		if (fieldInfo == null || fieldInfo.IsStatic || fieldInfo.IsInitOnly)
		{
			return false;
		}
		if (Sirenix.Serialization.Utilities.MemberInfoExtensions.IsDefined<NonSerializedAttribute>(fieldInfo))
		{
			return false;
		}
		if (SerializeReferenceAttributeType != null && fieldInfo.IsDefined(SerializeReferenceAttributeType, inherit: true))
		{
			return true;
		}
		if (!typeof(UnityEngine.Object).IsAssignableFrom(fieldInfo.FieldType) && fieldInfo.FieldType == fieldInfo.DeclaringType)
		{
			return false;
		}
		if (!fieldInfo.IsPublic && !Sirenix.Serialization.Utilities.MemberInfoExtensions.IsDefined<SerializeField>(fieldInfo))
		{
			return false;
		}
		if (Sirenix.Serialization.Utilities.MemberInfoExtensions.IsDefined<FixedBufferAttribute>(fieldInfo))
		{
			return Sirenix.Serialization.Utilities.UnityVersion.IsVersionOrGreater(2017, 1);
		}
		return GuessIfUnityWillSerialize(fieldInfo.FieldType);
	}

	public static bool GuessIfUnityWillSerialize(Type type)
	{
		if (type == null)
		{
			throw new ArgumentNullException("type");
		}
		bool value;
		lock (UnityWillSerializeTypesCache)
		{
			if (!UnityWillSerializeTypesCache.TryGetValue(type, out value))
			{
				value = GuessIfUnityWillSerializePrivate(type);
				UnityWillSerializeTypesCache[type] = value;
			}
		}
		return value;
	}

	private static bool GuessIfUnityWillSerializePrivate(Type type)
	{
		if (UnityNeverSerializesTypes.Contains(type) || UnityNeverSerializesTypeNames.Contains(type.FullName))
		{
			return false;
		}
		if (typeof(UnityEngine.Object).IsAssignableFrom(type))
		{
			if (type.IsGenericType)
			{
				return Sirenix.Serialization.Utilities.UnityVersion.IsVersionOrGreater(2020, 1);
			}
			return true;
		}
		if (type.IsAbstract || type.IsInterface || type == typeof(object))
		{
			return false;
		}
		if (type.IsEnum)
		{
			Type underlyingType = Enum.GetUnderlyingType(type);
			if (Sirenix.Serialization.Utilities.UnityVersion.IsVersionOrGreater(5, 6))
			{
				if (underlyingType != typeof(long))
				{
					return underlyingType != typeof(ulong);
				}
				return false;
			}
			if (!(underlyingType == typeof(int)))
			{
				return underlyingType == typeof(byte);
			}
			return true;
		}
		if (type.IsPrimitive || type == typeof(string))
		{
			return true;
		}
		if (typeof(Delegate).IsAssignableFrom(type))
		{
			return false;
		}
		if (typeof(UnityEventBase).IsAssignableFrom(type))
		{
			if (type.IsGenericType && !Sirenix.Serialization.Utilities.UnityVersion.IsVersionOrGreater(2020, 1))
			{
				return false;
			}
			if (!(type == typeof(UnityEvent)))
			{
				return Sirenix.Serialization.Utilities.TypeExtensions.IsDefined<SerializableAttribute>(type, inherit: false);
			}
			return true;
		}
		if (type.IsArray)
		{
			Type elementType = type.GetElementType();
			if (type.GetArrayRank() == 1 && !elementType.IsArray && !Sirenix.Serialization.Utilities.TypeExtensions.ImplementsOpenGenericClass(elementType, typeof(List<>)))
			{
				return GuessIfUnityWillSerialize(elementType);
			}
			return false;
		}
		if (type.IsGenericType && !type.IsGenericTypeDefinition && type.GetGenericTypeDefinition() == typeof(List<>))
		{
			Type type2 = Sirenix.Serialization.Utilities.TypeExtensions.GetArgumentsOfInheritedOpenGenericClass(type, typeof(List<>))[0];
			if (type2.IsArray || Sirenix.Serialization.Utilities.TypeExtensions.ImplementsOpenGenericClass(type2, typeof(List<>)))
			{
				return false;
			}
			return GuessIfUnityWillSerialize(type2);
		}
		if (type.Assembly.FullName.StartsWith("UnityEngine", StringComparison.InvariantCulture) || type.Assembly.FullName.StartsWith("UnityEditor", StringComparison.InvariantCulture))
		{
			return true;
		}
		if (type.IsGenericType && !Sirenix.Serialization.Utilities.UnityVersion.IsVersionOrGreater(2020, 1))
		{
			return false;
		}
		if (type.Assembly == String_Assembly || type.Assembly == HashSet_Assembly || type.Assembly == LinkedList_Assembly)
		{
			return false;
		}
		if (Sirenix.Serialization.Utilities.TypeExtensions.IsDefined<SerializableAttribute>(type, inherit: false))
		{
			if (Sirenix.Serialization.Utilities.UnityVersion.IsVersionOrGreater(4, 5))
			{
				return true;
			}
			return type.IsClass;
		}
		if (!Sirenix.Serialization.Utilities.UnityVersion.IsVersionOrGreater(2018, 2))
		{
			Type baseType = type.BaseType;
			while (baseType != null && baseType != typeof(object))
			{
				if (baseType.IsGenericType && baseType.GetGenericTypeDefinition().FullName == "UnityEngine.Networking.SyncListStruct`1")
				{
					return true;
				}
				baseType = baseType.BaseType;
			}
		}
		return false;
	}

	public static void SerializeUnityObject(UnityEngine.Object unityObject, ref SerializationData data, bool serializeUnityFields = false, SerializationContext context = null)
	{
		if (unityObject == null)
		{
			throw new ArgumentNullException("unityObject");
		}
		DataFormat dataFormat = ((!(unityObject is IOverridesSerializationFormat overridesSerializationFormat)) ? (GlobalConfig<GlobalSerializationConfig>.HasInstanceLoaded ? GlobalConfig<GlobalSerializationConfig>.Instance.BuildSerializationFormat : DataFormat.Binary) : overridesSerializationFormat.GetFormatToSerializeAs(isPlayer: true));
		if (dataFormat == DataFormat.Nodes)
		{
			Debug.LogWarning("The serialization format '" + dataFormat.ToString() + "' is disabled outside of the editor. Defaulting to the format '" + DataFormat.Binary.ToString() + "' instead.");
			dataFormat = DataFormat.Binary;
		}
		SerializeUnityObject(unityObject, ref data.SerializedBytes, ref data.ReferencedUnityObjects, dataFormat);
		data.SerializedFormat = dataFormat;
	}

	public static void SerializeUnityObject(UnityEngine.Object unityObject, ref string base64Bytes, ref List<UnityEngine.Object> referencedUnityObjects, DataFormat format, bool serializeUnityFields = false, SerializationContext context = null)
	{
		byte[] bytes = null;
		SerializeUnityObject(unityObject, ref bytes, ref referencedUnityObjects, format, serializeUnityFields, context);
		base64Bytes = Convert.ToBase64String(bytes);
	}

	public static void SerializeUnityObject(UnityEngine.Object unityObject, ref byte[] bytes, ref List<UnityEngine.Object> referencedUnityObjects, DataFormat format, bool serializeUnityFields = false, SerializationContext context = null)
	{
		if (unityObject == null)
		{
			throw new ArgumentNullException("unityObject");
		}
		if (format == DataFormat.Nodes)
		{
			Debug.LogError("The serialization data format '" + format.ToString() + "' is not supported by this method. You must create your own writer.");
			return;
		}
		if (referencedUnityObjects == null)
		{
			referencedUnityObjects = new List<UnityEngine.Object>();
		}
		else
		{
			referencedUnityObjects.Clear();
		}
		using Cache<CachedMemoryStream> cache = Cache<CachedMemoryStream>.Claim();
		using Cache<UnityReferenceResolver> cache2 = Cache<UnityReferenceResolver>.Claim();
		cache2.Value.SetReferencedUnityObjects(referencedUnityObjects);
		if (context != null)
		{
			context.IndexReferenceResolver = cache2.Value;
			using ICache cache3 = GetCachedUnityWriter(format, cache.Value.MemoryStream, context);
			SerializeUnityObject(unityObject, cache3.Value as IDataWriter, serializeUnityFields);
		}
		else
		{
			using Cache<SerializationContext> cache4 = Cache<SerializationContext>.Claim();
			cache4.Value.Config.SerializationPolicy = SerializationPolicies.Unity;
			if (GlobalConfig<GlobalSerializationConfig>.HasInstanceLoaded)
			{
				cache4.Value.Config.DebugContext.ErrorHandlingPolicy = GlobalConfig<GlobalSerializationConfig>.Instance.ErrorHandlingPolicy;
				cache4.Value.Config.DebugContext.LoggingPolicy = GlobalConfig<GlobalSerializationConfig>.Instance.LoggingPolicy;
				cache4.Value.Config.DebugContext.Logger = GlobalConfig<GlobalSerializationConfig>.Instance.Logger;
			}
			else
			{
				cache4.Value.Config.DebugContext.ErrorHandlingPolicy = ErrorHandlingPolicy.Resilient;
				cache4.Value.Config.DebugContext.LoggingPolicy = LoggingPolicy.LogErrors;
				cache4.Value.Config.DebugContext.Logger = DefaultLoggers.UnityLogger;
			}
			cache4.Value.IndexReferenceResolver = cache2.Value;
			using ICache cache5 = GetCachedUnityWriter(format, cache.Value.MemoryStream, cache4);
			SerializeUnityObject(unityObject, cache5.Value as IDataWriter, serializeUnityFields);
		}
		bytes = cache.Value.MemoryStream.ToArray();
	}

	public static void SerializeUnityObject(UnityEngine.Object unityObject, IDataWriter writer, bool serializeUnityFields = false)
	{
		if (unityObject == null)
		{
			throw new ArgumentNullException("unityObject");
		}
		if (writer == null)
		{
			throw new ArgumentNullException("writer");
		}
		try
		{
			writer.PrepareNewSerializationSession();
			MemberInfo[] serializableMembers = FormatterUtilities.GetSerializableMembers(unityObject.GetType(), writer.Context.Config.SerializationPolicy);
			object instance = unityObject;
			foreach (MemberInfo memberInfo in serializableMembers)
			{
				Sirenix.Serialization.Utilities.WeakValueGetter weakValueGetter = null;
				if (!OdinWillSerialize(memberInfo, serializeUnityFields, writer.Context.Config.SerializationPolicy) || (weakValueGetter = GetCachedUnityMemberGetter(memberInfo)) == null)
				{
					continue;
				}
				object obj = weakValueGetter(ref instance);
				if (obj == null || !(obj.GetType() == typeof(SerializationData)))
				{
					Serializer serializer = Serializer.Get(FormatterUtilities.GetContainedType(memberInfo));
					try
					{
						serializer.WriteValueWeak(memberInfo.Name, obj, writer);
					}
					catch (Exception exception)
					{
						writer.Context.Config.DebugContext.LogException(exception);
					}
				}
			}
			writer.FlushToStream();
		}
		catch (SerializationAbortException innerException)
		{
			throw new SerializationAbortException("Serialization of type '" + Sirenix.Serialization.Utilities.TypeExtensions.GetNiceFullName(unityObject.GetType()) + "' aborted.", innerException);
		}
		catch (Exception ex)
		{
			Debug.LogException(new Exception("Exception thrown while serializing type '" + Sirenix.Serialization.Utilities.TypeExtensions.GetNiceFullName(unityObject.GetType()) + "': " + ex.Message, ex));
		}
	}

	public static void DeserializeUnityObject(UnityEngine.Object unityObject, ref SerializationData data, DeserializationContext context = null)
	{
		DeserializeUnityObject(unityObject, ref data, context, isPrefabData: false, null);
	}

	private static void DeserializeUnityObject(UnityEngine.Object unityObject, ref SerializationData data, DeserializationContext context, bool isPrefabData, List<UnityEngine.Object> prefabInstanceUnityObjects)
	{
		if (unityObject == null)
		{
			throw new ArgumentNullException("unityObject");
		}
		if (isPrefabData && prefabInstanceUnityObjects == null)
		{
			prefabInstanceUnityObjects = new List<UnityEngine.Object>();
		}
		if (data.SerializedBytes != null && data.SerializedBytes.Length != 0 && (data.SerializationNodes == null || data.SerializationNodes.Count == 0))
		{
			if (data.SerializedFormat == DataFormat.Nodes)
			{
				DataFormat format = ((data.SerializedBytes[0] == 123) ? DataFormat.JSON : DataFormat.Binary);
				try
				{
					string text = ProperBitConverter.BytesToHexString(data.SerializedBytes);
					Debug.LogWarning("Serialization data has only bytes stored, but the serialized format is marked as being 'Nodes', which is incompatible with data stored as a byte array. Based on the appearance of the serialized bytes, Odin has guessed that the data format is '" + format.ToString() + "', and will attempt to deserialize the bytes using that format. The serialized bytes follow, converted to a hex string: " + text);
				}
				catch
				{
				}
				DeserializeUnityObject(unityObject, ref data.SerializedBytes, ref data.ReferencedUnityObjects, format, context);
			}
			else
			{
				DeserializeUnityObject(unityObject, ref data.SerializedBytes, ref data.ReferencedUnityObjects, data.SerializedFormat, context);
			}
			ApplyPrefabModifications(unityObject, data.PrefabModifications, data.PrefabModificationsReferencedUnityObjects);
			return;
		}
		Cache<DeserializationContext> cache = null;
		try
		{
			if (context == null)
			{
				cache = Cache<DeserializationContext>.Claim();
				context = cache;
				context.Config.SerializationPolicy = SerializationPolicies.Unity;
				if (GlobalConfig<GlobalSerializationConfig>.HasInstanceLoaded)
				{
					context.Config.DebugContext.ErrorHandlingPolicy = GlobalConfig<GlobalSerializationConfig>.Instance.ErrorHandlingPolicy;
					context.Config.DebugContext.LoggingPolicy = GlobalConfig<GlobalSerializationConfig>.Instance.LoggingPolicy;
					context.Config.DebugContext.Logger = GlobalConfig<GlobalSerializationConfig>.Instance.Logger;
				}
				else
				{
					context.Config.DebugContext.ErrorHandlingPolicy = ErrorHandlingPolicy.Resilient;
					context.Config.DebugContext.LoggingPolicy = LoggingPolicy.LogErrors;
					context.Config.DebugContext.Logger = DefaultLoggers.UnityLogger;
				}
			}
			if (unityObject is IOverridesSerializationPolicy { SerializationPolicy: { } serializationPolicy })
			{
				context.Config.SerializationPolicy = serializationPolicy;
			}
			if (!isPrefabData && !Sirenix.Serialization.Utilities.UnityExtensions.SafeIsUnityNull(data.Prefab))
			{
				if (data.Prefab is ISupportsPrefabSerialization)
				{
					if ((object)data.Prefab != unityObject || data.PrefabModifications == null || data.PrefabModifications.Count <= 0)
					{
						SerializationData data2 = (data.Prefab as ISupportsPrefabSerialization).SerializationData;
						if (!data2.ContainsData)
						{
							DeserializeUnityObject(unityObject, ref data, context, isPrefabData: true, data.ReferencedUnityObjects);
						}
						else
						{
							DeserializeUnityObject(unityObject, ref data2, context, isPrefabData: true, data.ReferencedUnityObjects);
						}
						ApplyPrefabModifications(unityObject, data.PrefabModifications, data.PrefabModificationsReferencedUnityObjects);
						return;
					}
				}
				else if (data.Prefab.GetType() != typeof(UnityEngine.Object))
				{
					Debug.LogWarning("The type " + Sirenix.Serialization.Utilities.TypeExtensions.GetNiceName(data.Prefab.GetType()) + " no longer supports special prefab serialization (the interface " + Sirenix.Serialization.Utilities.TypeExtensions.GetNiceName(typeof(ISupportsPrefabSerialization)) + ") upon deserialization of an instance of a prefab; prefab data may be lost. Has a type been lost?");
				}
			}
			List<UnityEngine.Object> referencedUnityObjects = (isPrefabData ? prefabInstanceUnityObjects : data.ReferencedUnityObjects);
			if (data.SerializedFormat == DataFormat.Nodes)
			{
				using SerializationNodeDataReader serializationNodeDataReader = new SerializationNodeDataReader(context);
				using Cache<UnityReferenceResolver> cache2 = Cache<UnityReferenceResolver>.Claim();
				cache2.Value.SetReferencedUnityObjects(referencedUnityObjects);
				context.IndexReferenceResolver = cache2.Value;
				serializationNodeDataReader.Nodes = data.SerializationNodes;
				DeserializeUnityObject(unityObject, serializationNodeDataReader);
			}
			else if (data.SerializedBytes != null && data.SerializedBytes.Length != 0)
			{
				DeserializeUnityObject(unityObject, ref data.SerializedBytes, ref referencedUnityObjects, data.SerializedFormat, context);
			}
			else
			{
				DeserializeUnityObject(unityObject, ref data.SerializedBytesString, ref referencedUnityObjects, data.SerializedFormat, context);
			}
			ApplyPrefabModifications(unityObject, data.PrefabModifications, data.PrefabModificationsReferencedUnityObjects);
		}
		finally
		{
			if (cache != null)
			{
				Cache<DeserializationContext>.Release(cache);
			}
		}
	}

	public static void DeserializeUnityObject(UnityEngine.Object unityObject, ref string base64Bytes, ref List<UnityEngine.Object> referencedUnityObjects, DataFormat format, DeserializationContext context = null)
	{
		if (!string.IsNullOrEmpty(base64Bytes))
		{
			byte[] bytes = null;
			try
			{
				bytes = Convert.FromBase64String(base64Bytes);
			}
			catch (FormatException)
			{
				Debug.LogError("Invalid base64 string when deserializing data: " + base64Bytes);
			}
			if (bytes != null)
			{
				DeserializeUnityObject(unityObject, ref bytes, ref referencedUnityObjects, format, context);
			}
		}
	}

	public static void DeserializeUnityObject(UnityEngine.Object unityObject, ref byte[] bytes, ref List<UnityEngine.Object> referencedUnityObjects, DataFormat format, DeserializationContext context = null)
	{
		if (unityObject == null)
		{
			throw new ArgumentNullException("unityObject");
		}
		if (bytes == null || bytes.Length == 0)
		{
			return;
		}
		if (format == DataFormat.Nodes)
		{
			try
			{
				Debug.LogError("The serialization data format '" + format.ToString() + "' is not supported by this method. You must create your own reader.");
				return;
			}
			catch
			{
				return;
			}
		}
		if (referencedUnityObjects == null)
		{
			referencedUnityObjects = new List<UnityEngine.Object>();
		}
		using Cache<CachedMemoryStream> cache = Cache<CachedMemoryStream>.Claim();
		using Cache<UnityReferenceResolver> cache2 = Cache<UnityReferenceResolver>.Claim();
		cache.Value.MemoryStream.Write(bytes, 0, bytes.Length);
		cache.Value.MemoryStream.Position = 0L;
		cache2.Value.SetReferencedUnityObjects(referencedUnityObjects);
		if (context != null)
		{
			context.IndexReferenceResolver = cache2.Value;
			using ICache cache3 = GetCachedUnityReader(format, cache.Value.MemoryStream, context);
			DeserializeUnityObject(unityObject, cache3.Value as IDataReader);
			return;
		}
		using Cache<DeserializationContext> cache4 = Cache<DeserializationContext>.Claim();
		cache4.Value.Config.SerializationPolicy = SerializationPolicies.Unity;
		if (GlobalConfig<GlobalSerializationConfig>.HasInstanceLoaded)
		{
			cache4.Value.Config.DebugContext.ErrorHandlingPolicy = GlobalConfig<GlobalSerializationConfig>.Instance.ErrorHandlingPolicy;
			cache4.Value.Config.DebugContext.LoggingPolicy = GlobalConfig<GlobalSerializationConfig>.Instance.LoggingPolicy;
			cache4.Value.Config.DebugContext.Logger = GlobalConfig<GlobalSerializationConfig>.Instance.Logger;
		}
		else
		{
			cache4.Value.Config.DebugContext.ErrorHandlingPolicy = ErrorHandlingPolicy.Resilient;
			cache4.Value.Config.DebugContext.LoggingPolicy = LoggingPolicy.LogErrors;
			cache4.Value.Config.DebugContext.Logger = DefaultLoggers.UnityLogger;
		}
		cache4.Value.IndexReferenceResolver = cache2.Value;
		using ICache cache5 = GetCachedUnityReader(format, cache.Value.MemoryStream, cache4);
		DeserializeUnityObject(unityObject, cache5.Value as IDataReader);
	}

	public static void DeserializeUnityObject(UnityEngine.Object unityObject, IDataReader reader)
	{
		if (unityObject == null)
		{
			throw new ArgumentNullException("unityObject");
		}
		if (reader == null)
		{
			throw new ArgumentNullException("reader");
		}
		if (unityObject is IOverridesSerializationPolicy { SerializationPolicy: { } serializationPolicy })
		{
			reader.Context.Config.SerializationPolicy = serializationPolicy;
		}
		try
		{
			reader.PrepareNewSerializationSession();
			Dictionary<string, MemberInfo> serializableMembersMap = FormatterUtilities.GetSerializableMembersMap(unityObject.GetType(), reader.Context.Config.SerializationPolicy);
			int num = 0;
			object instance = unityObject;
			EntryType entryType;
			string name;
			while ((entryType = reader.PeekEntry(out name)) != EntryType.EndOfNode && entryType != EntryType.EndOfArray && entryType != EntryType.EndOfStream)
			{
				MemberInfo value = null;
				Sirenix.Serialization.Utilities.WeakValueSetter weakValueSetter = null;
				bool flag = false;
				if (entryType == EntryType.Invalid)
				{
					string text = "Encountered invalid entry while reading serialization data for Unity object of type '" + Sirenix.Serialization.Utilities.TypeExtensions.GetNiceFullName(unityObject.GetType()) + "'. This likely means that Unity has filled Odin's stored serialization data with garbage, which can randomly happen after upgrading the Unity version of the project, or when otherwise doing things that have a lot of fragile interactions with the asset database. Locating the asset which causes this error log and causing it to reserialize (IE, modifying it and then causing it to be saved to disk) is likely to 'fix' the issue and make this message go away. Experience shows that this issue is particularly likely to occur on prefab instances, and if this is the case, the parent prefab is also under suspicion, and should be re-saved and re-imported. Note that DATA MAY HAVE BEEN LOST, and you should verify with your version control system (you're using one, right?!) that everything is alright, and if not, use it to rollback the asset to recover your data.\n\n\n";
					text = text + "IF YOU HAVE CONSISTENT REPRODUCTION STEPS THAT MAKE THIS ISSUE REOCCUR, please report it at this issue at 'https://bitbucket.org/sirenix/odin-inspector/issues/526', and copy paste this debug message into your comment, along with any potential actions or recent changes in the project that might have happened to cause this message to occur. If the data dump in this message is cut off, please find the editor's log file (see https://docs.unity3d.com/Manual/LogFiles.html) and copy paste the full version of this message from there.\n\n\nData dump:\n\n    Reader type: " + reader.GetType().Name + "\n";
					try
					{
						text = text + "    Data dump: " + reader.GetDataDump();
					}
					finally
					{
						reader.Context.Config.DebugContext.LogError(text);
						flag = true;
					}
				}
				else if (string.IsNullOrEmpty(name))
				{
					reader.Context.Config.DebugContext.LogError("Entry of type \"" + entryType.ToString() + "\" in node \"" + reader.CurrentNodeName + "\" is missing a name.");
					flag = true;
				}
				else if (!serializableMembersMap.TryGetValue(name, out value) || (weakValueSetter = GetCachedUnityMemberSetter(value)) == null)
				{
					flag = true;
				}
				if (flag)
				{
					reader.SkipEntry();
					continue;
				}
				Type containedType = FormatterUtilities.GetContainedType(value);
				Serializer serializer = Serializer.Get(containedType);
				try
				{
					object value2 = serializer.ReadValueWeak(reader);
					weakValueSetter(ref instance, value2);
				}
				catch (Exception exception)
				{
					reader.Context.Config.DebugContext.LogException(exception);
				}
				num++;
				if (num <= 1000)
				{
					continue;
				}
				reader.Context.Config.DebugContext.LogError("Breaking out of infinite reading loop! (Read more than a thousand entries for one type!)");
				break;
			}
		}
		catch (SerializationAbortException innerException)
		{
			throw new SerializationAbortException("Deserialization of type '" + Sirenix.Serialization.Utilities.TypeExtensions.GetNiceFullName(unityObject.GetType()) + "' aborted.", innerException);
		}
		catch (Exception ex)
		{
			Debug.LogException(new Exception("Exception thrown while deserializing type '" + Sirenix.Serialization.Utilities.TypeExtensions.GetNiceFullName(unityObject.GetType()) + "': " + ex.Message, ex));
		}
	}

	public static List<string> SerializePrefabModifications(List<PrefabModification> modifications, ref List<UnityEngine.Object> referencedUnityObjects)
	{
		if (referencedUnityObjects == null)
		{
			referencedUnityObjects = new List<UnityEngine.Object>();
		}
		else if (referencedUnityObjects.Count > 0)
		{
			referencedUnityObjects.Clear();
		}
		if (modifications == null || modifications.Count == 0)
		{
			return new List<string>();
		}
		modifications.Sort((PrefabModification a, PrefabModification b) =>
		{
			int num3 = a.Path.CompareTo(b.Path);
			if (num3 == 0)
			{
				if ((a.ModificationType == PrefabModificationType.ListLength || a.ModificationType == PrefabModificationType.Dictionary) && b.ModificationType == PrefabModificationType.Value)
				{
					return 1;
				}
				if (a.ModificationType == PrefabModificationType.Value && (b.ModificationType == PrefabModificationType.ListLength || b.ModificationType == PrefabModificationType.Dictionary))
				{
					return -1;
				}
			}
			return num3;
		});
		List<string> list = new List<string>();
		using Cache<SerializationContext> cache = Cache<SerializationContext>.Claim();
		using Cache<CachedMemoryStream> cache2 = CachedMemoryStream.Claim();
		using Cache<JsonDataWriter> cache3 = Cache<JsonDataWriter>.Claim();
		using Cache<UnityReferenceResolver> cache4 = Cache<UnityReferenceResolver>.Claim();
		JsonDataWriter value = cache3.Value;
		value.Context = cache;
		value.Stream = cache2.Value.MemoryStream;
		value.PrepareNewSerializationSession();
		value.FormatAsReadable = false;
		value.EnableTypeOptimization = false;
		cache4.Value.SetReferencedUnityObjects(referencedUnityObjects);
		value.Context.IndexReferenceResolver = cache4.Value;
		for (int num = 0; num < modifications.Count; num++)
		{
			PrefabModification prefabModification = modifications[num];
			if (prefabModification.ModificationType == PrefabModificationType.ListLength)
			{
				value.MarkJustStarted();
				value.WriteString("path", prefabModification.Path);
				value.WriteInt32("length", prefabModification.NewLength);
				value.FlushToStream();
				list.Add(GetStringFromStreamAndReset(cache2.Value.MemoryStream));
			}
			else if (prefabModification.ModificationType == PrefabModificationType.Value)
			{
				value.MarkJustStarted();
				value.WriteString("path", prefabModification.Path);
				if (prefabModification.ReferencePaths != null && prefabModification.ReferencePaths.Count > 0)
				{
					value.BeginStructNode("references", null);
					for (int num2 = 0; num2 < prefabModification.ReferencePaths.Count; num2++)
					{
						value.WriteString(null, prefabModification.ReferencePaths[num2]);
					}
					value.EndNode("references");
				}
				Serializer<object> serializer = Serializer.Get<object>();
				serializer.WriteValueWeak("value", prefabModification.ModifiedValue, value);
				value.FlushToStream();
				list.Add(GetStringFromStreamAndReset(cache2.Value.MemoryStream));
			}
			else if (prefabModification.ModificationType == PrefabModificationType.Dictionary)
			{
				value.MarkJustStarted();
				value.WriteString("path", prefabModification.Path);
				Serializer.Get<object[]>().WriteValue("add_keys", prefabModification.DictionaryKeysAdded, value);
				Serializer.Get<object[]>().WriteValue("remove_keys", prefabModification.DictionaryKeysRemoved, value);
				value.FlushToStream();
				list.Add(GetStringFromStreamAndReset(cache2.Value.MemoryStream));
			}
			value.Context.ResetInternalReferences();
		}
		return list;
	}

	private static string GetStringFromStreamAndReset(Stream stream)
	{
		byte[] array = new byte[stream.Position];
		stream.Position = 0L;
		stream.Read(array, 0, array.Length);
		stream.Position = 0L;
		return Encoding.UTF8.GetString(array);
	}

	public static List<PrefabModification> DeserializePrefabModifications(List<string> modifications, List<UnityEngine.Object> referencedUnityObjects)
	{
		if (modifications == null || modifications.Count == 0)
		{
			return new List<PrefabModification>();
		}
		List<PrefabModification> list = new List<PrefabModification>();
		int num = 0;
		for (int i = 0; i < modifications.Count; i++)
		{
			int num2 = modifications[i].Length * 2;
			if (num2 > num)
			{
				num = num2;
			}
		}
		using Cache<DeserializationContext> cache = Cache<DeserializationContext>.Claim();
		using Cache<CachedMemoryStream> cache2 = CachedMemoryStream.Claim(num);
		using Cache<JsonDataReader> cache3 = Cache<JsonDataReader>.Claim();
		using Cache<UnityReferenceResolver> cache4 = Cache<UnityReferenceResolver>.Claim();
		MemoryStream memoryStream = cache2.Value.MemoryStream;
		JsonDataReader value = cache3.Value;
		value.Context = cache;
		value.Stream = memoryStream;
		cache4.Value.SetReferencedUnityObjects(referencedUnityObjects);
		value.Context.IndexReferenceResolver = cache4.Value;
		for (int j = 0; j < modifications.Count; j++)
		{
			string s = modifications[j];
			byte[] bytes = Encoding.UTF8.GetBytes(s);
			memoryStream.SetLength(bytes.Length);
			memoryStream.Position = 0L;
			memoryStream.Write(bytes, 0, bytes.Length);
			memoryStream.Position = 0L;
			PrefabModification prefabModification = new PrefabModification();
			value.PrepareNewSerializationSession();
			EntryType entryType = value.PeekEntry(out var name);
			if (entryType == EntryType.EndOfStream)
			{
				value.SkipEntry();
			}
			while ((entryType = value.PeekEntry(out name)) != EntryType.EndOfNode && entryType != EntryType.EndOfArray && entryType != EntryType.EndOfStream)
			{
				if (name == null)
				{
					Debug.LogError("Unexpected entry of type " + entryType.ToString() + " without a name.");
					value.SkipEntry();
				}
				else if (name.Equals("path", StringComparison.InvariantCultureIgnoreCase))
				{
					value.ReadString(out prefabModification.Path);
				}
				else if (name.Equals("length", StringComparison.InvariantCultureIgnoreCase))
				{
					value.ReadInt32(out prefabModification.NewLength);
					prefabModification.ModificationType = PrefabModificationType.ListLength;
				}
				else if (name.Equals("references", StringComparison.InvariantCultureIgnoreCase))
				{
					prefabModification.ReferencePaths = new List<string>();
					value.EnterNode(out var _);
					while (value.PeekEntry(out name) == EntryType.String)
					{
						value.ReadString(out var value2);
						prefabModification.ReferencePaths.Add(value2);
					}
					value.ExitNode();
				}
				else if (name.Equals("value", StringComparison.InvariantCultureIgnoreCase))
				{
					prefabModification.ModifiedValue = Serializer.Get<object>().ReadValue(value);
					prefabModification.ModificationType = PrefabModificationType.Value;
				}
				else if (name.Equals("add_keys", StringComparison.InvariantCultureIgnoreCase))
				{
					prefabModification.DictionaryKeysAdded = Serializer.Get<object[]>().ReadValue(value);
					prefabModification.ModificationType = PrefabModificationType.Dictionary;
				}
				else if (name.Equals("remove_keys", StringComparison.InvariantCultureIgnoreCase))
				{
					prefabModification.DictionaryKeysRemoved = Serializer.Get<object[]>().ReadValue(value);
					prefabModification.ModificationType = PrefabModificationType.Dictionary;
				}
				else
				{
					Debug.LogError("Unexpected entry name '" + name + "' while deserializing prefab modifications.");
					value.SkipEntry();
				}
			}
			if (prefabModification.Path != null)
			{
				list.Add(prefabModification);
			}
		}
		return list;
	}

	public static object CreateDefaultUnityInitializedObject(Type type)
	{
		return CreateDefaultUnityInitializedObject(type, 0);
	}

	private static object CreateDefaultUnityInitializedObject(Type type, int depth)
	{
		if (depth > 5)
		{
			return null;
		}
		if (!GuessIfUnityWillSerialize(type))
		{
			if (!type.IsValueType)
			{
				return null;
			}
			return Activator.CreateInstance(type);
		}
		if (type == typeof(string))
		{
			return "";
		}
		if (type.IsEnum)
		{
			Array values = Enum.GetValues(type);
			if (values.Length <= 0)
			{
				return Enum.ToObject(type, 0);
			}
			return values.GetValue(0);
		}
		if (type.IsPrimitive)
		{
			return Activator.CreateInstance(type);
		}
		if (type.IsArray)
		{
			return Array.CreateInstance(type.GetElementType(), 0);
		}
		if (Sirenix.Serialization.Utilities.TypeExtensions.ImplementsOpenGenericClass(type, typeof(List<>)) || typeof(UnityEventBase).IsAssignableFrom(type))
		{
			try
			{
				return Activator.CreateInstance(type);
			}
			catch
			{
				return null;
			}
		}
		if (typeof(UnityEngine.Object).IsAssignableFrom(type))
		{
			return null;
		}
		if ((type.Assembly.GetName().Name.StartsWith("UnityEngine") || type.Assembly.GetName().Name.StartsWith("UnityEditor")) && type.GetConstructor(Type.EmptyTypes) != null)
		{
			try
			{
				return Activator.CreateInstance(type);
			}
			catch (Exception exception)
			{
				Debug.LogException(exception);
				return null;
			}
		}
		if (type.GetConstructor(Type.EmptyTypes) != null)
		{
			return Activator.CreateInstance(type);
		}
		object uninitializedObject = FormatterServices.GetUninitializedObject(type);
		FieldInfo[] fields = type.GetFields(BindingFlags.Instance | BindingFlags.Public | BindingFlags.NonPublic);
		foreach (FieldInfo fieldInfo in fields)
		{
			if (GuessIfUnityWillSerialize(fieldInfo))
			{
				fieldInfo.SetValue(uninitializedObject, CreateDefaultUnityInitializedObject(fieldInfo.FieldType, depth + 1));
			}
		}
		return uninitializedObject;
	}

	private static void ApplyPrefabModifications(UnityEngine.Object unityObject, List<string> modificationData, List<UnityEngine.Object> referencedUnityObjects)
	{
		if (unityObject == null)
		{
			throw new ArgumentNullException("unityObject");
		}
		if (modificationData == null || modificationData.Count == 0)
		{
			return;
		}
		List<PrefabModification> list = DeserializePrefabModifications(modificationData, referencedUnityObjects);
		for (int i = 0; i < list.Count; i++)
		{
			PrefabModification prefabModification = list[i];
			try
			{
				prefabModification.Apply(unityObject);
			}
			catch (Exception exception)
			{
				Debug.Log("The following exception was thrown when trying to apply a prefab modification for path '" + prefabModification.Path + "':");
				Debug.LogException(exception);
			}
		}
	}

	private static Sirenix.Serialization.Utilities.WeakValueGetter GetCachedUnityMemberGetter(MemberInfo member)
	{
		lock (UnityMemberGetters)
		{
			if (!UnityMemberGetters.TryGetValue(member, out var value))
			{
				if (member is FieldInfo)
				{
					value = Sirenix.Serialization.Utilities.EmitUtilities.CreateWeakInstanceFieldGetter(member.DeclaringType, member as FieldInfo);
				}
				else
				{
					value = ((!(member is PropertyInfo)) ? ((Sirenix.Serialization.Utilities.WeakValueGetter)delegate(ref object instance)
					{
						return FormatterUtilities.GetMemberValue(member, instance);
					}) : Sirenix.Serialization.Utilities.EmitUtilities.CreateWeakInstancePropertyGetter(member.DeclaringType, member as PropertyInfo));
				}
				UnityMemberGetters.Add(member, value);
			}
			return value;
		}
	}

	private static Sirenix.Serialization.Utilities.WeakValueSetter GetCachedUnityMemberSetter(MemberInfo member)
	{
		lock (UnityMemberSetters)
		{
			if (!UnityMemberSetters.TryGetValue(member, out var value))
			{
				if (member is FieldInfo)
				{
					value = Sirenix.Serialization.Utilities.EmitUtilities.CreateWeakInstanceFieldSetter(member.DeclaringType, member as FieldInfo);
				}
				else
				{
					value = ((!(member is PropertyInfo)) ? ((Sirenix.Serialization.Utilities.WeakValueSetter)delegate(ref object instance, object value2)
					{
						FormatterUtilities.SetMemberValue(member, instance, value2);
					}) : Sirenix.Serialization.Utilities.EmitUtilities.CreateWeakInstancePropertySetter(member.DeclaringType, member as PropertyInfo));
				}
				UnityMemberSetters.Add(member, value);
			}
			return value;
		}
	}

	private static ICache GetCachedUnityWriter(DataFormat format, Stream stream, SerializationContext context)
	{
		ICache cache2;
		switch (format)
		{
		case DataFormat.Binary:
		{
			Cache<BinaryDataWriter> cache3 = Cache<BinaryDataWriter>.Claim();
			cache3.Value.Stream = stream;
			cache2 = cache3;
			break;
		}
		case DataFormat.JSON:
		{
			Cache<JsonDataWriter> cache = Cache<JsonDataWriter>.Claim();
			cache.Value.Stream = stream;
			cache2 = cache;
			break;
		}
		case DataFormat.Nodes:
			throw new InvalidOperationException("Don't do this for nodes!");
		default:
			throw new NotImplementedException(format.ToString());
		}
		(cache2.Value as IDataWriter).Context = context;
		return cache2;
	}

	private static ICache GetCachedUnityReader(DataFormat format, Stream stream, DeserializationContext context)
	{
		ICache cache2;
		switch (format)
		{
		case DataFormat.Binary:
		{
			Cache<BinaryDataReader> cache3 = Cache<BinaryDataReader>.Claim();
			cache3.Value.Stream = stream;
			cache2 = cache3;
			break;
		}
		case DataFormat.JSON:
		{
			Cache<JsonDataReader> cache = Cache<JsonDataReader>.Claim();
			cache.Value.Stream = stream;
			cache2 = cache;
			break;
		}
		case DataFormat.Nodes:
			throw new InvalidOperationException("Don't do this for nodes!");
		default:
			throw new NotImplementedException(format.ToString());
		}
		(cache2.Value as IDataReader).Context = context;
		return cache2;
	}
}
