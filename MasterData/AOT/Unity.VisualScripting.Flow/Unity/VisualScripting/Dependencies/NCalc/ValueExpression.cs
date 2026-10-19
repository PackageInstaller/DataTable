using System;

namespace Unity.VisualScripting.Dependencies.NCalc;

public class ValueExpression : LogicalExpression
{
	public object Value { get; set; }

	public ValueType Type { get; set; }

	public ValueExpression(object value, ValueType type)
	{
		Value = value;
		Type = type;
	}

	public ValueExpression(object value)
	{
		switch (System.Type.GetTypeCode(value.GetType()))
		{
		case TypeCode.Boolean:
			Type = ValueType.Boolean;
			break;
		case TypeCode.DateTime:
			Type = ValueType.DateTime;
			break;
		case TypeCode.Single:
		case TypeCode.Double:
		case TypeCode.Decimal:
			Type = ValueType.Float;
			break;
		case TypeCode.SByte:
		case TypeCode.Byte:
		case TypeCode.Int16:
		case TypeCode.UInt16:
		case TypeCode.Int32:
		case TypeCode.UInt32:
		case TypeCode.Int64:
		case TypeCode.UInt64:
			Type = ValueType.Integer;
			break;
		case TypeCode.String:
			Type = ValueType.String;
			break;
		default:
			throw new EvaluationException("This value could not be handled: " + value);
		}
		Value = value;
	}

	public ValueExpression(string value)
	{
		Value = value;
		Type = ValueType.String;
	}

	public ValueExpression(int value)
	{
		Value = value;
		Type = ValueType.Integer;
	}

	public ValueExpression(float value)
	{
		Value = value;
		Type = ValueType.Float;
	}

	public ValueExpression(DateTime value)
	{
		Value = value;
		Type = ValueType.DateTime;
	}

	public ValueExpression(bool value)
	{
		Value = value;
		Type = ValueType.Boolean;
	}

	public override void Accept(LogicalExpressionVisitor visitor)
	{
		visitor.Visit(this);
	}
}
