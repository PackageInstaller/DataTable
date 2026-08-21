using System;
using System.Collections;
using System.Collections.Generic;
using System.Text;
using Cysharp.Threading.Tasks;
using GameFramework.Runtime;
using Newtonsoft.Json;
using UnityEngine.Networking;

namespace Ase;

public static class ServiceHelper
{
	public static IEnumerator SendWebRequest(GameFramework.Runtime.IPromise<WebRequestResult> promise, string url, Dictionary<string, string> data, bool showToast = true)
	{
		byte[] bytes = Encoding.Default.GetBytes(JsonConvert.SerializeObject(data));
		UnityWebRequest request = new UnityWebRequest(url, "POST");
		request.uploadHandler = (UploadHandler)new UploadHandlerRaw(bytes);
		request.downloadHandler = (DownloadHandler)new DownloadHandlerBuffer();
		request.timeout = 5;
		request.SetRequestHeader("Content-Type", "application/json;charset=utf-8");
		yield return request.SendWebRequest();
		promise.SetResult(GetWebRequestResult(request, showToast));
	}

	public static WebRequestResult GetWebRequestResult(UnityWebRequest request, bool showToast = true)
	{
		if (request.isHttpError || request.isNetworkError || request.responseCode != 200)
		{
			if (showToast)
			{
				Toast.ShowInfo(request.error);
			}
			return new WebRequestResult
			{
				code = -1
			};
		}
		try
		{
			WebRequestResult webRequestResult = JsonConvert.DeserializeObject<WebRequestResult>(Encoding.UTF8.GetString(request.downloadHandler.data, 3, request.downloadHandler.data.Length - 3));
			if (showToast && webRequestResult.Error())
			{
				Toast.ShowInfo(webRequestResult.msg);
			}
			return webRequestResult;
		}
		catch (Exception ex)
		{
			Toast.ShowError(ex.Message);
		}
		return new WebRequestResult
		{
			code = -1
		};
	}

	public static async UniTask RequestDataInPropTable()
	{
		IRoleService service = Singleton<ServiceSystem>.Instance.GetService<IRoleService>();
		if (service != null)
		{
			await service.RequestUserBaseInfo();
		}
		IKnapsackService service2 = Singleton<ServiceSystem>.Instance.GetService<IKnapsackService>();
		if (service2 != null)
		{
			await service2.RequestKnapsackData();
		}
	}
}
