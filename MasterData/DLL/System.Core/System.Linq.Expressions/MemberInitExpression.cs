using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Diagnostics;
using System.Dynamic.Utils;

namespace System.Linq.Expressions;

[DebuggerTypeProxy(typeof(MemberInitExpressionProxy))]
public sealed class MemberInitExpression : Expression
{
	public sealed override Type Type => NewExpression.Type;

	public override bool CanReduce => true;

	public sealed override ExpressionType NodeType => ExpressionType.MemberInit;

	public NewExpression NewExpression { get; }

	public ReadOnlyCollection<MemberBinding> Bindings { get; }

	internal MemberInitExpression(NewExpression newExpression, ReadOnlyCollection<MemberBinding> bindings)
	{
		NewExpression = newExpression;
		Bindings = bindings;
	}

	protected internal override Expression Accept(ExpressionVisitor visitor)
	{
		return visitor.VisitMemberInit(this);
	}

	public override Expression Reduce()
	{
		return ReduceMemberInit(NewExpression, Bindings, keepOnStack: true);
	}

	private static Expression ReduceMemberInit(Expression objExpression, ReadOnlyCollection<MemberBinding> bindings, bool keepOnStack)
	{
		ParameterExpression parameterExpression = Expression.Variable(objExpression.Type);
		int count = bindings.Count;
		Expression[] array = new Expression[count + 2];
		array[0] = Expression.Assign(parameterExpression, objExpression);
		for (int i = 0; i < count; i++)
		{
			array[i + 1] = ReduceMemberBinding(parameterExpression, bindings[i]);
		}
		array[count + 1] = (keepOnStack ? ((Expression)parameterExpression) : ((Expression)Utils.Empty));
		return Expression.Block(new ParameterExpression[1] { parameterExpression }, array);
	}

	internal static Expression ReduceListInit(Expression listExpression, ReadOnlyCollection<ElementInit> initializers, bool keepOnStack)
	{
		ParameterExpression parameterExpression = Expression.Variable(listExpression.Type);
		int count = initializers.Count;
		Expression[] array = new Expression[count + 2];
		array[0] = Expression.Assign(parameterExpression, listExpression);
		for (int i = 0; i < count; i++)
		{
			ElementInit elementInit = initializers[i];
			array[i + 1] = Expression.Call(parameterExpression, elementInit.AddMethod, elementInit.Arguments);
		}
		array[count + 1] = (keepOnStack ? ((Expression)parameterExpression) : ((Expression)Utils.Empty));
		return Expression.Block(new ParameterExpression[1] { parameterExpression }, array);
	}

	internal static Expression ReduceMemberBinding(ParameterExpression objVar, MemberBinding binding)
	{
		MemberExpression memberExpression = Expression.MakeMemberAccess(objVar, binding.Member);
		return binding.BindingType switch
		{
			MemberBindingType.Assignment => Expression.Assign(memberExpression, ((MemberAssignment)binding).Expression), 
			MemberBindingType.ListBinding => ReduceListInit(memberExpression, ((MemberListBinding)binding).Initializers, keepOnStack: false), 
			MemberBindingType.MemberBinding => ReduceMemberInit(memberExpression, ((MemberMemberBinding)binding).Bindings, keepOnStack: false), 
			_ => throw ContractUtils.Unreachable, 
		};
	}

	public MemberInitExpression Update(NewExpression newExpression, IEnumerable<MemberBinding> bindings)
	{
		if (((newExpression == NewExpression) & (bindings != null)) && ExpressionUtils.SameElements(ref bindings, Bindings))
		{
			return this;
		}
		return Expression.MemberInit(newExpression, bindings);
	}
}
