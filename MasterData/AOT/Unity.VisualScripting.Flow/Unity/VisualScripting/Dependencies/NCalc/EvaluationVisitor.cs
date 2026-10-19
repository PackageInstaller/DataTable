using System;
using System.Collections.Generic;
using System.Globalization;
using UnityEngine;

namespace Unity.VisualScripting.Dependencies.NCalc;

public class EvaluationVisitor : LogicalExpressionVisitor
{
	private delegate T Func<T>();

	private readonly Flow flow;

	private readonly EvaluateOptions options;

	private bool IgnoreCase => options.HasFlag(EvaluateOptions.IgnoreCase);

	public object Result { get; private set; }

	public Dictionary<string, object> Parameters { get; set; }

	public event EvaluateFunctionHandler EvaluateFunction;

	public event EvaluateParameterHandler EvaluateParameter;

	public EvaluationVisitor(Flow flow, EvaluateOptions options)
	{
		this.flow = flow;
		this.options = options;
	}

	private object Evaluate(LogicalExpression expression)
	{
		expression.Accept(this);
		return Result;
	}

	public override void Visit(TernaryExpression ternary)
	{
		ternary.LeftExpression.Accept(this);
		if (ConversionUtility.Convert<bool>(Result))
		{
			ternary.MiddleExpression.Accept(this);
		}
		else
		{
			ternary.RightExpression.Accept(this);
		}
	}

	public override void Visit(BinaryExpression binary)
	{
		object leftValue = null;
		Func<object> func = () =>
		{
			if (leftValue == null)
			{
				binary.LeftExpression.Accept(this);
				leftValue = Result;
			}
			return leftValue;
		};
		object rightValue = null;
		Func<object> func2 = () =>
		{
			if (rightValue == null)
			{
				binary.RightExpression.Accept(this);
				rightValue = Result;
			}
			return rightValue;
		};
		switch (binary.Type)
		{
		case BinaryExpressionType.And:
			Result = ConversionUtility.Convert<bool>(func()) && ConversionUtility.Convert<bool>(func2());
			break;
		case BinaryExpressionType.Or:
			Result = ConversionUtility.Convert<bool>(func()) || ConversionUtility.Convert<bool>(func2());
			break;
		case BinaryExpressionType.Div:
			Result = OperatorUtility.Divide(func(), func2());
			break;
		case BinaryExpressionType.Equal:
			Result = OperatorUtility.Equal(func(), func2());
			break;
		case BinaryExpressionType.Greater:
			Result = OperatorUtility.GreaterThan(func(), func2());
			break;
		case BinaryExpressionType.GreaterOrEqual:
			Result = OperatorUtility.GreaterThanOrEqual(func(), func2());
			break;
		case BinaryExpressionType.Lesser:
			Result = OperatorUtility.LessThan(func(), func2());
			break;
		case BinaryExpressionType.LesserOrEqual:
			Result = OperatorUtility.LessThanOrEqual(func(), func2());
			break;
		case BinaryExpressionType.Minus:
			Result = OperatorUtility.Subtract(func(), func2());
			break;
		case BinaryExpressionType.Modulo:
			Result = OperatorUtility.Modulo(func(), func2());
			break;
		case BinaryExpressionType.NotEqual:
			Result = OperatorUtility.NotEqual(func(), func2());
			break;
		case BinaryExpressionType.Plus:
			Result = OperatorUtility.Add(func(), func2());
			break;
		case BinaryExpressionType.Times:
			Result = OperatorUtility.Multiply(func(), func2());
			break;
		case BinaryExpressionType.BitwiseAnd:
			Result = OperatorUtility.And(func(), func2());
			break;
		case BinaryExpressionType.BitwiseOr:
			Result = OperatorUtility.Or(func(), func2());
			break;
		case BinaryExpressionType.BitwiseXOr:
			Result = OperatorUtility.ExclusiveOr(func(), func2());
			break;
		case BinaryExpressionType.LeftShift:
			Result = OperatorUtility.LeftShift(func(), func2());
			break;
		case BinaryExpressionType.RightShift:
			Result = OperatorUtility.RightShift(func(), func2());
			break;
		}
	}

	public override void Visit(UnaryExpression unary)
	{
		unary.Expression.Accept(this);
		switch (unary.Type)
		{
		case UnaryExpressionType.Not:
			Result = !ConversionUtility.Convert<bool>(Result);
			break;
		case UnaryExpressionType.Negate:
			Result = OperatorUtility.Negate(Result);
			break;
		case UnaryExpressionType.BitwiseNot:
			Result = OperatorUtility.Not(Result);
			break;
		}
	}

	public override void Visit(ValueExpression value)
	{
		Result = value.Value;
	}

	public override void Visit(FunctionExpression function)
	{
		FunctionArgs functionArgs = new FunctionArgs
		{
			Parameters = new Expression[function.Expressions.Length]
		};
		for (int i = 0; i < function.Expressions.Length; i++)
		{
			functionArgs.Parameters[i] = new Expression(function.Expressions[i], options);
			functionArgs.Parameters[i].EvaluateFunction += EvaluateFunction;
			functionArgs.Parameters[i].EvaluateParameter += EvaluateParameter;
			functionArgs.Parameters[i].Parameters = Parameters;
		}
		OnEvaluateFunction(IgnoreCase ? function.Identifier.Name.ToLower() : function.Identifier.Name, functionArgs);
		if (functionArgs.HasResult)
		{
			Result = functionArgs.Result;
			return;
		}
		switch (function.Identifier.Name.ToLower(CultureInfo.InvariantCulture))
		{
		case "abs":
			CheckCase(function, "Abs");
			CheckExactArgumentCount(function, 1);
			Result = Mathf.Abs(ConversionUtility.Convert<float>(Evaluate(function.Expressions[0])));
			break;
		case "acos":
			CheckCase(function, "Acos");
			CheckExactArgumentCount(function, 1);
			Result = Mathf.Acos(ConversionUtility.Convert<float>(Evaluate(function.Expressions[0])));
			break;
		case "asin":
			CheckCase(function, "Asin");
			CheckExactArgumentCount(function, 1);
			Result = Mathf.Asin(ConversionUtility.Convert<float>(Evaluate(function.Expressions[0])));
			break;
		case "atan":
			CheckCase(function, "Atan");
			CheckExactArgumentCount(function, 1);
			Result = Mathf.Atan(ConversionUtility.Convert<float>(Evaluate(function.Expressions[0])));
			break;
		case "ceil":
			CheckCase(function, "Ceil");
			CheckExactArgumentCount(function, 1);
			Result = Mathf.Ceil(ConversionUtility.Convert<float>(Evaluate(function.Expressions[0])));
			break;
		case "cos":
			CheckCase(function, "Cos");
			CheckExactArgumentCount(function, 1);
			Result = Mathf.Cos(ConversionUtility.Convert<float>(Evaluate(function.Expressions[0])));
			break;
		case "exp":
			CheckCase(function, "Exp");
			CheckExactArgumentCount(function, 1);
			Result = Mathf.Exp(ConversionUtility.Convert<float>(Evaluate(function.Expressions[0])));
			break;
		case "floor":
			CheckCase(function, "Floor");
			CheckExactArgumentCount(function, 1);
			Result = Mathf.Floor(ConversionUtility.Convert<float>(Evaluate(function.Expressions[0])));
			break;
		case "log":
			CheckCase(function, "Log");
			CheckExactArgumentCount(function, 2);
			Result = Mathf.Log(ConversionUtility.Convert<float>(Evaluate(function.Expressions[0])), ConversionUtility.Convert<float>(Evaluate(function.Expressions[1])));
			break;
		case "log10":
			CheckCase(function, "Log10");
			CheckExactArgumentCount(function, 1);
			Result = Mathf.Log10(ConversionUtility.Convert<float>(Evaluate(function.Expressions[0])));
			break;
		case "pow":
			CheckCase(function, "Pow");
			CheckExactArgumentCount(function, 2);
			Result = Mathf.Pow(ConversionUtility.Convert<float>(Evaluate(function.Expressions[0])), ConversionUtility.Convert<float>(Evaluate(function.Expressions[1])));
			break;
		case "round":
			CheckCase(function, "Round");
			CheckExactArgumentCount(function, 1);
			Result = Mathf.Round(ConversionUtility.Convert<float>(Evaluate(function.Expressions[0])));
			break;
		case "sign":
			CheckCase(function, "Sign");
			CheckExactArgumentCount(function, 1);
			Result = Mathf.Sign(ConversionUtility.Convert<float>(Evaluate(function.Expressions[0])));
			break;
		case "sin":
			CheckCase(function, "Sin");
			CheckExactArgumentCount(function, 1);
			Result = Mathf.Sin(ConversionUtility.Convert<float>(Evaluate(function.Expressions[0])));
			break;
		case "sqrt":
			CheckCase(function, "Sqrt");
			CheckExactArgumentCount(function, 1);
			Result = Mathf.Sqrt(ConversionUtility.Convert<float>(Evaluate(function.Expressions[0])));
			break;
		case "tan":
			CheckCase(function, "Tan");
			CheckExactArgumentCount(function, 1);
			Result = Mathf.Tan(ConversionUtility.Convert<float>(Evaluate(function.Expressions[0])));
			break;
		case "max":
			CheckCase(function, "Max");
			CheckExactArgumentCount(function, 2);
			Result = Mathf.Max(ConversionUtility.Convert<float>(Evaluate(function.Expressions[0])), ConversionUtility.Convert<float>(Evaluate(function.Expressions[1])));
			break;
		case "min":
			CheckCase(function, "Min");
			CheckExactArgumentCount(function, 2);
			Result = Mathf.Min(ConversionUtility.Convert<float>(Evaluate(function.Expressions[0])), ConversionUtility.Convert<float>(Evaluate(function.Expressions[1])));
			break;
		case "in":
		{
			CheckCase(function, "In");
			CheckExactArgumentCount(function, 2);
			object objA = Evaluate(function.Expressions[0]);
			bool flag = false;
			for (int j = 1; j < function.Expressions.Length; j++)
			{
				object objB = Evaluate(function.Expressions[j]);
				if (object.Equals(objA, objB))
				{
					flag = true;
					break;
				}
			}
			Result = flag;
			break;
		}
		default:
			throw new ArgumentException("Function not found", function.Identifier.Name);
		}
	}

	private void CheckCase(FunctionExpression function, string reference)
	{
		string name = function.Identifier.Name;
		if (IgnoreCase)
		{
			if (!string.Equals(name, reference, StringComparison.InvariantCultureIgnoreCase))
			{
				throw new ArgumentException("Function not found.", name);
			}
		}
		else if (name != reference)
		{
			throw new ArgumentException("Function not found: '" + name + "'. Try '" + reference + "' instead.");
		}
	}

	private void OnEvaluateFunction(string name, FunctionArgs args)
	{
		EvaluateFunction?.Invoke(flow, name, args);
	}

	public override void Visit(IdentifierExpression identifier)
	{
		if (Parameters.ContainsKey(identifier.Name))
		{
			if (Parameters[identifier.Name] is Expression)
			{
				Expression expression = (Expression)Parameters[identifier.Name];
				foreach (KeyValuePair<string, object> parameter in Parameters)
				{
					expression.Parameters[parameter.Key] = parameter.Value;
				}
				expression.EvaluateFunction += EvaluateFunction;
				expression.EvaluateParameter += EvaluateParameter;
				Result = ((Expression)Parameters[identifier.Name]).Evaluate(flow);
			}
			else
			{
				Result = Parameters[identifier.Name];
			}
		}
		else
		{
			ParameterArgs parameterArgs = new ParameterArgs();
			OnEvaluateParameter(identifier.Name, parameterArgs);
			if (!parameterArgs.HasResult)
			{
				throw new ArgumentException("Parameter was not defined", identifier.Name);
			}
			Result = parameterArgs.Result;
		}
	}

	private void OnEvaluateParameter(string name, ParameterArgs args)
	{
		EvaluateParameter?.Invoke(flow, name, args);
	}

	public static void CheckExactArgumentCount(FunctionExpression function, int count)
	{
		if (function.Expressions.Length != count)
		{
			throw new ArgumentException($"{function.Identifier.Name}() takes at exactly {count} arguments. {function.Expressions.Length} provided.");
		}
	}

	public static void CheckMinArgumentCount(FunctionExpression function, int count)
	{
		if (function.Expressions.Length < count)
		{
			throw new ArgumentException($"{function.Identifier.Name}() takes at at least {count} arguments. {function.Expressions.Length} provided.");
		}
	}
}
