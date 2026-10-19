using System;
using System.Collections.Generic;
using System.Linq;
using System.Reflection;
using System.Runtime.CompilerServices;
using Sirenix.Serialization.Utilities;

namespace Sirenix.Serialization;

public class DefaultSerializationBinder : TwoWaySerializationBinder
{
	private static readonly object ASSEMBLY_LOOKUP_LOCK;

	private static readonly Dictionary<string, Assembly> assemblyNameLookUp;

	private static readonly Dictionary<string, Type> customTypeNameToTypeBindings;

	private static readonly object TYPETONAME_LOCK;

	private static readonly Dictionary<Type, string> nameMap;

	private static readonly object NAMETOTYPE_LOCK;

	private static readonly Dictionary<string, Type> typeMap;

	private static readonly object ASSEMBLY_REGISTER_QUEUE_LOCK;

	private static readonly List<Assembly> assembliesQueuedForRegister;

	private static readonly List<AssemblyLoadEventArgs> assemblyLoadEventsQueuedForRegister;

	static DefaultSerializationBinder()
	{
		ASSEMBLY_LOOKUP_LOCK = new object();
		assemblyNameLookUp = new Dictionary<string, Assembly>();
		customTypeNameToTypeBindings = new Dictionary<string, Type>();
		TYPETONAME_LOCK = new object();
		nameMap = new Dictionary<Type, string>(FastTypeComparer.Instance);
		NAMETOTYPE_LOCK = new object();
		typeMap = new Dictionary<string, Type>();
		ASSEMBLY_REGISTER_QUEUE_LOCK = new object();
		assembliesQueuedForRegister = new List<Assembly>();
		assemblyLoadEventsQueuedForRegister = new List<AssemblyLoadEventArgs>();
		AppDomain.CurrentDomain.AssemblyLoad += (object sender, AssemblyLoadEventArgs args) =>
		{
			lock (ASSEMBLY_REGISTER_QUEUE_LOCK)
			{
				assemblyLoadEventsQueuedForRegister.Add(args);
			}
		};
		Assembly[] assemblies = AppDomain.CurrentDomain.GetAssemblies();
		foreach (Assembly item in assemblies)
		{
			lock (ASSEMBLY_REGISTER_QUEUE_LOCK)
			{
				assembliesQueuedForRegister.Add(item);
			}
		}
		lock (ASSEMBLY_LOOKUP_LOCK)
		{
			customTypeNameToTypeBindings["System.Reflection.MonoMethod"] = typeof(MethodInfo);
			customTypeNameToTypeBindings["System.Reflection.MonoMethod, mscorlib"] = typeof(MethodInfo);
		}
	}

	private static void RegisterAllQueuedAssembliesRepeating()
	{
		while (RegisterQueuedAssemblies())
		{
		}
		while (RegisterQueuedAssemblyLoadEvents())
		{
		}
	}

	private static bool RegisterQueuedAssemblies()
	{
		Assembly[] array = null;
		lock (ASSEMBLY_REGISTER_QUEUE_LOCK)
		{
			if (assembliesQueuedForRegister.Count > 0)
			{
				array = assembliesQueuedForRegister.ToArray();
				assembliesQueuedForRegister.Clear();
			}
		}
		if (array == null)
		{
			return false;
		}
		for (int i = 0; i < array.Length; i++)
		{
			RegisterAssembly(array[i]);
		}
		return true;
	}

	private static bool RegisterQueuedAssemblyLoadEvents()
	{
		AssemblyLoadEventArgs[] array = null;
		lock (ASSEMBLY_REGISTER_QUEUE_LOCK)
		{
			if (assemblyLoadEventsQueuedForRegister.Count > 0)
			{
				array = assemblyLoadEventsQueuedForRegister.ToArray();
				assemblyLoadEventsQueuedForRegister.Clear();
			}
		}
		if (array == null)
		{
			return false;
		}
		foreach (AssemblyLoadEventArgs e in array)
		{
			Assembly loadedAssembly;
			try
			{
				loadedAssembly = e.LoadedAssembly;
			}
			catch
			{
				continue;
			}
			RegisterAssembly(loadedAssembly);
		}
		return true;
	}

	private static void RegisterAssembly(Assembly assembly)
	{
		string name;
		try
		{
			name = assembly.GetName().Name;
		}
		catch
		{
			return;
		}
		bool flag = false;
		lock (ASSEMBLY_LOOKUP_LOCK)
		{
			if (!assemblyNameLookUp.ContainsKey(name))
			{
				assemblyNameLookUp.Add(name, assembly);
				flag = true;
			}
		}
		if (!flag)
		{
			return;
		}
		try
		{
			object[] array = assembly.SafeGetCustomAttributes(typeof(BindTypeNameToTypeAttribute), inherit: false);
			if (array == null)
			{
				return;
			}
			for (int i = 0; i < array.Length; i++)
			{
				if (array[i] is BindTypeNameToTypeAttribute bindTypeNameToTypeAttribute && bindTypeNameToTypeAttribute.NewType != null)
				{
					lock (ASSEMBLY_LOOKUP_LOCK)
					{
						customTypeNameToTypeBindings[bindTypeNameToTypeAttribute.OldTypeName] = bindTypeNameToTypeAttribute.NewType;
					}
				}
			}
		}
		catch
		{
		}
	}

	public override string BindToName(Type type, DebugContext debugContext = null)
	{
		if (type == null)
		{
			throw new ArgumentNullException("type");
		}
		string value;
		lock (TYPETONAME_LOCK)
		{
			if (!nameMap.TryGetValue(type, out value))
			{
				if (!type.IsGenericType)
				{
					value = ((!type.IsDefined(typeof(CompilerGeneratedAttribute), inherit: false)) ? (type.FullName + ", " + type.Assembly.GetName().Name) : (type.FullName + ", " + type.Assembly.GetName().Name));
				}
				else
				{
					List<Type> list = type.GetGenericArguments().ToList();
					HashSet<Assembly> hashSet = new HashSet<Assembly>();
					while (list.Count > 0)
					{
						Type type2 = list[0];
						if (type2.IsGenericType)
						{
							list.AddRange(type2.GetGenericArguments());
						}
						hashSet.Add(type2.Assembly);
						list.RemoveAt(0);
					}
					value = type.FullName + ", " + type.Assembly.GetName().Name;
					foreach (Assembly item in hashSet)
					{
						value = value.Replace(item.FullName, item.GetName().Name);
					}
				}
				nameMap.Add(type, value);
			}
		}
		return value;
	}

	public override bool ContainsType(string typeName)
	{
		lock (NAMETOTYPE_LOCK)
		{
			return typeMap.ContainsKey(typeName);
		}
	}

	public override Type BindToType(string typeName, DebugContext debugContext = null)
	{
		if (typeName == null)
		{
			throw new ArgumentNullException("typeName");
		}
		RegisterAllQueuedAssembliesRepeating();
		Type value;
		lock (NAMETOTYPE_LOCK)
		{
			if (!typeMap.TryGetValue(typeName, out value))
			{
				value = ParseTypeName(typeName, debugContext);
				if (value == null)
				{
					debugContext?.LogWarning("Failed deserialization type lookup for type name '" + typeName + "'.");
				}
				typeMap.Add(typeName, value);
			}
		}
		return value;
	}

	private Type ParseTypeName(string typeName, DebugContext debugContext)
	{
		Type value;
		lock (ASSEMBLY_LOOKUP_LOCK)
		{
			if (customTypeNameToTypeBindings.TryGetValue(typeName, out value))
			{
				return value;
			}
		}
		value = Type.GetType(typeName);
		if (value != null)
		{
			return value;
		}
		value = ParseGenericAndOrArrayType(typeName, debugContext);
		if (value != null)
		{
			return value;
		}
		ParseName(typeName, out var typeName2, out var assemblyName);
		if (!string.IsNullOrEmpty(typeName2))
		{
			lock (ASSEMBLY_LOOKUP_LOCK)
			{
				if (customTypeNameToTypeBindings.TryGetValue(typeName2, out value))
				{
					return value;
				}
			}
			if (assemblyName != null)
			{
				Assembly value2;
				lock (ASSEMBLY_LOOKUP_LOCK)
				{
					assemblyNameLookUp.TryGetValue(assemblyName, out value2);
				}
				if (value2 == null)
				{
					try
					{
						value2 = Assembly.Load(assemblyName);
					}
					catch
					{
					}
				}
				if (value2 != null)
				{
					try
					{
						value = value2.GetType(typeName2);
					}
					catch
					{
					}
					if (value != null)
					{
						return value;
					}
				}
			}
			Assembly[] assemblies = AppDomain.CurrentDomain.GetAssemblies();
			foreach (Assembly value2 in assemblies)
			{
				try
				{
					value = value2.GetType(typeName2, throwOnError: false);
				}
				catch
				{
				}
				if (value != null)
				{
					return value;
				}
			}
		}
		return null;
	}

	private static void ParseName(string fullName, out string typeName, out string assemblyName)
	{
		typeName = null;
		assemblyName = null;
		int num = fullName.IndexOf(',');
		if (num < 0 || num + 1 == fullName.Length)
		{
			typeName = fullName.Trim(',', ' ');
			return;
		}
		typeName = fullName.Substring(0, num);
		int num2 = fullName.IndexOf(',', num + 1);
		if (num2 < 0)
		{
			assemblyName = fullName.Substring(num).Trim(',', ' ');
		}
		else
		{
			assemblyName = fullName.Substring(num, num2 - num).Trim(',', ' ');
		}
	}

	private Type ParseGenericAndOrArrayType(string typeName, DebugContext debugContext)
	{
		if (!TryParseGenericAndOrArrayTypeName(typeName, out var actualTypeName, out var isGeneric, out var genericArgNames, out var isArray, out var arrayRank))
		{
			return null;
		}
		Type type = BindToType(actualTypeName, debugContext);
		if (type == null)
		{
			return null;
		}
		if (isGeneric)
		{
			if (!type.IsGenericType)
			{
				return null;
			}
			using Cache<List<Type>> cache = Cache<List<Type>>.Claim();
			List<Type> value = cache.Value;
			value.Clear();
			for (int i = 0; i < genericArgNames.Count; i++)
			{
				Type type2 = BindToType(genericArgNames[i], debugContext);
				if (type2 == null)
				{
					return null;
				}
				value.Add(type2);
			}
			Type[] array = value.ToArray();
			if (!type.AreGenericConstraintsSatisfiedBy(array))
			{
				if (debugContext != null)
				{
					string text = "";
					Type[] array2 = array;
					foreach (Type type3 in array2)
					{
						if (text != "")
						{
							text += ", ";
						}
						text += type3.GetNiceFullName();
					}
					debugContext.LogWarning("Deserialization type lookup failure: The generic type arguments '" + text + "' do not satisfy the generic constraints of generic type definition '" + type.GetNiceFullName() + "'. All this parsed from the full type name string: '" + typeName + "'");
				}
				return null;
			}
			type = type.MakeGenericType(array);
			value.Clear();
		}
		if (isArray)
		{
			type = ((arrayRank != 1) ? type.MakeArrayType(arrayRank) : type.MakeArrayType());
		}
		return type;
	}

	private static bool TryParseGenericAndOrArrayTypeName(string typeName, out string actualTypeName, out bool isGeneric, out List<string> genericArgNames, out bool isArray, out int arrayRank)
	{
		isGeneric = false;
		isArray = false;
		arrayRank = 0;
		bool flag = false;
		genericArgNames = null;
		actualTypeName = null;
		for (int i = 0; i < typeName.Length; i++)
		{
			if (typeName[i] == '[')
			{
				char c = Peek(typeName, i, 1);
				if (c == ',' || c == ']')
				{
					if (actualTypeName == null)
					{
						actualTypeName = typeName.Substring(0, i);
					}
					isArray = true;
					arrayRank = 1;
					i++;
					if (c != ',')
					{
						continue;
					}
					while (true)
					{
						switch (c)
						{
						case ',':
							goto IL_005f;
						default:
							return false;
						case ']':
							break;
						}
						break;
						IL_005f:
						arrayRank++;
						c = Peek(typeName, i, 1);
						i++;
					}
				}
				else if (!isGeneric)
				{
					actualTypeName = typeName.Substring(0, i);
					isGeneric = true;
					flag = true;
					genericArgNames = new List<string>();
				}
				else
				{
					if (!isGeneric || !ReadGenericArg(typeName, ref i, out var argName))
					{
						return false;
					}
					genericArgNames.Add(argName);
				}
			}
			else if (typeName[i] == ']')
			{
				if (!flag)
				{
					return false;
				}
				flag = false;
			}
			else if (typeName[i] == ',' && !flag)
			{
				actualTypeName += typeName.Substring(i);
				break;
			}
		}
		return isArray | isGeneric;
	}

	private static char Peek(string str, int i, int ahead)
	{
		if (i + ahead < str.Length)
		{
			return str[i + ahead];
		}
		return '\0';
	}

	private static bool ReadGenericArg(string typeName, ref int i, out string argName)
	{
		argName = null;
		if (typeName[i] != '[')
		{
			return false;
		}
		int num = i + 1;
		int num2 = 0;
		while (i < typeName.Length)
		{
			if (typeName[i] == '[')
			{
				num2++;
			}
			else if (typeName[i] == ']')
			{
				num2--;
				if (num2 == 0)
				{
					int length = i - num;
					argName = typeName.Substring(num, length);
					return true;
				}
			}
			i++;
		}
		return false;
	}
}
