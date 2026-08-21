using System;
using System.Runtime.InteropServices;

public class CriAtomExRawPcmVoicePool : CriAtomExVoicePool
{
	public enum RawPcmFormat
	{
		Sint16,
		Float32
	}

	protected struct RawPcmPlayerConfig
	{
		public RawPcmFormat format;

		public int maxChannels;

		public int maxSamplingRate;

		public int soundRendererType;

		public int decodeLatency;

		private IntPtr context;
	}

	protected struct RawPcmVoicePoolConfig
	{
		public uint identifier;

		public int numVoices;

		public RawPcmPlayerConfig playerConfig;
	}

	public CriAtomExRawPcmVoicePool(int numVoices, int maxChannels, int maxSamplingRate, RawPcmFormat format, uint identifier = 0u)
	{
		_identifier = identifier;
		_numVoices = numVoices;
		_maxChannels = maxChannels;
		_maxSamplingRate = maxSamplingRate;
		RawPcmVoicePoolConfig config = new RawPcmVoicePoolConfig
		{
			identifier = identifier,
			numVoices = numVoices,
			playerConfig = 
			{
				maxChannels = maxChannels,
				maxSamplingRate = maxSamplingRate,
				format = format,
				soundRendererType = 2,
				decodeLatency = 0
			}
		};
		_handle = criAtomExVoicePool_AllocateRawPcmVoicePool(ref config, IntPtr.Zero, 0);
		if (_handle == IntPtr.Zero)
		{
			throw new Exception("CriAtomExRawPcmVoicePool() failed.");
		}
		CriDisposableObjectManager.Register(this, CriDisposableObjectManager.ModuleType.Atom);
	}

	[DllImport("cri_ware_unity")]
	private static extern IntPtr criAtomExVoicePool_AllocateRawPcmVoicePool(ref RawPcmVoicePoolConfig config, IntPtr work, int work_size);
}
