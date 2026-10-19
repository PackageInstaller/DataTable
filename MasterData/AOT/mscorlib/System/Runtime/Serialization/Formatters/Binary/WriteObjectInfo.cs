using System.Reflection;
using System.Security;

namespace System.Runtime.Serialization.Formatters.Binary;

internal sealed class WriteObjectInfo
{
	internal int objectInfoId;

	internal object obj;

	internal Type objectType;

	internal bool isSi;

	internal bool isNamed;

	internal bool isTyped;

	internal bool isArray;

	internal SerializationInfo si;

	internal SerObjectInfoCache cache;

	internal object[] memberData;

	internal ISerializationSurrogate serializationSurrogate;

	internal StreamingContext context;

	internal SerObjectInfoInit serObjectInfoInit;

	internal long objectId;

	internal long assemId;

	private string binderTypeName;

	private string binderAssemblyString;

	internal WriteObjectInfo()
	{
	}

	internal void ObjectEnd()
	{
		PutObjectInfo(serObjectInfoInit, this);
	}

	private void InternalInit()
	{
		obj = null;
		objectType = null;
		isSi = false;
		isNamed = false;
		isTyped = false;
		isArray = false;
		si = null;
		cache = null;
		memberData = null;
		objectId = 0L;
		assemId = 0L;
		binderTypeName = null;
		binderAssemblyString = null;
	}

	internal static WriteObjectInfo Serialize(object obj, ISurrogateSelector surrogateSelector, StreamingContext context, SerObjectInfoInit serObjectInfoInit, IFormatterConverter converter, ObjectWriter objectWriter, SerializationBinder binder)
	{
		WriteObjectInfo objectInfo = GetObjectInfo(serObjectInfoInit);
		objectInfo.InitSerialize(obj, surrogateSelector, context, serObjectInfoInit, converter, objectWriter, binder);
		return objectInfo;
	}

	internal void InitSerialize(object obj, ISurrogateSelector surrogateSelector, StreamingContext context, SerObjectInfoInit serObjectInfoInit, IFormatterConverter converter, ObjectWriter objectWriter, SerializationBinder binder)
	{
		this.context = context;
		this.obj = obj;
		this.serObjectInfoInit = serObjectInfoInit;
		objectType = obj.GetType();
		if (objectType.IsArray)
		{
			isArray = true;
			InitNoMembers();
			return;
		}
		InvokeSerializationBinder(binder);
		objectWriter.ObjectManager.RegisterObject(obj);
		if (surrogateSelector != null && (serializationSurrogate = surrogateSelector.GetSurrogate(objectType, context, out var _)) != null)
		{
			si = new SerializationInfo(objectType, converter);
			if (!objectType.IsPrimitive)
			{
				serializationSurrogate.GetObjectData(obj, si, context);
			}
			InitSiWrite();
		}
		else if (obj is ISerializable)
		{
			if (!objectType.IsSerializable)
			{
				throw new SerializationException(Environment.GetResourceString("Type '{0}' in Assembly '{1}' is not marked as serializable.", objectType.FullName, objectType.Assembly.FullName));
			}
			si = new SerializationInfo(objectType, converter, !FormatterServices.UnsafeTypeForwardersIsEnabled());
			((ISerializable)obj).GetObjectData(si, context);
			InitSiWrite();
			CheckTypeForwardedFrom(cache, objectType, binderAssemblyString);
		}
		else
		{
			InitMemberInfo();
			CheckTypeForwardedFrom(cache, objectType, binderAssemblyString);
		}
	}

	internal static WriteObjectInfo Serialize(Type objectType, ISurrogateSelector surrogateSelector, StreamingContext context, SerObjectInfoInit serObjectInfoInit, IFormatterConverter converter, SerializationBinder binder)
	{
		WriteObjectInfo objectInfo = GetObjectInfo(serObjectInfoInit);
		objectInfo.InitSerialize(objectType, surrogateSelector, context, serObjectInfoInit, converter, binder);
		return objectInfo;
	}

	internal void InitSerialize(Type objectType, ISurrogateSelector surrogateSelector, StreamingContext context, SerObjectInfoInit serObjectInfoInit, IFormatterConverter converter, SerializationBinder binder)
	{
		this.objectType = objectType;
		this.context = context;
		this.serObjectInfoInit = serObjectInfoInit;
		if (objectType.IsArray)
		{
			InitNoMembers();
			return;
		}
		InvokeSerializationBinder(binder);
		ISurrogateSelector selector = null;
		if (surrogateSelector != null)
		{
			serializationSurrogate = surrogateSelector.GetSurrogate(objectType, context, out selector);
		}
		if (serializationSurrogate != null)
		{
			si = new SerializationInfo(objectType, converter);
			cache = new SerObjectInfoCache(objectType);
			isSi = true;
		}
		else if ((object)objectType != Converter.typeofObject && Converter.typeofISerializable.IsAssignableFrom(objectType))
		{
			si = new SerializationInfo(objectType, converter, !FormatterServices.UnsafeTypeForwardersIsEnabled());
			cache = new SerObjectInfoCache(objectType);
			CheckTypeForwardedFrom(cache, objectType, binderAssemblyString);
			isSi = true;
		}
		if (!isSi)
		{
			InitMemberInfo();
			CheckTypeForwardedFrom(cache, objectType, binderAssemblyString);
		}
	}

	private void InitSiWrite()
	{
		SerializationInfoEnumerator serializationInfoEnumerator = null;
		isSi = true;
		serializationInfoEnumerator = si.GetEnumerator();
		int memberCount = si.MemberCount;
		TypeInformation typeInformation = null;
		string fullTypeName = si.FullTypeName;
		string assemblyName = si.AssemblyName;
		bool hasTypeForwardedFrom = false;
		if (!si.IsFullTypeNameSetExplicit)
		{
			typeInformation = BinaryFormatter.GetTypeInformation(si.ObjectType);
			fullTypeName = typeInformation.FullTypeName;
			hasTypeForwardedFrom = typeInformation.HasTypeForwardedFrom;
		}
		if (!si.IsAssemblyNameSetExplicit)
		{
			if (typeInformation == null)
			{
				typeInformation = BinaryFormatter.GetTypeInformation(si.ObjectType);
			}
			assemblyName = typeInformation.AssemblyString;
			hasTypeForwardedFrom = typeInformation.HasTypeForwardedFrom;
		}
		cache = new SerObjectInfoCache(fullTypeName, assemblyName, hasTypeForwardedFrom);
		cache.memberNames = new string[memberCount];
		cache.memberTypes = new Type[memberCount];
		memberData = new object[memberCount];
		serializationInfoEnumerator = si.GetEnumerator();
		int num = 0;
		while (serializationInfoEnumerator.MoveNext())
		{
			cache.memberNames[num] = serializationInfoEnumerator.Name;
			cache.memberTypes[num] = serializationInfoEnumerator.ObjectType;
			memberData[num] = serializationInfoEnumerator.Value;
			num++;
		}
		isNamed = true;
		isTyped = false;
	}

	private static void CheckTypeForwardedFrom(SerObjectInfoCache cache, Type objectType, string binderAssemblyString)
	{
		if (cache.hasTypeForwardedFrom && binderAssemblyString == null && !FormatterServices.UnsafeTypeForwardersIsEnabled())
		{
			Assembly assembly = objectType.Assembly;
			if (!SerializationInfo.IsAssemblyNameAssignmentSafe(assembly.FullName, cache.assemblyString) && !assembly.IsFullyTrusted)
			{
				throw new SecurityException(Environment.GetResourceString("A type '{0}' that is defined in a partially trusted assembly cannot be type forwarded from an assembly with a different Public Key Token or without a public key token. To fix this, please either turn on unsafeTypeForwarding flag in the configuration file or remove the TypeForwardedFrom attribute.", objectType));
			}
		}
	}

	private void InitNoMembers()
	{
		cache = (SerObjectInfoCache)serObjectInfoInit.seenBeforeTable[objectType];
		if (cache == null)
		{
			cache = new SerObjectInfoCache(objectType);
			serObjectInfoInit.seenBeforeTable.Add(objectType, cache);
		}
	}

	private void InitMemberInfo()
	{
		cache = (SerObjectInfoCache)serObjectInfoInit.seenBeforeTable[objectType];
		if (cache == null)
		{
			cache = new SerObjectInfoCache(objectType);
			cache.memberInfos = FormatterServices.GetSerializableMembers(objectType, context);
			int num = cache.memberInfos.Length;
			cache.memberNames = new string[num];
			cache.memberTypes = new Type[num];
			for (int i = 0; i < num; i++)
			{
				cache.memberNames[i] = cache.memberInfos[i].Name;
				cache.memberTypes[i] = GetMemberType(cache.memberInfos[i]);
			}
			serObjectInfoInit.seenBeforeTable.Add(objectType, cache);
		}
		if (obj != null)
		{
			memberData = FormatterServices.GetObjectData(obj, cache.memberInfos);
		}
		isTyped = true;
		isNamed = true;
	}

	internal string GetTypeFullName()
	{
		return binderTypeName ?? cache.fullTypeName;
	}

	internal string GetAssemblyString()
	{
		return binderAssemblyString ?? cache.assemblyString;
	}

	private void InvokeSerializationBinder(SerializationBinder binder)
	{
		binder?.BindToName(objectType, out binderAssemblyString, out binderTypeName);
	}

	internal Type GetMemberType(MemberInfo objMember)
	{
		Type type = null;
		if (objMember is FieldInfo)
		{
			return ((FieldInfo)objMember).FieldType;
		}
		if (objMember is PropertyInfo)
		{
			return ((PropertyInfo)objMember).PropertyType;
		}
		throw new SerializationException(Environment.GetResourceString("MemberInfo type {0} cannot be serialized.", objMember.GetType()));
	}

	internal void GetMemberInfo(out string[] outMemberNames, out Type[] outMemberTypes, out object[] outMemberData)
	{
		outMemberNames = cache.memberNames;
		outMemberTypes = cache.memberTypes;
		outMemberData = memberData;
		if (isSi && !isNamed)
		{
			throw new SerializationException(Environment.GetResourceString("MemberInfo requested for ISerializable type."));
		}
	}

	private static WriteObjectInfo GetObjectInfo(SerObjectInfoInit serObjectInfoInit)
	{
		WriteObjectInfo writeObjectInfo = null;
		if (!serObjectInfoInit.oiPool.IsEmpty())
		{
			writeObjectInfo = (WriteObjectInfo)serObjectInfoInit.oiPool.Pop();
			writeObjectInfo.InternalInit();
		}
		else
		{
			writeObjectInfo = new WriteObjectInfo();
			writeObjectInfo.objectInfoId = serObjectInfoInit.objectInfoIdCount++;
		}
		return writeObjectInfo;
	}

	private static void PutObjectInfo(SerObjectInfoInit serObjectInfoInit, WriteObjectInfo objectInfo)
	{
		serObjectInfoInit.oiPool.Push(objectInfo);
	}
}
