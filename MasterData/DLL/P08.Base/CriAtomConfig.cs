using System;

[Serializable]
public class CriAtomConfig
{
	[Serializable]
	public class StandardVoicePoolConfig
	{
		public int memoryVoices = 16;

		public int streamingVoices = 8;
	}

	[Serializable]
	public class HcaMxVoicePoolConfig
	{
		public int memoryVoices;

		public int streamingVoices;
	}

	[Serializable]
	public enum InGamePreviewSwitchMode
	{
		Disable,
		Enable,
		FollowBuildSetting,
		Default
	}

	[Serializable]
	public class InGamePreviewConfig
	{
		public int maxPreviewObjects = 200;

		public int communicationBufferSize = 2048;

		public int playbackPositionUpdateInterval = 8;
	}

	[Serializable]
	public class EditorPcmOutputConfig
	{
		public bool enable;

		public int bufferLength = 4096;
	}

	public enum LinuxOutput
	{
		Default,
		PulseAudio,
		ALSA
	}

	[Serializable]
	public class AndroidLowLatencyStandardVoicePoolConfig
	{
		public int memoryVoices;

		public int streamingVoices;
	}

	[Serializable]
	public class VitaManaVoicePoolConfig
	{
		public int numberOfManaDecoders = 8;
	}

	[Serializable]
	public class VitaAtrac9VoicePoolConfig
	{
		public int memoryVoices;

		public int streamingVoices;
	}

	[Serializable]
	public class Ps4Atrac9VoicePoolConfig
	{
		public int memoryVoices;

		public int streamingVoices;
	}

	[Serializable]
	public class Ps5PortConfig
	{
		public int maxChannelPorts = 16;

		public int maxObjectPorts = 64;
	}

	[Serializable]
	public class SwitchOpusVoicePoolConfig
	{
		public int memoryVoices;

		public int streamingVoices;
	}

	[Serializable]
	public class Switch2OpusVoicePoolConfig
	{
		public int memoryVoices;

		public int streamingVoices;
	}

	[Serializable]
	public class Ps4Audio3dConfig
	{
		[Serializable]
		public class VoicePoolConfig
		{
			public int memoryVoices;

			public int streamingVoices;
		}

		public bool useAudio3D;

		public VoicePoolConfig voicePoolConfig = new VoicePoolConfig();
	}

	public string acfFileName = "";

	public int maxVirtualVoices = 32;

	public int maxVoiceLimitGroups = 32;

	public int maxCategories = 32;

	public int maxAisacs = 8;

	public int maxBusSends = 8;

	public int maxSequenceEventsPerFrame = 2;

	public int maxBeatSyncCallbacksPerFrame = 1;

	public int maxCueLinkCallbacksPerFrame = 1;

	public StandardVoicePoolConfig standardVoicePoolConfig = new StandardVoicePoolConfig();

	public HcaMxVoicePoolConfig hcaMxVoicePoolConfig = new HcaMxVoicePoolConfig();

	public int outputSamplingRate;

	public bool usesInGamePreview;

	public InGamePreviewSwitchMode inGamePreviewMode = InGamePreviewSwitchMode.Default;

	public bool switchInitializeSocket;

	public bool switch2InitializeSocket;

	public InGamePreviewConfig inGamePreviewConfig = new InGamePreviewConfig();

	public float serverFrequency = 60f;

	public CriAtom.SpeakerMapping speakerMapping;

	public int asrOutputChannels;

	public bool useRandomSeedWithTime = true;

	public int categoriesPerPlayback = 4;

	public int maxFaders = 4;

	public int maxBuses = 8;

	public float maxPitch = 2400f;

	public int maxParameterBlocks = 1024;

	public CriAtomEx.SoundRendererType soundRendererType = CriAtomEx.SoundRendererType.Native;

	public bool keepPlayingSoundOnPause = true;

	public bool enableSonicSync = true;

	public bool enableAtomSoundDisabledMode;

	public bool enableAtomSoundDisabledModeLinux;

	public EditorPcmOutputConfig editorPcmOutputConfig = new EditorPcmOutputConfig();

	public int pcBufferingTime;

	public bool useMicrosoftSpatialSound = true;

	public LinuxOutput linuxOutput;

	public int linuxPulseLatencyUsec = 60000;

	public bool iosEnableSonicSync = true;

	public int iosBufferingTime = 50;

	public bool iosOverrideIPodMusic;

	public bool iosEnableOSNotificationHandling = true;

	public bool androidEnableSonicSync = true;

	public int androidBufferingTime = 133;

	public int androidStartBufferingTime = 100;

	public AndroidLowLatencyStandardVoicePoolConfig androidLowLatencyStandardVoicePoolConfig = new AndroidLowLatencyStandardVoicePoolConfig();

	public bool androidUsesAndroidFastMixer = true;

	public bool androidForceToUseAsrForDefaultPlayback = true;

	public bool androidUsesAAudio;

	public int androidStreamType;

	public VitaManaVoicePoolConfig vitaManaVoicePoolConfig = new VitaManaVoicePoolConfig();

	public VitaAtrac9VoicePoolConfig vitaAtrac9VoicePoolConfig = new VitaAtrac9VoicePoolConfig();

	public Ps4Atrac9VoicePoolConfig ps4Atrac9VoicePoolConfig = new Ps4Atrac9VoicePoolConfig();

	public Ps5PortConfig ps5PortConfig = new Ps5PortConfig();

	public int ps5Mp3StreamingVoices;

	public bool switchEnableSonicSync = true;

	public SwitchOpusVoicePoolConfig switchOpusVoicePoolConfig = new SwitchOpusVoicePoolConfig();

	public Switch2OpusVoicePoolConfig switch2OpusVoicePoolConfig = new Switch2OpusVoicePoolConfig();

	public Ps4Audio3dConfig ps4Audio3dConfig = new Ps4Audio3dConfig();

	public int ps4Mp3StreamingVoices;
}
