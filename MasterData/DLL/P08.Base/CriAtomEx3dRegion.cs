using System;
using System.Runtime.InteropServices;

public class CriAtomEx3dRegion : CriDisposable
{
	public struct Config
	{
		public int reserved;
	}

	private static class UnsafeNativeMethods
	{
		[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
		internal static extern IntPtr criAtomEx3dRegion_Create(ref Config config, IntPtr work, int work_size);

		[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
		internal static extern void criAtomEx3dRegion_Destroy(IntPtr ex_3d_region);

		[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
		internal static extern bool criAtomEx3dRegion_IsDestroyable(IntPtr ex3dRegion);
	}

	private IntPtr handle = IntPtr.Zero;

	public IntPtr nativeHandle => handle;

	public CriAtomEx3dRegion()
	{
		Config config = default(Config);
		handle = UnsafeNativeMethods.criAtomEx3dRegion_Create(ref config, IntPtr.Zero, 0);
		CriDisposableObjectManager.Register(this, CriDisposableObjectManager.ModuleType.Atom);
	}

	public override void Dispose()
	{
		Dispose(disposing: true);
	}

	private void Dispose(bool disposing)
	{
		CriDisposableObjectManager.Unregister(this);
		if (handle != IntPtr.Zero)
		{
			UnsafeNativeMethods.criAtomEx3dRegion_Destroy(handle);
			handle = IntPtr.Zero;
		}
		if (disposing)
		{
			GC.SuppressFinalize(this);
		}
	}

	~CriAtomEx3dRegion()
	{
		Dispose(disposing: false);
	}

	public bool IsDestroyable()
	{
		return UnsafeNativeMethods.criAtomEx3dRegion_IsDestroyable(nativeHandle);
	}
}
