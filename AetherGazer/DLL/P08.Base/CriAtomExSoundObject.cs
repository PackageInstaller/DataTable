using System;
using System.Runtime.InteropServices;

public class CriAtomExSoundObject : CriDisposable
{
	private struct Config
	{
		public bool enableVoiceLimitScope;

		public bool enableCategoryCueLimitScope;
	}

	private IntPtr handle = IntPtr.Zero;

	public IntPtr nativeHandle => handle;

	public CriAtomExSoundObject(bool enableVoiceLimitScope, bool enableCategoryCueLimitScope)
	{
		if (!CriAtomPlugin.IsLibraryInitialized())
		{
			throw new Exception("CriAtomPlugin is not initialized.");
		}
		Config config = default(Config);
		config.enableVoiceLimitScope = enableVoiceLimitScope;
		config.enableCategoryCueLimitScope = enableCategoryCueLimitScope;
		handle = criAtomExSoundObject_Create(ref config, IntPtr.Zero, 0);
		CriDisposableObjectManager.Register(this, CriDisposableObjectManager.ModuleType.Atom);
	}

	public override void Dispose()
	{
		CriDisposableObjectManager.Unregister(this);
		if (handle != IntPtr.Zero)
		{
			criAtomExSoundObject_Destroy(handle);
			handle = IntPtr.Zero;
		}
		GC.SuppressFinalize(this);
	}

	public void AddPlayer(CriAtomExPlayer player)
	{
		criAtomExSoundObject_AddPlayer(handle, player.nativeHandle);
	}

	public void DeletePlayer(CriAtomExPlayer player)
	{
		criAtomExSoundObject_DeletePlayer(handle, player.nativeHandle);
	}

	public void DeleteAllPlayers()
	{
		criAtomExSoundObject_DeleteAllPlayers(handle);
	}

	~CriAtomExSoundObject()
	{
		Dispose();
	}

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern IntPtr criAtomExSoundObject_Create(ref Config config, IntPtr work, int work_size);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern void criAtomExSoundObject_Destroy(IntPtr soundObject);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern void criAtomExSoundObject_AddPlayer(IntPtr soundObject, IntPtr player);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern void criAtomExSoundObject_DeletePlayer(IntPtr soundObject, IntPtr player);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern void criAtomExSoundObject_DeleteAllPlayers(IntPtr soundObject);
}
