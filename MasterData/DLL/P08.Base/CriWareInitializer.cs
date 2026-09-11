using System;
using System.Collections.Generic;
using System.IO;
using CriWare;
using UnityEngine;

[AddComponentMenu("CRIWARE/Library Initializer")]
public class CriWareInitializer : CriMonoBehaviour
{
	public bool initializesFileSystem = true;

	public CriFsConfig fileSystemConfig = new CriFsConfig();

	public bool initializesAtom = true;

	public CriAtomConfig atomConfig = new CriAtomConfig();

	public bool initializesMana = true;

	public CriManaConfig manaConfig = new CriManaConfig();

	public bool useDecrypter;

	public CriWareDecrypter.Config DecrypterConfig = new CriWareDecrypter.Config();

	public bool dontInitializeOnAwake;

	public bool dontDestroyOnLoad;

	private static int initializationCount;

	private void Awake()
	{
		Common.CheckBinaryVersionCompatibility();
		if (!dontInitializeOnAwake)
		{
			Initialize();
		}
	}

	protected override void OnEnable()
	{
		base.OnEnable();
	}

	private void Start()
	{
	}

	private void OnDestroy()
	{
		Shutdown();
	}

	public override void CriInternalUpdate()
	{
	}

	public override void CriInternalLateUpdate()
	{
	}

	public void Initialize()
	{
		initializationCount++;
		if (initializationCount != 1)
		{
			UnityEngine.Object.Destroy(this);
			return;
		}
		ValidateConfig();
		if ((CriFsPlugin.IsLibraryInitialized() && CriAtomPlugin.IsLibraryInitialized() && CriManaPlugin.IsLibraryInitialized()) || (CriFsPlugin.IsLibraryInitialized() && CriAtomPlugin.IsLibraryInitialized() && !CriManaPlugin.IsLibraryInitialized()) || (CriFsPlugin.IsLibraryInitialized() && !CriAtomPlugin.IsLibraryInitialized() && !CriManaPlugin.IsLibraryInitialized()))
		{
			if (initializesMana)
			{
				CriManaPlugin.FinalizeLibrary();
			}
			if (initializesAtom)
			{
				while (CriAtomExLatencyEstimator.GetCurrentInfo().status != CriAtomExLatencyEstimator.Status.Stop)
				{
					CriAtomExLatencyEstimator.FinalizeModule();
				}
				CriAtomPlugin.FinalizeLibrary();
			}
			if (initializesFileSystem)
			{
				CriFsPlugin.FinalizeLibrary();
			}
		}
		if (initializesFileSystem)
		{
			InitializeFileSystem(fileSystemConfig);
		}
		if (initializesMana)
		{
			CriManaPlugin.SetConfigAdditonalParameters_PC(manaConfig.pcH264PlaybackConfig.useH264Playback);
		}
		if (initializesAtom)
		{
			switch (atomConfig.inGamePreviewMode)
			{
			case CriAtomConfig.InGamePreviewSwitchMode.Disable:
				atomConfig.usesInGamePreview = false;
				break;
			case CriAtomConfig.InGamePreviewSwitchMode.Enable:
				atomConfig.usesInGamePreview = true;
				break;
			case CriAtomConfig.InGamePreviewSwitchMode.FollowBuildSetting:
				atomConfig.usesInGamePreview = Debug.isDebugBuild;
				break;
			}
			InitializeAtom(atomConfig);
		}
		if (initializesMana)
		{
			InitializeMana(manaConfig);
		}
		if (useDecrypter)
		{
			CriWareDecrypter.Initialize(DecrypterConfig);
		}
		else
		{
			CriWareDecrypter.Initialize("0", enableAtomDecryption: false, enableManaDecryption: false);
		}
		if (dontDestroyOnLoad)
		{
			UnityEngine.Object.DontDestroyOnLoad(base.transform.gameObject);
		}
	}

	public void Shutdown()
	{
		initializationCount--;
		if (initializationCount != 0)
		{
			initializationCount = ((initializationCount >= 0) ? initializationCount : 0);
			return;
		}
		if (initializesMana)
		{
			CriManaPlugin.FinalizeLibrary();
		}
		if (initializesAtom)
		{
			while (CriAtomExLatencyEstimator.GetCurrentInfo().status != CriAtomExLatencyEstimator.Status.Stop)
			{
				CriAtomExLatencyEstimator.FinalizeModule();
			}
			CriAtomPlugin.FinalizeLibrary();
		}
		if (initializesFileSystem)
		{
			CriFsPlugin.FinalizeLibrary();
		}
	}

	public static bool IsInitialized()
	{
		if (initializationCount > 0)
		{
			return true;
		}
		Common.CheckBinaryVersionCompatibility();
		return false;
	}

	public static void AddAudioEffectInterface(IntPtr effect_interface)
	{
		List<IntPtr> effect_interface_list = null;
		if (CriAtomPlugin.GetAudioEffectInterfaceList(out effect_interface_list))
		{
			effect_interface_list.Add(effect_interface);
		}
	}

	public static bool InitializeFileSystem(CriFsConfig config)
	{
		if (!CriFsPlugin.IsLibraryInitialized())
		{
			CriFsPlugin.SetConfigParameters(config.numberOfLoaders, config.numberOfBinders, config.numberOfInstallers, config.installBufferSize * 1024, config.maxPath, config.minimizeFileDescriptorUsage, config.enableCrcCheck);
			if (config.androidDeviceReadBitrate == 0)
			{
				config.androidDeviceReadBitrate = 50000000;
			}
			CriFsPlugin.SetConfigAdditionalParameters_ANDROID(config.androidDeviceReadBitrate);
			CriFsPlugin.InitializeLibrary();
			if (config.userAgentString.Length != 0)
			{
				CriFsUtility.SetUserAgentString(config.userAgentString);
			}
			return true;
		}
		return false;
	}

	public static bool InitializeAtom(CriAtomConfig config)
	{
		if (!CriAtomPlugin.IsLibraryInitialized())
		{
			bool flag = false;
			flag = config.enableAtomSoundDisabledMode;
			CriAtomPlugin.SetConfigParameters(Math.Max(config.maxVirtualVoices, CriAtomPlugin.GetRequiredMaxVirtualVoices(config)), config.maxVoiceLimitGroups, config.maxCategories, (byte)config.maxAisacs, (byte)config.maxBusSends, config.maxSequenceEventsPerFrame, config.maxBeatSyncCallbacksPerFrame, config.maxCueLinkCallbacksPerFrame, config.standardVoicePoolConfig.memoryVoices, config.standardVoicePoolConfig.streamingVoices, config.hcaMxVoicePoolConfig.memoryVoices, config.hcaMxVoicePoolConfig.streamingVoices, config.outputSamplingRate, config.asrOutputChannels, config.speakerMapping, config.usesInGamePreview, config.serverFrequency, config.maxParameterBlocks, config.categoriesPerPlayback, config.maxFaders, config.maxBuses, config.maxPitch, config.soundRendererType, config.enableSonicSync, flag);
			CriAtomPlugin.SetConfigMonitorParametes(config.inGamePreviewConfig.maxPreviewObjects, config.inGamePreviewConfig.communicationBufferSize, config.inGamePreviewConfig.playbackPositionUpdateInterval);
			CriAtomPlugin.SetConfigAdditionalParameters_EDITOR(config.editorPcmOutputConfig.enable, config.editorPcmOutputConfig.bufferLength);
			CriAtomPlugin.SetConfigAdditionalParameters_PC(config.pcBufferingTime, config.useMicrosoftSpatialSound);
			CriAtomPlugin.SetConfigAdditionalParameters_LINUX(config.linuxOutput, config.linuxPulseLatencyUsec);
			CriAtomPlugin.SetConfigAdditionalParameters_IOS(config.iosEnableSonicSync, (uint)Math.Max(config.iosBufferingTime, 16), config.iosOverrideIPodMusic, config.iosEnableOSNotificationHandling);
			if (config.androidBufferingTime == 0)
			{
				config.androidBufferingTime = (int)(4000.0 / (double)config.serverFrequency);
			}
			if (config.androidStartBufferingTime == 0)
			{
				config.androidStartBufferingTime = (int)(3000.0 / (double)config.serverFrequency);
			}
			CriAtomPlugin.SetConfigAdditionalParameters_ANDROID(config.androidEnableSonicSync, config.androidLowLatencyStandardVoicePoolConfig.memoryVoices, config.androidLowLatencyStandardVoicePoolConfig.streamingVoices, config.androidBufferingTime, config.androidStartBufferingTime, config.androidUsesAndroidFastMixer, config.androidUsesAAudio, config.androidStreamType);
			CriAtomPlugin.SetConfigAdditionalParameters_VITA(config.vitaAtrac9VoicePoolConfig.memoryVoices, config.vitaAtrac9VoicePoolConfig.streamingVoices, config.vitaManaVoicePoolConfig.numberOfManaDecoders);
			CriAtomPlugin.SetConfigAdditionalParameters_PS4(config.ps4Atrac9VoicePoolConfig.memoryVoices, config.ps4Atrac9VoicePoolConfig.streamingVoices, config.ps4Audio3dConfig.useAudio3D, config.ps4Audio3dConfig.voicePoolConfig.memoryVoices, config.ps4Audio3dConfig.voicePoolConfig.streamingVoices, config.ps4Mp3StreamingVoices);
			CriAtomPlugin.SetConfigAdditionalParameters_PS5(config.ps5PortConfig.maxChannelPorts, config.ps5PortConfig.maxObjectPorts, config.ps5Mp3StreamingVoices);
			CriAtomPlugin.SetConfigAdditionalParameters_SWITCH(config.switchEnableSonicSync, config.switchOpusVoicePoolConfig.memoryVoices, config.switchOpusVoicePoolConfig.streamingVoices, config.switchInitializeSocket);
			CriAtomPlugin.SetConfigAdditionalParameters_SWITCH2(config.switch2OpusVoicePoolConfig.memoryVoices, config.switch2OpusVoicePoolConfig.streamingVoices, config.switch2InitializeSocket);
			CriAtomPlugin.SetConfigAdditionalParameters_WEBGL(0);
			CriAtomPlugin.InitializeLibrary();
			if (config.useRandomSeedWithTime)
			{
				CriAtomEx.SetRandomSeed((uint)DateTime.Now.Ticks);
			}
			if (config.acfFileName.Length != 0)
			{
				string text = config.acfFileName;
				if (Common.IsStreamingAssetsPath(text))
				{
					text = Path.Combine(Common.streamingAssetsPath, text);
				}
				CriAtomEx.RegisterAcf(null, text);
			}
			CriAtomServer.KeepPlayingSoundOnPause = config.keepPlayingSoundOnPause;
			return true;
		}
		return false;
	}

	public static bool InitializeMana(CriManaConfig config)
	{
		if (!CriManaPlugin.IsLibraryInitialized())
		{
			CriManaPlugin.SetConfigParameters(config.graphicsMultiThreaded, config.numberOfDecoders, config.numberOfMaxEntries);
			CriManaPlugin.UseLegacyDecoder_PC(useLegacyDecoder: false);
			if (!CriAtomPlugin.IsLibraryInitialized())
			{
				CriManaPlugin.SetConfigAdditonalParameters_PC(config.pcH264PlaybackConfig.useH264Playback);
			}
			CriManaPlugin.InitializeLibrary();
			CriManaPlugin.UseStreamerManager(config.useStreamerManager);
			return true;
		}
		return false;
	}

	private void OnValidate()
	{
		ValidateConfigEditor();
		ValidateConfig();
	}

	private void ValidateConfigEditorForNotPublic()
	{
		if (useDecrypter)
		{
			Debug.LogWarning("[CRIWARE] \"CriWareInitializer.useDecrypter\" is for development only.Content protection is vulnerable to values set in the inspector.");
		}
	}

	private void ValidateConfigForNotPublic()
	{
	}

	private void ValidateConfigEditor()
	{
		ValidateConfigEditorForNotPublic();
	}

	private void ValidateConfig()
	{
		ValidateConfigForNotPublic();
	}
}
