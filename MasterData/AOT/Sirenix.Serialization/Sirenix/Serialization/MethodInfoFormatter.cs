using System;
using System.Linq;
using System.Reflection;
using Sirenix.Serialization.Utilities;

namespace Sirenix.Serialization;

public class MethodInfoFormatter<T> : BaseFormatter<T> where T : MethodInfo
{
	private static readonly Serializer<string> StringSerializer = Serializer.Get<string>();

	private static readonly Serializer<Type> TypeSerializer = Serializer.Get<Type>();

	private static readonly Serializer<Type[]> TypeArraySerializer = Serializer.Get<Type[]>();

	protected override void DeserializeImplementation(ref T value, IDataReader reader)
	{
		EntryType entryType = reader.PeekEntry(out var name);
		if (entryType == EntryType.StartOfArray)
		{
			IFormatter formatter = new WeakSerializableFormatter(typeof(T));
			value = (T)formatter.Deserialize(reader);
			return;
		}
		Type type = null;
		string text = null;
		Type[] array = null;
		Type[] array2 = null;
		while ((entryType = reader.PeekEntry(out name)) != EntryType.EndOfNode && entryType != EntryType.EndOfArray && entryType != EntryType.EndOfStream)
		{
			switch (name)
			{
			case "declaringType":
			{
				Type type2 = TypeSerializer.ReadValue(reader);
				if (type2 != null)
				{
					type = type2;
				}
				break;
			}
			case "methodName":
				text = StringSerializer.ReadValue(reader);
				break;
			case "signature":
				array = TypeArraySerializer.ReadValue(reader);
				break;
			case "genericArguments":
				array2 = TypeArraySerializer.ReadValue(reader);
				break;
			default:
				reader.SkipEntry();
				break;
			}
		}
		if (type == null)
		{
			reader.Context.Config.DebugContext.LogWarning("Missing declaring type of MethodInfo on deserialize.");
			return;
		}
		if (text == null)
		{
			reader.Context.Config.DebugContext.LogError("Missing method name of MethodInfo on deserialize.");
			return;
		}
		bool flag = false;
		bool flag2 = false;
		if (array != null)
		{
			flag = true;
			for (int i = 0; i < array.Length; i++)
			{
				if (array[i] == null)
				{
					flag = false;
					break;
				}
			}
		}
		MethodInfo methodInfo;
		if (flag)
		{
			try
			{
				methodInfo = type.GetMethod(text, BindingFlags.Instance | BindingFlags.Static | BindingFlags.Public | BindingFlags.NonPublic | BindingFlags.FlattenHierarchy, null, array, null);
			}
			catch (AmbiguousMatchException)
			{
				methodInfo = null;
				flag2 = true;
			}
		}
		else
		{
			try
			{
				methodInfo = type.GetMethod(text, BindingFlags.Instance | BindingFlags.Static | BindingFlags.Public | BindingFlags.NonPublic | BindingFlags.FlattenHierarchy);
			}
			catch (AmbiguousMatchException)
			{
				methodInfo = null;
				flag2 = true;
			}
		}
		if (methodInfo == null)
		{
			if (flag)
			{
				reader.Context.Config.DebugContext.LogWarning("Could not find method with signature " + name + "(" + string.Join(", ", array.Select((Type p) => p.GetNiceFullName()).ToArray()) + ") on type '" + type.FullName + (flag2 ? "; resolution was ambiguous between multiple methods" : string.Empty) + ".");
			}
			else
			{
				reader.Context.Config.DebugContext.LogWarning("Could not find method with name " + name + " on type '" + type.GetNiceFullName() + (flag2 ? "; resolution was ambiguous between multiple methods" : string.Empty) + ".");
			}
			return;
		}
		if (methodInfo.IsGenericMethodDefinition)
		{
			if (array2 == null)
			{
				reader.Context.Config.DebugContext.LogWarning("Method '" + type.GetNiceFullName() + "." + methodInfo.GetNiceName() + "' to deserialize is a generic method definition, but no generic arguments were in the serialization data.");
				return;
			}
			int num = methodInfo.GetGenericArguments().Length;
			if (array2.Length != num)
			{
				reader.Context.Config.DebugContext.LogWarning("Method '" + type.GetNiceFullName() + "." + methodInfo.GetNiceName() + "' to deserialize is a generic method definition, but there is the wrong number of generic arguments in the serialization data.");
				return;
			}
			for (int num2 = 0; num2 < array2.Length; num2++)
			{
				if (array2[num2] == null)
				{
					reader.Context.Config.DebugContext.LogWarning("Method '" + type.GetNiceFullName() + "." + methodInfo.GetNiceName() + "' to deserialize is a generic method definition, but one of the serialized generic argument types failed to bind on deserialization.");
					return;
				}
			}
			try
			{
				methodInfo = methodInfo.MakeGenericMethod(array2);
			}
			catch (Exception ex3)
			{
				reader.Context.Config.DebugContext.LogWarning("Method '" + type.GetNiceFullName() + "." + methodInfo.GetNiceName() + "' to deserialize is a generic method definition, but failed to create generic method from definition, using generic arguments '" + string.Join(", ", array2.Select((Type p) => p.GetNiceFullName()).ToArray()) + "'. Method creation failed with an exception of type " + ex3.GetType().GetNiceFullName() + ", with the message: " + ex3.Message);
				return;
			}
		}
		try
		{
			value = (T)methodInfo;
		}
		catch (InvalidCastException)
		{
			reader.Context.Config.DebugContext.LogWarning("The serialized method '" + type.GetNiceFullName() + "." + methodInfo.GetNiceName() + "' was successfully resolved into a MethodInfo reference of the runtime type '" + methodInfo.GetType().GetNiceFullName() + "', but failed to be cast to expected type '" + typeof(T).GetNiceFullName() + "'.");
			return;
		}
		RegisterReferenceID(value, reader);
	}

	protected override void SerializeImplementation(ref T value, IDataWriter writer)
	{
		MethodInfo methodInfo = value;
		if (methodInfo.GetType().Name.Contains("DynamicMethod"))
		{
			writer.Context.Config.DebugContext.LogWarning("Cannot serialize a dynamically emitted method " + methodInfo?.ToString() + ".");
			return;
		}
		if (methodInfo.IsGenericMethodDefinition)
		{
			writer.Context.Config.DebugContext.LogWarning("Serializing a MethodInfo for a generic method definition '" + methodInfo.GetNiceName() + "' is not currently supported.");
			return;
		}
		TypeSerializer.WriteValue("declaringType", methodInfo.DeclaringType, writer);
		StringSerializer.WriteValue("methodName", methodInfo.Name, writer);
		ParameterInfo[] array = ((!methodInfo.IsGenericMethod) ? methodInfo.GetParameters() : methodInfo.GetGenericMethodDefinition().GetParameters());
		Type[] array2 = new Type[array.Length];
		for (int i = 0; i < array2.Length; i++)
		{
			array2[i] = array[i].ParameterType;
		}
		TypeArraySerializer.WriteValue("signature", array2, writer);
		if (methodInfo.IsGenericMethod)
		{
			Type[] genericArguments = methodInfo.GetGenericArguments();
			TypeArraySerializer.WriteValue("genericArguments", genericArguments, writer);
		}
	}

	protected override T GetUninitializedObject()
	{
		return null;
	}
}
