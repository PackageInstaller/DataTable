using System.Reflection;

namespace System.Runtime.Remoting.Messaging;

internal class ArgInfo
{
	private int[] _paramMap;

	private int _inoutArgCount;

	private MethodBase _method;

	public ArgInfo(MethodBase method, ArgInfoType type)
	{
		_method = method;
		ParameterInfo[] parameters = _method.GetParameters();
		_paramMap = new int[parameters.Length];
		_inoutArgCount = 0;
		if (type == ArgInfoType.In)
		{
			for (int i = 0; i < parameters.Length; i++)
			{
				if (!parameters[i].ParameterType.IsByRef)
				{
					_paramMap[_inoutArgCount++] = i;
				}
			}
			return;
		}
		for (int j = 0; j < parameters.Length; j++)
		{
			if (parameters[j].ParameterType.IsByRef || parameters[j].IsOut)
			{
				_paramMap[_inoutArgCount++] = j;
			}
		}
	}

	public object[] GetInOutArgs(object[] args)
	{
		object[] array = new object[_inoutArgCount];
		for (int i = 0; i < _inoutArgCount; i++)
		{
			array[i] = args[_paramMap[i]];
		}
		return array;
	}
}
