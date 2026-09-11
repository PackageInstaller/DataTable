using System.Collections.Generic;
using System.Dynamic.Utils;
using System.Globalization;
using System.IO;
using System.Reflection;

namespace System.Linq.Expressions;

internal sealed class DebugViewWriter : ExpressionVisitor
{
	[Flags]
	private enum Flow
	{
		None = 0,
		Space = 1,
		NewLine = 2,
		Break = 0x8000
	}

	private readonly TextWriter _out;

	private int _column;

	private readonly Stack<int> _stack = new Stack<int>();

	private int _delta;

	private Flow _flow;

	private Queue<LambdaExpression> _lambdas;

	private Dictionary<LambdaExpression, int> _lambdaIds;

	private Dictionary<ParameterExpression, int> _paramIds;

	private Dictionary<LabelTarget, int> _labelIds;

	private int Base
	{
		get
		{
			if (_stack.Count <= 0)
			{
				return 0;
			}
			return _stack.Peek();
		}
	}

	private int Delta => _delta;

	private int Depth => Base + Delta;

	private DebugViewWriter(TextWriter file)
	{
		_out = file;
	}

	private void Indent()
	{
		_delta += 4;
	}

	private void Dedent()
	{
		_delta -= 4;
	}

	private void NewLine()
	{
		_flow = Flow.NewLine;
	}

	private static int GetId<T>(T e, ref Dictionary<T, int> ids)
	{
		if (ids == null)
		{
			ids = new Dictionary<T, int>();
			ids.Add(e, 1);
			return 1;
		}
		if (!ids.TryGetValue(e, out var value))
		{
			value = ids.Count + 1;
			ids.Add(e, value);
		}
		return value;
	}

	private int GetLambdaId(LambdaExpression le)
	{
		return GetId(le, ref _lambdaIds);
	}

	private int GetParamId(ParameterExpression p)
	{
		return GetId(p, ref _paramIds);
	}

	private int GetLabelTargetId(LabelTarget target)
	{
		return GetId(target, ref _labelIds);
	}

	internal static void WriteTo(Expression node, TextWriter writer)
	{
		new DebugViewWriter(writer).WriteTo(node);
	}

	private void WriteTo(Expression node)
	{
		if (node is LambdaExpression lambda)
		{
			WriteLambda(lambda);
		}
		else
		{
			Visit(node);
		}
		while (_lambdas != null && _lambdas.Count > 0)
		{
			WriteLine();
			WriteLine();
			WriteLambda(_lambdas.Dequeue());
		}
	}

	private void Out(string s)
	{
		Out(Flow.None, s, Flow.None);
	}

	private void Out(Flow before, string s)
	{
		Out(before, s, Flow.None);
	}

	private void Out(string s, Flow after)
	{
		Out(Flow.None, s, after);
	}

	private void Out(Flow before, string s, Flow after)
	{
		switch (GetFlow(before))
		{
		case Flow.Space:
			Write(" ");
			break;
		case Flow.NewLine:
			WriteLine();
			Write(new string(' ', Depth));
			break;
		}
		Write(s);
		_flow = after;
	}

	private void WriteLine()
	{
		_out.WriteLine();
		_column = 0;
	}

	private void Write(string s)
	{
		_out.Write(s);
		_column += s.Length;
	}

	private Flow GetFlow(Flow flow)
	{
		Flow val = CheckBreak(_flow);
		flow = CheckBreak(flow);
		return (Flow)Math.Max((int)val, (int)flow);
	}

	private Flow CheckBreak(Flow flow)
	{
		if ((flow & Flow.Break) != Flow.None)
		{
			flow = ((_column <= 120 + Depth) ? (flow & ~Flow.Break) : Flow.NewLine);
		}
		return flow;
	}

	private void VisitExpressions<T>(char open, IReadOnlyList<T> expressions) where T : Expression
	{
		VisitExpressions(open, ',', expressions);
	}

	private void VisitExpressions<T>(char open, char separator, IReadOnlyList<T> expressions) where T : Expression
	{
		VisitExpressions(open, separator, expressions, delegate(T e)
		{
			Visit(e);
		});
	}

	private void VisitDeclarations(IReadOnlyList<ParameterExpression> expressions)
	{
		VisitExpressions('(', ',', expressions, delegate(ParameterExpression variable)
		{
			Out(variable.Type.ToString());
			if (variable.IsByRef)
			{
				Out("&");
			}
			Out(" ");
			VisitParameter(variable);
		});
	}

	private void VisitExpressions<T>(char open, char separator, IReadOnlyList<T> expressions, Action<T> visit)
	{
		Out(open.ToString());
		if (expressions != null)
		{
			Indent();
			bool flag = true;
			foreach (T expression in expressions)
			{
				if (flag)
				{
					if (open == '{' || expressions.Count > 1)
					{
						NewLine();
					}
					flag = false;
				}
				else
				{
					Out(separator.ToString(), Flow.NewLine);
				}
				visit(expression);
			}
			Dedent();
		}
		char c = open switch
		{
			'(' => ')', 
			'{' => '}', 
			'[' => ']', 
			_ => throw ContractUtils.Unreachable, 
		};
		if (open == '{')
		{
			NewLine();
		}
		Out(c.ToString(), Flow.Break);
	}

	protected internal override Expression VisitBinary(BinaryExpression node)
	{
		if (node.NodeType == ExpressionType.ArrayIndex)
		{
			ParenthesizedVisit(node, node.Left);
			Out("[");
			Visit(node.Right);
			Out("]");
		}
		else
		{
			bool flag = NeedsParentheses(node, node.Left);
			bool flag2 = NeedsParentheses(node, node.Right);
			Flow before = Flow.Space;
			string s;
			switch (node.NodeType)
			{
			case ExpressionType.Assign:
				s = "=";
				break;
			case ExpressionType.Equal:
				s = "==";
				break;
			case ExpressionType.NotEqual:
				s = "!=";
				break;
			case ExpressionType.AndAlso:
				s = "&&";
				before = Flow.Space | Flow.Break;
				break;
			case ExpressionType.OrElse:
				s = "||";
				before = Flow.Space | Flow.Break;
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
				s = "+";
				break;
			case ExpressionType.AddAssign:
				s = "+=";
				break;
			case ExpressionType.AddAssignChecked:
				s = "#+=";
				break;
			case ExpressionType.AddChecked:
				s = "#+";
				break;
			case ExpressionType.Subtract:
				s = "-";
				break;
			case ExpressionType.SubtractAssign:
				s = "-=";
				break;
			case ExpressionType.SubtractAssignChecked:
				s = "#-=";
				break;
			case ExpressionType.SubtractChecked:
				s = "#-";
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
				s = "*";
				break;
			case ExpressionType.MultiplyAssign:
				s = "*=";
				break;
			case ExpressionType.MultiplyAssignChecked:
				s = "#*=";
				break;
			case ExpressionType.MultiplyChecked:
				s = "#*";
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
				s = "&";
				break;
			case ExpressionType.AndAssign:
				s = "&=";
				break;
			case ExpressionType.Or:
				s = "|";
				break;
			case ExpressionType.OrAssign:
				s = "|=";
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
			if (flag)
			{
				Out("(", Flow.None);
			}
			Visit(node.Left);
			if (flag)
			{
				Out(Flow.None, ")", Flow.Break);
			}
			Out(before, s, Flow.Space | Flow.Break);
			if (flag2)
			{
				Out("(", Flow.None);
			}
			Visit(node.Right);
			if (flag2)
			{
				Out(Flow.None, ")", Flow.Break);
			}
		}
		return node;
	}

	protected internal override Expression VisitParameter(ParameterExpression node)
	{
		Out("$");
		if (string.IsNullOrEmpty(node.Name))
		{
			Out("var" + GetParamId(node));
		}
		else
		{
			Out(GetDisplayName(node.Name));
		}
		return node;
	}

	protected internal override Expression VisitLambda<T>(Expression<T> node)
	{
		Out(string.Format(CultureInfo.CurrentCulture, ".Lambda {0}<{1}>", GetLambdaName(node), node.Type.ToString()));
		if (_lambdas == null)
		{
			_lambdas = new Queue<LambdaExpression>();
		}
		if (!_lambdas.Contains(node))
		{
			_lambdas.Enqueue(node);
		}
		return node;
	}

	private static bool IsSimpleExpression(Expression node)
	{
		if (node is BinaryExpression binaryExpression)
		{
			if (!(binaryExpression.Left is BinaryExpression))
			{
				return !(binaryExpression.Right is BinaryExpression);
			}
			return false;
		}
		return false;
	}

	protected internal override Expression VisitConditional(ConditionalExpression node)
	{
		if (IsSimpleExpression(node.Test))
		{
			Out(".If (");
			Visit(node.Test);
			Out(") {", Flow.NewLine);
		}
		else
		{
			Out(".If (", Flow.NewLine);
			Indent();
			Visit(node.Test);
			Dedent();
			Out(Flow.NewLine, ") {", Flow.NewLine);
		}
		Indent();
		Visit(node.IfTrue);
		Dedent();
		Out(Flow.NewLine, "} .Else {", Flow.NewLine);
		Indent();
		Visit(node.IfFalse);
		Dedent();
		Out(Flow.NewLine, "}");
		return node;
	}

	protected internal override Expression VisitConstant(ConstantExpression node)
	{
		object value = node.Value;
		if (value == null)
		{
			Out("null");
		}
		else if (value is string && node.Type == typeof(string))
		{
			Out(string.Format(CultureInfo.CurrentCulture, "\"{0}\"", value));
		}
		else if (value is char && node.Type == typeof(char))
		{
			Out(string.Format(CultureInfo.CurrentCulture, "'{0}'", value));
		}
		else if ((value is int && node.Type == typeof(int)) || (value is bool && node.Type == typeof(bool)))
		{
			Out(value.ToString());
		}
		else
		{
			string constantValueSuffix = GetConstantValueSuffix(node.Type);
			if (constantValueSuffix != null)
			{
				Out(value.ToString());
				Out(constantValueSuffix);
			}
			else
			{
				Out(string.Format(CultureInfo.CurrentCulture, ".Constant<{0}>({1})", node.Type.ToString(), value));
			}
		}
		return node;
	}

	private static string GetConstantValueSuffix(Type type)
	{
		if (type == typeof(uint))
		{
			return "U";
		}
		if (type == typeof(long))
		{
			return "L";
		}
		if (type == typeof(ulong))
		{
			return "UL";
		}
		if (type == typeof(double))
		{
			return "D";
		}
		if (type == typeof(float))
		{
			return "F";
		}
		if (type == typeof(decimal))
		{
			return "M";
		}
		return null;
	}

	protected internal override Expression VisitRuntimeVariables(RuntimeVariablesExpression node)
	{
		Out(".RuntimeVariables");
		VisitExpressions('(', node.Variables);
		return node;
	}

	private void OutMember(Expression node, Expression instance, MemberInfo member)
	{
		if (instance != null)
		{
			ParenthesizedVisit(node, instance);
			Out("." + member.Name);
		}
		else
		{
			Out(member.DeclaringType.ToString() + "." + member.Name);
		}
	}

	protected internal override Expression VisitMember(MemberExpression node)
	{
		OutMember(node, node.Expression, node.Member);
		return node;
	}

	protected internal override Expression VisitInvocation(InvocationExpression node)
	{
		Out(".Invoke ");
		ParenthesizedVisit(node, node.Expression);
		VisitExpressions('(', node.Arguments);
		return node;
	}

	private static bool NeedsParentheses(Expression parent, Expression child)
	{
		if (child == null)
		{
			return false;
		}
		switch (parent.NodeType)
		{
		case ExpressionType.Decrement:
		case ExpressionType.Increment:
		case ExpressionType.Unbox:
		case ExpressionType.IsTrue:
		case ExpressionType.IsFalse:
			return true;
		default:
		{
			int operatorPrecedence = GetOperatorPrecedence(child);
			int operatorPrecedence2 = GetOperatorPrecedence(parent);
			if (operatorPrecedence == operatorPrecedence2)
			{
				switch (parent.NodeType)
				{
				case ExpressionType.And:
				case ExpressionType.AndAlso:
				case ExpressionType.ExclusiveOr:
				case ExpressionType.Or:
				case ExpressionType.OrElse:
					return false;
				case ExpressionType.Add:
				case ExpressionType.AddChecked:
				case ExpressionType.Multiply:
				case ExpressionType.MultiplyChecked:
					return false;
				case ExpressionType.Divide:
				case ExpressionType.Modulo:
				case ExpressionType.Subtract:
				case ExpressionType.SubtractChecked:
				{
					BinaryExpression binaryExpression = parent as BinaryExpression;
					return child == binaryExpression.Right;
				}
				default:
					return true;
				}
			}
			if (child != null && child.NodeType == ExpressionType.Constant && (parent.NodeType == ExpressionType.Negate || parent.NodeType == ExpressionType.NegateChecked))
			{
				return true;
			}
			return operatorPrecedence < operatorPrecedence2;
		}
		}
	}

	private static int GetOperatorPrecedence(Expression node)
	{
		switch (node.NodeType)
		{
		case ExpressionType.Coalesce:
		case ExpressionType.Assign:
		case ExpressionType.AddAssign:
		case ExpressionType.AndAssign:
		case ExpressionType.DivideAssign:
		case ExpressionType.ExclusiveOrAssign:
		case ExpressionType.LeftShiftAssign:
		case ExpressionType.ModuloAssign:
		case ExpressionType.MultiplyAssign:
		case ExpressionType.OrAssign:
		case ExpressionType.PowerAssign:
		case ExpressionType.RightShiftAssign:
		case ExpressionType.SubtractAssign:
		case ExpressionType.AddAssignChecked:
		case ExpressionType.MultiplyAssignChecked:
		case ExpressionType.SubtractAssignChecked:
			return 1;
		case ExpressionType.OrElse:
			return 2;
		case ExpressionType.AndAlso:
			return 3;
		case ExpressionType.Or:
			return 4;
		case ExpressionType.ExclusiveOr:
			return 5;
		case ExpressionType.And:
			return 6;
		case ExpressionType.Equal:
		case ExpressionType.NotEqual:
			return 7;
		case ExpressionType.GreaterThan:
		case ExpressionType.GreaterThanOrEqual:
		case ExpressionType.LessThan:
		case ExpressionType.LessThanOrEqual:
		case ExpressionType.TypeAs:
		case ExpressionType.TypeIs:
		case ExpressionType.TypeEqual:
			return 8;
		case ExpressionType.LeftShift:
		case ExpressionType.RightShift:
			return 9;
		case ExpressionType.Add:
		case ExpressionType.AddChecked:
		case ExpressionType.Subtract:
		case ExpressionType.SubtractChecked:
			return 10;
		case ExpressionType.Divide:
		case ExpressionType.Modulo:
		case ExpressionType.Multiply:
		case ExpressionType.MultiplyChecked:
			return 11;
		case ExpressionType.Convert:
		case ExpressionType.ConvertChecked:
		case ExpressionType.Negate:
		case ExpressionType.UnaryPlus:
		case ExpressionType.NegateChecked:
		case ExpressionType.Not:
		case ExpressionType.Decrement:
		case ExpressionType.Increment:
		case ExpressionType.Throw:
		case ExpressionType.Unbox:
		case ExpressionType.PreIncrementAssign:
		case ExpressionType.PreDecrementAssign:
		case ExpressionType.OnesComplement:
		case ExpressionType.IsTrue:
		case ExpressionType.IsFalse:
			return 12;
		case ExpressionType.Power:
			return 13;
		default:
			return 14;
		case ExpressionType.Constant:
		case ExpressionType.Parameter:
			return 15;
		}
	}

	private void ParenthesizedVisit(Expression parent, Expression nodeToVisit)
	{
		if (NeedsParentheses(parent, nodeToVisit))
		{
			Out("(");
			Visit(nodeToVisit);
			Out(")");
		}
		else
		{
			Visit(nodeToVisit);
		}
	}

	protected internal override Expression VisitMethodCall(MethodCallExpression node)
	{
		Out(".Call ");
		if (node.Object != null)
		{
			ParenthesizedVisit(node, node.Object);
		}
		else if (node.Method.DeclaringType != null)
		{
			Out(node.Method.DeclaringType.ToString());
		}
		else
		{
			Out("<UnknownType>");
		}
		Out(".");
		Out(node.Method.Name);
		VisitExpressions('(', node.Arguments);
		return node;
	}

	protected internal override Expression VisitNewArray(NewArrayExpression node)
	{
		if (node.NodeType == ExpressionType.NewArrayBounds)
		{
			Out(".NewArray " + node.Type.GetElementType().ToString());
			VisitExpressions('[', node.Expressions);
		}
		else
		{
			Out(".NewArray " + node.Type.ToString(), Flow.Space);
			VisitExpressions('{', node.Expressions);
		}
		return node;
	}

	protected internal override Expression VisitNew(NewExpression node)
	{
		Out(".New " + node.Type.ToString());
		VisitExpressions('(', node.Arguments);
		return node;
	}

	protected override ElementInit VisitElementInit(ElementInit node)
	{
		if (node.Arguments.Count == 1)
		{
			Visit(node.Arguments[0]);
		}
		else
		{
			VisitExpressions('{', node.Arguments);
		}
		return node;
	}

	protected internal override Expression VisitListInit(ListInitExpression node)
	{
		Visit(node.NewExpression);
		VisitExpressions('{', ',', node.Initializers, delegate(ElementInit e)
		{
			VisitElementInit(e);
		});
		return node;
	}

	protected override MemberAssignment VisitMemberAssignment(MemberAssignment assignment)
	{
		Out(assignment.Member.Name);
		Out(Flow.Space, "=", Flow.Space);
		Visit(assignment.Expression);
		return assignment;
	}

	protected override MemberListBinding VisitMemberListBinding(MemberListBinding binding)
	{
		Out(binding.Member.Name);
		Out(Flow.Space, "=", Flow.Space);
		VisitExpressions('{', ',', binding.Initializers, delegate(ElementInit e)
		{
			VisitElementInit(e);
		});
		return binding;
	}

	protected override MemberMemberBinding VisitMemberMemberBinding(MemberMemberBinding binding)
	{
		Out(binding.Member.Name);
		Out(Flow.Space, "=", Flow.Space);
		VisitExpressions('{', ',', binding.Bindings, delegate(MemberBinding e)
		{
			VisitMemberBinding(e);
		});
		return binding;
	}

	protected internal override Expression VisitMemberInit(MemberInitExpression node)
	{
		Visit(node.NewExpression);
		VisitExpressions('{', ',', node.Bindings, delegate(MemberBinding e)
		{
			VisitMemberBinding(e);
		});
		return node;
	}

	protected internal override Expression VisitTypeBinary(TypeBinaryExpression node)
	{
		ParenthesizedVisit(node, node.Expression);
		switch (node.NodeType)
		{
		case ExpressionType.TypeIs:
			Out(Flow.Space, ".Is", Flow.Space);
			break;
		case ExpressionType.TypeEqual:
			Out(Flow.Space, ".TypeEqual", Flow.Space);
			break;
		}
		Out(node.TypeOperand.ToString());
		return node;
	}

	protected internal override Expression VisitUnary(UnaryExpression node)
	{
		switch (node.NodeType)
		{
		case ExpressionType.Convert:
			Out("(" + node.Type.ToString() + ")");
			break;
		case ExpressionType.ConvertChecked:
			Out("#(" + node.Type.ToString() + ")");
			break;
		case ExpressionType.Not:
			Out((node.Type == typeof(bool)) ? "!" : "~");
			break;
		case ExpressionType.OnesComplement:
			Out("~");
			break;
		case ExpressionType.Negate:
			Out("-");
			break;
		case ExpressionType.NegateChecked:
			Out("#-");
			break;
		case ExpressionType.UnaryPlus:
			Out("+");
			break;
		case ExpressionType.Quote:
			Out("'");
			break;
		case ExpressionType.Throw:
			if (node.Operand == null)
			{
				Out(".Rethrow");
			}
			else
			{
				Out(".Throw", Flow.Space);
			}
			break;
		case ExpressionType.IsFalse:
			Out(".IsFalse");
			break;
		case ExpressionType.IsTrue:
			Out(".IsTrue");
			break;
		case ExpressionType.Decrement:
			Out(".Decrement");
			break;
		case ExpressionType.Increment:
			Out(".Increment");
			break;
		case ExpressionType.PreDecrementAssign:
			Out("--");
			break;
		case ExpressionType.PreIncrementAssign:
			Out("++");
			break;
		case ExpressionType.Unbox:
			Out(".Unbox");
			break;
		}
		ParenthesizedVisit(node, node.Operand);
		switch (node.NodeType)
		{
		case ExpressionType.TypeAs:
			Out(Flow.Space, ".As", Flow.Space | Flow.Break);
			Out(node.Type.ToString());
			break;
		case ExpressionType.ArrayLength:
			Out(".Length");
			break;
		case ExpressionType.PostDecrementAssign:
			Out("--");
			break;
		case ExpressionType.PostIncrementAssign:
			Out("++");
			break;
		}
		return node;
	}

	protected internal override Expression VisitBlock(BlockExpression node)
	{
		Out(".Block");
		if (node.Type != node.GetExpression(node.ExpressionCount - 1).Type)
		{
			Out(string.Format(CultureInfo.CurrentCulture, "<{0}>", node.Type.ToString()));
		}
		VisitDeclarations(node.Variables);
		Out(" ");
		VisitExpressions('{', ';', node.Expressions);
		return node;
	}

	protected internal override Expression VisitDefault(DefaultExpression node)
	{
		Out(".Default(" + node.Type.ToString() + ")");
		return node;
	}

	protected internal override Expression VisitLabel(LabelExpression node)
	{
		Out(".Label", Flow.NewLine);
		Indent();
		Visit(node.DefaultValue);
		Dedent();
		NewLine();
		DumpLabel(node.Target);
		return node;
	}

	protected internal override Expression VisitGoto(GotoExpression node)
	{
		Out("." + node.Kind, Flow.Space);
		Out(GetLabelTargetName(node.Target), Flow.Space);
		Out("{", Flow.Space);
		Visit(node.Value);
		Out(Flow.Space, "}");
		return node;
	}

	protected internal override Expression VisitLoop(LoopExpression node)
	{
		Out(".Loop", Flow.Space);
		if (node.ContinueLabel != null)
		{
			DumpLabel(node.ContinueLabel);
		}
		Out(" {", Flow.NewLine);
		Indent();
		Visit(node.Body);
		Dedent();
		Out(Flow.NewLine, "}");
		if (node.BreakLabel != null)
		{
			Out("", Flow.NewLine);
			DumpLabel(node.BreakLabel);
		}
		return node;
	}

	protected override SwitchCase VisitSwitchCase(SwitchCase node)
	{
		foreach (Expression testValue in node.TestValues)
		{
			Out(".Case (");
			Visit(testValue);
			Out("):", Flow.NewLine);
		}
		Indent();
		Indent();
		Visit(node.Body);
		Dedent();
		Dedent();
		NewLine();
		return node;
	}

	protected internal override Expression VisitSwitch(SwitchExpression node)
	{
		Out(".Switch ");
		Out("(");
		Visit(node.SwitchValue);
		Out(") {", Flow.NewLine);
		ExpressionVisitor.Visit(node.Cases, VisitSwitchCase);
		if (node.DefaultBody != null)
		{
			Out(".Default:", Flow.NewLine);
			Indent();
			Indent();
			Visit(node.DefaultBody);
			Dedent();
			Dedent();
			NewLine();
		}
		Out("}");
		return node;
	}

	protected override CatchBlock VisitCatchBlock(CatchBlock node)
	{
		Out(Flow.NewLine, "} .Catch (" + node.Test.ToString());
		if (node.Variable != null)
		{
			Out(Flow.Space, "");
			VisitParameter(node.Variable);
		}
		if (node.Filter != null)
		{
			Out(") .If (", Flow.Break);
			Visit(node.Filter);
		}
		Out(") {", Flow.NewLine);
		Indent();
		Visit(node.Body);
		Dedent();
		return node;
	}

	protected internal override Expression VisitTry(TryExpression node)
	{
		Out(".Try {", Flow.NewLine);
		Indent();
		Visit(node.Body);
		Dedent();
		ExpressionVisitor.Visit(node.Handlers, VisitCatchBlock);
		if (node.Finally != null)
		{
			Out(Flow.NewLine, "} .Finally {", Flow.NewLine);
			Indent();
			Visit(node.Finally);
			Dedent();
		}
		else if (node.Fault != null)
		{
			Out(Flow.NewLine, "} .Fault {", Flow.NewLine);
			Indent();
			Visit(node.Fault);
			Dedent();
		}
		Out(Flow.NewLine, "}");
		return node;
	}

	protected internal override Expression VisitIndex(IndexExpression node)
	{
		if (node.Indexer != null)
		{
			OutMember(node, node.Object, node.Indexer);
		}
		else
		{
			ParenthesizedVisit(node, node.Object);
		}
		VisitExpressions('[', node.Arguments);
		return node;
	}

	protected internal override Expression VisitExtension(Expression node)
	{
		Out(string.Format(CultureInfo.CurrentCulture, ".Extension<{0}>", node.GetType().ToString()));
		if (node.CanReduce)
		{
			Out(Flow.Space, "{", Flow.NewLine);
			Indent();
			Visit(node.Reduce());
			Dedent();
			Out(Flow.NewLine, "}");
		}
		return node;
	}

	protected internal override Expression VisitDebugInfo(DebugInfoExpression node)
	{
		Out(string.Format(CultureInfo.CurrentCulture, ".DebugInfo({0}: {1}, {2} - {3}, {4})", node.Document.FileName, node.StartLine, node.StartColumn, node.EndLine, node.EndColumn));
		return node;
	}

	private void DumpLabel(LabelTarget target)
	{
		Out(string.Format(CultureInfo.CurrentCulture, ".LabelTarget {0}:", GetLabelTargetName(target)));
	}

	private string GetLabelTargetName(LabelTarget target)
	{
		if (string.IsNullOrEmpty(target.Name))
		{
			return "#Label" + GetLabelTargetId(target);
		}
		return GetDisplayName(target.Name);
	}

	private void WriteLambda(LambdaExpression lambda)
	{
		Out(string.Format(CultureInfo.CurrentCulture, ".Lambda {0}<{1}>", GetLambdaName(lambda), lambda.Type.ToString()));
		VisitDeclarations(lambda.Parameters);
		Out(Flow.Space, "{", Flow.NewLine);
		Indent();
		Visit(lambda.Body);
		Dedent();
		Out(Flow.NewLine, "}");
	}

	private string GetLambdaName(LambdaExpression lambda)
	{
		if (string.IsNullOrEmpty(lambda.Name))
		{
			return "#Lambda" + GetLambdaId(lambda);
		}
		return GetDisplayName(lambda.Name);
	}

	private static bool ContainsWhiteSpace(string name)
	{
		for (int i = 0; i < name.Length; i++)
		{
			if (char.IsWhiteSpace(name[i]))
			{
				return true;
			}
		}
		return false;
	}

	private static string QuoteName(string name)
	{
		return string.Format(CultureInfo.CurrentCulture, "'{0}'", name);
	}

	private static string GetDisplayName(string name)
	{
		if (ContainsWhiteSpace(name))
		{
			return QuoteName(name);
		}
		return name;
	}
}
