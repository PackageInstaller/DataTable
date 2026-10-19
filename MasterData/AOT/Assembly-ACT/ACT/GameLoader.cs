using System;
using System.Collections;
using System.Collections.Generic;
using ACT.Battle;
using ACT.Config;
using ACT.Game;
using ACT.Local;
using ACT.Net;
using ACT.Sound;
using ACT.UI;
using ACT.Utility;
using Bamboo.Chronos;
using Fundamental;
using UnityEngine;
using UnityEngine.EventSystems;
using UnityEngine.Rendering;
using bamboosdk;

namespace ACT;

public class GameLoader : MonoBehaviour
{
	public enum GameMode
	{
		ConfigSave,
		Local,
		Network,
		Selection
	}

	public enum NetworkMode
	{
		Auto,
		Host,
		Client,
		Server
	}

	public enum LoginSchema
	{
		SDK,
		Account,
		Uid
	}

	private static MetaRes _meta;

	[Tooltip("ConfigSave => 使用下面save数据\nLocal => 使用上一次Local退出时保存的数据\nNetWork => 和Selection一样\nSelection => 显示服务器UI")]
	public GameMode mode;

	public bool IsCustomize;

	public string text;

	public ViewConfigs viewConfigs;

	public List<YooAssetReference> PreLoadBanksAssetID = new List<YooAssetReference>();

	public EventSystem uiEventSystem;

	public Volume globalVolume;

	private Coroutine m_CoResource;

	[NonSerialized]
	public static RaidMonsterInfo monsterInfo;

	[NonSerialized]
	public static RaidPerformanceConfig raidPerformanceConfig;

	[NonSerialized]
	public static ConnectNodeModelConfig connectNodeModelConfig;

	private uint m_loginEnvironmentSound;

	private uint m_loginBGMSound;

	private Delayer delayer;

	private static string _currentAppVersion;

	internal static bool IsMetaLoaded => _meta != null;

	public static MetaRes meta
	{
		get
		{
			return _meta;
		}
		set
		{
			_meta = value;
		}
	}

	public bool IsNetMode => mode == GameMode.Network;

	public static bool IsPCMode { get; private set; }

	public static bool NeedHideCursor { get; private set; }

	private void Test()
	{
		AlgorithmUtility.CalculateReturnDouble(text);
	}

	static GameLoader()
	{
		bool needHideCursor = false;
		IsPCMode = false;
		NeedHideCursor = needHideCursor;
	}

	private async void Awake()
	{
		gameObject.name = "GameLoader";
		mode = GameMode.Network;
		new GameObject("mobileResolutionPolicyWatcher").AddComponent<MobileResolutionPolicyWatcher>();
		InitAppVersionWatcher();
	}

	private static void InitAppVersionWatcher()
	{
		LuminApplication.OnDisplayVersionUpdate.RemoveListener(ReportAppVersionUpdate);
		LuminApplication.OnDisplayVersionUpdate.AddListener(ReportAppVersionUpdate);
		ReportAppVersionUpdate();
	}

	private static void ReportAppVersionUpdate()
	{
		if (!(LuminApplication.DisplayVersion == _currentAppVersion))
		{
			_currentAppVersion = LuminApplication.DisplayVersion;
			LuminApplication.APM.GPM.AddCustomEvent("VERSION_UPDATE", "GameInfo", "version", _currentAppVersion);
		}
	}

	private void Update()
	{
		OperationManager.Update();
		if (Singleton<NetManager>.HasInstance())
		{
			Singleton<NetManager>.instance.Update();
		}
	}

	public void ReopenWaitClickView()
	{
		StartCoroutine(CoModeSelection());
	}

	internal void ContinueGameStart()
	{
		StartCoroutine(CoModeSelection());
	}

	public IEnumerator CoModeSelection()
	{
		switch (mode)
		{
		case GameMode.ConfigSave:
			G.service = new LocalGameService();
			throw new NotImplementedException("ConfigSave模式无法在非编辑器模式下运行");
		case GameMode.Local:
			G.service = new LocalGameService();
			(G.service as LocalGameService).LoadGame();
			GameStartWithOutUI();
			break;
		case GameMode.Network:
		case GameMode.Selection:
			yield return Singleton<NewUIManager>.instance.OpenUI(UI_TYPE.UI_LOGINWAITCLICK, true);
			break;
		}
	}

	public void PlayLoginEnvironmentSound()
	{
		if (m_loginEnvironmentSound == 0)
		{
			m_loginEnvironmentSound = Singleton<GameManager>.instance.audioManager.PlaySound("event:/Local/Amb/0.10_Desert", new AudioPlayOptions
			{
				attachTarget = transform
			});
			PlayLoginBgmAfterEnvironmentSound();
		}
	}

	private void PlayLoginBgmAfterEnvironmentSound()
	{
		if (!delayer.IsValid())
		{
			delayer = UpdateTimer.Default.DelayMs(5000, () =>
			{
				m_loginBGMSound = Singleton<GameManager>.instance.audioManager.PlaySound("event:/Local/Mus/0.10_Desert", new AudioPlayOptions
				{
					attachTarget = transform
				});
				delayer.Cancel();
			});
		}
	}

	public bool GetEnvironmentSoundState()
	{
		return false;
	}

	public void SetPauseEnvironmentSound(bool state)
	{
		if (m_loginEnvironmentSound != 0)
		{
			Singleton<GameManager>.instance.audioManager.SetPause(m_loginEnvironmentSound, state);
		}
	}

	public void SetPauseBGMSound(bool state)
	{
		if (m_loginBGMSound != 0)
		{
			Singleton<GameManager>.instance.audioManager.SetPause(m_loginBGMSound, state);
		}
		if (delayer.IsValid())
		{
			delayer.Cancel();
		}
	}

	public void StopLoginEnvironmentSoundSlowly()
	{
		if (m_loginEnvironmentSound != 0)
		{
			Singleton<GameManager>.instance.audioManager.Stop(m_loginEnvironmentSound);
		}
	}

	public void StopLoginBGMSoundSlowly()
	{
		if (m_loginBGMSound != 0)
		{
			Singleton<GameManager>.instance.audioManager.Stop(m_loginBGMSound);
		}
		if (delayer.IsValid())
		{
			delayer.Cancel();
		}
	}

	public void GameStartWithOutUI()
	{
		MonoECS.instance.StartWorld();
		if (mode == GameMode.Network)
		{
			BamBooSdk.getInstance().enterGame(LoginUtility.RoleInfo);
		}
	}

	private void QuitProcess()
	{
		BamBooSdk.getInstance().exit();
		if (Singleton<NetManager>.HasInstance())
		{
			Singleton<NetManager>.instance.Disconnect();
		}
	}

	private void OnApplicationFocus(bool focus)
	{
		if (!focus && mode == GameMode.Local && G.service != null)
		{
			(G.service as LocalGameService).SaveGame();
		}
	}
}
