using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Dynamic.Utils;
using System.Linq.Expressions;
using System.Reflection;
using System.Runtime.CompilerServices;

namespace System.Dynamic;

[Serializable]
public class DynamicObject : IDynamicMetaObjectProvider
{
	private sealed class MetaDynamic : DynamicMetaObject
	{
		private delegate DynamicMetaObject Fallback<TBinder>(MetaDynamic @this, TBinder binder, DynamicMetaObject errorSuggestion);

		private sealed class GetBinderAdapter : GetMemberBinder
		{
			internal GetBinderAdapter(InvokeMemberBinder binder)
				: base(binder.Name, binder.IgnoreCase)
			{
			}

			public override DynamicMetaObject FallbackGetMember(DynamicMetaObject target, DynamicMetaObject errorSuggestion)
			{
				throw new NotSupportedException();
			}
		}

		private static readonly Expression[] s_noArgs = new Expression[0];

		private new DynamicObject Value => (DynamicObject)base.Value;

		internal MetaDynamic(Expression expression, DynamicObject value)
			: base(expression, BindingRestrictions.Empty, value)
		{
		}

		public override IEnumerable<string> GetDynamicMemberNames()
		{
			return Value.GetDynamicMemberNames();
		}

		public override DynamicMetaObject BindGetMember(GetMemberBinder binder)
		{
			if (IsOverridden(CachedReflectionInfo.DynamicObject_TryGetMember))
			{
				return CallMethodWithResult(CachedReflectionInfo.DynamicObject_TryGetMember, binder, s_noArgs, (MetaDynamic @this, GetMemberBinder b, DynamicMetaObject e) => b.FallbackGetMember(@this, e));
			}
			return base.BindGetMember(binder);
		}

		public override DynamicMetaObject BindSetMember(SetMemberBinder binder, DynamicMetaObject value)
		{
			if (IsOverridden(CachedReflectionInfo.DynamicObject_TrySetMember))
			{
				DynamicMetaObject localValue = value;
				return CallMethodReturnLast(CachedReflectionInfo.DynamicObject_TrySetMember, binder, s_noArgs, value.Expression, (MetaDynamic @this, SetMemberBinder b, DynamicMetaObject e) => b.FallbackSetMember(@this, localValue, e));
			}
			return base.BindSetMember(binder, value);
		}

		public override DynamicMetaObject BindDeleteMember(DeleteMemberBinder binder)
		{
			if (IsOverridden(CachedReflectionInfo.DynamicObject_TryDeleteMember))
			{
				return CallMethodNoResult(CachedReflectionInfo.DynamicObject_TryDeleteMember, binder, s_noArgs, (MetaDynamic @this, DeleteMemberBinder b, DynamicMetaObject e) => b.FallbackDeleteMember(@this, e));
			}
			return base.BindDeleteMember(binder);
		}

		public override DynamicMetaObject BindConvert(ConvertBinder binder)
		{
			if (IsOverridden(CachedReflectionInfo.DynamicObject_TryConvert))
			{
				return CallMethodWithResult(CachedReflectionInfo.DynamicObject_TryConvert, binder, s_noArgs, (MetaDynamic @this, ConvertBinder b, DynamicMetaObject e) => b.FallbackConvert(@this, e));
			}
			return base.BindConvert(binder);
		}

		public override DynamicMetaObject BindInvokeMember(InvokeMemberBinder binder, DynamicMetaObject[] args)
		{
			DynamicMetaObject errorSuggestion = BuildCallMethodWithResult(CachedReflectionInfo.DynamicObject_TryInvokeMember, binder, DynamicMetaObject.GetExpressions(args), BuildCallMethodWithResult(CachedReflectionInfo.DynamicObject_TryGetMember, new GetBinderAdapter(binder), s_noArgs, binder.FallbackInvokeMember(this, args, null), (MetaDynamic @this, GetMemberBinder ignored, DynamicMetaObject e) => binder.FallbackInvoke(e, args, null)), null);
			return binder.FallbackInvokeMember(this, args, errorSuggestion);
		}

		public override DynamicMetaObject BindCreateInstance(CreateInstanceBinder binder, DynamicMetaObject[] args)
		{
			if (IsOverridden(CachedReflectionInfo.DynamicObject_TryCreateInstance))
			{
				DynamicMetaObject[] localArgs = args;
				return CallMethodWithResult(CachedReflectionInfo.DynamicObject_TryCreateInstance, binder, DynamicMetaObject.GetExpressions(args), (MetaDynamic @this, CreateInstanceBinder b, DynamicMetaObject e) => b.FallbackCreateInstance(@this, localArgs, e));
			}
			return base.BindCreateInstance(binder, args);
		}

		public override DynamicMetaObject BindInvoke(InvokeBinder binder, DynamicMetaObject[] args)
		{
			if (IsOverridden(CachedReflectionInfo.DynamicObject_TryInvoke))
			{
				DynamicMetaObject[] localArgs = args;
				return CallMethodWithResult(CachedReflectionInfo.DynamicObject_TryInvoke, binder, DynamicMetaObject.GetExpressions(args), (MetaDynamic @this, InvokeBinder b, DynamicMetaObject e) => b.FallbackInvoke(@this, localArgs, e));
			}
			return base.BindInvoke(binder, args);
		}

		public override DynamicMetaObject BindBinaryOperation(BinaryOperationBinder binder, DynamicMetaObject arg)
		{
			if (IsOverridden(CachedReflectionInfo.DynamicObject_TryBinaryOperation))
			{
				DynamicMetaObject localArg = arg;
				return CallMethodWithResult(CachedReflectionInfo.DynamicObject_TryBinaryOperation, binder, new Expression[1] { arg.Expression }, (MetaDynamic @this, BinaryOperationBinder b, DynamicMetaObject e) => b.FallbackBinaryOperation(@this, localArg, e));
			}
			return base.BindBinaryOperation(binder, arg);
		}

		public override DynamicMetaObject BindUnaryOperation(UnaryOperationBinder binder)
		{
			if (IsOverridden(CachedReflectionInfo.DynamicObject_TryUnaryOperation))
			{
				return CallMethodWithResult(CachedReflectionInfo.DynamicObject_TryUnaryOperation, binder, s_noArgs, (MetaDynamic @this, UnaryOperationBinder b, DynamicMetaObject e) => b.FallbackUnaryOperation(@this, e));
			}
			return base.BindUnaryOperation(binder);
		}

		public override DynamicMetaObject BindGetIndex(GetIndexBinder binder, DynamicMetaObject[] indexes)
		{
			if (IsOverridden(CachedReflectionInfo.DynamicObject_TryGetIndex))
			{
				DynamicMetaObject[] localIndexes = indexes;
				return CallMethodWithResult(CachedReflectionInfo.DynamicObject_TryGetIndex, binder, DynamicMetaObject.GetExpressions(indexes), (MetaDynamic @this, GetIndexBinder b, DynamicMetaObject e) => b.FallbackGetIndex(@this, localIndexes, e));
			}
			return base.BindGetIndex(binder, indexes);
		}

		public override DynamicMetaObject BindSetIndex(SetIndexBinder binder, DynamicMetaObject[] indexes, DynamicMetaObject value)
		{
			if (IsOverridden(CachedReflectionInfo.DynamicObject_TrySetIndex))
			{
				DynamicMetaObject[] localIndexes = indexes;
				DynamicMetaObject localValue = value;
				return CallMethodReturnLast(CachedReflectionInfo.DynamicObject_TrySetIndex, binder, DynamicMetaObject.GetExpressions(indexes), value.Expression, (MetaDynamic @this, SetIndexBinder b, DynamicMetaObject e) => b.FallbackSetIndex(@this, localIndexes, localValue, e));
			}
			return base.BindSetIndex(binder, indexes, value);
		}

		public override DynamicMetaObject BindDeleteIndex(DeleteIndexBinder binder, DynamicMetaObject[] indexes)
		{
			if (IsOverridden(CachedReflectionInfo.DynamicObject_TryDeleteIndex))
			{
				DynamicMetaObject[] localIndexes = indexes;
				return CallMethodNoResult(CachedReflectionInfo.DynamicObject_TryDeleteIndex, binder, DynamicMetaObject.GetExpressions(indexes), (MetaDynamic @this, DeleteIndexBinder b, DynamicMetaObject e) => b.FallbackDeleteIndex(@this, localIndexes, e));
			}
			return base.BindDeleteIndex(binder, indexes);
		}

		private static ReadOnlyCollection<Expression> GetConvertedArgs(params Expression[] args)
		{
			Expression[] array = new Expression[args.Length];
			for (int i = 0; i < args.Length; i++)
			{
				array[i] = Expression.Convert(args[i], typeof(object));
			}
			return new TrueReadOnlyCollection<Expression>(array);
		}

		private static Expression ReferenceArgAssign(Expression callArgs, Expression[] args)
		{
			ReadOnlyCollectionBuilder<Expression> readOnlyCollectionBuilder = null;
			for (int i = 0; i < args.Length; i++)
			{
				ParameterExpression parameterExpression = args[i] as ParameterExpression;
				ContractUtils.Requires(parameterExpression != null, "args");
				if (parameterExpression.IsByRef)
				{
					if (readOnlyCollectionBuilder == null)
					{
						readOnlyCollectionBuilder = new ReadOnlyCollectionBuilder<Expression>();
					}
					readOnlyCollectionBuilder.Add(Expression.Assign(parameterExpression, Expression.Convert(Expression.ArrayIndex(callArgs, System.Linq.Expressions.Utils.Constant(i)), parameterExpression.Type)));
				}
			}
			if (readOnlyCollectionBuilder != null)
			{
				return Expression.Block(readOnlyCollectionBuilder);
			}
			return System.Linq.Expressions.Utils.Empty;
		}

		private static Expression[] BuildCallArgs<TBinder>(TBinder binder, Expression[] parameters, Expression arg0, Expression arg1) where TBinder : DynamicMetaObjectBinder
		{
			if (parameters != s_noArgs)
			{
				if (arg1 != null)
				{
					return new Expression[3]
					{
						Constant(binder),
						arg0,
						arg1
					};
				}
				return new Expression[2]
				{
					Constant(binder),
					arg0
				};
			}
			if (arg1 != null)
			{
				return new Expression[2]
				{
					Constant(binder),
					arg1
				};
			}
			return new Expression[1] { Constant(binder) };
		}

		private static ConstantExpression Constant<TBinder>(TBinder binder)
		{
			return Expression.Constant(binder, typeof(TBinder));
		}

		private DynamicMetaObject CallMethodWithResult<TBinder>(MethodInfo method, TBinder binder, Expression[] args, Fallback<TBinder> fallback) where TBinder : DynamicMetaObjectBinder
		{
			return CallMethodWithResult(method, binder, args, fallback, null);
		}

		private DynamicMetaObject CallMethodWithResult<TBinder>(MethodInfo method, TBinder binder, Expression[] args, Fallback<TBinder> fallback, Fallback<TBinder> fallbackInvoke) where TBinder : DynamicMetaObjectBinder
		{
			DynamicMetaObject fallbackResult = fallback(this, binder, null);
			DynamicMetaObject errorSuggestion = BuildCallMethodWithResult(method, binder, args, fallbackResult, fallbackInvoke);
			return fallback(this, binder, errorSuggestion);
		}

		private DynamicMetaObject BuildCallMethodWithResult<TBinder>(MethodInfo method, TBinder binder, Expression[] args, DynamicMetaObject fallbackResult, Fallback<TBinder> fallbackInvoke) where TBinder : DynamicMetaObjectBinder
		{
			if (!IsOverridden(method))
			{
				return fallbackResult;
			}
			ParameterExpression parameterExpression = Expression.Parameter(typeof(object), null);
			ParameterExpression parameterExpression2 = ((method != CachedReflectionInfo.DynamicObject_TryBinaryOperation) ? Expression.Parameter(typeof(object[]), null) : Expression.Parameter(typeof(object), null));
			ReadOnlyCollection<Expression> convertedArgs = GetConvertedArgs(args);
			DynamicMetaObject dynamicMetaObject = new DynamicMetaObject(parameterExpression, BindingRestrictions.Empty);
			if (binder.ReturnType != typeof(object))
			{
				UnaryExpression ifTrue = Expression.Convert(dynamicMetaObject.Expression, binder.ReturnType);
				string value = Strings.DynamicObjectResultNotAssignable("{0}", Value.GetType(), binder.GetType(), binder.ReturnType);
				Expression test = ((!binder.ReturnType.IsValueType || !(Nullable.GetUnderlyingType(binder.ReturnType) == null)) ? ((Expression)Expression.OrElse(Expression.Equal(dynamicMetaObject.Expression, System.Linq.Expressions.Utils.Null), Expression.TypeIs(dynamicMetaObject.Expression, binder.ReturnType))) : ((Expression)Expression.TypeIs(dynamicMetaObject.Expression, binder.ReturnType)));
				dynamicMetaObject = new DynamicMetaObject(Expression.Condition(test, ifTrue, Expression.Throw(Expression.New(CachedReflectionInfo.InvalidCastException_Ctor_String, new TrueReadOnlyCollection<Expression>(Expression.Call(CachedReflectionInfo.String_Format_String_ObjectArray, Expression.Constant(value), Expression.NewArrayInit(typeof(object), new TrueReadOnlyCollection<Expression>(Expression.Condition(Expression.Equal(dynamicMetaObject.Expression, System.Linq.Expressions.Utils.Null), Expression.Constant("null"), Expression.Call(dynamicMetaObject.Expression, CachedReflectionInfo.Object_GetType), typeof(object))))))), binder.ReturnType), binder.ReturnType), dynamicMetaObject.Restrictions);
			}
			if (fallbackInvoke != null)
			{
				dynamicMetaObject = fallbackInvoke(this, binder, dynamicMetaObject);
			}
			return new DynamicMetaObject(Expression.Block(new TrueReadOnlyCollection<ParameterExpression>(parameterExpression, parameterExpression2), new TrueReadOnlyCollection<Expression>((method != CachedReflectionInfo.DynamicObject_TryBinaryOperation) ? Expression.Assign(parameterExpression2, Expression.NewArrayInit(typeof(object), convertedArgs)) : Expression.Assign(parameterExpression2, convertedArgs[0]), Expression.Condition(Expression.Call(GetLimitedSelf(), method, BuildCallArgs(binder, args, parameterExpression2, parameterExpression)), Expression.Block((method != CachedReflectionInfo.DynamicObject_TryBinaryOperation) ? ReferenceArgAssign(parameterExpression2, args) : System.Linq.Expressions.Utils.Empty, dynamicMetaObject.Expression), fallbackResult.Expression, binder.ReturnType))), GetRestrictions().Merge(dynamicMetaObject.Restrictions).Merge(fallbackResult.Restrictions));
		}

		private DynamicMetaObject CallMethodReturnLast<TBinder>(MethodInfo method, TBinder binder, Expression[] args, Expression value, Fallback<TBinder> fallback) where TBinder : DynamicMetaObjectBinder
		{
			DynamicMetaObject dynamicMetaObject = fallback(this, binder, null);
			ParameterExpression parameterExpression = Expression.Parameter(typeof(object), null);
			ParameterExpression parameterExpression2 = Expression.Parameter(typeof(object[]), null);
			ReadOnlyCollection<Expression> convertedArgs = GetConvertedArgs(args);
			DynamicMetaObject errorSuggestion = new DynamicMetaObject(Expression.Block(new TrueReadOnlyCollection<ParameterExpression>(parameterExpression, parameterExpression2), new TrueReadOnlyCollection<Expression>(Expression.Assign(parameterExpression2, Expression.NewArrayInit(typeof(object), convertedArgs)), Expression.Condition(Expression.Call(GetLimitedSelf(), method, BuildCallArgs(binder, args, parameterExpression2, Expression.Assign(parameterExpression, Expression.Convert(value, typeof(object))))), Expression.Block(ReferenceArgAssign(parameterExpression2, args), parameterExpression), dynamicMetaObject.Expression, typeof(object)))), GetRestrictions().Merge(dynamicMetaObject.Restrictions));
			return fallback(this, binder, errorSuggestion);
		}

		private DynamicMetaObject CallMethodNoResult<TBinder>(MethodInfo method, TBinder binder, Expression[] args, Fallback<TBinder> fallback) where TBinder : DynamicMetaObjectBinder
		{
			DynamicMetaObject dynamicMetaObject = fallback(this, binder, null);
			ParameterExpression parameterExpression = Expression.Parameter(typeof(object[]), null);
			ReadOnlyCollection<Expression> convertedArgs = GetConvertedArgs(args);
			DynamicMetaObject errorSuggestion = new DynamicMetaObject(Expression.Block(new TrueReadOnlyCollection<ParameterExpression>(parameterExpression), new TrueReadOnlyCollection<Expression>(Expression.Assign(parameterExpression, Expression.NewArrayInit(typeof(object), convertedArgs)), Expression.Condition(Expression.Call(GetLimitedSelf(), method, BuildCallArgs(binder, args, parameterExpression, null)), Expression.Block(ReferenceArgAssign(parameterExpression, args), System.Linq.Expressions.Utils.Empty), dynamicMetaObject.Expression, typeof(void)))), GetRestrictions().Merge(dynamicMetaObject.Restrictions));
			return fallback(this, binder, errorSuggestion);
		}

		private bool IsOverridden(MethodInfo method)
		{
			MemberInfo[] member = Value.GetType().GetMember(method.Name, MemberTypes.Method, BindingFlags.Instance | BindingFlags.Public);
			for (int i = 0; i < member.Length; i++)
			{
				MethodInfo methodInfo = (MethodInfo)member[i];
				if (methodInfo.DeclaringType != typeof(DynamicObject) && methodInfo.GetBaseDefinition() == method)
				{
					return true;
				}
			}
			return false;
		}

		private BindingRestrictions GetRestrictions()
		{
			return BindingRestrictions.GetTypeRestriction(this);
		}

		private Expression GetLimitedSelf()
		{
			if (TypeUtils.AreEquivalent(base.Expression.Type, typeof(DynamicObject)))
			{
				return base.Expression;
			}
			return Expression.Convert(base.Expression, typeof(DynamicObject));
		}
	}

	protected DynamicObject()
	{
	}

	public virtual bool TryGetMember(GetMemberBinder binder, out object result)
	{
		result = null;
		return false;
	}

	public virtual bool TrySetMember(SetMemberBinder binder, object value)
	{
		return false;
	}

	public virtual bool TryDeleteMember(DeleteMemberBinder binder)
	{
		return false;
	}

	public virtual bool TryInvokeMember(InvokeMemberBinder binder, object[] args, out object result)
	{
		result = null;
		return false;
	}

	public virtual bool TryConvert(ConvertBinder binder, out object result)
	{
		result = null;
		return false;
	}

	public virtual bool TryCreateInstance(CreateInstanceBinder binder, object[] args, out object result)
	{
		result = null;
		return false;
	}

	public virtual bool TryInvoke(InvokeBinder binder, object[] args, out object result)
	{
		result = null;
		return false;
	}

	public virtual bool TryBinaryOperation(BinaryOperationBinder binder, object arg, out object result)
	{
		result = null;
		return false;
	}

	public virtual bool TryUnaryOperation(UnaryOperationBinder binder, out object result)
	{
		result = null;
		return false;
	}

	public virtual bool TryGetIndex(GetIndexBinder binder, object[] indexes, out object result)
	{
		result = null;
		return false;
	}

	public virtual bool TrySetIndex(SetIndexBinder binder, object[] indexes, object value)
	{
		return false;
	}

	public virtual bool TryDeleteIndex(DeleteIndexBinder binder, object[] indexes)
	{
		return false;
	}

	public virtual IEnumerable<string> GetDynamicMemberNames()
	{
		return Array.Empty<string>();
	}

	public virtual DynamicMetaObject GetMetaObject(Expression parameter)
	{
		return new MetaDynamic(parameter, this);
	}
}
