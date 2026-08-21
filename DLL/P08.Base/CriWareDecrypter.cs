using System;
using System.Runtime.InteropServices;
using AOT;
using CriWare;

public static class CriWareDecrypter
{
	[Serializable]
	public class Config
	{
		public string key = "";

		public bool enableAtomDecryption = true;

		public bool enableManaDecryption = true;
	}

	[UnmanagedFunctionPointer(CallingConvention.Cdecl)]
	public delegate ulong CallbackFromNativeDelegate(IntPtr ptr1);

	private static ulong temporalStorage;

	public static bool Initialize(Config config)
	{
		return Initialize(config.key, config.enableAtomDecryption, config.enableManaDecryption);
	}

	public static bool Initialize(string key, bool enableAtomDecryption, bool enableManaDecryption)
	{
		if (!CriFsPlugin.IsLibraryInitialized())
		{
			return false;
		}
		if (!Common.CheckBinaryVersionCompatibility())
		{
			return false;
		}
		temporalStorage = ((key.Length == 0) ? 0 : Convert.ToUInt64(key)) ^ 0xD47EB533AEF7E5L;
		CRIWARE784C4141(enableAtomDecryption, enableManaDecryption, CallbackFromNative, IntPtr.Zero);
		temporalStorage = 0uL;
		return true;
	}

	[MonoPInvokeCallback(typeof(CallbackFromNativeDelegate))]
	private static ulong CallbackFromNative(IntPtr ptr1)
	{
		return temporalStorage;
	}

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	public static extern int CRIWARE784C4141(bool enable_atom_decryption, bool enable_mana_decryption, CallbackFromNativeDelegate func, IntPtr obj);
}
