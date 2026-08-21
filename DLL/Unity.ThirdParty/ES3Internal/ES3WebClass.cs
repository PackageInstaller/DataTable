using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.Networking;

namespace ES3Internal;

public class ES3WebClass
{
	protected string url;

	protected string apiKey;

	protected List<KeyValuePair<string, string>> formData = new List<KeyValuePair<string, string>>();

	protected UnityWebRequest _webRequest;

	public bool isDone;

	public string error;

	public long errorCode;

	public float uploadProgress
	{
		get
		{
			if (_webRequest == null)
			{
				return 0f;
			}
			return _webRequest.uploadProgress;
		}
	}

	public float downloadProgress
	{
		get
		{
			if (_webRequest == null)
			{
				return 0f;
			}
			return _webRequest.downloadProgress;
		}
	}

	public bool isError
	{
		get
		{
			if (string.IsNullOrEmpty(error))
			{
				return errorCode > 0;
			}
			return true;
		}
	}

	public static bool IsNetworkError(UnityWebRequest www)
	{
		//IL_0001: Unknown result type (might be due to invalid IL or missing references)
		//IL_0007: Invalid comparison between Unknown and I4
		return (int)www.result == 2;
	}

	protected ES3WebClass(string url, string apiKey)
	{
		this.url = url;
		this.apiKey = apiKey;
	}

	public void AddPOSTField(string fieldName, string value)
	{
		formData.Add(new KeyValuePair<string, string>(fieldName, value));
	}

	protected string GetUser(string user, string password)
	{
		if (string.IsNullOrEmpty(user))
		{
			return "";
		}
		if (!string.IsNullOrEmpty(password))
		{
			user += password;
		}
		user = ES3Hash.SHA1Hash(user);
		return user;
	}

	protected WWWForm CreateWWWForm()
	{
		//IL_0000: Unknown result type (might be due to invalid IL or missing references)
		//IL_0006: Expected O, but got Unknown
		WWWForm val = new WWWForm();
		foreach (KeyValuePair<string, string> formDatum in formData)
		{
			val.AddField(formDatum.Key, formDatum.Value);
		}
		return val;
	}

	protected bool HandleError(UnityWebRequest webRequest, bool errorIfDataIsDownloaded)
	{
		if (IsNetworkError(webRequest))
		{
			errorCode = 1L;
			error = "Error: " + webRequest.error;
		}
		else if (webRequest.responseCode >= 400)
		{
			errorCode = webRequest.responseCode;
			if (string.IsNullOrEmpty(webRequest.downloadHandler.text))
			{
				error = $"Server returned {webRequest.responseCode} error with no message";
			}
			else
			{
				error = webRequest.downloadHandler.text;
			}
		}
		else
		{
			if (!errorIfDataIsDownloaded || webRequest.downloadedBytes == 0)
			{
				return false;
			}
			errorCode = 2L;
			error = "Server error: '" + webRequest.downloadHandler.text + "'";
		}
		return true;
	}

	protected IEnumerator SendWebRequest(UnityWebRequest webRequest)
	{
		_webRequest = webRequest;
		yield return webRequest.SendWebRequest();
	}

	protected virtual void Reset()
	{
		error = null;
		errorCode = 0L;
		isDone = false;
	}
}
