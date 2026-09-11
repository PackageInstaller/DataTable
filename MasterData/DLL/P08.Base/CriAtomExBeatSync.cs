using System;
using System.Runtime.InteropServices;

public static class CriAtomExBeatSync
{
	public struct Info
	{
		public IntPtr playerHn;

		public uint playbackId;

		public uint barCount;

		public uint beatCount;

		public float beatProgress;

		public float bpm;

		public int offset;

		public uint numBeats;

		public IntPtr labelPtr;

		public string label
		{
			get
			{
				if (new CriAtomExPlayback(playbackId).GetStatus() == CriAtomExPlayback.Status.Removed)
				{
					return null;
				}
				return Marshal.PtrToStringAnsi(labelPtr);
			}
		}
	}

	[UnmanagedFunctionPointer(CallingConvention.Cdecl)]
	public delegate void CbFunc(ref Info info);

	public static event CbFunc OnCallback
	{
		add
		{
			CriAtom.OnBeatSyncCallback += value;
		}
		remove
		{
			CriAtom.OnBeatSyncCallback -= value;
		}
	}

	[Obsolete("SetCallback is deprecated. Use OnBeatSyncCallback event", false)]
	public static void SetCallback(CbFunc func)
	{
		CriAtom.SetBeatSyncCallback(func);
	}
}
