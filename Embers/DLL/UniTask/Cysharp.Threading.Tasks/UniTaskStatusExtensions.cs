using System.Runtime.CompilerServices;

namespace Cysharp.Threading.Tasks;

public static class UniTaskStatusExtensions
{
	[MethodImpl((MethodImplOptions)256)]
	public static bool IsCompleted(this UniTaskStatus status)
	{
		return status != UniTaskStatus.Pending;
	}

	[MethodImpl((MethodImplOptions)256)]
	public static bool IsCompletedSuccessfully(this UniTaskStatus status)
	{
		return status == UniTaskStatus.Succeeded;
	}

	[MethodImpl((MethodImplOptions)256)]
	public static bool IsCanceled(this UniTaskStatus status)
	{
		return status == UniTaskStatus.Canceled;
	}

	[MethodImpl((MethodImplOptions)256)]
	public static bool IsFaulted(this UniTaskStatus status)
	{
		return status == UniTaskStatus.Faulted;
	}
}
