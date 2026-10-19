using System;
using System.Text;

namespace Unity.VisualScripting.Dependencies.NCalc;

public abstract class LogicalExpression
{
	private const char BS = '\\';

	public BinaryExpression And(LogicalExpression operand)
	{
		return new BinaryExpression(BinaryExpressionType.And, this, operand);
	}

	public BinaryExpression And(object operand)
	{
		return new BinaryExpression(BinaryExpressionType.And, this, new ValueExpression(operand));
	}

	public BinaryExpression DividedBy(LogicalExpression operand)
	{
		return new BinaryExpression(BinaryExpressionType.Div, this, operand);
	}

	public BinaryExpression DividedBy(object operand)
	{
		return new BinaryExpression(BinaryExpressionType.Div, this, new ValueExpression(operand));
	}

	public BinaryExpression EqualsTo(LogicalExpression operand)
	{
		return new BinaryExpression(BinaryExpressionType.Equal, this, operand);
	}

	public BinaryExpression EqualsTo(object operand)
	{
		return new BinaryExpression(BinaryExpressionType.Equal, this, new ValueExpression(operand));
	}

	public BinaryExpression GreaterThan(LogicalExpression operand)
	{
		return new BinaryExpression(BinaryExpressionType.Greater, this, operand);
	}

	public BinaryExpression GreaterThan(object operand)
	{
		return new BinaryExpression(BinaryExpressionType.Greater, this, new ValueExpression(operand));
	}

	public BinaryExpression GreaterOrEqualThan(LogicalExpression operand)
	{
		return new BinaryExpression(BinaryExpressionType.GreaterOrEqual, this, operand);
	}

	public BinaryExpression GreaterOrEqualThan(object operand)
	{
		return new BinaryExpression(BinaryExpressionType.GreaterOrEqual, this, new ValueExpression(operand));
	}

	public BinaryExpression LesserThan(LogicalExpression operand)
	{
		return new BinaryExpression(BinaryExpressionType.Lesser, this, operand);
	}

	public BinaryExpression LesserThan(object operand)
	{
		return new BinaryExpression(BinaryExpressionType.Lesser, this, new ValueExpression(operand));
	}

	public BinaryExpression LesserOrEqualThan(LogicalExpression operand)
	{
		return new BinaryExpression(BinaryExpressionType.LesserOrEqual, this, operand);
	}

	public BinaryExpression LesserOrEqualThan(object operand)
	{
		return new BinaryExpression(BinaryExpressionType.LesserOrEqual, this, new ValueExpression(operand));
	}

	public BinaryExpression Minus(LogicalExpression operand)
	{
		return new BinaryExpression(BinaryExpressionType.Minus, this, operand);
	}

	public BinaryExpression Minus(object operand)
	{
		return new BinaryExpression(BinaryExpressionType.Minus, this, new ValueExpression(operand));
	}

	public BinaryExpression Modulo(LogicalExpression operand)
	{
		return new BinaryExpression(BinaryExpressionType.Modulo, this, operand);
	}

	public BinaryExpression Modulo(object operand)
	{
		return new BinaryExpression(BinaryExpressionType.Modulo, this, new ValueExpression(operand));
	}

	public BinaryExpression NotEqual(LogicalExpression operand)
	{
		return new BinaryExpression(BinaryExpressionType.NotEqual, this, operand);
	}

	public BinaryExpression NotEqual(object operand)
	{
		return new BinaryExpression(BinaryExpressionType.NotEqual, this, new ValueExpression(operand));
	}

	public BinaryExpression Or(LogicalExpression operand)
	{
		return new BinaryExpression(BinaryExpressionType.Or, this, operand);
	}

	public BinaryExpression Or(object operand)
	{
		return new BinaryExpression(BinaryExpressionType.Or, this, new ValueExpression(operand));
	}

	public BinaryExpression Plus(LogicalExpression operand)
	{
		return new BinaryExpression(BinaryExpressionType.Plus, this, operand);
	}

	public BinaryExpression Plus(object operand)
	{
		return new BinaryExpression(BinaryExpressionType.Plus, this, new ValueExpression(operand));
	}

	public BinaryExpression Mult(LogicalExpression operand)
	{
		return new BinaryExpression(BinaryExpressionType.Times, this, operand);
	}

	public BinaryExpression Mult(object operand)
	{
		return new BinaryExpression(BinaryExpressionType.Times, this, new ValueExpression(operand));
	}

	public BinaryExpression BitwiseOr(LogicalExpression operand)
	{
		return new BinaryExpression(BinaryExpressionType.BitwiseOr, this, operand);
	}

	public BinaryExpression BitwiseOr(object operand)
	{
		return new BinaryExpression(BinaryExpressionType.BitwiseOr, this, new ValueExpression(operand));
	}

	public BinaryExpression BitwiseAnd(LogicalExpression operand)
	{
		return new BinaryExpression(BinaryExpressionType.BitwiseAnd, this, operand);
	}

	public BinaryExpression BitwiseAnd(object operand)
	{
		return new BinaryExpression(BinaryExpressionType.BitwiseAnd, this, new ValueExpression(operand));
	}

	public BinaryExpression BitwiseXOr(LogicalExpression operand)
	{
		return new BinaryExpression(BinaryExpressionType.BitwiseXOr, this, operand);
	}

	public BinaryExpression BitwiseXOr(object operand)
	{
		return new BinaryExpression(BinaryExpressionType.BitwiseXOr, this, new ValueExpression(operand));
	}

	public BinaryExpression LeftShift(LogicalExpression operand)
	{
		return new BinaryExpression(BinaryExpressionType.LeftShift, this, operand);
	}

	public BinaryExpression LeftShift(object operand)
	{
		return new BinaryExpression(BinaryExpressionType.LeftShift, this, new ValueExpression(operand));
	}

	public BinaryExpression RightShift(LogicalExpression operand)
	{
		return new BinaryExpression(BinaryExpressionType.RightShift, this, operand);
	}

	public BinaryExpression RightShift(object operand)
	{
		return new BinaryExpression(BinaryExpressionType.RightShift, this, new ValueExpression(operand));
	}

	public override string ToString()
	{
		SerializationVisitor serializationVisitor = new SerializationVisitor();
		Accept(serializationVisitor);
		return serializationVisitor.Result.ToString().TrimEnd(' ');
	}

	public virtual void Accept(LogicalExpressionVisitor visitor)
	{
		throw new NotImplementedException();
	}

	private static string ExtractString(string text)
	{
		StringBuilder stringBuilder = new StringBuilder(text);
		int startIndex = 1;
		int num = -1;
		while ((num = stringBuilder.ToString().IndexOf('\\', startIndex)) != -1)
		{
			char c = stringBuilder[num + 1];
			switch (c)
			{
			case 'u':
			{
				string value = string.Concat(stringBuilder[num + 4], stringBuilder[num + 5]);
				string value2 = string.Concat(stringBuilder[num + 2], stringBuilder[num + 3]);
				char value3 = Encoding.Unicode.GetChars(new byte[2]
				{
					Convert.ToByte(value, 16),
					Convert.ToByte(value2, 16)
				})[0];
				stringBuilder.Remove(num, 6).Insert(num, value3);
				break;
			}
			case 'n':
				stringBuilder.Remove(num, 2).Insert(num, '\n');
				break;
			case 'r':
				stringBuilder.Remove(num, 2).Insert(num, '\r');
				break;
			case 't':
				stringBuilder.Remove(num, 2).Insert(num, '\t');
				break;
			case '\'':
				stringBuilder.Remove(num, 2).Insert(num, '\'');
				break;
			case '\\':
				stringBuilder.Remove(num, 2).Insert(num, '\\');
				break;
			default:
				throw new ApplicationException("Unvalid escape sequence: \\" + c);
			}
			startIndex = num + 1;
		}
		stringBuilder.Remove(0, 1);
		stringBuilder.Remove(stringBuilder.Length - 1, 1);
		return stringBuilder.ToString();
	}
}
