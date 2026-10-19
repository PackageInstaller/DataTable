using UnityEngine.Networking;

namespace Cysharp.Threading.Tasks.Internal;

internal static class UnityWebRequestResultExtensions
{
	public static bool IsError(this UnityWebRequest unityWebRequest)
	{
		UnityWebRequest.Result result = unityWebRequest.result;
		if (result != UnityWebRequest.Result.ConnectionError && result != UnityWebRequest.Result.DataProcessingError)
		{
			return result == UnityWebRequest.Result.ProtocolError;
		}
		return true;
	}
}
