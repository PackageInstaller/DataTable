using System;
using CriWare;
using UnityEngine;

public class CriAtomServer : CriMonoBehaviour
{
	private static CriAtomServer _instance = null;

	public Action<bool> onApplicationPausePreProcess;

	public Action<bool> onApplicationPausePostProcess;

	public static bool KeepPlayingSoundOnPause = true;

	public static bool EnableAutoConsumePcmOutput = true;

	public static bool EnableBackgroundPlayback_ANDROID = false;

	public static CriAtomServer instance
	{
		get
		{
			CreateInstance();
			return _instance;
		}
	}

	public static void CreateInstance()
	{
		if (_instance == null)
		{
			Common.managerObject.AddComponent<CriAtomServer>();
		}
	}

	public static void DestroyInstance()
	{
		if (_instance != null)
		{
			UnityEngine.Object.Destroy(_instance);
		}
	}

	private void Awake()
	{
		if (_instance == null)
		{
			_instance = this;
		}
		else
		{
			UnityEngine.Object.Destroy(this);
		}
	}

	protected override void OnEnable()
	{
		base.OnEnable();
	}

	protected override void OnDisable()
	{
		base.OnDisable();
		if (_instance == this)
		{
			_instance = null;
		}
	}

	public override void CriInternalUpdate()
	{
		CriAtomPlugin.ExecuteQueuedCueLinkCallbacks();
		CriAtomPlugin.ExecuteQueuedEventCallbacks();
		CriAtomPlugin.ExecuteQueuedBeatSyncCallbacks();
		ConsumePcmOutput();
	}

	public override void CriInternalLateUpdate()
	{
	}

	private void ConsumePcmOutput()
	{
	}

	private void OnApplicationPause(bool appPause)
	{
		ProcessApplicationPause(appPause);
	}

	private void ProcessApplicationPause(bool appPause)
	{
		if (onApplicationPausePreProcess != null)
		{
			onApplicationPausePreProcess(appPause);
		}
		if (!KeepPlayingSoundOnPause)
		{
			CriAtomPlugin.Pause(appPause);
		}
		if (onApplicationPausePostProcess != null)
		{
			onApplicationPausePostProcess(appPause);
		}
	}
}
