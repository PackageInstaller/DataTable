using System.Runtime.InteropServices;

namespace CriMana;

[StructLayout(LayoutKind.Sequential)]
public class FrameInfo
{
	public int frameNo;

	public int frameNoPerFile;

	public uint width;

	public uint height;

	public uint dispWidth;

	public uint dispHeight;

	public uint numImages;

	public uint framerateN;

	public uint framerateD;

	private uint _reserved1;

	public ulong time;

	public ulong tunit;

	public uint cntConcatenatedMovie;

	private AlphaType alphaType;

	public uint cntSkippedFrames;

	public uint totalFramesPerFile;
}
