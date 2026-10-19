using System.Collections.Generic;

namespace YooAsset;

internal class WebRequestCounter
{
	private static readonly Dictionary<string, int> _requestFailedRecorder = new Dictionary<string, int>(1000);

	public static void RecordRequestFailed(string packageName, string eventName)
	{
		string key = packageName + "_" + eventName;
		if (!_requestFailedRecorder.ContainsKey(key))
		{
			_requestFailedRecorder.Add(key, 0);
		}
		_requestFailedRecorder[key]++;
	}

	public static int GetRequestFailedCount(string packageName, string eventName)
	{
		string key = packageName + "_" + eventName;
		if (!_requestFailedRecorder.ContainsKey(key))
		{
			_requestFailedRecorder.Add(key, 0);
		}
		return _requestFailedRecorder[key];
	}
}
