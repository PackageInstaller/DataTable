using System.Runtime.CompilerServices;
using System.Threading.Tasks;
using UnityEngine.Networking;

namespace P08.SimBusiness;

public static class UnityWebRequestAsyncOperationEx
{
	public static TaskAwaiter GetAwaiter(this UnityWebRequestAsyncOperation asyncOp)
	{
		TaskCompletionSource<object> tcs = new TaskCompletionSource<object>();
		asyncOp.completed += delegate
		{
			tcs.SetResult(null);
		};
		return ((Task)tcs.Task).GetAwaiter();
	}
}
