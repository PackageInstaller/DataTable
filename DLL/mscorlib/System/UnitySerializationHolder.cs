using System.Collections.Generic;
using System.Reflection;
using System.Runtime.Serialization;

namespace System;

[Serializable]
internal class UnitySerializationHolder : ISerializable, IObjectReference
{
	private Type[] m_instantiation;

	private int[] m_elementTypes;

	private int m_genericParameterPosition;

	private Type m_declaringType;

	private MethodBase m_declaringMethod;

	private string m_data;

	private string m_assemblyName;

	private int m_unityType;

	internal static RuntimeType AddElementTypes(SerializationInfo info, RuntimeType type)
	{
		List<int> list = new List<int>();
		while (type.HasElementType)
		{
			if (type.IsSzArray)
			{
				list.Add(3);
			}
			else if (type.IsArray)
			{
				list.Add(type.GetArrayRank());
				list.Add(2);
			}
			else if (type.IsPointer)
			{
				list.Add(1);
			}
			else if (type.IsByRef)
			{
				list.Add(4);
			}
			type = (RuntimeType)type.GetElementType();
		}
		info.AddValue("ElementTypes", list.ToArray(), typeof(int[]));
		return type;
	}

	internal Type MakeElementTypes(Type type)
	{
		for (int num = m_elementTypes.Length - 1; num >= 0; num--)
		{
			if (m_elementTypes[num] == 3)
			{
				type = type.MakeArrayType();
			}
			else if (m_elementTypes[num] == 2)
			{
				type = type.MakeArrayType(m_elementTypes[--num]);
			}
			else if (m_elementTypes[num] == 1)
			{
				type = type.MakePointerType();
			}
			else if (m_elementTypes[num] == 4)
			{
				type = type.MakeByRefType();
			}
		}
		return type;
	}

	internal static void GetUnitySerializationInfo(SerializationInfo info, int unityType)
	{
		info.SetType(typeof(UnitySerializationHolder));
		info.AddValue("Data", null, typeof(string));
		info.AddValue("UnityType", unityType);
		info.AddValue("AssemblyName", string.Empty);
	}

	internal static void GetUnitySerializationInfo(SerializationInfo info, RuntimeType type)
	{
		if (type.GetRootElementType().IsGenericParameter)
		{
			type = AddElementTypes(info, type);
			info.SetType(typeof(UnitySerializationHolder));
			info.AddValue("UnityType", 7);
			info.AddValue("GenericParameterPosition", type.GenericParameterPosition);
			info.AddValue("DeclaringMethod", type.DeclaringMethod, typeof(MethodBase));
			info.AddValue("DeclaringType", type.DeclaringType, typeof(Type));
			return;
		}
		int unityType = 4;
		if (!type.IsGenericTypeDefinition && type.ContainsGenericParameters)
		{
			unityType = 8;
			type = AddElementTypes(info, type);
			info.AddValue("GenericArguments", type.GetGenericArguments(), typeof(Type[]));
			type = (RuntimeType)type.GetGenericTypeDefinition();
		}
		GetUnitySerializationInfo(info, unityType, type.FullName, type.GetRuntimeAssembly());
	}

	internal static void GetUnitySerializationInfo(SerializationInfo info, int unityType, string data, RuntimeAssembly assembly)
	{
		info.SetType(typeof(UnitySerializationHolder));
		info.AddValue("Data", data, typeof(string));
		info.AddValue("UnityType", unityType);
		string value = ((!(assembly == null)) ? assembly.FullName : string.Empty);
		info.AddValue("AssemblyName", value);
	}

	internal UnitySerializationHolder(SerializationInfo info, StreamingContext context)
	{
		if (info == null)
		{
			throw new ArgumentNullException("info");
		}
		m_unityType = info.GetInt32("UnityType");
		if (m_unityType == 3)
		{
			return;
		}
		if (m_unityType == 7)
		{
			m_declaringMethod = info.GetValue("DeclaringMethod", typeof(MethodBase)) as MethodBase;
			m_declaringType = info.GetValue("DeclaringType", typeof(Type)) as Type;
			m_genericParameterPosition = info.GetInt32("GenericParameterPosition");
			m_elementTypes = info.GetValue("ElementTypes", typeof(int[])) as int[];
			return;
		}
		if (m_unityType == 8)
		{
			m_instantiation = info.GetValue("GenericArguments", typeof(Type[])) as Type[];
			m_elementTypes = info.GetValue("ElementTypes", typeof(int[])) as int[];
		}
		m_data = info.GetString("Data");
		m_assemblyName = info.GetString("AssemblyName");
	}

	private void ThrowInsufficientInformation(string field)
	{
		throw new SerializationException(Environment.GetResourceString("Insufficient state to deserialize the object. Missing field '{0}'. More information is needed.", field));
	}

	public virtual void GetObjectData(SerializationInfo info, StreamingContext context)
	{
		throw new NotSupportedException(Environment.GetResourceString("The UnitySerializationHolder object is designed to transmit information about other types and is not serializable itself."));
	}

	public virtual object GetRealObject(StreamingContext context)
	{
		switch (m_unityType)
		{
		case 1:
			return Empty.Value;
		case 2:
			return DBNull.Value;
		case 3:
			return Missing.Value;
		case 8:
		{
			m_unityType = 4;
			Type type = GetRealObject(context) as Type;
			m_unityType = 8;
			if (m_instantiation[0] == null)
			{
				return null;
			}
			return MakeElementTypes(type.MakeGenericType(m_instantiation));
		}
		case 7:
			if (m_declaringMethod == null && m_declaringType == null)
			{
				ThrowInsufficientInformation("DeclaringMember");
			}
			if (m_declaringMethod != null)
			{
				return m_declaringMethod.GetGenericArguments()[m_genericParameterPosition];
			}
			return MakeElementTypes(m_declaringType.GetGenericArguments()[m_genericParameterPosition]);
		case 4:
			if (m_data == null || m_data.Length == 0)
			{
				ThrowInsufficientInformation("Data");
			}
			if (m_assemblyName == null)
			{
				ThrowInsufficientInformation("AssemblyName");
			}
			if (m_assemblyName.Length == 0)
			{
				return Type.GetType(m_data, throwOnError: true, ignoreCase: false);
			}
			return Assembly.Load(m_assemblyName).GetType(m_data, throwOnError: true, ignoreCase: false);
		case 5:
		{
			if (m_data == null || m_data.Length == 0)
			{
				ThrowInsufficientInformation("Data");
			}
			if (m_assemblyName == null)
			{
				ThrowInsufficientInformation("AssemblyName");
			}
			Module module = Assembly.Load(m_assemblyName).GetModule(m_data);
			if (module == null)
			{
				throw new SerializationException(Environment.GetResourceString("The given module {0} cannot be found within the assembly {1}.", m_data, m_assemblyName));
			}
			return module;
		}
		case 6:
			if (m_data == null || m_data.Length == 0)
			{
				ThrowInsufficientInformation("Data");
			}
			if (m_assemblyName == null)
			{
				ThrowInsufficientInformation("AssemblyName");
			}
			return Assembly.Load(m_assemblyName);
		default:
			throw new ArgumentException(Environment.GetResourceString("Invalid Unity type."));
		}
	}
}
