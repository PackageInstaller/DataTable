using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Dynamic.Utils;
using System.Linq.Expressions.Compiler;
using System.Reflection;
using System.Runtime.CompilerServices;

namespace System.Linq.Expressions;

internal static class ExpressionExtension
{
	public static DynamicExpression MakeDynamic(Type delegateType, CallSiteBinder binder, params Expression[] arguments)
	{
		return MakeDynamic(delegateType, binder, (IEnumerable<Expression>)arguments);
	}

	public static DynamicExpression MakeDynamic(Type delegateType, CallSiteBinder binder, IEnumerable<Expression> arguments)
	{
		IReadOnlyList<Expression> readOnlyList = (arguments as IReadOnlyList<Expression>) ?? arguments.ToReadOnly();
		switch (readOnlyList.Count)
		{
		case 1:
			return MakeDynamic(delegateType, binder, readOnlyList[0]);
		case 2:
			return MakeDynamic(delegateType, binder, readOnlyList[0], readOnlyList[1]);
		case 3:
			return MakeDynamic(delegateType, binder, readOnlyList[0], readOnlyList[1], readOnlyList[2]);
		case 4:
			return MakeDynamic(delegateType, binder, readOnlyList[0], readOnlyList[1], readOnlyList[2], readOnlyList[3]);
		default:
		{
			ContractUtils.RequiresNotNull(delegateType, "delegateType");
			ContractUtils.RequiresNotNull(binder, "binder");
			if (!delegateType.IsSubclassOf(typeof(MulticastDelegate)))
			{
				throw Error.TypeMustBeDerivedFromSystemDelegate();
			}
			MethodInfo validMethodForDynamic = GetValidMethodForDynamic(delegateType);
			ReadOnlyCollection<Expression> arguments2 = arguments.ToReadOnly();
			ExpressionUtils.ValidateArgumentTypes(validMethodForDynamic, ExpressionType.Dynamic, ref arguments2, "delegateType");
			return DynamicExpression.Make(validMethodForDynamic.GetReturnType(), delegateType, binder, arguments2);
		}
		}
	}

	public static DynamicExpression MakeDynamic(Type delegateType, CallSiteBinder binder, Expression arg0)
	{
		ContractUtils.RequiresNotNull(delegateType, "delegateType");
		ContractUtils.RequiresNotNull(binder, "binder");
		if (!delegateType.IsSubclassOf(typeof(MulticastDelegate)))
		{
			throw Error.TypeMustBeDerivedFromSystemDelegate();
		}
		MethodInfo validMethodForDynamic = GetValidMethodForDynamic(delegateType);
		ParameterInfo[] parametersCached = validMethodForDynamic.GetParametersCached();
		ExpressionUtils.ValidateArgumentCount(validMethodForDynamic, ExpressionType.Dynamic, 2, parametersCached);
		ValidateDynamicArgument(arg0, "arg0");
		ExpressionUtils.ValidateOneArgument(validMethodForDynamic, ExpressionType.Dynamic, arg0, parametersCached[1], "delegateType", "arg0");
		return DynamicExpression.Make(validMethodForDynamic.GetReturnType(), delegateType, binder, arg0);
	}

	public static DynamicExpression MakeDynamic(Type delegateType, CallSiteBinder binder, Expression arg0, Expression arg1)
	{
		ContractUtils.RequiresNotNull(delegateType, "delegateType");
		ContractUtils.RequiresNotNull(binder, "binder");
		if (!delegateType.IsSubclassOf(typeof(MulticastDelegate)))
		{
			throw Error.TypeMustBeDerivedFromSystemDelegate();
		}
		MethodInfo validMethodForDynamic = GetValidMethodForDynamic(delegateType);
		ParameterInfo[] parametersCached = validMethodForDynamic.GetParametersCached();
		ExpressionUtils.ValidateArgumentCount(validMethodForDynamic, ExpressionType.Dynamic, 3, parametersCached);
		ValidateDynamicArgument(arg0, "arg0");
		ExpressionUtils.ValidateOneArgument(validMethodForDynamic, ExpressionType.Dynamic, arg0, parametersCached[1], "delegateType", "arg0");
		ValidateDynamicArgument(arg1, "arg1");
		ExpressionUtils.ValidateOneArgument(validMethodForDynamic, ExpressionType.Dynamic, arg1, parametersCached[2], "delegateType", "arg1");
		return DynamicExpression.Make(validMethodForDynamic.GetReturnType(), delegateType, binder, arg0, arg1);
	}

	public static DynamicExpression MakeDynamic(Type delegateType, CallSiteBinder binder, Expression arg0, Expression arg1, Expression arg2)
	{
		ContractUtils.RequiresNotNull(delegateType, "delegateType");
		ContractUtils.RequiresNotNull(binder, "binder");
		if (!delegateType.IsSubclassOf(typeof(MulticastDelegate)))
		{
			throw Error.TypeMustBeDerivedFromSystemDelegate();
		}
		MethodInfo validMethodForDynamic = GetValidMethodForDynamic(delegateType);
		ParameterInfo[] parametersCached = validMethodForDynamic.GetParametersCached();
		ExpressionUtils.ValidateArgumentCount(validMethodForDynamic, ExpressionType.Dynamic, 4, parametersCached);
		ValidateDynamicArgument(arg0, "arg0");
		ExpressionUtils.ValidateOneArgument(validMethodForDynamic, ExpressionType.Dynamic, arg0, parametersCached[1], "delegateType", "arg0");
		ValidateDynamicArgument(arg1, "arg1");
		ExpressionUtils.ValidateOneArgument(validMethodForDynamic, ExpressionType.Dynamic, arg1, parametersCached[2], "delegateType", "arg1");
		ValidateDynamicArgument(arg2, "arg2");
		ExpressionUtils.ValidateOneArgument(validMethodForDynamic, ExpressionType.Dynamic, arg2, parametersCached[3], "delegateType", "arg2");
		return DynamicExpression.Make(validMethodForDynamic.GetReturnType(), delegateType, binder, arg0, arg1, arg2);
	}

	public static DynamicExpression MakeDynamic(Type delegateType, CallSiteBinder binder, Expression arg0, Expression arg1, Expression arg2, Expression arg3)
	{
		ContractUtils.RequiresNotNull(delegateType, "delegateType");
		ContractUtils.RequiresNotNull(binder, "binder");
		if (!delegateType.IsSubclassOf(typeof(MulticastDelegate)))
		{
			throw Error.TypeMustBeDerivedFromSystemDelegate();
		}
		MethodInfo validMethodForDynamic = GetValidMethodForDynamic(delegateType);
		ParameterInfo[] parametersCached = validMethodForDynamic.GetParametersCached();
		ExpressionUtils.ValidateArgumentCount(validMethodForDynamic, ExpressionType.Dynamic, 5, parametersCached);
		ValidateDynamicArgument(arg0, "arg0");
		ExpressionUtils.ValidateOneArgument(validMethodForDynamic, ExpressionType.Dynamic, arg0, parametersCached[1], "delegateType", "arg0");
		ValidateDynamicArgument(arg1, "arg1");
		ExpressionUtils.ValidateOneArgument(validMethodForDynamic, ExpressionType.Dynamic, arg1, parametersCached[2], "delegateType", "arg1");
		ValidateDynamicArgument(arg2, "arg2");
		ExpressionUtils.ValidateOneArgument(validMethodForDynamic, ExpressionType.Dynamic, arg2, parametersCached[3], "delegateType", "arg2");
		ValidateDynamicArgument(arg3, "arg3");
		ExpressionUtils.ValidateOneArgument(validMethodForDynamic, ExpressionType.Dynamic, arg3, parametersCached[4], "delegateType", "arg3");
		return DynamicExpression.Make(validMethodForDynamic.GetReturnType(), delegateType, binder, arg0, arg1, arg2, arg3);
	}

	private static MethodInfo GetValidMethodForDynamic(Type delegateType)
	{
		MethodInfo invokeMethod = delegateType.GetInvokeMethod();
		ParameterInfo[] parametersCached = invokeMethod.GetParametersCached();
		if (parametersCached.Length == 0 || parametersCached[0].ParameterType != typeof(CallSite))
		{
			throw Error.FirstArgumentMustBeCallSite();
		}
		return invokeMethod;
	}

	public static DynamicExpression Dynamic(CallSiteBinder binder, Type returnType, params Expression[] arguments)
	{
		return Dynamic(binder, returnType, (IEnumerable<Expression>)arguments);
	}

	public static DynamicExpression Dynamic(CallSiteBinder binder, Type returnType, Expression arg0)
	{
		ContractUtils.RequiresNotNull(binder, "binder");
		ValidateDynamicArgument(arg0, "arg0");
		DelegateHelpers.TypeInfo nextTypeInfo = DelegateHelpers.GetNextTypeInfo(returnType, DelegateHelpers.GetNextTypeInfo(arg0.Type, DelegateHelpers.NextTypeInfo(typeof(CallSite))));
		Type delegateType = nextTypeInfo.DelegateType ?? nextTypeInfo.MakeDelegateType(returnType, arg0);
		return DynamicExpression.Make(returnType, delegateType, binder, arg0);
	}

	public static DynamicExpression Dynamic(CallSiteBinder binder, Type returnType, Expression arg0, Expression arg1)
	{
		ContractUtils.RequiresNotNull(binder, "binder");
		ValidateDynamicArgument(arg0, "arg0");
		ValidateDynamicArgument(arg1, "arg1");
		DelegateHelpers.TypeInfo nextTypeInfo = DelegateHelpers.GetNextTypeInfo(returnType, DelegateHelpers.GetNextTypeInfo(arg1.Type, DelegateHelpers.GetNextTypeInfo(arg0.Type, DelegateHelpers.NextTypeInfo(typeof(CallSite)))));
		Type delegateType = nextTypeInfo.DelegateType ?? nextTypeInfo.MakeDelegateType(returnType, arg0, arg1);
		return DynamicExpression.Make(returnType, delegateType, binder, arg0, arg1);
	}

	public static DynamicExpression Dynamic(CallSiteBinder binder, Type returnType, Expression arg0, Expression arg1, Expression arg2)
	{
		ContractUtils.RequiresNotNull(binder, "binder");
		ValidateDynamicArgument(arg0, "arg0");
		ValidateDynamicArgument(arg1, "arg1");
		ValidateDynamicArgument(arg2, "arg2");
		DelegateHelpers.TypeInfo nextTypeInfo = DelegateHelpers.GetNextTypeInfo(returnType, DelegateHelpers.GetNextTypeInfo(arg2.Type, DelegateHelpers.GetNextTypeInfo(arg1.Type, DelegateHelpers.GetNextTypeInfo(arg0.Type, DelegateHelpers.NextTypeInfo(typeof(CallSite))))));
		Type delegateType = nextTypeInfo.DelegateType ?? nextTypeInfo.MakeDelegateType(returnType, arg0, arg1, arg2);
		return DynamicExpression.Make(returnType, delegateType, binder, arg0, arg1, arg2);
	}

	public static DynamicExpression Dynamic(CallSiteBinder binder, Type returnType, Expression arg0, Expression arg1, Expression arg2, Expression arg3)
	{
		ContractUtils.RequiresNotNull(binder, "binder");
		ValidateDynamicArgument(arg0, "arg0");
		ValidateDynamicArgument(arg1, "arg1");
		ValidateDynamicArgument(arg2, "arg2");
		ValidateDynamicArgument(arg3, "arg3");
		DelegateHelpers.TypeInfo nextTypeInfo = DelegateHelpers.GetNextTypeInfo(returnType, DelegateHelpers.GetNextTypeInfo(arg3.Type, DelegateHelpers.GetNextTypeInfo(arg2.Type, DelegateHelpers.GetNextTypeInfo(arg1.Type, DelegateHelpers.GetNextTypeInfo(arg0.Type, DelegateHelpers.NextTypeInfo(typeof(CallSite)))))));
		Type delegateType = nextTypeInfo.DelegateType ?? nextTypeInfo.MakeDelegateType(returnType, arg0, arg1, arg2, arg3);
		return DynamicExpression.Make(returnType, delegateType, binder, arg0, arg1, arg2, arg3);
	}

	public static DynamicExpression Dynamic(CallSiteBinder binder, Type returnType, IEnumerable<Expression> arguments)
	{
		ContractUtils.RequiresNotNull(arguments, "arguments");
		ContractUtils.RequiresNotNull(returnType, "returnType");
		ReadOnlyCollection<Expression> readOnlyCollection = arguments.ToReadOnly();
		ContractUtils.RequiresNotEmpty(readOnlyCollection, "arguments");
		return MakeDynamic(binder, returnType, readOnlyCollection);
	}

	private static DynamicExpression MakeDynamic(CallSiteBinder binder, Type returnType, ReadOnlyCollection<Expression> arguments)
	{
		ContractUtils.RequiresNotNull(binder, "binder");
		int count = arguments.Count;
		for (int i = 0; i < count; i++)
		{
			ValidateDynamicArgument(arguments[i], "arguments", i);
		}
		Type delegateType = DelegateHelpers.MakeCallSiteDelegate(arguments, returnType);
		return count switch
		{
			1 => DynamicExpression.Make(returnType, delegateType, binder, arguments[0]), 
			2 => DynamicExpression.Make(returnType, delegateType, binder, arguments[0], arguments[1]), 
			3 => DynamicExpression.Make(returnType, delegateType, binder, arguments[0], arguments[1], arguments[2]), 
			4 => DynamicExpression.Make(returnType, delegateType, binder, arguments[0], arguments[1], arguments[2], arguments[3]), 
			_ => DynamicExpression.Make(returnType, delegateType, binder, arguments), 
		};
	}

	private static void ValidateDynamicArgument(Expression arg, string paramName)
	{
		ValidateDynamicArgument(arg, paramName, -1);
	}

	private static void ValidateDynamicArgument(Expression arg, string paramName, int index)
	{
		ExpressionUtils.RequiresCanRead(arg, paramName, index);
		Type type = arg.Type;
		ContractUtils.RequiresNotNull(type, "type");
		TypeUtils.ValidateType(type, "type", allowByRef: true, allowPointer: true);
		if (type == typeof(void))
		{
			throw Error.ArgumentTypeCannotBeVoid();
		}
	}
}
