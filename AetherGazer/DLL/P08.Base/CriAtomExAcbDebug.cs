using System;
using System.Runtime.InteropServices;
using CriAtomDebugDetail;

public static class CriAtomExAcbDebug
{
	public struct AcbInfo
	{
		public string name;

		public uint size;

		public uint version;

		public CriAtomEx.CharacterEncoding characterEncoding;

		public float volume;

		public int numCues;
	}

	private struct AcbInfoForMarshaling
	{
		public IntPtr namePtr;

		public uint size;

		public uint version;

		public CriAtomEx.CharacterEncoding characterEncoding;

		public float volume;

		public int numCues;

		public void Convert(out AcbInfo x)
		{
			x.name = Utility.PtrToStringAutoOrNull(namePtr);
			x.size = size;
			x.version = version;
			x.characterEncoding = characterEncoding;
			x.volume = volume;
			x.numCues = numCues;
		}
	}

	public static bool GetAcbInfo(CriAtomExAcb acb, out AcbInfo acbInfo)
	{
		bool result = criAtomExAcb_GetAcbInfo(acb.nativeHandle, out var acbInfo2) == 1;
		acbInfo2.Convert(out acbInfo);
		return result;
	}

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern int criAtomExAcb_GetAcbInfo(IntPtr acbHn, out AcbInfoForMarshaling acbInfo);
}
