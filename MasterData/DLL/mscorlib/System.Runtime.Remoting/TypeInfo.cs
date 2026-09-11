namespace System.Runtime.Remoting;

[Serializable]
internal class TypeInfo : IRemotingTypeInfo
{
	private string serverType;

	private string[] serverHierarchy;

	private string[] interfacesImplemented;

	public string TypeName => serverType;

	public TypeInfo(Type type)
	{
		if (type.IsInterface)
		{
			serverType = typeof(MarshalByRefObject).AssemblyQualifiedName;
			serverHierarchy = new string[0];
			Type[] interfaces = type.GetInterfaces();
			interfacesImplemented = new string[interfaces.Length + 1];
			for (int i = 0; i < interfaces.Length; i++)
			{
				interfacesImplemented[i] = interfaces[i].AssemblyQualifiedName;
			}
			interfacesImplemented[interfaces.Length] = type.AssemblyQualifiedName;
			return;
		}
		serverType = type.AssemblyQualifiedName;
		int num = 0;
		Type baseType = type.BaseType;
		while (baseType != typeof(MarshalByRefObject) && baseType != null)
		{
			baseType = baseType.BaseType;
			num++;
		}
		serverHierarchy = new string[num];
		baseType = type.BaseType;
		for (int j = 0; j < num; j++)
		{
			serverHierarchy[j] = baseType.AssemblyQualifiedName;
			baseType = baseType.BaseType;
		}
		Type[] interfaces2 = type.GetInterfaces();
		interfacesImplemented = new string[interfaces2.Length];
		for (int k = 0; k < interfaces2.Length; k++)
		{
			interfacesImplemented[k] = interfaces2[k].AssemblyQualifiedName;
		}
	}

	public bool CanCastTo(Type fromType, object o)
	{
		if (fromType == typeof(object))
		{
			return true;
		}
		if (fromType == typeof(MarshalByRefObject))
		{
			return true;
		}
		string assemblyQualifiedName = fromType.AssemblyQualifiedName;
		int num = assemblyQualifiedName.IndexOf(',');
		if (num != -1)
		{
			num = assemblyQualifiedName.IndexOf(',', num + 1);
		}
		assemblyQualifiedName = ((num == -1) ? (assemblyQualifiedName + ",") : assemblyQualifiedName.Substring(0, num + 1));
		if ((serverType + ",").StartsWith(assemblyQualifiedName))
		{
			return true;
		}
		if (serverHierarchy != null)
		{
			string[] array = serverHierarchy;
			for (int i = 0; i < array.Length; i++)
			{
				if ((array[i] + ",").StartsWith(assemblyQualifiedName))
				{
					return true;
				}
			}
		}
		if (interfacesImplemented != null)
		{
			string[] array = interfacesImplemented;
			for (int i = 0; i < array.Length; i++)
			{
				if ((array[i] + ",").StartsWith(assemblyQualifiedName))
				{
					return true;
				}
			}
		}
		return false;
	}
}
