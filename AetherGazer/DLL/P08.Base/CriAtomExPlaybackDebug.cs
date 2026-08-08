using System.Runtime.InteropServices;

public static class CriAtomExPlaybackDebug
{
	public static bool GetParameter(CriAtomExPlayback playback, CriAtomEx.Parameter parameterId, out float value)
	{
		return criAtomExPlayback_GetParameterFloat32(playback.id, (int)parameterId, out value) == 1;
	}

	public static bool GetParameter(CriAtomExPlayback playback, CriAtomEx.Parameter parameterId, out uint value)
	{
		return criAtomExPlayback_GetParameterUint32(playback.id, (int)parameterId, out value) == 1;
	}

	public static bool GetParameter(CriAtomExPlayback playback, CriAtomEx.Parameter parameterId, out int value)
	{
		return criAtomExPlayback_GetParameterSint32(playback.id, (int)parameterId, out value) == 1;
	}

	public static bool GetAisacControl(CriAtomExPlayback playback, uint controlId, out float value)
	{
		return criAtomExPlayback_GetAisacControlById(playback.id, controlId, out value) == 1;
	}

	public static bool GetAisacControl(CriAtomExPlayback playback, string controlName, out float value)
	{
		return criAtomExPlayback_GetAisacControlByName(playback.id, controlName, out value) == 1;
	}

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern int criAtomExPlayback_GetParameterFloat32(uint id, int parameterId, out float value);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern int criAtomExPlayback_GetParameterUint32(uint id, int parameterId, out uint value);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern int criAtomExPlayback_GetParameterSint32(uint id, int parameterId, out int value);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern int criAtomExPlayback_GetAisacControlById(uint id, uint controlId, out float value);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern int criAtomExPlayback_GetAisacControlByName(uint id, string controlName, out float value);
}
