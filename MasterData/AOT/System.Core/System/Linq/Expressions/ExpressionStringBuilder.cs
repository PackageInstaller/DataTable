using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Reflection;
using System.Runtime.CompilerServices;
using System.Text;

namespace System.Linq.Expressions;

internal sealed class ExpressionStringBuilder : ExpressionVisitor
{
	private readonly StringBuilder _out;

	private Dictionary<object, int> _ids;

	private ExpressionStringBuilder()
	{
		_out = new StringBuilder();
	}

	public override string ToString()
	{
		return _out.ToString();
	}

	private int GetLabelId(LabelTarget label)
	{
		return GetId(label);
	}

	private int GetParamId(ParameterExpression p)
	{
		return GetId(p);
	}

	private int GetId(object o)
	{
		if (_ids == null)
		{
			_ids = new Dictionary<object, int>();
		}
		if (!_ids.TryGetValue(o, out var value))
		{
			value = _ids.Count;
			_ids.Add(o, value);
		}
		return value;
	}

	private void Out(string s)
	{
		_out.Append(s);
	}

	private void Out(char c)
	{
		_out.Append(c);
	}

	internal static string ExpressionToString(Expression node)
	{
		ExpressionStringBuilder expressionStringBuilder = new ExpressionStringBuilder();
		expressionStringBuilder.Visit(node);
		return expressionStringBuilder.ToString();
	}

	internal static string CatchBlockToString(CatchBlock node)
	{
		ExpressionStringBuilder expressionStringBuilder = new ExpressionStringBuilder();
		expressionStringBuilder.VisitCatchBlock(node);
		return expressionStringBuilder.ToString();
	}

	private void VisitExpressions<T>(char open, ReadOnlyCollection<T> expressions, char close) where T : Expression
	{
		VisitExpressions(open, expressions, close, ", ");
	}

	private void VisitExpressions<T>(char open, ReadOnlyCollection<T> expressions, char close, string seperator) where T : Expression
	{
		Out(open);
		if (expressions != null)
		{
			bool flag = true;
			foreach (T expression in expressions)
			{
				if (flag)
				{
					flag = false;
				}
				else
				{
					Out(seperator);
				}
				Visit(expression);
			}
		}
		Out(close);
	}

	protected internal override Expression VisitBinary(BinaryExpression node)
	{
		if (node.NodeType == ExpressionType.ArrayIndex)
		{
			Visit(node.Left);
			Out('[');
			Visit(node.Right);
			Out(']');
		}
		else
		{
			string s;
			switch (node.NodeType)
			{
			case ExpressionType.AndAlso:
				s = "AndAlso";
				break;
			case ExpressionType.OrElse:
				s = "OrElse";
				break;
			case ExpressionType.Assign:
				s = "=";
				break;
			case ExpressionType.Equal:
				s = "==";
				break;
			case ExpressionType.NotEqual:
				s = "!=";
				break;
			case ExpressionType.GreaterThan:
				s = ">";
				break;
			case ExpressionType.LessThan:
				s = "<";
				break;
			case ExpressionType.GreaterThanOrEqual:
				s = ">=";
				break;
			case ExpressionType.LessThanOrEqual:
				s = "<=";
				break;
			case ExpressionType.Add:
			case ExpressionType.AddChecked:
				s = "+";
				break;
			case ExpressionType.AddAssign:
			case ExpressionType.AddAssignChecked:
				s = "+=";
				break;
			case ExpressionType.Subtract:
			case ExpressionType.SubtractChecked:
				s = "-";
				break;
			case ExpressionType.SubtractAssign:
			case ExpressionType.SubtractAssignChecked:
				s = "-=";
				break;
			case ExpressionType.Divide:
				s = "/";
				break;
			case ExpressionType.DivideAssign:
				s = "/=";
				break;
			case ExpressionType.Modulo:
				s = "%";
				break;
			case ExpressionType.ModuloAssign:
				s = "%=";
				break;
			case ExpressionType.Multiply:
			case ExpressionType.MultiplyChecked:
				s = "*";
				break;
			case ExpressionType.MultiplyAssign:
			case ExpressionType.MultiplyAssignChecked:
				s = "*=";
				break;
			case ExpressionType.LeftShift:
				s = "<<";
				break;
			case ExpressionType.LeftShiftAssign:
				s = "<<=";
				break;
			case ExpressionType.RightShift:
				s = ">>";
				break;
			case ExpressionType.RightShiftAssign:
				s = ">>=";
				break;
			case ExpressionType.And:
				s = (IsBool(node) ? "And" : "&");
				break;
			case ExpressionType.AndAssign:
				s = (IsBool(node) ? "&&=" : "&=");
				break;
			case ExpressionType.Or:
				s = (IsBool(node) ? "Or" : "|");
				break;
			case ExpressionType.OrAssign:
				s = (IsBool(node) ? "||=" : "|=");
				break;
			case ExpressionType.ExclusiveOr:
				s = "^";
				break;
			case ExpressionType.ExclusiveOrAssign:
				s = "^=";
				break;
			case ExpressionType.Power:
				s = "**";
				break;
			case ExpressionType.PowerAssign:
				s = "**=";
				break;
			case ExpressionType.Coalesce:
				s = "??";
				break;
			default:
				throw new InvalidOperationException();
			}
			Out('(');
			Visit(node.Left);
			Out(' ');
			Out(s);
			Out(' ');
			Visit(node.Right);
			Out(')');
		}
		return node;
	}

	protected internal override Expression VisitParameter(ParameterExpression node)
	{
		if (node.IsByRef)
		{
			Out("ref ");
		}
		string name = node.Name;
		if (string.IsNullOrEmpty(name))
		{
			Out("Param_" + GetParamId(node));
		}
		else
		{
			Out(name);
		}
		return node;
	}

	protected internal override Expression VisitLambda<T>(Expression<T> node)
	{
		if (node.ParameterCount == 1)
		{
			Visit(node.GetParameter(0));
		}
		else
		{
			Out('(');
			string s = ", ";
			int i = 0;
			for (int parameterCount = node.ParameterCount; i < parameterCount; i++)
			{
				if (i > 0)
				{
					Out(s);
				}
				Visit(node.GetParameter(i));
			}
			Out(')');
		}
		Out(" => ");
		Visit(node.Body);
		return node;
	}

	protected internal override Expression VisitConditional(ConditionalExpression node)
	{
		Out("IIF(");
		Visit(node.Test);
		Out(", ");
		Visit(node.IfTrue);
		Out(", ");
		Visit(node.IfFalse);
		Out(')');
		return node;
	}

	protected internal override Expression VisitConstant(ConstantExpression node)
	{
		if (node.Value != null)
		{
			string text = node.Value.ToString();
			if (node.Value is string)
			{
				Out('"');
				Out(text);
				Out('"');
			}
			else if (text == node.Value.GetType().ToString())
			{
				Out("value(");
				Out(text);
				Out(')');
			}
			else
			{
				Out(text);
			}
		}
		else
		{
			Out("null");
		}
		return node;
	}

	private void OutMember(Expression instance, MemberInfo member)
	{
		if (instance != null)
		{
			Visit(instance);
		}
		else
		{
			Out(member.DeclaringType.Name);
		}
		Out('.');
		Out(member.Name);
	}

	protected internal override Expression VisitMember(MemberExpression node)
	{
		OutMember(node.Expression, node.Member);
		return node;
	}

	protected internal override Expression VisitInvocation(InvocationExpression node)
	{
		Out("Invoke(");
		Visit(node.Expression);
		string s = ", ";
		int i = 0;
		for (int argumentCount = node.ArgumentCount; i < argumentCount; i++)
		{
			Out(s);
			Visit(node.GetArgument(i));
		}
		Out(')');
		return node;
	}

	protected internal override Expression VisitMethodCall(MethodCallExpression node)
	{
		int num = 0;
		Expression expression = node.Object;
		if (node.Method.GetCustomAttribute(typeof(ExtensionAttribute)) != null)
		{
			num = 1;
			expression = node.GetArgument(0);
		}
		if (expression != null)
		{
			Visit(expression);
			Out('.');
		}
		Out(node.Method.Name);
		Out('(');
		int i = num;
		for (int argumentCount = node.ArgumentCount; i < argumentCount; i++)
		{
			if (i > num)
			{
				Out(", ");
			}
			Visit(node.GetArgument(i));
		}
		Out(')');
		return node;
	}

	protected internal override Expression VisitNewArray(NewArrayExpression node)
	{
		switch (node.NodeType)
		{
		case ExpressionType.NewArrayBounds:
			Out("new ");
			Out(node.Type.ToString());
			VisitExpressions('(', node.Expressions, ')');
			break;
		case ExpressionType.NewArrayInit:
			Out("new [] ");
			VisitExpressions('{', node.Expressions, '}');
			break;
		}
		return node;
	}

	protected internal override Expression VisitTypeBinary(TypeBinaryExpression node)
	{
		Out('(');
		Visit(node.Expression);
		switch (node.NodeType)
		{
		case ExpressionType.TypeIs:
			Out(" Is ");
			break;
		case ExpressionType.TypeEqual:
			Out(" TypeEqual ");
			break;
		}
		Out(node.TypeOperand.Name);
		Out(')');
		return node;
	}

	protected internal override Expression VisitUnary(UnaryExpression node)
	{
		switch (node.NodeType)
		{
		case ExpressionType.Negate:
		case ExpressionType.NegateChecked:
			Out('-');
			break;
		case ExpressionType.Not:
			Out("Not(");
			break;
		case ExpressionType.IsFalse:
			Out("IsFalse(");
			break;
		case ExpressionType.IsTrue:
			Out("IsTrue(");
			break;
		case ExpressionType.OnesComplement:
			Out("~(");
			break;
		case ExpressionType.ArrayLength:
			Out("ArrayLength(");
			break;
		case ExpressionType.Convert:
			Out("Convert(");
			break;
		case ExpressionType.ConvertChecked:
			Out("ConvertChecked(");
			break;
		case ExpressionType.Throw:
			Out("throw(");
			break;
		case ExpressionType.TypeAs:
			Out('(');
			break;
		case ExpressionType.UnaryPlus:
			Out('+');
			break;
		case ExpressionType.Unbox:
			Out("Unbox(");
			break;
		case ExpressionType.Increment:
			Out("Increment(");
			break;
		case ExpressionType.Decrement:
			Out("Decrement(");
			break;
		case ExpressionType.PreIncrementAssign:
			Out("++");
			break;
		case ExpressionType.PreDecrementAssign:
			Out("--");
			break;
		default:
			throw new InvalidOperationException();
		case ExpressionType.Quote:
		case ExpressionType.PostIncrementAssign:
		case ExpressionType.PostDecrementAssign:
			break;
		}
		Visit(node.Operand);
		switch (node.NodeType)
		{
		case ExpressionType.TypeAs:
			Out(" As ");
			Out(node.Type.Name);
			Out(')');
			break;
		case ExpressionType.Convert:
		case ExpressionType.ConvertChecked:
			Out(", ");
			Out(node.Type.Name);
			Out(')');
			break;
		case ExpressionType.PostIncrementAssign:
			Out("++");
			break;
		case ExpressionType.PostDecrementAssign:
			Out("--");
			break;
		default:
			Out(')');
			break;
		case ExpressionType.Negate:
		case ExpressionType.UnaryPlus:
		case ExpressionType.NegateChecked:
		case ExpressionType.Quote:
		case ExpressionType.PreIncrementAssign:
		case ExpressionType.PreDecrementAssign:
			break;
		}
		return node;
	}

	protected internal override Expression VisitBlock(BlockExpression node)
	{
		Out('{');
		foreach (ParameterExpression variable in node.Variables)
		{
			Out("var ");
			Visit(variable);
			Out(';');
		}
		Out(" ... }");
		return node;
	}

	protected internal override Expression VisitDefault(DefaultExpression node)
	{
		Out("default(");
		Out(node.Type.Name);
		Out(')');
		return node;
	}

	protected internal override Expression VisitLabel(LabelExpression node)
	{
		Out("{ ... } ");
		DumpLabel(node.Target);
		Out(':');
		return node;
	}

	protected internal override Expression VisitGoto(GotoExpression node)
	{
		Out(node.Kind switch
		{
			GotoExpressionKind.Goto => "goto", 
			GotoExpressionKind.Break => "break", 
			GotoExpressionKind.Continue => "continue", 
			GotoExpressionKind.Return => "return", 
			_ => throw new InvalidOperationException(), 
		});
		Out(' ');
		DumpLabel(node.Target);
		if (node.Value != null)
		{
			Out(" (");
			Visit(node.Value);
			Out(")");
		}
		return node;
	}

	protected internal override Expression VisitLoop(LoopExpression node)
	{
		Out("loop { ... }");
		return node;
	}

	protected override CatchBlock VisitCatchBlock(CatchBlock node)
	{
		Out("catch (");
		Out(node.Test.Name);
		if (!string.IsNullOrEmpty(node.Variable?.Name))
		{
			Out(' ');
			Out(node.Variable.Name);
		}
		Out(") { ... }");
		return node;
	}

	protected internal override Expression VisitTry(TryExpression node)
	{
		Out("try { ... }");
		return node;
	}

	protected internal override Expression VisitIndex(IndexExpression node)
	{
		if (node.Object != null)
		{
			Visit(node.Object);
		}
		else
		{
			Out(node.Indexer.DeclaringType.Name);
		}
		if (node.Indexer != null)
		{
			Out('.');
			Out(node.Indexer.Name);
		}
		Out('[');
		int i = 0;
		for (int argumentCount = node.ArgumentCount; i < argumentCount; i++)
		{
			if (i > 0)
			{
				Out(", ");
			}
			Visit(node.GetArgument(i));
		}
		Out(']');
		return node;
	}

	protected internal override Expression VisitExtension(Expression node)
	{
		MethodInfo method = node.GetType().GetMethod("ToString", Type.EmptyTypes);
		if (method.DeclaringType != typeof(Expression) && !method.IsStatic)
		{
			Out(node.ToString());
			return node;
		}
		Out('[');
		Out((node.NodeType == ExpressionType.Extension) ? node.GetType().FullName : node.NodeType.ToString());
		Out(']');
		return node;
	}

	private void DumpLabel(LabelTarget target)
	{
		if (!string.IsNullOrEmpty(target.Name))
		{
			Out(target.Name);
		}
		else
		{
			Out("UnnamedLabel_" + GetLabelId(target));
		}
	}

	private static bool IsBool(Expression node)
	{
		if (!(node.Type == typeof(bool)))
		{
			return node.Type == typeof(bool?);
		}
		return true;
	}
}
