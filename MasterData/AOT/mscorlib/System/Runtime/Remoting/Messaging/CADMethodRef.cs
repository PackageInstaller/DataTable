using System.Reflection;

namespace System.Runtime.Remoting.Messaging;

[Serializable]
internal class CADMethodRef
{
	private bool ctor;

	private string typeName;

	private string methodName;

	private string[] param_names;

	private string[] generic_arg_names;

	private Type[] GetTypes(string[] typeArray)
	{
		Type[] array = new Type[typeArray.Length];
		for (int i = 0; i < typeArray.Length; i++)
		{
			array[i] = Type.GetType(typeArray[i], throwOnError: true);
		}
		return array;
	}

	public MethodBase Resolve()
	{
		Type type = Type.GetType(typeName, throwOnError: true);
		MethodBase methodBase = null;
		Type[] types = GetTypes(param_names);
		methodBase = ((!ctor) ? ((MethodBase)type.GetMethod(methodName, BindingFlags.Instance | BindingFlags.Public | BindingFlags.NonPublic, null, types, null)) : ((MethodBase)type.GetConstructor(BindingFlags.Instance | BindingFlags.Public | BindingFlags.NonPublic, null, types, null)));
		if (methodBase != null && generic_arg_names != null && !methodBase.IsGenericMethodDefinition)
		{
			methodBase = null;
		}
		if (methodBase != null && generic_arg_names != null)
		{
			methodBase = ((MethodInfo)methodBase).MakeGenericMethod(GetTypes(generic_arg_names));
		}
		if (methodBase == null && generic_arg_names != null)
		{
			MethodInfo[] methods = type.GetMethods();
			foreach (MethodInfo methodInfo in methods)
			{
				if (methodInfo.Name != methodName || !methodInfo.IsGenericMethodDefinition || methodInfo.GetGenericArguments().Length != generic_arg_names.Length)
				{
					continue;
				}
				methodBase = methodInfo.MakeGenericMethod(GetTypes(generic_arg_names));
				ParameterInfo[] parameters = methodBase.GetParameters();
				if (param_names.Length != parameters.Length)
				{
					continue;
				}
				for (int j = 0; j < parameters.Length; j++)
				{
					if (parameters[j].ParameterType.AssemblyQualifiedName != param_names[j])
					{
						methodBase = null;
						break;
					}
				}
				if (methodBase != null)
				{
					break;
				}
			}
		}
		if (methodBase == null)
		{
			throw new RemotingException("Method '" + methodName + "' not found in type '" + typeName + "'");
		}
		return methodBase;
	}

	public CADMethodRef(IMethodMessage msg)
	{
		MethodBase methodBase = msg.MethodBase;
		typeName = methodBase.DeclaringType.AssemblyQualifiedName;
		ctor = methodBase.IsConstructor;
		methodName = methodBase.Name;
		ParameterInfo[] parameters = methodBase.GetParameters();
		param_names = new string[parameters.Length];
		for (int i = 0; i < parameters.Length; i++)
		{
			param_names[i] = parameters[i].ParameterType.AssemblyQualifiedName;
		}
		if (!ctor && methodBase.IsGenericMethod)
		{
			Type[] genericArguments = methodBase.GetGenericArguments();
			generic_arg_names = new string[genericArguments.Length];
			for (int j = 0; j < genericArguments.Length; j++)
			{
				generic_arg_names[j] = genericArguments[j].AssemblyQualifiedName;
			}
		}
	}
}
