using System.Reflection;
using System.Runtime.ExceptionServices;

namespace System.Linq.Expressions.Interpreter;

internal static class ExceptionHelpers
{
	public static void UnwrapAndRethrow(TargetInvocationException exception)
	{
		ExceptionDispatchInfo.Throw(exception.InnerException);
	}
}
