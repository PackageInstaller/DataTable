using UnityEngine;

namespace ACT;

[DisallowMultipleComponent]
[DefaultExecutionOrder(-32000)]
public sealed class MobileResolutionPolicyWatcher : MonoBehaviour
{
	private static bool s_Installed;

	private void Awake()
	{
		if (s_Installed)
		{
			Debug.LogWarning("[MobileResolutionPolicy] Duplicate scene watcher ignored. object=" + name);
			enabled = false;
			return;
		}
		s_Installed = true;
		Object.DontDestroyOnLoad(gameObject);
		Debug.Log("[MobileResolutionPolicy] Scene watcher installed. object=" + name);
		MobileResolutionPolicy.RefreshRuntimeState();
	}
}
