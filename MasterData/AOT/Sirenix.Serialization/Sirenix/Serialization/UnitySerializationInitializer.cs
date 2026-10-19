using Sirenix.Utilities;
using UnityEngine;

namespace Sirenix.Serialization;

public static class UnitySerializationInitializer
{
	private static readonly object LOCK = new object();

	private static bool initialized = false;

	public static bool Initialized => initialized;

	public static RuntimePlatform CurrentPlatform { get; private set; }

	public static void Initialize()
	{
		if (initialized)
		{
			return;
		}
		lock (LOCK)
		{
			if (initialized)
			{
				return;
			}
			try
			{
				GlobalConfig<GlobalSerializationConfig>.LoadInstanceIfAssetExists();
				CurrentPlatform = Application.platform;
				if (!Application.isEditor)
				{
					ArchitectureInfo.SetRuntimePlatform(CurrentPlatform);
				}
			}
			finally
			{
				initialized = true;
			}
		}
	}

	[RuntimeInitializeOnLoadMethod(RuntimeInitializeLoadType.BeforeSceneLoad)]
	private static void InitializeRuntime()
	{
		Initialize();
	}
}
