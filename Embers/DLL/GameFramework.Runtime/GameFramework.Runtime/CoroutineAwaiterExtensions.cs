using System;
using System.Collections;
using UnityEngine;
using UnityEngine.Networking;

namespace GameFramework.Runtime;

public static class CoroutineAwaiterExtensions
{
	private static CoroutineAwaiter RunOnCoroutine(IEnumerator routine)
	{
		CoroutineAwaiter awaiter = new CoroutineAwaiter();
		InterceptableEnumerator interceptableEnumerator = ((routine is InterceptableEnumerator) ? ((InterceptableEnumerator)routine) : InterceptableEnumerator.Create(routine));
		interceptableEnumerator.RegisterCatchBlock(delegate(Exception e)
		{
			awaiter.SetResult(e);
		});
		interceptableEnumerator.RegisterFinallyBlock(delegate
		{
			if (!awaiter.IsCompleted)
			{
				awaiter.SetResult(null);
			}
		});
		Executors.RunOnCoroutineNoReturn(interceptableEnumerator);
		return awaiter;
	}

	private static IEnumerator DoYieldInstruction(YieldInstruction instruction, CoroutineAwaiter awaiter)
	{
		yield return instruction;
		awaiter.SetResult(null);
	}

	private static IEnumerator DoYieldInstruction(CustomYieldInstruction instruction, CoroutineAwaiter<CustomYieldInstruction> awaiter)
	{
		yield return instruction;
		awaiter.SetResult(instruction, null);
	}

	public static IAwaiter GetAwaiter(this IEnumerator coroutine)
	{
		return RunOnCoroutine(coroutine);
	}

	public static IAwaiter GetAwaiter(this YieldInstruction instruction)
	{
		CoroutineAwaiter coroutineAwaiter = new CoroutineAwaiter();
		Executors.RunOnCoroutineNoReturn(DoYieldInstruction(instruction, coroutineAwaiter));
		return coroutineAwaiter;
	}

	public static IAwaiter GetAwaiter(this WaitForMainThread instruction)
	{
		CoroutineAwaiter awaiter = new CoroutineAwaiter();
		Executors.RunOnMainThread(delegate
		{
			awaiter.SetResult(null);
		});
		return awaiter;
	}

	public static IAwaiter GetAwaiter(this WaitForBackgroundThread instruction)
	{
		CoroutineAwaiter awaiter = new CoroutineAwaiter();
		Executors.RunAsyncNoReturn(delegate
		{
			awaiter.SetResult(null);
		});
		return awaiter;
	}

	public static IAwaiter<CustomYieldInstruction> GetAwaiter(this CustomYieldInstruction instruction)
	{
		CoroutineAwaiter<CustomYieldInstruction> coroutineAwaiter = new CoroutineAwaiter<CustomYieldInstruction>();
		Executors.RunOnCoroutineNoReturn(DoYieldInstruction(instruction, coroutineAwaiter));
		return coroutineAwaiter;
	}

	public static IAwaiter GetAwaiter(this AsyncOperation target)
	{
		return new AsyncOperationAwaiter(target);
	}

	public static IAwaiter<UnityEngine.Object> GetAwaiter(this ResourceRequest target)
	{
		return new AsyncOperationAwaiter<ResourceRequest, UnityEngine.Object>(target, (ResourceRequest request) => request.asset);
	}

	public static IAwaiter<UnityEngine.Object> GetAwaiter(this AssetBundleRequest target)
	{
		return new AsyncOperationAwaiter<AssetBundleRequest, UnityEngine.Object>(target, (AssetBundleRequest request) => request.asset);
	}

	public static IAwaiter<AssetBundle> GetAwaiter(this AssetBundleCreateRequest target)
	{
		return new AsyncOperationAwaiter<AssetBundleCreateRequest, AssetBundle>(target, (AssetBundleCreateRequest request) => request.assetBundle);
	}

	public static IAwaiter<UnityWebRequest> GetAwaiter(this UnityWebRequestAsyncOperation target)
	{
		return new AsyncOperationAwaiter<UnityWebRequestAsyncOperation, UnityWebRequest>(target, (UnityWebRequestAsyncOperation request) => request.webRequest);
	}

	public static IAwaiter GetAwaiter(this IAsyncResult target)
	{
		return new AsyncResultAwaiter<IAsyncResult>(target);
	}

	public static IAwaiter<TResult> GetAwaiter<TResult>(this IAsyncResult<TResult> target)
	{
		return new AsyncResultAwaiter<IAsyncResult<TResult>, TResult>(target);
	}

	public static IAwaiter GetAwaiter(this AsyncResult target)
	{
		return new AsyncResultAwaiter<IAsyncResult>(target);
	}

	public static IAwaiter<TResult> GetAwaiter<TResult>(this AsyncResult<TResult> target)
	{
		return new AsyncResultAwaiter<IAsyncResult<TResult>, TResult>(target);
	}
}
