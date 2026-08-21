using System;
using System.Runtime.InteropServices;
using CriWare;

public class CriAtomExAcbLoader : CriDisposable
{
	public enum Status
	{
		Stop,
		Loading,
		Complete,
		Error
	}

	private struct LoaderConfig
	{
		public bool shouldLoadAwbOnMemory;
	}

	private IntPtr handle = IntPtr.Zero;

	private GCHandle? gch;

	public static CriAtomExAcbLoader LoadAcbFileAsync(CriFsBinder binder, string acbPath, string awbPath, bool loadAwbOnMemory = false)
	{
		if (!Common.CheckBinaryVersionCompatibility())
		{
			return null;
		}
		IntPtr intPtr = binder?.nativeHandle ?? IntPtr.Zero;
		LoaderConfig config = new LoaderConfig
		{
			shouldLoadAwbOnMemory = loadAwbOnMemory
		};
		IntPtr intPtr2 = criAtomExAcbLoader_Create(ref config);
		if (intPtr2 == IntPtr.Zero)
		{
			return null;
		}
		if (string.IsNullOrEmpty(awbPath))
		{
			awbPath = null;
		}
		if (!criAtomExAcbLoader_LoadAcbFileAsync(intPtr2, intPtr, acbPath, intPtr, awbPath))
		{
			criAtomExAcbLoader_Destroy(intPtr2);
			return null;
		}
		return new CriAtomExAcbLoader(intPtr2, null);
	}

	public static CriAtomExAcbLoader LoadAcbDataAsync(byte[] acbData, CriFsBinder awbBinder, string awbPath, bool loadAwbOnMemory = false)
	{
		if (!Common.CheckBinaryVersionCompatibility())
		{
			return null;
		}
		IntPtr awb_binder = awbBinder?.nativeHandle ?? IntPtr.Zero;
		LoaderConfig config = new LoaderConfig
		{
			shouldLoadAwbOnMemory = loadAwbOnMemory
		};
		IntPtr intPtr = criAtomExAcbLoader_Create(ref config);
		if (intPtr == IntPtr.Zero)
		{
			return null;
		}
		GCHandle value = GCHandle.Alloc(acbData, GCHandleType.Pinned);
		if (string.IsNullOrEmpty(awbPath))
		{
			awbPath = null;
		}
		if (!criAtomExAcbLoader_LoadAcbDataAsync(intPtr, value.AddrOfPinnedObject(), acbData.Length, awb_binder, awbPath))
		{
			criAtomExAcbLoader_Destroy(intPtr);
			return null;
		}
		return new CriAtomExAcbLoader(intPtr, value);
	}

	public static CriAtomExAcbLoader LoadAcbDataAsync(IntPtr acbData, int dataSize, CriFsBinder awbBinder, string awbPath, bool loadAwbOnMemory = false)
	{
		if (!Common.CheckBinaryVersionCompatibility())
		{
			return null;
		}
		IntPtr awb_binder = awbBinder?.nativeHandle ?? IntPtr.Zero;
		LoaderConfig config = new LoaderConfig
		{
			shouldLoadAwbOnMemory = loadAwbOnMemory
		};
		IntPtr intPtr = criAtomExAcbLoader_Create(ref config);
		if (intPtr == IntPtr.Zero)
		{
			return null;
		}
		if (string.IsNullOrEmpty(awbPath))
		{
			awbPath = null;
		}
		if (!criAtomExAcbLoader_LoadAcbDataAsync(intPtr, acbData, dataSize, awb_binder, awbPath))
		{
			criAtomExAcbLoader_Destroy(intPtr);
			return null;
		}
		return new CriAtomExAcbLoader(intPtr, null);
	}

	public Status GetStatus()
	{
		return criAtomExAcbLoader_GetStatus(handle);
	}

	public CriAtomExAcb MoveAcb()
	{
		IntPtr intPtr = criAtomExAcbLoader_MoveAcbHandle(handle);
		if (intPtr != IntPtr.Zero)
		{
			CriAtomExAcb result = new CriAtomExAcb(intPtr, gch);
			gch = null;
			return result;
		}
		return null;
	}

	public override void Dispose()
	{
		Dispose(disposing: true);
		GC.SuppressFinalize(this);
	}

	private void Dispose(bool disposing)
	{
		CriDisposableObjectManager.Unregister(this);
		if (handle != IntPtr.Zero)
		{
			criAtomExAcbLoader_Destroy(handle);
			handle = IntPtr.Zero;
		}
		if (disposing && gch.HasValue && gch.Value.IsAllocated)
		{
			gch.Value.Free();
		}
	}

	private CriAtomExAcbLoader(IntPtr handle, GCHandle? dataHandle)
	{
		this.handle = handle;
		if (dataHandle.HasValue)
		{
			gch = dataHandle.Value;
		}
		CriDisposableObjectManager.Register(this, CriDisposableObjectManager.ModuleType.Atom);
	}

	~CriAtomExAcbLoader()
	{
		Dispose(disposing: false);
	}

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern IntPtr criAtomExAcbLoader_Create([In] ref LoaderConfig config);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern void criAtomExAcbLoader_Destroy(IntPtr acb_loader);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern bool criAtomExAcbLoader_LoadAcbFileAsync(IntPtr acb_loader, IntPtr acb_binder, string acb_path, IntPtr awb_binder, string awb_path);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern bool criAtomExAcbLoader_LoadAcbDataAsync(IntPtr acb_loader, IntPtr acb_data, int acb_size, IntPtr awb_binder, string awb_path);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern Status criAtomExAcbLoader_GetStatus(IntPtr acb_loader);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern bool criAtomExAcbLoader_WaitForCompletion(IntPtr acb_loader);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern IntPtr criAtomExAcbLoader_MoveAcbHandle(IntPtr acb_loader);
}
