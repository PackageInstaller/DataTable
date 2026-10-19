namespace UnityEngine;

internal static class UINumericFieldsUtils
{
	public static readonly string k_AllowedCharactersForFloat = "inftynaeINFTYNAE0123456789.,-*/+%^()cosqrludxvRL=pP#";

	public static readonly string k_AllowedCharactersForInt = "0123456789-*/+%^()cosintaqrtelfundxvRL,=pPI#";

	public static readonly string k_DoubleFieldFormatString = "R";

	public static readonly string k_FloatFieldFormatString = "g7";

	public static readonly string k_IntFieldFormatString = "#######0";

	public static bool TryConvertStringToDouble(string str, out double value, out ExpressionEvaluator.Expression expr)
	{
		expr = null;
		switch (str.ToLower())
		{
		case "inf":
		case "infinity":
			value = double.PositiveInfinity;
			break;
		case "-inf":
		case "-infinity":
			value = double.NegativeInfinity;
			break;
		case "nan":
			value = double.NaN;
			break;
		default:
			return ExpressionEvaluator.Evaluate<double>(str, out value, out expr);
		}
		return true;
	}

	public static bool TryConvertStringToDouble(string str, string initialValueAsString, out double value, out ExpressionEvaluator.Expression expression)
	{
		bool flag = TryConvertStringToDouble(str, out value, out expression);
		if (!flag && expression != null && !string.IsNullOrEmpty(initialValueAsString) && TryConvertStringToDouble(initialValueAsString, out var value2, out var _))
		{
			value = value2;
			flag = expression.Evaluate(ref value);
		}
		return flag;
	}

	public static bool TryConvertStringToFloat(string str, string initialValueAsString, out float value, out ExpressionEvaluator.Expression expression)
	{
		bool result = TryConvertStringToDouble(str, initialValueAsString, out var value2, out expression);
		value = Mathf.ClampToFloat(value2);
		return result;
	}

	public static bool TryConvertStringToLong(string str, out long value, out ExpressionEvaluator.Expression expr)
	{
		return ExpressionEvaluator.Evaluate<long>(str, out value, out expr);
	}

	public static bool TryConvertStringToLong(string str, string initialValueAsString, out long value, out ExpressionEvaluator.Expression expression)
	{
		bool flag = TryConvertStringToLong(str, out value, out expression);
		if (!flag && expression != null && !string.IsNullOrEmpty(initialValueAsString) && TryConvertStringToLong(initialValueAsString, out var value2, out var _))
		{
			value = value2;
			flag = expression.Evaluate(ref value);
		}
		return flag;
	}

	public static bool TryConvertStringToULong(string str, out ulong value, out ExpressionEvaluator.Expression expr)
	{
		return ExpressionEvaluator.Evaluate<ulong>(str, out value, out expr);
	}

	public static bool TryConvertStringToULong(string str, string initialValueAsString, out ulong value, out ExpressionEvaluator.Expression expression)
	{
		bool flag = TryConvertStringToULong(str, out value, out expression);
		if (!flag && expression != null && !string.IsNullOrEmpty(initialValueAsString) && TryConvertStringToULong(initialValueAsString, out var value2, out var _))
		{
			value = value2;
			flag = expression.Evaluate(ref value);
		}
		return flag;
	}

	public static bool TryConvertStringToInt(string str, string initialValueAsString, out int value, out ExpressionEvaluator.Expression expression)
	{
		bool result = TryConvertStringToLong(str, initialValueAsString, out var value2, out expression);
		value = Mathf.ClampToInt(value2);
		return result;
	}

	public static bool TryConvertStringToUInt(string str, string initialValueAsString, out uint value, out ExpressionEvaluator.Expression expression)
	{
		bool result = TryConvertStringToLong(str, initialValueAsString, out var value2, out expression);
		value = Mathf.ClampToUInt(value2);
		return result;
	}
}
