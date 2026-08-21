using System;
using System.Collections.Generic;
using System.Runtime.CompilerServices;
using UnityEngine.Networking;

namespace Cysharp.Threading.Tasks;

public class UnityWebRequestException : Exception
{
	[CompilerGenerated]
	private readonly Result _003CResult_003Ek__BackingField;

	private string msg;

	public UnityWebRequest UnityWebRequest { get; }

	public Result Result
	{
		[CompilerGenerated]
		get
		{
			//IL_0001: Unknown result type (might be due to invalid IL or missing references)
			return _003CResult_003Ek__BackingField;
		}
	}

	public string Error { get; }

	public string Text { get; }

	public long ResponseCode { get; }

	public Dictionary<string, string> ResponseHeaders { get; }

	public override string Message
	{
		get
		{
			if (msg == null)
			{
				if (!string.IsNullOrWhiteSpace(Text))
				{
					msg = Error + Environment.NewLine + Text;
				}
				else
				{
					msg = Error;
				}
			}
			return msg;
		}
	}

	public UnityWebRequestException(UnityWebRequest unityWebRequest)
	{
		//IL_000f: Unknown result type (might be due to invalid IL or missing references)
		//IL_0014: Unknown result type (might be due to invalid IL or missing references)
		base._002Ector();
		UnityWebRequest = unityWebRequest;
		Result = unityWebRequest.result;
		Error = unityWebRequest.error;
		ResponseCode = unityWebRequest.responseCode;
		if (UnityWebRequest.downloadHandler != null)
		{
			DownloadHandler downloadHandler = unityWebRequest.downloadHandler;
			DownloadHandlerBuffer val = (DownloadHandlerBuffer)(object)((downloadHandler is DownloadHandlerBuffer) ? downloadHandler : null);
			if (val != null)
			{
				Text = ((DownloadHandler)val).text;
			}
		}
		ResponseHeaders = unityWebRequest.GetResponseHeaders();
	}
}
