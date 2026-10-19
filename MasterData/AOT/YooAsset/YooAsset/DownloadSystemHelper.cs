using UnityEngine.Networking;

namespace YooAsset;

internal class DownloadSystemHelper
{
	public static UnityWebRequestDelegate UnityWebRequestCreater;

	public static UnityWebRequest NewUnityWebRequestGet(string requestURL)
	{
		if (UnityWebRequestCreater != null)
		{
			return UnityWebRequestCreater(requestURL);
		}
		return new UnityWebRequest(requestURL, "GET");
	}

	public static string ConvertToWWWPath(string path)
	{
		string text = ((!path.StartsWith("jar:file://")) ? StringUtility.Format("jar:file://{0}", path) : path);
		return text.Replace("+", "%2B").Replace("#", "%23").Replace("?", "%3F");
	}

	public static bool IsRequestLocalFile(string url)
	{
		if (url.StartsWith("file:"))
		{
			return true;
		}
		if (url.StartsWith("jar:file:"))
		{
			return true;
		}
		return false;
	}
}
