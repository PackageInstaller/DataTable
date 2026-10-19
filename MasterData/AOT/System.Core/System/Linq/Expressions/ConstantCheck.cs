using System.Dynamic.Utils;

namespace System.Linq.Expressions;

internal static class ConstantCheck
{
	internal static AnalyzeTypeIsResult AnalyzeTypeIs(TypeBinaryExpression typeIs)
	{
		return AnalyzeTypeIs(typeIs.Expression, typeIs.TypeOperand);
	}

	private static AnalyzeTypeIsResult AnalyzeTypeIs(Expression operand, Type testType)
	{
		Type type = operand.Type;
		if (type == typeof(void))
		{
			if (!(testType == typeof(void)))
			{
				return AnalyzeTypeIsResult.KnownFalse;
			}
			return AnalyzeTypeIsResult.KnownTrue;
		}
		if (testType == typeof(void) || testType.IsPointer)
		{
			return AnalyzeTypeIsResult.KnownFalse;
		}
		Type nonNullableType = type.GetNonNullableType();
		if (testType.GetNonNullableType().IsAssignableFrom(nonNullableType))
		{
			if (type.IsValueType && !type.IsNullableType())
			{
				return AnalyzeTypeIsResult.KnownTrue;
			}
			return AnalyzeTypeIsResult.KnownAssignable;
		}
		return AnalyzeTypeIsResult.Unknown;
	}
}
