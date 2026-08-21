using System;
using System.Collections.Generic;
using System.Reflection;
using GameFramework;
using GameFramework.Network;

namespace Ase;

public class NetCodes : Singleton<NetCodes>
{
	private readonly UnOrderMultiMapSet<Type, Type> types = new UnOrderMultiMapSet<Type, Type>();

	private readonly DoubleMap<Type, ushort> typeOpcode = new DoubleMap<Type, ushort>();

	public void Init(Assembly assembly)
	{
		Add(Utility.Assembly.GetAssemblyTypes(assembly));
		foreach (Type type in GetTypes(typeof(MessageAttribute)))
		{
			object[] customAttributes = type.GetCustomAttributes(typeof(MessageAttribute), inherit: false);
			if (customAttributes.Length != 0 && customAttributes[0] is MessageAttribute messageAttribute)
			{
				typeOpcode.Add(type, messageAttribute.Opcode);
			}
		}
	}

	public void Add(Dictionary<string, Type> addTypes)
	{
		types.Clear();
		foreach (KeyValuePair<string, Type> addType in addTypes)
		{
			if (!addType.Value.IsAbstract)
			{
				object[] customAttributes = addType.Value.GetCustomAttributes(typeof(BaseAttribute), inherit: true);
				foreach (object obj in customAttributes)
				{
					types.Add(obj.GetType(), addType.Value);
				}
			}
		}
	}

	public HashSet<Type> GetTypes(Type systemAttributeType)
	{
		if (!types.ContainsKey(systemAttributeType))
		{
			return new HashSet<Type>();
		}
		return types[systemAttributeType];
	}

	public ushort GetOpcode(Type type)
	{
		return typeOpcode.GetValueByKey(type);
	}

	public Type GetType(ushort opcode)
	{
		return typeOpcode.GetKeyByValue(opcode);
	}
}
