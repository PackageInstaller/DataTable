using UnityEngine.Networking;

namespace Cysharp.Threading.Tasks.Internal;

internal static class UnityWebRequestResultExtensions
{
	public static bool IsError(this UnityWebRequest unityWebRequest)
	{
		//IL_0001: Unknown result type (might be due to invalid IL or missing references)
		//IL_0006: Unknown result type (might be due to invalid IL or missing references)
		//IL_0007: Unknown result type (might be due to invalid IL or missing references)
		//IL_0009: Invalid comparison between Unknown and I4
		//IL_000b: Unknown result type (might be due to invalid IL or missing references)
		//IL_000d: Invalid comparison between Unknown and I4
		//IL_000f: Unknown result type (might be due to invalid IL or missing references)
		//IL_0011: Invalid comparison between Unknown and I4
		Result result = unityWebRequest.result;
		if ((int)result != 2 && (int)result != 4)
		{
			return (int)result == 3;
		}
		return true;
	}
}
