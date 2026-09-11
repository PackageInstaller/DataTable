using System;
using System.Runtime.InteropServices;

public class CriAtomExOutputPort : CriDisposable
{
	public enum Type
	{
		Audio,
		Vibration
	}

	public struct Config
	{
		public string name;

		public Type type;

		public uint maxIgnoredCategories;

		public static Config Default()
		{
			return new Config
			{
				name = string.Empty,
				type = Type.Audio,
				maxIgnoredCategories = 4u
			};
		}
	}

	private class NativeMethods
	{
		[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
		internal static extern int criAtomExOutputPort_CalculateWorkSize([In] Config config);

		[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
		internal static extern IntPtr criAtomExOutputPort_Create(ref Config config, IntPtr work, int workSize);

		[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
		internal static extern void criAtomExOutputPort_Destroy(IntPtr outputPort);

		[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
		internal static extern void criAtomExOutputPort_SetAsrRackId(IntPtr outputPort, int rackId);

		[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
		internal static extern void criAtomExOutputPort_SetVibrationChannelLevel(IntPtr outputPort, int channel, float level);

		[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
		internal static extern void criAtomExOutputPort_SetMonauralMix(IntPtr outputPort, bool monauralMix);

		[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
		internal static extern bool criAtomExOutputPort_IsDestroyable(IntPtr outputPort);
	}

	public const uint MaxNameLength = 64u;

	private bool hasExistingNativeHandle;

	public bool isAvailable => NativeHandle != IntPtr.Zero;

	internal IntPtr NativeHandle { get; private set; }

	public int CalculateWorkSize(Config config)
	{
		return NativeMethods.criAtomExOutputPort_CalculateWorkSize(config);
	}

	public CriAtomExOutputPort(Config config)
	{
		NativeHandle = NativeMethods.criAtomExOutputPort_Create(ref config, IntPtr.Zero, 0);
		CriDisposableObjectManager.Register(this, CriDisposableObjectManager.ModuleType.Atom);
	}

	internal CriAtomExOutputPort(IntPtr existingNativeHandle)
	{
		NativeHandle = existingNativeHandle;
		hasExistingNativeHandle = true;
		CriDisposableObjectManager.Register(this, CriDisposableObjectManager.ModuleType.Atom);
	}

	~CriAtomExOutputPort()
	{
		Dispose(disposing: false);
	}

	public override void Dispose()
	{
		Dispose(disposing: true);
	}

	protected virtual void Dispose(bool disposing)
	{
		CriDisposableObjectManager.Unregister(this);
		if (hasExistingNativeHandle)
		{
			NativeHandle = IntPtr.Zero;
		}
		if (isAvailable)
		{
			NativeMethods.criAtomExOutputPort_Destroy(NativeHandle);
			NativeHandle = IntPtr.Zero;
		}
		if (disposing)
		{
			GC.SuppressFinalize(this);
		}
	}

	public void SetAsrRackId(int rackId)
	{
		NativeMethods.criAtomExOutputPort_SetAsrRackId(NativeHandle, rackId);
	}

	public void SetVibrationChannelLevel(int channel, float level)
	{
		NativeMethods.criAtomExOutputPort_SetVibrationChannelLevel(NativeHandle, channel, level);
	}

	public void SetMonauralMix(bool monauralMix)
	{
		NativeMethods.criAtomExOutputPort_SetMonauralMix(NativeHandle, monauralMix);
	}

	public bool IsDestroyable()
	{
		return NativeMethods.criAtomExOutputPort_IsDestroyable(NativeHandle);
	}
}
