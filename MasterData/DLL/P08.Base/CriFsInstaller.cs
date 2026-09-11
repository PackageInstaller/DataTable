using System;
using System.Runtime.InteropServices;

public class CriFsInstaller : CriDisposable
{
	public enum Status
	{
		Stop,
		Busy,
		Complete,
		Error
	}

	private enum CopyPolicy
	{
		Always
	}

	private byte[] installBuffer;

	private GCHandle installBufferGch;

	private IntPtr handle;

	public CriFsInstaller()
	{
		if (!CriFsPlugin.IsLibraryInitialized())
		{
			throw new Exception("CriFsPlugin is not initialized.");
		}
		handle = IntPtr.Zero;
		criFsInstaller_Create(out handle, CopyPolicy.Always);
		if (handle == IntPtr.Zero)
		{
			throw new Exception("criFsInstaller_Create() failed.");
		}
		CriDisposableObjectManager.Register(this, CriDisposableObjectManager.ModuleType.Fs);
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
			criFsInstaller_Destroy(handle);
			handle = IntPtr.Zero;
		}
		if (disposing && installBuffer != null)
		{
			installBufferGch.Free();
			installBuffer = null;
		}
	}

	public void Copy(CriFsBinder binder, string srcPath, string dstPath, int installBufferSize)
	{
		string text = srcPath;
		if (text.StartsWith("http:") || text.StartsWith("https:"))
		{
			text = "net2:" + text;
		}
		if (installBufferSize > 0)
		{
			installBuffer = new byte[installBufferSize];
			installBufferGch = GCHandle.Alloc(installBuffer, GCHandleType.Pinned);
			criFsInstaller_Copy(handle, binder?.nativeHandle ?? IntPtr.Zero, text, dstPath, installBufferGch.AddrOfPinnedObject(), installBuffer.Length);
		}
		else
		{
			criFsInstaller_Copy(handle, binder?.nativeHandle ?? IntPtr.Zero, text, dstPath, IntPtr.Zero, 0L);
		}
	}

	public void Stop()
	{
		if (handle != IntPtr.Zero)
		{
			criFsInstaller_Stop(handle);
		}
	}

	public Status GetStatus()
	{
		Status status = Status.Stop;
		if (handle != IntPtr.Zero)
		{
			criFsInstaller_GetStatus(handle, out status);
		}
		return status;
	}

	public float GetProgress()
	{
		float progress = 0f;
		if (handle != IntPtr.Zero)
		{
			criFsInstaller_GetProgress(handle, out progress);
		}
		return progress;
	}

	public static void ExecuteMain()
	{
		criFsInstaller_ExecuteMain();
	}

	~CriFsInstaller()
	{
		Dispose(disposing: false);
	}

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern int criFsInstaller_ExecuteMain();

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern int criFsInstaller_Create(out IntPtr installer, CopyPolicy option);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern int criFsInstaller_Destroy(IntPtr installer);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern int criFsInstaller_Copy(IntPtr installer, IntPtr binder, string src_path, string dst_path, IntPtr buffer, long buffer_size);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern int criFsInstaller_Stop(IntPtr installer);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern int criFsInstaller_GetStatus(IntPtr installer, out Status status);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern int criFsInstaller_GetProgress(IntPtr installer, out float progress);
}
