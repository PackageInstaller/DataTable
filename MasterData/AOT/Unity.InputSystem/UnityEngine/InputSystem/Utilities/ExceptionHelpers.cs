using System;

namespace UnityEngine.InputSystem.Utilities;

internal static class ExceptionHelpers
{
	public static bool IsExceptionIndicatingBugInCode(this Exception exception)
	{
		if (!(exception is NullReferenceException) && !(exception is IndexOutOfRangeException))
		{
			return exception is ArgumentException;
		}
		return true;
	}
}
