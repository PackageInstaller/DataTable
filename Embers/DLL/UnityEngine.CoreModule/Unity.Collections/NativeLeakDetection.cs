using UnityEngine;

namespace Unity.Collections;

public static class NativeLeakDetection
{
	private static int s_NativeLeakDetectionMode;

	[RuntimeInitializeOnLoadMethod]
	private static void Initialize()
	{
		s_NativeLeakDetectionMode = 1;
	}
}
