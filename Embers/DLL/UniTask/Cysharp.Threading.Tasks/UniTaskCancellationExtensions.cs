using System.Threading;
using Cysharp.Threading.Tasks.Triggers;
using UnityEngine;

namespace Cysharp.Threading.Tasks;

public static class UniTaskCancellationExtensions
{
	public static CancellationToken GetCancellationTokenOnDestroy(this GameObject gameObject)
	{
		return gameObject.GetAsyncDestroyTrigger().CancellationToken;
	}

	public static CancellationToken GetCancellationTokenOnDestroy(this Component component)
	{
		return component.GetAsyncDestroyTrigger().CancellationToken;
	}
}
