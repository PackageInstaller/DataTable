using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Dynamic.Utils;
using System.Linq.Expressions;
using System.Reflection;
using System.Threading;

namespace System.Runtime.CompilerServices;

public abstract class CallSiteBinder
{
	private sealed class LambdaSignature<T> where T : class
	{
		private static LambdaSignature<T> s_instance;

		internal readonly ReadOnlyCollection<ParameterExpression> Parameters;

		internal readonly LabelTarget ReturnLabel;

		internal static LambdaSignature<T> Instance
		{
			get
			{
				if (s_instance == null)
				{
					s_instance = new LambdaSignature<T>();
				}
				return s_instance;
			}
		}

		private LambdaSignature()
		{
			Type typeFromHandle = typeof(T);
			if (!typeFromHandle.IsSubclassOf(typeof(MulticastDelegate)))
			{
				throw Error.TypeParameterIsNotDelegate(typeFromHandle);
			}
			MethodInfo invokeMethod = typeFromHandle.GetInvokeMethod();
			ParameterInfo[] parametersCached = invokeMethod.GetParametersCached();
			if (parametersCached[0].ParameterType != typeof(CallSite))
			{
				throw Error.FirstArgumentMustBeCallSite();
			}
			ParameterExpression[] array = new ParameterExpression[parametersCached.Length - 1];
			for (int i = 0; i < array.Length; i++)
			{
				array[i] = Expression.Parameter(parametersCached[i + 1].ParameterType, "$arg" + i);
			}
			Parameters = new TrueReadOnlyCollection<ParameterExpression>(array);
			ReturnLabel = Expression.Label(invokeMethod.GetReturnType());
		}
	}

	internal Dictionary<Type, object> Cache;

	public static LabelTarget UpdateLabel { get; } = Expression.Label("CallSiteBinder.UpdateLabel");

	public abstract Expression Bind(object[] args, ReadOnlyCollection<ParameterExpression> parameters, LabelTarget returnLabel);

	public virtual T BindDelegate<T>(CallSite<T> site, object[] args) where T : class
	{
		return null;
	}

	internal T BindCore<T>(CallSite<T> site, object[] args) where T : class
	{
		T val = BindDelegate(site, args);
		if (val != null)
		{
			return val;
		}
		LambdaSignature<T> instance = LambdaSignature<T>.Instance;
		T val2 = Stitch(Bind(args, instance.Parameters, instance.ReturnLabel) ?? throw Error.NoOrInvalidRuleProduced(), instance).Compile();
		CacheTarget(val2);
		return val2;
	}

	protected void CacheTarget<T>(T target) where T : class
	{
		GetRuleCache<T>().AddRule(target);
	}

	private static Expression<T> Stitch<T>(Expression binding, LambdaSignature<T> signature) where T : class
	{
		Type typeFromHandle = typeof(CallSite<T>);
		ReadOnlyCollectionBuilder<Expression> obj = new ReadOnlyCollectionBuilder<Expression>(3) { binding };
		ParameterExpression parameterExpression = Expression.Parameter(typeof(CallSite), "$site");
		TrueReadOnlyCollection<ParameterExpression> trueReadOnlyCollection = signature.Parameters.AddFirst(parameterExpression);
		Expression item = Expression.Label(UpdateLabel);
		obj.Add(item);
		obj.Add(Expression.Label(signature.ReturnLabel, Expression.Condition(Expression.Call(CachedReflectionInfo.CallSiteOps_SetNotMatched, parameterExpression), Expression.Default(signature.ReturnLabel.Type), Expression.Invoke(Expression.Property(Expression.Convert(parameterExpression, typeFromHandle), typeof(CallSite<T>).GetProperty("Update")), trueReadOnlyCollection))));
		return Expression.Lambda<T>(Expression.Block(obj), "CallSite.Target", tailCall: true, trueReadOnlyCollection);
	}

	internal RuleCache<T> GetRuleCache<T>() where T : class
	{
		if (Cache == null)
		{
			Interlocked.CompareExchange(ref Cache, new Dictionary<Type, object>(), null);
		}
		Dictionary<Type, object> cache = Cache;
		object value;
		lock (cache)
		{
			if (!cache.TryGetValue(typeof(T), out value))
			{
				value = (cache[typeof(T)] = new RuleCache<T>());
			}
		}
		return value as RuleCache<T>;
	}
}
