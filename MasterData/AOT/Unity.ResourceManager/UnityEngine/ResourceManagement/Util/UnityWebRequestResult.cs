using System.Text;
using UnityEngine.Networking;

namespace UnityEngine.ResourceManagement.Util;

public class UnityWebRequestResult
{
	public string Error { get; set; }

	public long ResponseCode { get; }

	public UnityWebRequest.Result Result { get; }

	public string Method { get; }

	public string Url { get; }

	public UnityWebRequestResult(UnityWebRequest request)
	{
		string text = request.error;
		if (request.result == UnityWebRequest.Result.DataProcessingError && request.downloadHandler != null)
		{
			text = text + " : " + request.downloadHandler.error;
		}
		Result = request.result;
		Error = text;
		ResponseCode = request.responseCode;
		Method = request.method;
		Url = request.url;
	}

	public override string ToString()
	{
		StringBuilder stringBuilder = new StringBuilder();
		stringBuilder.AppendLine($"{Result} : {Error}");
		if (ResponseCode > 0)
		{
			stringBuilder.AppendLine($"ResponseCode : {ResponseCode}, Method : {Method}");
		}
		stringBuilder.AppendLine("url : " + Url);
		return stringBuilder.ToString();
	}

	public bool ShouldRetryDownloadError()
	{
		if (string.IsNullOrEmpty(Error))
		{
			return true;
		}
		if (Error == "Request aborted" || Error == "Unable to write data" || Error == "Malformed URL" || Error == "Out of memory" || Error == "Encountered invalid redirect (missing Location header?)" || Error == "Cannot modify request at this time" || Error == "Unsupported Protocol" || Error == "Destination host has an erroneous SSL certificate" || Error == "Unable to load SSL Cipher for verification" || Error == "SSL CA certificate error" || Error == "Unrecognized content-encoding" || Error == "Request already transmitted" || Error == "Invalid HTTP Method" || Error == "Header name contains invalid characters" || Error == "Header value contains invalid characters" || Error == "Cannot override system-specified headers" || Error == "Insecure connection not allowed")
		{
			return false;
		}
		return true;
	}
}
