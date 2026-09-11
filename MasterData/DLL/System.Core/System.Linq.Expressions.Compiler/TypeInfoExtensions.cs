using System.Collections.Generic;
using System.Runtime.CompilerServices;

namespace System.Linq.Expressions.Compiler;

internal static class TypeInfoExtensions
{
	public static Type MakeDelegateType(this DelegateHelpers.TypeInfo info, Type retType, params Expression[] args)
	{
		return info.MakeDelegateType(retType, (IList<Expression>)args);
	}

	public static Type MakeDelegateType(this DelegateHelpers.TypeInfo info, Type retType, IList<Expression> args)
	{
		Type[] array = new Type[args.Count + 2];
		array[0] = typeof(CallSite);
		array[array.Length - 1] = retType;
		for (int i = 0; i < args.Count; i++)
		{
			array[i + 1] = args[i].Type;
		}
		return info.DelegateType = DelegateHelpers.MakeNewDelegate(array);
	}
}
