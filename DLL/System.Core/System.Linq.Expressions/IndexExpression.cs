using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Diagnostics;
using System.Dynamic.Utils;
using System.Reflection;

namespace System.Linq.Expressions;

[DebuggerTypeProxy(typeof(IndexExpressionProxy))]
public sealed class IndexExpression : Expression, IArgumentProvider
{
	private IReadOnlyList<Expression> _arguments;

	public sealed override ExpressionType NodeType => ExpressionType.Index;

	public sealed override Type Type
	{
		get
		{
			if (Indexer != null)
			{
				return Indexer.PropertyType;
			}
			return Object.Type.GetElementType();
		}
	}

	public Expression Object { get; }

	public PropertyInfo Indexer { get; }

	public ReadOnlyCollection<Expression> Arguments => ExpressionUtils.ReturnReadOnly(ref _arguments);

	public int ArgumentCount => _arguments.Count;

	internal IndexExpression(Expression instance, PropertyInfo indexer, IReadOnlyList<Expression> arguments)
	{
		_ = indexer == null;
		Object = instance;
		Indexer = indexer;
		_arguments = arguments;
	}

	public Expression GetArgument(int index)
	{
		return _arguments[index];
	}

	protected internal override Expression Accept(ExpressionVisitor visitor)
	{
		return visitor.VisitIndex(this);
	}

	internal Expression Rewrite(Expression instance, Expression[] arguments)
	{
		return Expression.MakeIndex(instance, Indexer, arguments ?? _arguments);
	}
}
