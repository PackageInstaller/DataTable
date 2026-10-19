using System;
using UnityEngine.Networking;

namespace UnityEngine.ResourceManagement.Util;

public class UnityWebRequestUtilities
{
	public static bool RequestHasErrors(UnityWebRequest webReq, out UnityWebRequestResult result)
	{
		result = null;
		if (webReq == null || !webReq.isDone)
		{
			return false;
		}
		switch (webReq.result)
		{
		case UnityWebRequest.Result.InProgress:
		case UnityWebRequest.Result.Success:
			return false;
		case UnityWebRequest.Result.ConnectionError:
		case UnityWebRequest.Result.ProtocolError:
		case UnityWebRequest.Result.DataProcessingError:
			result = new UnityWebRequestResult(webReq);
			return true;
		default:
			throw new NotImplementedException($"Cannot determine whether UnityWebRequest succeeded or not from result : {webReq.result}");
		}
	}

	public static bool IsAssetBundleDownloaded(UnityWebRequestAsyncOperation op)
	{
		DownloadHandlerAssetBundle downloadHandlerAssetBundle = (DownloadHandlerAssetBundle)op.webRequest.downloadHandler;
		if (downloadHandlerAssetBundle != null && downloadHandlerAssetBundle.autoLoadAssetBundle)
		{
			return downloadHandlerAssetBundle.isDownloadComplete;
		}
		return op.isDone;
	}
}
