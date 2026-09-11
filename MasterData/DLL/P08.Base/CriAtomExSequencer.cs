using System;
using System.Runtime.InteropServices;

public static class CriAtomExSequencer
{
	public struct CriAtomExSequenceEventInfo
	{
		public ulong position;

		public IntPtr playerHn;

		[MarshalAs(UnmanagedType.LPStr)]
		public readonly string tag;

		public uint playbackId;

		private int type;

		public uint id;

		private uint reserved;
	}

	[UnmanagedFunctionPointer(CallingConvention.Cdecl)]
	public delegate void EventCbFunc(string eventParamsString);

	[UnmanagedFunctionPointer(CallingConvention.Cdecl)]
	public delegate void EventCallback(ref CriAtomExSequenceEventInfo criAtomExSequenceInfo);

	public static event EventCallback OnCallback
	{
		add
		{
			CriAtom.OnEventSequencerCallback += value;
		}
		remove
		{
			CriAtom.OnEventSequencerCallback -= value;
		}
	}

	[Obsolete("SetEventCallback is deprecated. Use CriAtomExSequencer.OnCallback event", false)]
	public static void SetEventCallback(EventCbFunc func, string separator = "\t")
	{
		CriAtom.SetEventCallback(func, separator);
	}
}
