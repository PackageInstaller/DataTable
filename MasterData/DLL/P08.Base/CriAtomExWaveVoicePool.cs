using System;
using System.Runtime.InteropServices;

public class CriAtomExWaveVoicePool : CriAtomExVoicePool
{
	public struct Config
	{
		public uint identifier;

		public int numVoices;

		public PlayerConfig playerConfig;

		public bool isStreamingOnly;

		public int minChannels;

		public static Config Default()
		{
			Config config = default(Config);
			SetDefaultConfigForWaveVoicePool(ref config);
			return config;
		}
	}

	public static void SetDefaultConfigForWaveVoicePool(ref Config config)
	{
		CRIWARE5C13B6E7(ref config);
	}

	public CriAtomExWaveVoicePool(Config config)
	{
		_identifier = config.identifier;
		_numVoices = config.numVoices;
		_maxChannels = config.playerConfig.maxChannels;
		_maxSamplingRate = config.playerConfig.maxSamplingRate;
		_handle = criAtomExVoicePool_AllocateWaveVoicePool(ref config, IntPtr.Zero, 0);
		CriDisposableObjectManager.Register(this, CriDisposableObjectManager.ModuleType.Atom);
	}

	public CriAtomExWaveVoicePool(int numVoices, int maxChannels, int maxSamplingRate, bool streamingFlag, uint identifier = 0u)
	{
		_identifier = identifier;
		_numVoices = numVoices;
		_maxChannels = maxChannels;
		_maxSamplingRate = maxSamplingRate;
		Config config = new Config
		{
			identifier = identifier,
			numVoices = numVoices,
			playerConfig = 
			{
				maxChannels = maxChannels,
				maxSamplingRate = maxSamplingRate,
				streamingFlag = streamingFlag,
				soundRendererType = 2,
				decodeLatency = 0
			},
			isStreamingOnly = false,
			minChannels = 1
		};
		_handle = criAtomExVoicePool_AllocateWaveVoicePool(ref config, IntPtr.Zero, 0);
		if (_handle == IntPtr.Zero)
		{
			throw new Exception("CriAtomExWaveVoicePool() failed.");
		}
		CriDisposableObjectManager.Register(this, CriDisposableObjectManager.ModuleType.Atom);
	}

	[DllImport("cri_ware_unity")]
	private static extern IntPtr criAtomExVoicePool_AllocateWaveVoicePool(ref Config config, IntPtr work, int work_size);

	[DllImport("cri_ware_unity")]
	private static extern void CRIWARE5C13B6E7(ref Config config);
}
