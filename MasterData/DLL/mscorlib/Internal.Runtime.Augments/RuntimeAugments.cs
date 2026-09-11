using System;
using System.Runtime.ExceptionServices;

namespace Internal.Runtime.Augments;

internal class RuntimeAugments
{
	private static ReflectionExecutionDomainCallbacks s_reflectionExecutionDomainCallbacks = new ReflectionExecutionDomainCallbacks();

	internal static ReflectionExecutionDomainCallbacks Callbacks => s_reflectionExecutionDomainCallbacks;

	public static void ReportUnhandledException(Exception exception)
	{
		ExceptionDispatchInfo.Capture(exception).Throw();
	}
}
