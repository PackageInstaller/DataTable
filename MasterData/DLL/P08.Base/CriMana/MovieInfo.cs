using System;
using System.Runtime.InteropServices;

namespace CriMana;

[Serializable]
[StructLayout(LayoutKind.Sequential)]
public class MovieInfo
{
	private uint _reserved1;

	public uint numAlphaStreams;

	public uint width;

	public uint height;

	public uint dispWidth;

	public uint dispHeight;

	public uint framerateN;

	public uint framerateD;

	public uint totalFrames;

	public CodecType codecType;

	public CodecType alphaCodecType;

	public uint numAudioStreams;

	[MarshalAs(UnmanagedType.ByValArray, SizeConst = 32)]
	public AudioInfo[] audioPrm;

	public uint numSubtitleChannels;

	public uint maxSubtitleSize;

	public uint maxChunkSize;

	public bool hasAlpha
	{
		get
		{
			return numAlphaStreams != 0;
		}
		internal set
		{
			numAlphaStreams = (value ? 1u : 0u);
		}
	}
}
