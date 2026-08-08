using System.Collections.ObjectModel;
using System.Dynamic.Utils;
using System.Linq.Expressions;
using System.Runtime.CompilerServices;

namespace System.Dynamic;

public abstract class DynamicMetaObjectBinder : CallSiteBinder
{
	public virtual Type ReturnType => typeof(object);

	internal virtual bool IsStandardBinder => false;

	public sealed override Expression Bind(object[] args, ReadOnlyCollection<ParameterExpression> parameters, LabelTarget returnLabel)
	{
		ContractUtils.RequiresNotNull(args, "args");
		ContractUtils.RequiresNotNull(parameters, "parameters");
		ContractUtils.RequiresNotNull(returnLabel, "returnLabel");
		if (args.Length == 0)
		{
			throw Error.OutOfRange("args.Length", 1);
		}
		if (parameters.Count == 0)
		{
			throw Error.OutOfRange("parameters.Count", 1);
		}
		if (args.Length != parameters.Count)
		{
			throw new ArgumentOutOfRangeException("args");
		}
		Type type;
		if (IsStandardBinder)
		{
			type = ReturnType;
			if (returnLabel.Type != typeof(void) && !TypeUtils.AreReferenceAssignable(returnLabel.Type, type))
			{
				throw Error.BinderNotCompatibleWithCallSite(type, this, returnLabel.Type);
			}
		}
		else
		{
			type = returnLabel.Type;
		}
		DynamicMetaObject dynamicMetaObject = DynamicMetaObject.Create(args[0], parameters[0]);
		DynamicMetaObject[] args2 = CreateArgumentMetaObjects(args, parameters);
		DynamicMetaObject obj = Bind(dynamicMetaObject, args2) ?? throw Error.BindingCannotBeNull();
		Expression expression = obj.Expression;
		BindingRestrictions restrictions = obj.Restrictions;
		if (type != typeof(void) && !TypeUtils.AreReferenceAssignable(type, expression.Type))
		{
			if (dynamicMetaObject.Value is IDynamicMetaObjectProvider)
			{
				throw Error.DynamicObjectResultNotAssignable(expression.Type, dynamicMetaObject.Value.GetType(), this, type);
			}
			throw Error.DynamicBinderResultNotAssignable(expression.Type, this, type);
		}
		if (IsStandardBinder && args[0] is IDynamicMetaObjectProvider && restrictions == BindingRestrictions.Empty)
		{
			throw Error.DynamicBindingNeedsRestrictions(dynamicMetaObject.Value.GetType(), this);
		}
		if (expression.NodeType != ExpressionType.Goto)
		{
			expression = Expression.Return(returnLabel, expression);
		}
		if (restrictions != BindingRestrictions.Empty)
		{
			expression = Expression.IfThen(restrictions.ToExpression(), expression);
		}
		return expression;
	}

	private static DynamicMetaObject[] CreateArgumentMetaObjects(object[] args, ReadOnlyCollection<ParameterExpression> parameters)
	{
		DynamicMetaObject[] array;
		if (args.Length != 1)
		{
			array = new DynamicMetaObject[args.Length - 1];
			for (int i = 1; i < args.Length; i++)
			{
				array[i - 1] = DynamicMetaObject.Create(args[i], parameters[i]);
			}
		}
		else
		{
			array = DynamicMetaObject.EmptyMetaObjects;
		}
		return array;
	}

	public abstract DynamicMetaObject Bind(DynamicMetaObject target, DynamicMetaObject[] args);

	public Expression GetUpdateExpression(Type type)
	{
		return Expression.Goto(CallSiteBinder.UpdateLabel, type);
	}
}
