using System;
using System.Runtime.InteropServices;
using CriWare;

public class CriAtomExAcb : CriDisposable
{
	private IntPtr handle = IntPtr.Zero;

	private GCHandle dataHandle;

	public IntPtr nativeHandle => handle;

	public bool isAvailable => handle != IntPtr.Zero;

	public static CriAtomExAcb LoadAcbFile(CriFsBinder binder, string acbPath, string awbPath)
	{
		if (!Common.CheckBinaryVersionCompatibility())
		{
			return null;
		}
		IntPtr intPtr = binder?.nativeHandle ?? IntPtr.Zero;
		if (string.IsNullOrEmpty(awbPath))
		{
			awbPath = null;
		}
		IntPtr intPtr2 = criAtomExAcb_LoadAcbFile(intPtr, acbPath, intPtr, awbPath, IntPtr.Zero, 0);
		if (intPtr2 == IntPtr.Zero)
		{
			return null;
		}
		return new CriAtomExAcb(intPtr2, null);
	}

	public static CriAtomExAcb LoadAcbData(byte[] acbData, CriFsBinder awbBinder, string awbPath)
	{
		if (!Common.CheckBinaryVersionCompatibility())
		{
			return null;
		}
		IntPtr awb_binder = awbBinder?.nativeHandle ?? IntPtr.Zero;
		GCHandle value = GCHandle.Alloc(acbData, GCHandleType.Pinned);
		if (string.IsNullOrEmpty(awbPath))
		{
			awbPath = null;
		}
		IntPtr intPtr = criAtomExAcb_LoadAcbData(value.AddrOfPinnedObject(), acbData.Length, awb_binder, awbPath, IntPtr.Zero, 0);
		if (intPtr == IntPtr.Zero)
		{
			return null;
		}
		return new CriAtomExAcb(intPtr, value);
	}

	public static CriAtomExAcb LoadAcbData(IntPtr acbData, int dataSize, CriFsBinder awbBinder, string awbPath)
	{
		if (!Common.CheckBinaryVersionCompatibility())
		{
			return null;
		}
		IntPtr awb_binder = awbBinder?.nativeHandle ?? IntPtr.Zero;
		if (string.IsNullOrEmpty(awbPath))
		{
			awbPath = null;
		}
		IntPtr intPtr = criAtomExAcb_LoadAcbData(acbData, dataSize, awb_binder, awbPath, IntPtr.Zero, 0);
		if (intPtr == IntPtr.Zero)
		{
			return null;
		}
		return new CriAtomExAcb(intPtr, null);
	}

	public override void Dispose()
	{
		Dispose(disposing: true);
		GC.SuppressFinalize(this);
	}

	private void Dispose(bool disposing)
	{
		CriDisposableObjectManager.Unregister(this);
		if (isAvailable)
		{
			criAtomExAcb_Release(handle);
			handle = IntPtr.Zero;
		}
		if (disposing && dataHandle.IsAllocated)
		{
			dataHandle.Free();
		}
	}

	public bool Exists(string cueName)
	{
		return criAtomExAcb_ExistsName(handle, cueName);
	}

	public bool Exists(int cueId)
	{
		return criAtomExAcb_ExistsId(handle, cueId);
	}

	public bool GetCueInfo(string cueName, out CriAtomEx.CueInfo info)
	{
		using CriStructMemory<CriAtomEx.CueInfo> criStructMemory = new CriStructMemory<CriAtomEx.CueInfo>();
		bool result = criAtomExAcb_GetCueInfoByName(handle, cueName, criStructMemory.ptr);
		info = new CriAtomEx.CueInfo(criStructMemory.bytes, 0);
		return result;
	}

	public bool GetCueInfo(int cueId, out CriAtomEx.CueInfo info)
	{
		using CriStructMemory<CriAtomEx.CueInfo> criStructMemory = new CriStructMemory<CriAtomEx.CueInfo>();
		bool result = criAtomExAcb_GetCueInfoById(handle, cueId, criStructMemory.ptr);
		info = new CriAtomEx.CueInfo(criStructMemory.bytes, 0);
		return result;
	}

	public bool GetCueInfoByIndex(int index, out CriAtomEx.CueInfo info)
	{
		using CriStructMemory<CriAtomEx.CueInfo> criStructMemory = new CriStructMemory<CriAtomEx.CueInfo>();
		bool result = criAtomExAcb_GetCueInfoByIndex(handle, index, criStructMemory.ptr);
		info = new CriAtomEx.CueInfo(criStructMemory.bytes, 0);
		return result;
	}

	public CriAtomEx.CueInfo[] GetCueInfoList()
	{
		int num = criAtomExAcb_GetNumCues(handle);
		CriAtomEx.CueInfo[] array = new CriAtomEx.CueInfo[num];
		for (int i = 0; i < num; i++)
		{
			GetCueInfoByIndex(i, out array[i]);
		}
		return array;
	}

	public bool GetWaveFormInfo(string cueName, out CriAtomEx.WaveformInfo info)
	{
		using CriStructMemory<CriAtomEx.WaveformInfo> criStructMemory = new CriStructMemory<CriAtomEx.WaveformInfo>();
		bool result = criAtomExAcb_GetWaveformInfoByName(handle, cueName, criStructMemory.ptr);
		info = new CriAtomEx.WaveformInfo(criStructMemory.bytes, 0);
		return result;
	}

	public bool GetWaveFormInfo(int cueId, out CriAtomEx.WaveformInfo info)
	{
		using CriStructMemory<CriAtomEx.WaveformInfo> criStructMemory = new CriStructMemory<CriAtomEx.WaveformInfo>();
		bool result = criAtomExAcb_GetWaveformInfoById(handle, cueId, criStructMemory.ptr);
		info = new CriAtomEx.WaveformInfo(criStructMemory.bytes, 0);
		return result;
	}

	public int GetNumCuePlaying(string name)
	{
		return criAtomExAcb_GetNumCuePlayingCountByName(handle, name);
	}

	public int GetNumCuePlaying(int id)
	{
		return criAtomExAcb_GetNumCuePlayingCountById(handle, id);
	}

	public int GetBlockIndex(string cueName, string blockName)
	{
		return criAtomExAcb_GetBlockIndexByName(handle, cueName, blockName);
	}

	public int GetBlockIndex(int cueId, string blockName)
	{
		return criAtomExAcb_GetBlockIndexById(handle, cueId, blockName);
	}

	public int GetNumUsableAisacControls(string cueName)
	{
		return criAtomExAcb_GetNumUsableAisacControlsByName(handle, cueName);
	}

	public int GetNumUsableAisacControls(int cueId)
	{
		return criAtomExAcb_GetNumUsableAisacControlsById(handle, cueId);
	}

	public bool GetUsableAisacControl(string cueName, int index, out CriAtomEx.AisacControlInfo info)
	{
		using CriStructMemory<CriAtomEx.AisacControlInfo> criStructMemory = new CriStructMemory<CriAtomEx.AisacControlInfo>();
		bool result = criAtomExAcb_GetUsableAisacControlByName(handle, cueName, (ushort)index, criStructMemory.ptr);
		info = new CriAtomEx.AisacControlInfo(criStructMemory.bytes, 0);
		return result;
	}

	public bool GetUsableAisacControl(int cueId, int index, out CriAtomEx.AisacControlInfo info)
	{
		using CriStructMemory<CriAtomEx.AisacControlInfo> criStructMemory = new CriStructMemory<CriAtomEx.AisacControlInfo>();
		bool result = criAtomExAcb_GetUsableAisacControlById(handle, cueId, (ushort)index, criStructMemory.ptr);
		info = new CriAtomEx.AisacControlInfo(criStructMemory.bytes, 0);
		return result;
	}

	public CriAtomEx.AisacControlInfo[] GetUsableAisacControlList(string cueName)
	{
		int numUsableAisacControls = GetNumUsableAisacControls(cueName);
		CriAtomEx.AisacControlInfo[] array = new CriAtomEx.AisacControlInfo[numUsableAisacControls];
		for (int i = 0; i < numUsableAisacControls; i++)
		{
			GetUsableAisacControl(cueName, i, out array[i]);
		}
		return array;
	}

	public CriAtomEx.AisacControlInfo[] GetUsableAisacControlList(int cueId)
	{
		int numUsableAisacControls = GetNumUsableAisacControls(cueId);
		CriAtomEx.AisacControlInfo[] array = new CriAtomEx.AisacControlInfo[numUsableAisacControls];
		for (int i = 0; i < numUsableAisacControls; i++)
		{
			GetUsableAisacControl(cueId, i, out array[i]);
		}
		return array;
	}

	public void ResetCueTypeState(string cueName)
	{
		criAtomExAcb_ResetCueTypeStateByName(handle, cueName);
	}

	public void ResetCueTypeState(int cueId)
	{
		criAtomExAcb_ResetCueTypeStateById(handle, cueId);
	}

	public void AttachAwbFile(CriFsBinder awb_binder, string awb_path, string awb_name)
	{
		if (isAvailable)
		{
			IntPtr awb_binder2 = awb_binder?.nativeHandle ?? IntPtr.Zero;
			criAtomExAcb_AttachAwbFile(handle, awb_binder2, awb_path, awb_name, IntPtr.Zero, 0);
		}
	}

	public void DetachAwbFile(string awb_name)
	{
		if (isAvailable)
		{
			criAtomExAcb_DetachAwbFile(handle, awb_name);
		}
	}

	public bool IsReadyToRelease()
	{
		if (isAvailable)
		{
			return criAtomExAcb_IsReadyToRelease(handle);
		}
		return false;
	}

	public bool IsAttachedAwbFile(string awbName)
	{
		if (isAvailable)
		{
			return criAtomExAcb_IsAttachedAwbFile(handle, awbName);
		}
		return false;
	}

	public float GetLoadProgress()
	{
		return 1f;
	}

	public void Decrypt(ulong key, ulong nonce)
	{
		if (isAvailable)
		{
			CriAtomPlugin.DecryptAcb(handle, key, nonce);
		}
	}

	internal CriAtomExAcb(IntPtr handle, GCHandle? dataHandle)
	{
		this.handle = handle;
		if (dataHandle.HasValue)
		{
			this.dataHandle = dataHandle.Value;
		}
		CriDisposableObjectManager.Register(this, CriDisposableObjectManager.ModuleType.Atom);
	}

	~CriAtomExAcb()
	{
		Dispose(disposing: false);
	}

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern IntPtr criAtomExAcb_LoadAcbFile(IntPtr acb_binder, string acb_path, IntPtr awb_binder, string awb_path, IntPtr work, int work_size);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern IntPtr criAtomExAcb_LoadAcbData(IntPtr acb_data, int acb_data_size, IntPtr awb_binder, string awb_path, IntPtr work, int work_size);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern void criAtomExAcb_Release(IntPtr acb_hn);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern int criAtomExAcb_GetNumCues(IntPtr acb_hn);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern bool criAtomExAcb_ExistsId(IntPtr acb_hn, int id);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern bool criAtomExAcb_ExistsName(IntPtr acb_hn, string name);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern int criAtomExAcb_GetNumUsableAisacControlsById(IntPtr acb_hn, int id);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern int criAtomExAcb_GetNumUsableAisacControlsByName(IntPtr acb_hn, string name);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern bool criAtomExAcb_GetUsableAisacControlById(IntPtr acb_hn, int id, ushort index, IntPtr info);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern bool criAtomExAcb_GetUsableAisacControlByName(IntPtr acb_hn, string name, ushort index, IntPtr info);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern bool criAtomExAcb_GetWaveformInfoById(IntPtr acb_hn, int id, IntPtr waveform_info);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern bool criAtomExAcb_GetWaveformInfoByName(IntPtr acb_hn, string name, IntPtr waveform_info);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern bool criAtomExAcb_GetCueInfoByName(IntPtr acb_hn, string name, IntPtr info);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern bool criAtomExAcb_GetCueInfoById(IntPtr acb_hn, int id, IntPtr info);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern bool criAtomExAcb_GetCueInfoByIndex(IntPtr acb_hn, int index, IntPtr info);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern int criAtomExAcb_GetNumCuePlayingCountByName(IntPtr acb_hn, string name);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern int criAtomExAcb_GetNumCuePlayingCountById(IntPtr acb_hn, int id);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern int criAtomExAcb_GetBlockIndexById(IntPtr acb_hn, int id, string block_name);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern int criAtomExAcb_GetBlockIndexByName(IntPtr acb_hn, string name, string block_name);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern void criAtomExAcb_ResetCueTypeStateByName(IntPtr acb_hn, string name);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern void criAtomExAcb_ResetCueTypeStateById(IntPtr acb_hn, int id);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern void criAtomExAcb_AttachAwbFile(IntPtr acb_hn, IntPtr awb_binder, string awb_path, string awb_name, IntPtr work, int work_size);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern void criAtomExAcb_DetachAwbFile(IntPtr acb_hn, string awb_name);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern bool criAtomExAcb_IsReadyToRelease(IntPtr acb_hn);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern bool criAtomExAcb_IsAttachedAwbFile(IntPtr acbHn, string awbName);
}
