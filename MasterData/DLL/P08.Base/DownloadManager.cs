using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using UnityEngine;
using UnityEngine.Events;

public class DownloadManager : MonoBehaviour
{
	public static DownloadManager Instance;

	private string downloadRootUrl = "localhost:8080";

	private int maxDownloadingNum = 5;

	private int downloadRetryTime = 3;

	public long downloadSpeed;

	private long downloadedSize;

	public long downloadedFileSize;

	private long downloadSizeLastSecond;

	private float downloadRuntime;

	private int maxDownloadFailedRetryTime = 5;

	public bool ConfigLoaded;

	private Dictionary<string, DownloadRequest> processingRequest = new Dictionary<string, DownloadRequest>();

	private Dictionary<string, DownloadRequest> succeedRequest = new Dictionary<string, DownloadRequest>();

	private Dictionary<string, DownloadRequest> failedRequest = new Dictionary<string, DownloadRequest>();

	private Dictionary<string, DownloadRequest> waitingRequests = new Dictionary<string, DownloadRequest>();

	private List<DownloadRequest> requestedBeforeInit = new List<DownloadRequest>();

	private List<string> newFinisheds = new List<string>();

	private List<string> newFaileds = new List<string>();

	private string finishedUrl = string.Empty;

	public static EDownloadType sDownloadType;

	public static void Create()
	{
		if (!UnityEngine.Object.FindObjectOfType(typeof(DownloadManager)))
		{
			GameObject obj = new GameObject("DownloadManager", typeof(DownloadManager));
			UnityEngine.Object.DontDestroyOnLoad(obj);
			Instance = obj.GetComponent<DownloadManager>();
			Instance.InitRootUrl();
		}
	}

	public static void Destroy()
	{
		Instance.StopAll();
		UnityEngine.Object.DestroyImmediate(Instance.gameObject);
		Instance = null;
	}

	public void InitRootUrl()
	{
		downloadRootUrl = Platform.GetDownloadURL();
		Debug.Log("游戏的下载目录:" + downloadRootUrl);
		ConfigLoaded = true;
	}

	public string GetError(string url)
	{
		if (!ConfigLoaded)
		{
			return null;
		}
		url = formatUrl(url);
		if (failedRequest.ContainsKey(url))
		{
			return failedRequest[url].GetError();
		}
		return null;
	}

	public DownloadRequest GetWWW(string url)
	{
		if (!ConfigLoaded)
		{
			return null;
		}
		url = formatUrl(url);
		if (succeedRequest.ContainsKey(url))
		{
			return succeedRequest[url];
		}
		return null;
	}

	public void DisposeWWW(string url)
	{
		url = formatUrl(url);
		StopDownload(url);
		if (succeedRequest.ContainsKey(url))
		{
			succeedRequest[url].Pure();
			succeedRequest.Remove(url);
		}
		if (failedRequest.ContainsKey(url))
		{
			failedRequest[url].Pure();
			failedRequest.Remove(url);
		}
	}

	public DownloadRequest StartDownload(string url, object userData = null, int priority = 0)
	{
		DownloadRequest downloadRequest = new DownloadRequest(userData);
		downloadRequest.url = url;
		downloadRequest.priority = priority;
		if (!ConfigLoaded)
		{
			if (!isInBeforeInitList(url))
			{
				requestedBeforeInit.Add(downloadRequest);
			}
		}
		else
		{
			AddtoDownloadList(downloadRequest);
		}
		return downloadRequest;
	}

	public DownloadRequest StartDownloadWithCache(string url, string localPath, UnityAction<DownloadRequest> callback = null, int priority = 0, bool forceDownload = false)
	{
		DownloadRequest downloadRequest = null;
		downloadRequest = new DownloadRequest(localPath, isCache: true);
		downloadRequest.url = url;
		downloadRequest.priority = priority;
		downloadRequest.callback = callback;
		downloadRequest.forceDownload = forceDownload;
		if (!ConfigLoaded)
		{
			if (!isInBeforeInitList(url))
			{
				requestedBeforeInit.Add(downloadRequest);
			}
		}
		else
		{
			AddtoDownloadList(downloadRequest);
		}
		return downloadRequest;
	}

	public DownloadRequest StartDownload(string url, byte[] postData, Dictionary<string, string> header, UnityAction<DownloadRequest> callback, object userData = null, int priority = 0)
	{
		DownloadRequest downloadRequest = new DownloadRequest(url, postData, header, userData);
		downloadRequest.priority = priority;
		downloadRequest.callback = callback;
		if (!ConfigLoaded)
		{
			if (!isInBeforeInitList(url))
			{
				requestedBeforeInit.Add(downloadRequest);
			}
		}
		else
		{
			AddtoDownloadList(downloadRequest);
		}
		return downloadRequest;
	}

	public IEnumerator WaitDownload(string url, int priority)
	{
		yield return null;
	}

	public DownloadRequest GetProcessingWWW(string url)
	{
		if (!ConfigLoaded)
		{
			return null;
		}
		url = formatUrl(url);
		if (processingRequest.ContainsKey(url))
		{
			return processingRequest[url];
		}
		return null;
	}

	public void StopDownload(string url)
	{
		if (!ConfigLoaded)
		{
			requestedBeforeInit.RemoveAll((DownloadRequest x) => x.url == url);
			return;
		}
		url = formatUrl(url);
		waitingRequests.Remove(url);
		if (processingRequest.ContainsKey(url))
		{
			processingRequest[url].Pure();
			processingRequest.Remove(url);
		}
	}

	public void StopAll()
	{
		requestedBeforeInit.Clear();
		waitingRequests.Clear();
		foreach (DownloadRequest value in processingRequest.Values)
		{
			value.Pure();
		}
		processingRequest.Clear();
	}

	private void AddtoDownloadList(DownloadRequest request)
	{
		request.url = formatUrl(request.url);
		if (!isDownloadingWWW(request.url) && !succeedRequest.ContainsKey(request.url))
		{
			addRequestToWaitingList(request);
		}
	}

	private string formatUrl(string urlstr)
	{
		Uri uri = (isAbsoluteUrl(urlstr) ? new Uri(urlstr) : new Uri(new Uri(downloadRootUrl + "/"), urlstr));
		return uri.AbsoluteUri;
	}

	private bool isAbsoluteUrl(string url)
	{
		Uri result;
		return Uri.TryCreate(url, UriKind.Absolute, out result);
	}

	private bool isInWaitingList(string url)
	{
		return waitingRequests.ContainsKey(url);
	}

	private void addRequestToWaitingList(DownloadRequest request)
	{
		if (!succeedRequest.ContainsKey(request.url) && !isInWaitingList(request.url))
		{
			waitingRequests.Add(request.url, request);
		}
	}

	private bool isDownloadingWWW(string url)
	{
		if (isInWaitingList(url))
		{
			return true;
		}
		return processingRequest.ContainsKey(url);
	}

	private bool isInBeforeInitList(string url)
	{
		foreach (DownloadRequest item in requestedBeforeInit)
		{
			if (item.url == url)
			{
				return true;
			}
		}
		return false;
	}

	public List<string> GetDependList(string bundle)
	{
		return getDependList(bundle);
	}

	private List<string> getDependList(string bundle)
	{
		return new List<string>();
	}

	private void Update()
	{
		if (!ConfigLoaded)
		{
			return;
		}
		downloadRuntime += Time.unscaledDeltaTime;
		if (downloadRuntime > 1f)
		{
			downloadSpeed = downloadedSize - downloadSizeLastSecond;
			downloadRuntime--;
			downloadSizeLastSecond = downloadedSize;
		}
		if (EDownloadType.Pause == sDownloadType)
		{
			return;
		}
		newFinisheds.Clear();
		newFaileds.Clear();
		Dictionary<string, DownloadRequest>.Enumerator enumerator = processingRequest.GetEnumerator();
		while (enumerator.MoveNext())
		{
			DownloadRequest value = enumerator.Current.Value;
			downloadedSize += value.deltaDownloadBytes;
			downloadedFileSize += value.deltaFileSize;
			if (!value.isDone)
			{
				continue;
			}
			if (!string.IsNullOrEmpty(value.GetError()))
			{
				if (value.triedTimes - 1 < downloadRetryTime)
				{
					Debug.LogWarning(value.url + " has error： " + value.GetError() + ",code: " + value.GetWWW().responseCode);
					value.CreateWWW();
					continue;
				}
				newFaileds.Add(value.url);
				if (value.GetError().Contains("System.IO.IOException: Win32 IO returned 112."))
				{
					break;
				}
				Debug.LogWarning("Download " + value.url + " failed for " + value.triedTimes + " times.\nError: " + value.GetError());
			}
			else
			{
				newFinisheds.Add(value.url);
			}
		}
		for (int i = 0; i < newFinisheds.Count; i++)
		{
			finishedUrl = newFinisheds[i];
			DownloadRequest downloadRequest = processingRequest[finishedUrl];
			if (succeedRequest.ContainsKey(finishedUrl))
			{
				Debug.LogError(finishedUrl + " has same key");
			}
			else
			{
				succeedRequest.Add(finishedUrl, downloadRequest);
			}
			if (downloadRequest.callback != null)
			{
				downloadRequest.callback(downloadRequest);
			}
			processingRequest.Remove(finishedUrl);
		}
		for (int j = 0; j < newFaileds.Count; j++)
		{
			finishedUrl = newFaileds[j];
			DownloadRequest downloadRequest2 = processingRequest[finishedUrl];
			if (!failedRequest.ContainsKey(finishedUrl))
			{
				failedRequest.Add(finishedUrl, downloadRequest2);
			}
			processingRequest.Remove(finishedUrl);
			if (downloadRequest2.callback != null)
			{
				downloadRequest2.callback(downloadRequest2);
			}
		}
		int num = 0;
		while (processingRequest.Count < maxDownloadingNum && num < waitingRequests.Count)
		{
			num++;
			DownloadRequest value2 = waitingRequests.First().Value;
			waitingRequests.Remove(value2.url);
			value2.CreateWWW();
			processingRequest.Add(value2.url, value2);
		}
	}

	public int GetWaitingRequestsCount()
	{
		if (waitingRequests != null)
		{
			return waitingRequests.Count;
		}
		return 0;
	}

	public int GetFailedRequestsCount()
	{
		if (failedRequest != null)
		{
			return failedRequest.Count;
		}
		return 0;
	}

	public int GetProcessingRequestsCount()
	{
		if (processingRequest != null)
		{
			return processingRequest.Count;
		}
		return 0;
	}

	public void TryFixFailedRequest(DownloadRequest downloadRequest, string newUrl)
	{
		if (failedRequest.ContainsKey(downloadRequest.url))
		{
			failedRequest.Remove(downloadRequest.url);
			downloadRequest.triedTimes = 0;
			downloadRequest.url = newUrl;
			AddtoDownloadList(downloadRequest);
		}
	}

	private void OnApplicationQuit()
	{
		foreach (KeyValuePair<string, DownloadRequest> item in succeedRequest)
		{
			item.Value.Pure();
		}
	}
}
