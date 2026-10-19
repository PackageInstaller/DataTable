using System;
using System.Collections.Generic;
using System.Linq;
using System.Reflection;
using System.Runtime.Serialization;
using UnityEngine;

namespace Unity.VisualScripting;

public static class RuntimeCodebase
{
	private static readonly object @lock;

	private static readonly List<Type> _types;

	private static readonly List<Assembly> _assemblies;

	public static HashSet<string> disallowedAssemblies;

	private static readonly Dictionary<string, Type> typeSerializations;

	private static Dictionary<string, Type> _renamedTypes;

	private static Dictionary<string, string> _renamedNamespaces;

	private static Dictionary<string, string> _renamedAssemblies;

	private static readonly Dictionary<Type, Dictionary<string, string>> _renamedMembers;

	public static IEnumerable<Type> types => _types;

	public static IEnumerable<Assembly> assemblies => _assemblies;

	public static Dictionary<string, string> renamedNamespaces
	{
		get
		{
			if (_renamedNamespaces == null)
			{
				_renamedNamespaces = FetchRenamedNamespaces();
			}
			return _renamedNamespaces;
		}
	}

	public static Dictionary<string, string> renamedAssemblies
	{
		get
		{
			if (_renamedAssemblies == null)
			{
				_renamedAssemblies = FetchRenamedAssemblies();
			}
			return _renamedAssemblies;
		}
	}

	public static Dictionary<string, Type> renamedTypes
	{
		get
		{
			if (_renamedTypes == null)
			{
				_renamedTypes = FetchRenamedTypes();
			}
			return _renamedTypes;
		}
	}

	static RuntimeCodebase()
	{
		@lock = new object();
		_types = new List<Type>();
		_assemblies = new List<Assembly>();
		disallowedAssemblies = new HashSet<string>();
		typeSerializations = new Dictionary<string, Type>();
		_renamedTypes = null;
		_renamedNamespaces = null;
		_renamedAssemblies = null;
		_renamedMembers = new Dictionary<Type, Dictionary<string, string>>();
		lock (@lock)
		{
			Assembly[] array = AppDomain.CurrentDomain.GetAssemblies();
			foreach (Assembly assembly in array)
			{
				_assemblies.Add(assembly);
				foreach (Type item in assembly.GetTypesSafely())
				{
					_types.Add(item);
				}
			}
		}
	}

	public static void AddHotUpdateAssembly(Assembly[] assemblies)
	{
		lock (@lock)
		{
			foreach (Assembly assembly in assemblies)
			{
				_assemblies.Add(assembly);
				foreach (Type item in assembly.GetTypesSafely())
				{
					_types.Add(item);
				}
			}
		}
	}

	public static IEnumerable<Attribute> GetAssemblyAttributes(Type attributeType)
	{
		return GetAssemblyAttributes(attributeType, assemblies);
	}

	public static IEnumerable<Attribute> GetAssemblyAttributes(Type attributeType, IEnumerable<Assembly> assemblies)
	{
		Ensure.That("attributeType").IsNotNull(attributeType);
		Ensure.That("assemblies").IsNotNull(assemblies);
		foreach (Assembly assembly in assemblies)
		{
			foreach (Attribute customAttribute in assembly.GetCustomAttributes(attributeType))
			{
				if (attributeType.IsInstanceOfType(customAttribute))
				{
					yield return customAttribute;
				}
			}
		}
	}

	public static IEnumerable<TAttribute> GetAssemblyAttributes<TAttribute>(IEnumerable<Assembly> assemblies) where TAttribute : Attribute
	{
		return GetAssemblyAttributes(typeof(TAttribute), assemblies).Cast<TAttribute>();
	}

	public static IEnumerable<TAttribute> GetAssemblyAttributes<TAttribute>() where TAttribute : Attribute
	{
		return GetAssemblyAttributes(typeof(TAttribute)).Cast<TAttribute>();
	}

	public static void PrewarmTypeDeserialization(Type type)
	{
		Ensure.That("type").IsNotNull(type);
		string key = SerializeType(type);
		if (!typeSerializations.ContainsKey(key))
		{
			typeSerializations.Add(key, type);
		}
	}

	public static string SerializeType(Type type)
	{
		Ensure.That("type").IsNotNull(type);
		return type?.FullName;
	}

	public static bool TryDeserializeType(string typeName, out Type type)
	{
		if (string.IsNullOrEmpty(typeName))
		{
			type = null;
			return false;
		}
		lock (@lock)
		{
			if (!TryCachedTypeLookup(typeName, out type))
			{
				if (!TrySystemTypeLookup(typeName, out type) && !TryRenamedTypeLookup(typeName, out type))
				{
					return false;
				}
				typeSerializations.Add(typeName, type);
			}
			return true;
		}
	}

	public static Type DeserializeType(string typeName)
	{
		if (!TryDeserializeType(typeName, out var type))
		{
			throw new SerializationException("Unable to find type: '" + (typeName ?? "(null)") + "'.");
		}
		return type;
	}

	public static void ClearCachedTypes()
	{
		typeSerializations.Clear();
	}

	private static bool TryCachedTypeLookup(string typeName, out Type type)
	{
		return typeSerializations.TryGetValue(typeName, out type);
	}

	private static bool TrySystemTypeLookup(string typeName, out Type type)
	{
		foreach (Assembly assembly in _assemblies)
		{
			if (disallowedAssemblies.Contains(assembly.GetName().Name))
			{
				continue;
			}
			type = assembly.GetType(typeName);
			if (!(type != null))
			{
				continue;
			}
			foreach (string disallowedAssembly in disallowedAssemblies)
			{
				if (type.FullName.Contains(disallowedAssembly))
				{
					return false;
				}
			}
			return true;
		}
		type = null;
		return false;
	}

	private static bool TrySystemTypeLookup(TypeName typeName, out Type type)
	{
		if (disallowedAssemblies.Contains(typeName.AssemblyName))
		{
			type = null;
			return false;
		}
		if (typeName.IsArray)
		{
			foreach (Assembly item in _assemblies.Where((Assembly a) => typeName.AssemblyName == a.GetName().Name))
			{
				type = item.GetType(typeName.Name);
				if (type != null)
				{
					return true;
				}
			}
			type = null;
			return false;
		}
		return TrySystemTypeLookup(typeName.ToLooseString(), out type);
	}

	private static bool TryRenamedTypeLookup(string previousTypeName, out Type type)
	{
		if (renamedTypes.TryGetValue(previousTypeName, out var value))
		{
			type = value;
			return true;
		}
		TypeName typeName = TypeName.Parse(previousTypeName);
		foreach (KeyValuePair<string, Type> renamedType in renamedTypes)
		{
			typeName.ReplaceName(renamedType.Key, renamedType.Value);
		}
		foreach (KeyValuePair<string, string> renamedNamespace in renamedNamespaces)
		{
			typeName.ReplaceNamespace(renamedNamespace.Key, renamedNamespace.Value);
		}
		foreach (KeyValuePair<string, string> renamedAssembly in renamedAssemblies)
		{
			typeName.ReplaceAssembly(renamedAssembly.Key, renamedAssembly.Value);
		}
		if (TrySystemTypeLookup(typeName, out type))
		{
			return true;
		}
		type = null;
		return false;
	}

	public static Dictionary<string, string> RenamedMembers(Type type)
	{
		if (!_renamedMembers.TryGetValue(type, out var value))
		{
			value = FetchRenamedMembers(type);
			_renamedMembers.Add(type, value);
		}
		return value;
	}

	private static Dictionary<string, string> FetchRenamedMembers(Type type)
	{
		Ensure.That("type").IsNotNull(type);
		Dictionary<string, string> dictionary = new Dictionary<string, string>();
		MemberInfo[] extendedMembers = type.GetExtendedMembers(BindingFlags.Instance | BindingFlags.Static | BindingFlags.Public | BindingFlags.NonPublic | BindingFlags.FlattenHierarchy);
		foreach (MemberInfo memberInfo in extendedMembers)
		{
			IEnumerable<RenamedFromAttribute> enumerable;
			try
			{
				enumerable = Attribute.GetCustomAttributes(memberInfo, typeof(RenamedFromAttribute), inherit: false).Cast<RenamedFromAttribute>();
			}
			catch (Exception arg)
			{
				Debug.LogWarning($"Failed to fetch RenamedFrom attributes for member '{memberInfo}':\n{arg}");
				continue;
			}
			string name = memberInfo.Name;
			foreach (RenamedFromAttribute item in enumerable)
			{
				string previousName = item.previousName;
				if (dictionary.ContainsKey(previousName))
				{
					Debug.LogWarning($"Multiple members on '{type}' indicate having been renamed from '{previousName}'.\nIgnoring renamed attributes for '{memberInfo}'.");
				}
				else
				{
					dictionary.Add(previousName, name);
				}
			}
		}
		return dictionary;
	}

	private static Dictionary<string, string> FetchRenamedNamespaces()
	{
		Dictionary<string, string> dictionary = new Dictionary<string, string>();
		foreach (RenamedNamespaceAttribute assemblyAttribute in GetAssemblyAttributes<RenamedNamespaceAttribute>())
		{
			string previousName = assemblyAttribute.previousName;
			string newName = assemblyAttribute.newName;
			if (dictionary.ContainsKey(previousName))
			{
				Debug.LogWarning("Multiple new names have been provided for namespace '" + previousName + "'.\nIgnoring new name '" + newName + "'.");
			}
			else
			{
				dictionary.Add(previousName, newName);
			}
		}
		return dictionary;
	}

	private static Dictionary<string, string> FetchRenamedAssemblies()
	{
		Dictionary<string, string> dictionary = new Dictionary<string, string>();
		foreach (RenamedAssemblyAttribute assemblyAttribute in GetAssemblyAttributes<RenamedAssemblyAttribute>())
		{
			string previousName = assemblyAttribute.previousName;
			string newName = assemblyAttribute.newName;
			if (dictionary.ContainsKey(previousName))
			{
				Debug.LogWarning("Multiple new names have been provided for assembly '" + previousName + "'.\nIgnoring new name '" + newName + "'.");
			}
			else
			{
				dictionary.Add(previousName, newName);
			}
		}
		return dictionary;
	}

	private static Dictionary<string, Type> FetchRenamedTypes()
	{
		Dictionary<string, Type> dictionary = new Dictionary<string, Type>();
		foreach (Assembly assembly in assemblies)
		{
			foreach (Type item in assembly.GetTypesSafely())
			{
				IEnumerable<RenamedFromAttribute> enumerable;
				try
				{
					enumerable = Attribute.GetCustomAttributes(item, typeof(RenamedFromAttribute), inherit: false).Cast<RenamedFromAttribute>();
				}
				catch (Exception arg)
				{
					Debug.LogWarning($"Failed to fetch RenamedFrom attributes for type '{item}':\n{arg}");
					continue;
				}
				_ = item.FullName;
				foreach (RenamedFromAttribute item2 in enumerable)
				{
					string previousName = item2.previousName;
					if (dictionary.ContainsKey(previousName))
					{
						Debug.LogWarning($"Multiple types indicate having been renamed from '{previousName}'.\nIgnoring renamed attributes for '{item}'.");
					}
					else
					{
						dictionary.Add(previousName, item);
					}
				}
			}
		}
		return dictionary;
	}
}
