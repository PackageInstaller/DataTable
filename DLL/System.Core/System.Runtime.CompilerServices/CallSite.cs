using System.Collections.Generic;
using System.Dynamic.Utils;
using System.Linq.Expressions;
using System.Reflection;

namespace System.Runtime.CompilerServices;

public class CallSite
{
	private static volatile CacheDict<Type, Func<CallSiteBinder, CallSite>> s_siteCtors;

	internal readonly CallSiteBinder _binder;

	internal bool _match;

	public CallSiteBinder Binder => _binder;

	internal CallSite(CallSiteBinder binder)
	{
		_binder = binder;
	}

	public static CallSite Create(Type delegateType, CallSiteBinder binder)
	{
		ContractUtils.RequiresNotNull(delegateType, "delegateType");
		ContractUtils.RequiresNotNull(binder, "binder");
		if (!delegateType.IsSubclassOf(typeof(MulticastDelegate)))
		{
			throw Error.TypeMustBeDerivedFromSystemDelegate();
		}
		CacheDict<Type, Func<CallSiteBinder, CallSite>> cacheDict = s_siteCtors;
		if (cacheDict == null)
		{
			cacheDict = (s_siteCtors = new CacheDict<Type, Func<CallSiteBinder, CallSite>>(100));
		}
		if (!cacheDict.TryGetValue(delegateType, out var value))
		{
			MethodInfo method = typeof(CallSite<>).MakeGenericType(delegateType).GetMethod("Create");
			if (delegateType.IsCollectible)
			{
				return (CallSite)method.Invoke(null, new object[1] { binder });
			}
			value = (Func<CallSiteBinder, CallSite>)method.CreateDelegate(typeof(Func<CallSiteBinder, CallSite>));
			cacheDict.Add(delegateType, value);
		}
		return value(binder);
	}
}
public class CallSite<T> : CallSite where T : class
{
	public T Target;

	internal T[] Rules;

	private static T s_cachedUpdate;

	private static volatile T s_cachedNoMatch;

	public T Update
	{
		get
		{
			if (_match)
			{
				return s_cachedNoMatch;
			}
			return s_cachedUpdate;
		}
	}

	private CallSite(CallSiteBinder binder)
		: base(binder)
	{
		Target = GetUpdateDelegate();
	}

	private CallSite()
		: base(null)
	{
	}

	internal CallSite<T> CreateMatchMaker()
	{
		return new CallSite<T>();
	}

	public static CallSite<T> Create(CallSiteBinder binder)
	{
		if (!typeof(T).IsSubclassOf(typeof(MulticastDelegate)))
		{
			throw Error.TypeMustBeDerivedFromSystemDelegate();
		}
		ContractUtils.RequiresNotNull(binder, "binder");
		return new CallSite<T>(binder);
	}

	private T GetUpdateDelegate()
	{
		return GetUpdateDelegate(ref s_cachedUpdate);
	}

	private T GetUpdateDelegate(ref T addr)
	{
		if (addr == null)
		{
			addr = MakeUpdateDelegate();
		}
		return addr;
	}

	internal void AddRule(T newRule)
	{
		T[] rules = Rules;
		if (rules == null)
		{
			Rules = new T[1] { newRule };
			return;
		}
		T[] array;
		if (rules.Length < 9)
		{
			array = new T[rules.Length + 1];
			Array.Copy(rules, 0, array, 1, rules.Length);
		}
		else
		{
			array = new T[10];
			Array.Copy(rules, 0, array, 1, 9);
		}
		array[0] = newRule;
		Rules = array;
	}

	internal void MoveRule(int i)
	{
		if (i > 1)
		{
			T[] rules = Rules;
			T val = rules[i];
			rules[i] = rules[i - 1];
			rules[i - 1] = rules[i - 2];
			rules[i - 2] = val;
		}
	}

	internal T MakeUpdateDelegate()
	{
		MethodInfo invokeMethod = typeof(T).GetInvokeMethod();
		s_cachedNoMatch = CreateCustomNoMatchDelegate(invokeMethod);
		return CreateCustomUpdateDelegate(invokeMethod);
	}

	private T CreateCustomUpdateDelegate(MethodInfo invoke)
	{
		Type returnType = invoke.GetReturnType();
		bool flag = returnType == typeof(void);
		ArrayBuilder<Expression> builder = new ArrayBuilder<Expression>(13);
		ArrayBuilder<ParameterExpression> builder2 = new ArrayBuilder<ParameterExpression>(8 + ((!flag) ? 1 : 0));
		ParameterExpression[] array = Array.ConvertAll(invoke.GetParametersCached(), (ParameterInfo p) => Expression.Parameter(p.ParameterType, p.Name));
		LabelTarget labelTarget = Expression.Label(returnType);
		Type[] typeArguments = new Type[1] { typeof(T) };
		ParameterExpression parameterExpression = array[0];
		ParameterExpression[] array2 = array.RemoveFirst();
		ParameterExpression parameterExpression2 = Expression.Variable(typeof(CallSite<T>), "this");
		builder2.UncheckedAdd(parameterExpression2);
		builder.UncheckedAdd(Expression.Assign(parameterExpression2, Expression.Convert(parameterExpression, parameterExpression2.Type)));
		ParameterExpression parameterExpression3 = Expression.Variable(typeof(T[]), "applicable");
		builder2.UncheckedAdd(parameterExpression3);
		ParameterExpression parameterExpression4 = Expression.Variable(typeof(T), "rule");
		builder2.UncheckedAdd(parameterExpression4);
		ParameterExpression parameterExpression5 = Expression.Variable(typeof(T), "originalRule");
		builder2.UncheckedAdd(parameterExpression5);
		Expression expression = Expression.Field(parameterExpression2, "Target");
		builder.UncheckedAdd(Expression.Assign(parameterExpression5, expression));
		ParameterExpression parameterExpression6 = null;
		if (!flag)
		{
			builder2.UncheckedAdd(parameterExpression6 = Expression.Variable(labelTarget.Type, "result"));
		}
		ParameterExpression parameterExpression7 = Expression.Variable(typeof(int), "count");
		builder2.UncheckedAdd(parameterExpression7);
		ParameterExpression parameterExpression8 = Expression.Variable(typeof(int), "index");
		builder2.UncheckedAdd(parameterExpression8);
		builder.UncheckedAdd(Expression.Assign(parameterExpression, Expression.Call(CachedReflectionInfo.CallSiteOps_CreateMatchmaker.MakeGenericMethod(typeArguments), parameterExpression2)));
		Expression test = Expression.Call(CachedReflectionInfo.CallSiteOps_GetMatch, parameterExpression);
		Expression expression2 = Expression.Call(CachedReflectionInfo.CallSiteOps_ClearMatch, parameterExpression);
		Expression[] list = array;
		Expression expression3 = Expression.Invoke(parameterExpression4, new TrueReadOnlyCollection<Expression>(list));
		Expression arg = Expression.Call(CachedReflectionInfo.CallSiteOps_UpdateRules.MakeGenericMethod(typeArguments), parameterExpression2, parameterExpression8);
		Expression arg2 = ((!flag) ? Expression.Block(Expression.Assign(parameterExpression6, expression3), Expression.IfThen(test, Expression.Block(arg, Expression.Return(labelTarget, parameterExpression6)))) : Expression.Block(expression3, Expression.IfThen(test, Expression.Block(arg, Expression.Return(labelTarget)))));
		Expression expression4 = Expression.Assign(parameterExpression4, Expression.ArrayAccess(parameterExpression3, new TrueReadOnlyCollection<Expression>(parameterExpression8)));
		Expression arg3 = expression4;
		LabelTarget labelTarget2 = Expression.Label();
		Expression arg4 = Expression.IfThen(Expression.Equal(parameterExpression8, parameterExpression7), Expression.Break(labelTarget2));
		Expression expression5 = Expression.PreIncrementAssign(parameterExpression8);
		builder.UncheckedAdd(Expression.IfThen(Expression.NotEqual(Expression.Assign(parameterExpression3, Expression.Call(CachedReflectionInfo.CallSiteOps_GetRules.MakeGenericMethod(typeArguments), parameterExpression2)), Expression.Constant(null, parameterExpression3.Type)), Expression.Block(Expression.Assign(parameterExpression7, Expression.ArrayLength(parameterExpression3)), Expression.Assign(parameterExpression8, Utils.Constant(0)), Expression.Loop(Expression.Block(arg4, arg3, Expression.IfThen(Expression.NotEqual(Expression.Convert(parameterExpression4, typeof(object)), Expression.Convert(parameterExpression5, typeof(object))), Expression.Block(Expression.Assign(expression, parameterExpression4), arg2, expression2)), expression5), labelTarget2, null))));
		ParameterExpression parameterExpression9 = Expression.Variable(typeof(RuleCache<T>), "cache");
		builder2.UncheckedAdd(parameterExpression9);
		builder.UncheckedAdd(Expression.Assign(parameterExpression9, Expression.Call(CachedReflectionInfo.CallSiteOps_GetRuleCache.MakeGenericMethod(typeArguments), parameterExpression2)));
		builder.UncheckedAdd(Expression.Assign(parameterExpression3, Expression.Call(CachedReflectionInfo.CallSiteOps_GetCachedRules.MakeGenericMethod(typeArguments), parameterExpression9)));
		arg2 = ((!flag) ? Expression.Block(Expression.Assign(parameterExpression6, expression3), Expression.IfThen(test, Expression.Return(labelTarget, parameterExpression6))) : Expression.Block(expression3, Expression.IfThen(test, Expression.Return(labelTarget))));
		Expression arg5 = Expression.TryFinally(arg2, Expression.IfThen(test, Expression.Block(Expression.Call(CachedReflectionInfo.CallSiteOps_AddRule.MakeGenericMethod(typeArguments), parameterExpression2, parameterExpression4), Expression.Call(CachedReflectionInfo.CallSiteOps_MoveRule.MakeGenericMethod(typeArguments), parameterExpression9, parameterExpression4, parameterExpression8))));
		arg3 = Expression.Assign(expression, expression4);
		builder.UncheckedAdd(Expression.Assign(parameterExpression8, Utils.Constant(0)));
		builder.UncheckedAdd(Expression.Assign(parameterExpression7, Expression.ArrayLength(parameterExpression3)));
		builder.UncheckedAdd(Expression.Loop(Expression.Block(arg4, arg3, arg5, expression2, expression5), labelTarget2, null));
		builder.UncheckedAdd(Expression.Assign(parameterExpression4, Expression.Constant(null, parameterExpression4.Type)));
		ParameterExpression parameterExpression10 = Expression.Variable(typeof(object[]), "args");
		Expression[] list2 = Array.ConvertAll(array2, (ParameterExpression p) => Convert(p, typeof(object)));
		builder2.UncheckedAdd(parameterExpression10);
		builder.UncheckedAdd(Expression.Assign(parameterExpression10, Expression.NewArrayInit(typeof(object), new TrueReadOnlyCollection<Expression>(list2))));
		Expression arg6 = Expression.Assign(expression, parameterExpression5);
		arg3 = Expression.Assign(expression, Expression.Assign(parameterExpression4, Expression.Call(CachedReflectionInfo.CallSiteOps_Bind.MakeGenericMethod(typeArguments), Expression.Property(parameterExpression2, "Binder"), parameterExpression2, parameterExpression10)));
		arg5 = Expression.TryFinally(arg2, Expression.IfThen(test, Expression.Call(CachedReflectionInfo.CallSiteOps_AddRule.MakeGenericMethod(typeArguments), parameterExpression2, parameterExpression4)));
		builder.UncheckedAdd(Expression.Loop(Expression.Block(arg6, arg3, arg5, expression2), null, null));
		builder.UncheckedAdd(Expression.Default(labelTarget.Type));
		return Expression.Lambda<T>(Expression.Label(labelTarget, Expression.Block(builder2.ToReadOnly(), builder.ToReadOnly())), "CallSite.Target", tailCall: true, new TrueReadOnlyCollection<ParameterExpression>(array)).Compile();
	}

	private T CreateCustomNoMatchDelegate(MethodInfo invoke)
	{
		ParameterExpression[] array = Array.ConvertAll(invoke.GetParametersCached(), (ParameterInfo p) => Expression.Parameter(p.ParameterType, p.Name));
		return Expression.Lambda<T>(Expression.Block(Expression.Call(typeof(CallSiteOps).GetMethod("SetNotMatched"), array[0]), Expression.Default(invoke.GetReturnType())), new TrueReadOnlyCollection<ParameterExpression>(array)).Compile();
	}

	private static Expression Convert(Expression arg, Type type)
	{
		if (TypeUtils.AreReferenceAssignable(type, arg.Type))
		{
			return arg;
		}
		return Expression.Convert(arg, type);
	}
}
