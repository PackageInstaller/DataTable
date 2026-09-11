using System.Globalization;

namespace System.Linq.Expressions.Interpreter;

internal sealed class ExceptionHandler
{
	private readonly Type _exceptionType;

	public readonly int LabelIndex;

	public readonly int HandlerStartIndex;

	public readonly int HandlerEndIndex;

	public readonly ExceptionFilter Filter;

	internal ExceptionHandler(int labelIndex, int handlerStartIndex, int handlerEndIndex, Type exceptionType, ExceptionFilter filter)
	{
		LabelIndex = labelIndex;
		_exceptionType = exceptionType;
		HandlerStartIndex = handlerStartIndex;
		HandlerEndIndex = handlerEndIndex;
		Filter = filter;
	}

	public bool Matches(Type exceptionType)
	{
		return _exceptionType.IsAssignableFrom(exceptionType);
	}

	public override string ToString()
	{
		return string.Format(CultureInfo.InvariantCulture, "catch({0}) [{1}->{2}]", _exceptionType.Name, HandlerStartIndex, HandlerEndIndex);
	}
}
