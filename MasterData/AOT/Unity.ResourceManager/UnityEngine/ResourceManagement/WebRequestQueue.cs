using System;
using System.Collections.Generic;
using System.Threading;
using UnityEngine.Networking;
using UnityEngine.ResourceManagement.Util;

namespace UnityEngine.ResourceManagement;

public static class WebRequestQueue
{
	internal static int s_MaxRequest = 3;

	internal static Queue<WebRequestQueueOperation> s_QueuedOperations = new Queue<WebRequestQueueOperation>();

	internal static List<UnityWebRequestAsyncOperation> s_ActiveRequests = new List<UnityWebRequestAsyncOperation>();

	public static void SetMaxConcurrentRequests(int maxRequests)
	{
		if (maxRequests < 1)
		{
			throw new ArgumentException("MaxRequests must be 1 or greater.", "maxRequests");
		}
		s_MaxRequest = maxRequests;
	}

	public static WebRequestQueueOperation QueueRequest(UnityWebRequest request)
	{
		WebRequestQueueOperation webRequestQueueOperation = new WebRequestQueueOperation(request);
		if (s_ActiveRequests.Count < s_MaxRequest)
		{
			BeginWebRequest(webRequestQueueOperation);
		}
		else
		{
			s_QueuedOperations.Enqueue(webRequestQueueOperation);
		}
		return webRequestQueueOperation;
	}

	public static void WaitForRequestToBeActive(WebRequestQueueOperation request, int millisecondsTimeout)
	{
		List<UnityWebRequestAsyncOperation> list = new List<UnityWebRequestAsyncOperation>();
		while (s_QueuedOperations.Contains(request))
		{
			list.Clear();
			foreach (UnityWebRequestAsyncOperation s_ActiveRequest in s_ActiveRequests)
			{
				if (UnityWebRequestUtilities.IsAssetBundleDownloaded(s_ActiveRequest))
				{
					list.Add(s_ActiveRequest);
				}
			}
			foreach (UnityWebRequestAsyncOperation item in list)
			{
				bool flag = s_QueuedOperations.Peek() == request;
				item.completed -= OnWebAsyncOpComplete;
				OnWebAsyncOpComplete(item);
				if (flag)
				{
					return;
				}
			}
			Thread.Sleep(millisecondsTimeout);
		}
	}

	internal static void DequeueRequest(UnityWebRequestAsyncOperation operation)
	{
		operation.completed -= OnWebAsyncOpComplete;
		OnWebAsyncOpComplete(operation);
	}

	private static void OnWebAsyncOpComplete(AsyncOperation operation)
	{
		OnWebAsyncOpComplete(operation as UnityWebRequestAsyncOperation);
	}

	private static void OnWebAsyncOpComplete(UnityWebRequestAsyncOperation operation)
	{
		if (s_ActiveRequests.Remove(operation) && s_QueuedOperations.Count > 0)
		{
			BeginWebRequest(s_QueuedOperations.Dequeue());
		}
	}

	private static void BeginWebRequest(WebRequestQueueOperation queueOperation)
	{
		UnityWebRequest webRequest = queueOperation.m_WebRequest;
		UnityWebRequestAsyncOperation unityWebRequestAsyncOperation = null;
		try
		{
			unityWebRequestAsyncOperation = webRequest.SendWebRequest();
			if (unityWebRequestAsyncOperation != null)
			{
				s_ActiveRequests.Add(unityWebRequestAsyncOperation);
				if (unityWebRequestAsyncOperation.isDone)
				{
					OnWebAsyncOpComplete(unityWebRequestAsyncOperation);
				}
				else
				{
					unityWebRequestAsyncOperation.completed += OnWebAsyncOpComplete;
				}
			}
			else
			{
				OnWebAsyncOpComplete(null);
			}
		}
		catch (Exception ex)
		{
			Debug.LogError(ex.Message);
		}
		queueOperation.Complete(unityWebRequestAsyncOperation);
	}
}
