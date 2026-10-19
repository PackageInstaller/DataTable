using System;
using System.Reflection;

namespace Mono;

internal struct RuntimeGenericParamInfoHandle
{
	private unsafe RuntimeStructs.GenericParamInfo* value = (RuntimeStructs.GenericParamInfo*)(void*)ptr;

	internal Type[] Constraints => GetConstraints();

	internal unsafe GenericParameterAttributes Attributes => (GenericParameterAttributes)value->flags;

	internal unsafe RuntimeGenericParamInfoHandle(IntPtr ptr)
	{
	}

	private unsafe Type[] GetConstraints()
	{
		int constraintsCount = GetConstraintsCount();
		Type[] array = new Type[constraintsCount];
		for (int i = 0; i < constraintsCount; i++)
		{
			array[i] = Type.GetTypeFromHandle(new RuntimeClassHandle(value->constraints[i]).GetTypeHandle());
		}
		return array;
	}

	private unsafe int GetConstraintsCount()
	{
		int num = 0;
		RuntimeStructs.MonoClass** ptr = value->constraints;
		while (ptr != null && *ptr != null)
		{
			ptr++;
			num++;
		}
		return num;
	}
}
