using System;
using System.Collections.Generic;
using System.Reflection;
using Sirenix.Serialization.Utilities;

namespace Sirenix.Serialization;

public class ReflectionFormatter<T> : BaseFormatter<T>
{
	public ISerializationPolicy OverridePolicy { get; private set; }

	public ReflectionFormatter()
	{
	}

	public ReflectionFormatter(ISerializationPolicy overridePolicy)
	{
		OverridePolicy = overridePolicy;
	}

	protected override void DeserializeImplementation(ref T value, IDataReader reader)
	{
		object obj = value;
		Dictionary<string, MemberInfo> serializableMembersMap = FormatterUtilities.GetSerializableMembersMap(typeof(T), OverridePolicy ?? reader.Context.Config.SerializationPolicy);
		EntryType entryType;
		string name;
		while ((entryType = reader.PeekEntry(out name)) != EntryType.EndOfNode && entryType != EntryType.EndOfArray && entryType != EntryType.EndOfStream)
		{
			MemberInfo value2;
			if (string.IsNullOrEmpty(name))
			{
				reader.Context.Config.DebugContext.LogError("Entry of type \"" + entryType.ToString() + "\" in node \"" + reader.CurrentNodeName + "\" is missing a name.");
				reader.SkipEntry();
			}
			else if (!serializableMembersMap.TryGetValue(name, out value2))
			{
				reader.Context.Config.DebugContext.LogWarning("Lost serialization data for entry \"" + name + "\" of type \"" + entryType.ToString() + "\" in node \"" + reader.CurrentNodeName + "\" because a serialized member of that name could not be found in type " + typeof(T).GetNiceFullName() + ".");
				reader.SkipEntry();
			}
			else
			{
				Type containedType = FormatterUtilities.GetContainedType(value2);
				try
				{
					Serializer serializer = Serializer.Get(containedType);
					object value3 = serializer.ReadValueWeak(reader);
					FormatterUtilities.SetMemberValue(value2, obj, value3);
				}
				catch (Exception exception)
				{
					reader.Context.Config.DebugContext.LogException(exception);
				}
			}
		}
		value = (T)obj;
	}

	protected override void SerializeImplementation(ref T value, IDataWriter writer)
	{
		MemberInfo[] serializableMembers = FormatterUtilities.GetSerializableMembers(typeof(T), OverridePolicy ?? writer.Context.Config.SerializationPolicy);
		foreach (MemberInfo memberInfo in serializableMembers)
		{
			object memberValue = FormatterUtilities.GetMemberValue(memberInfo, value);
			Type containedType = FormatterUtilities.GetContainedType(memberInfo);
			Serializer serializer = Serializer.Get(containedType);
			try
			{
				serializer.WriteValueWeak(memberInfo.Name, memberValue, writer);
			}
			catch (Exception exception)
			{
				writer.Context.Config.DebugContext.LogException(exception);
			}
		}
	}
}
