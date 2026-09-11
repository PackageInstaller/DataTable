using System;

[Serializable]
public class CriManaConfig
{
	[Serializable]
	public class PCH264PlaybackConfig
	{
		public bool useH264Playback = true;
	}

	[Serializable]
	public class VitaH264PlaybackConfig
	{
		public bool useH264Playback;

		public int maxWidth = 960;

		public int maxHeight = 544;

		public bool getMemoryFromTexture;
	}

	[Serializable]
	public class WebGLConfig
	{
		public string webworkerPath = "StreamingAssets";

		public int heapSize = 32;
	}

	public int numberOfDecoders = 8;

	public int numberOfMaxEntries = 4;

	public readonly bool graphicsMultiThreaded = true;

	public bool useStreamerManager;

	public PCH264PlaybackConfig pcH264PlaybackConfig = new PCH264PlaybackConfig();

	public VitaH264PlaybackConfig vitaH264PlaybackConfig = new VitaH264PlaybackConfig();

	public WebGLConfig webglConfig = new WebGLConfig();
}
