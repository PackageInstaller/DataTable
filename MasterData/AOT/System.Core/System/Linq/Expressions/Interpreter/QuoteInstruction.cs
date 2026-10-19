using System.Collections.Generic;
using System.Dynamic.Utils;
using System.Runtime.CompilerServices;

namespace System.Linq.Expressions.Interpreter;

internal sealed class QuoteInstruction : Instruction
{
	private sealed class ExpressionQuoter : ExpressionVisitor
	{
		private readonly Dictionary<ParameterExpression, LocalVariable> _variables;

		private readonly InterpretedFrame _frame;

		private readonly Stack<HashSet<ParameterExpression>> _shadowedVars = new Stack<HashSet<ParameterExpression>>();

		internal ExpressionQuoter(Dictionary<ParameterExpression, LocalVariable> hoistedVariables, InterpretedFrame frame)
		{
			_variables = hoistedVariables;
			_frame = frame;
		}

		protected internal override Expression VisitLambda<T>(Expression<T> node)
		{
			if (node.ParameterCount > 0)
			{
				HashSet<ParameterExpression> hashSet = new HashSet<ParameterExpression>();
				int i = 0;
				for (int parameterCount = node.ParameterCount; i < parameterCount; i++)
				{
					hashSet.Add(node.GetParameter(i));
				}
				_shadowedVars.Push(hashSet);
			}
			Expression expression = Visit(node.Body);
			if (node.ParameterCount > 0)
			{
				_shadowedVars.Pop();
			}
			if (expression == node.Body)
			{
				return node;
			}
			return node.Rewrite(expression, null);
		}

		protected internal override Expression VisitBlock(BlockExpression node)
		{
			if (node.Variables.Count > 0)
			{
				_shadowedVars.Push(new HashSet<ParameterExpression>(node.Variables));
			}
			Expression[] array = ExpressionVisitorUtils.VisitBlockExpressions(this, node);
			if (node.Variables.Count > 0)
			{
				_shadowedVars.Pop();
			}
			if (array == null)
			{
				return node;
			}
			return node.Rewrite(node.Variables, array);
		}

		protected override CatchBlock VisitCatchBlock(CatchBlock node)
		{
			if (node.Variable != null)
			{
				_shadowedVars.Push(new HashSet<ParameterExpression> { node.Variable });
			}
			Expression expression = Visit(node.Body);
			Expression expression2 = Visit(node.Filter);
			if (node.Variable != null)
			{
				_shadowedVars.Pop();
			}
			if (expression == node.Body && expression2 == node.Filter)
			{
				return node;
			}
			return Expression.MakeCatchBlock(node.Test, node.Variable, expression, expression2);
		}

		protected internal override Expression VisitParameter(ParameterExpression node)
		{
			IStrongBox box = GetBox(node);
			if (box == null)
			{
				return node;
			}
			return Expression.Convert(Expression.Field(Expression.Constant(box), "Value"), node.Type);
		}

		private IStrongBox GetBox(ParameterExpression variable)
		{
			if (_variables.TryGetValue(variable, out var value))
			{
				if (value.InClosure)
				{
					return _frame.Closure[value.Index];
				}
				return (IStrongBox)_frame.Data[value.Index];
			}
			return null;
		}
	}

	private readonly Expression _operand;

	private readonly Dictionary<ParameterExpression, LocalVariable> _hoistedVariables;

	public override int ProducedStack => 1;

	public override string InstructionName => "Quote";

	public QuoteInstruction(Expression operand, Dictionary<ParameterExpression, LocalVariable> hoistedVariables)
	{
		_operand = operand;
		_hoistedVariables = hoistedVariables;
	}

	public override int Run(InterpretedFrame frame)
	{
		Expression expression = _operand;
		if (_hoistedVariables != null)
		{
			expression = new ExpressionQuoter(_hoistedVariables, frame).Visit(expression);
		}
		frame.Push(expression);
		return 1;
	}
}
