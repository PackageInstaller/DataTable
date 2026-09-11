using System;
using System.Runtime.InteropServices;

public struct CriAtomExPlayback
{
	public enum Status
	{
		Prep = 1,
		Playing,
		Removed
	}

	public struct TrackInfo
	{
		public uint id;

		public CriAtomEx.CueType sequenceType;

		public IntPtr playerHn;

		public ushort trackNo;

		public ushort reserved;
	}

	public const uint invalidId = uint.MaxValue;

	public uint id { get; private set; }

	public Status status => GetStatus();

	public long time => GetTime();

	public long timeSyncedWithAudio => GetTimeSyncedWithAudio();

	public CriAtomExPlayback(uint id)
	{
		this = default(CriAtomExPlayback);
		this.id = id;
	}

	public void Stop(bool ignoresReleaseTime)
	{
		if (CriAtomPlugin.IsLibraryInitialized())
		{
			if (!ignoresReleaseTime)
			{
				criAtomExPlayback_Stop(id);
			}
			else
			{
				criAtomExPlayback_StopWithoutReleaseTime(id);
			}
		}
	}

	public void Pause()
	{
		criAtomExPlayback_Pause(id, sw: true);
	}

	public void Resume(CriAtomEx.ResumeMode mode)
	{
		criAtomExPlayback_Resume(id, mode);
	}

	public bool IsPaused()
	{
		return criAtomExPlayback_IsPaused(id);
	}

	public bool GetFormatInfo(out CriAtomEx.FormatInfo info)
	{
		return criAtomExPlayback_GetFormatInfo(id, out info);
	}

	public Status GetStatus()
	{
		return criAtomExPlayback_GetStatus(id);
	}

	public long GetTime()
	{
		return criAtomExPlayback_GetTime(id);
	}

	public long GetTimeSyncedWithAudio()
	{
		return criAtomExPlayback_GetTimeSyncedWithAudio(id);
	}

	public bool GetNumPlayedSamples(out long numSamples, out int samplingRate)
	{
		return criAtomExPlayback_GetNumPlayedSamples(id, out numSamples, out samplingRate);
	}

	public long GetSequencePosition()
	{
		return criAtomExPlayback_GetSequencePosition(id);
	}

	public int GetCurrentBlockIndex()
	{
		return criAtomExPlayback_GetCurrentBlockIndex(id);
	}

	public bool GetTrackInfo(out TrackInfo info)
	{
		return criAtomExPlayback_GetPlaybackTrackInfo(id, out info);
	}

	public bool GetBeatSyncInfo(out CriAtomExBeatSync.Info info)
	{
		return criAtomExPlayback_GetBeatSyncInfo(id, out info);
	}

	public void SetNextBlockIndex(int index)
	{
		criAtomExPlayback_SetNextBlockIndex(id, index);
	}

	public bool SetBeatSyncOffset(short timeMs)
	{
		return criAtomExPlayback_SetBeatSyncOffset(id, timeMs);
	}

	public void Stop()
	{
		if (CriAtomPlugin.IsLibraryInitialized())
		{
			criAtomExPlayback_Stop(id);
		}
	}

	public void StopWithoutReleaseTime()
	{
		if (CriAtomPlugin.IsLibraryInitialized())
		{
			criAtomExPlayback_StopWithoutReleaseTime(id);
		}
	}

	public void Pause(bool sw)
	{
		criAtomExPlayback_Pause(id, sw);
	}

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern void criAtomExPlayback_Stop(uint id);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern void criAtomExPlayback_StopWithoutReleaseTime(uint id);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern void criAtomExPlayback_Pause(uint id, bool sw);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern void criAtomExPlayback_Resume(uint id, CriAtomEx.ResumeMode mode);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern bool criAtomExPlayback_IsPaused(uint id);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern Status criAtomExPlayback_GetStatus(uint id);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern bool criAtomExPlayback_GetFormatInfo(uint id, out CriAtomEx.FormatInfo info);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern long criAtomExPlayback_GetTime(uint id);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern long criAtomExPlayback_GetTimeSyncedWithAudio(uint id);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern bool criAtomExPlayback_GetNumPlayedSamples(uint id, out long num_samples, out int sampling_rate);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern long criAtomExPlayback_GetSequencePosition(uint id);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern void criAtomExPlayback_SetNextBlockIndex(uint id, int index);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern int criAtomExPlayback_GetCurrentBlockIndex(uint id);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern bool criAtomExPlayback_GetPlaybackTrackInfo(uint id, out TrackInfo info);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern bool criAtomExPlayback_GetBeatSyncInfo(uint id, out CriAtomExBeatSync.Info info);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern bool criAtomExPlayback_SetBeatSyncOffset(uint id, short timeMs);
}
