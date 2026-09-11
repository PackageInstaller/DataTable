using System;
using System.Runtime.InteropServices;

public class CriFsLoader : CriDisposable
{
	public enum Status
	{
		Stop,
		Loading,
		Complete,
		Error
	}

	private IntPtr handle;

	private GCHandle dstGch;

	private GCHandle srcGch;

	public CriFsLoader()
	{
		if (!CriFsPlugin.IsLibraryInitialized())
		{
			throw new Exception("CriFsPlugin is not initialized.");
		}
		handle = IntPtr.Zero;
		criFsLoader_Create(out handle);
		if (handle == IntPtr.Zero)
		{
			throw new Exception("criFsLoader_Create() failed.");
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
			criFsLoader_Destroy(handle);
			handle = IntPtr.Zero;
		}
		if (disposing)
		{
			if (dstGch.IsAllocated)
			{
				dstGch.Free();
			}
			if (srcGch.IsAllocated)
			{
				srcGch.Free();
			}
		}
	}

	public void Load(CriFsBinder binder, string path, long fileOffset, long loadSize, byte[] buffer)
	{
		dstGch = GCHandle.Alloc(buffer, GCHandleType.Pinned);
		criFsLoader_Load(handle, binder?.nativeHandle ?? IntPtr.Zero, path, fileOffset, loadSize, dstGch.AddrOfPinnedObject(), buffer.Length);
	}

	public void LoadById(CriFsBinder binder, int id, long fileOffset, long loadSize, byte[] buffer)
	{
		dstGch = GCHandle.Alloc(buffer, GCHandleType.Pinned);
		criFsLoader_LoadById(handle, binder?.nativeHandle ?? IntPtr.Zero, id, fileOffset, loadSize, dstGch.AddrOfPinnedObject(), buffer.Length);
	}

	public void LoadWithoutDecompression(CriFsBinder binder, string path, long fileOffset, long loadSize, byte[] buffer)
	{
		dstGch = GCHandle.Alloc(buffer, GCHandleType.Pinned);
		criFsLoader_LoadWithoutDecompression(handle, binder?.nativeHandle ?? IntPtr.Zero, path, fileOffset, loadSize, dstGch.AddrOfPinnedObject(), buffer.Length);
	}

	public void LoadWithoutDecompressionById(CriFsBinder binder, int id, long fileOffset, long loadSize, byte[] buffer)
	{
		dstGch = GCHandle.Alloc(buffer, GCHandleType.Pinned);
		criFsLoader_LoadWithoutDecompressionById(handle, binder?.nativeHandle ?? IntPtr.Zero, id, fileOffset, loadSize, dstGch.AddrOfPinnedObject(), buffer.Length);
	}

	public void DecompressData(long srcSize, byte[] srcBuffer, long dstSize, byte[] dstBuffer)
	{
		srcGch = GCHandle.Alloc(srcBuffer, GCHandleType.Pinned);
		dstGch = GCHandle.Alloc(dstBuffer, GCHandleType.Pinned);
		criFsLoader_DecompressData(handle, srcGch.AddrOfPinnedObject(), srcSize, dstGch.AddrOfPinnedObject(), dstSize);
	}

	public void Stop()
	{
		if (handle != IntPtr.Zero)
		{
			criFsLoader_Stop(handle);
		}
	}

	public Status GetStatus()
	{
		Status status = Status.Stop;
		if (handle != IntPtr.Zero)
		{
			criFsLoader_GetStatus(handle, out status);
		}
		if (status != Status.Loading)
		{
			if (dstGch.IsAllocated)
			{
				dstGch.Free();
			}
			if (srcGch.IsAllocated)
			{
				srcGch.Free();
			}
		}
		return status;
	}

	public void SetReadUnitSize(int unit_size)
	{
		if (handle != IntPtr.Zero)
		{
			criFsLoader_SetReadUnitSize(handle, unit_size);
		}
	}

	~CriFsLoader()
	{
		Dispose(disposing: false);
	}

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern int criFsLoader_Create(out IntPtr loader);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern int criFsLoader_Destroy(IntPtr loader);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern int criFsLoader_Load(IntPtr loader, IntPtr binder, string path, long offset, long load_size, IntPtr buffer, long buffer_size);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern int criFsLoader_LoadById(IntPtr loader, IntPtr binder, int id, long offset, long load_size, IntPtr buffer, long buffer_size);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern int criFsLoader_Stop(IntPtr loader);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern int criFsLoader_GetStatus(IntPtr loader, out Status status);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern int criFsLoader_SetReadUnitSize(IntPtr loader, long unit_size);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern int criFsLoader_LoadWithoutDecompression(IntPtr loader, IntPtr binder, string path, long offset, long load_size, IntPtr buffer, long buffer_size);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern int criFsLoader_LoadWithoutDecompressionById(IntPtr loader, IntPtr binder, int id, long offset, long load_size, IntPtr buffer, long buffer_size);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern int criFsLoader_DecompressData(IntPtr loader, IntPtr src, long src_size, IntPtr dst, long dst_size);
}
