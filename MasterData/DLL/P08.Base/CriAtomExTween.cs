using System;
using System.Runtime.InteropServices;

public class CriAtomExTween : CriDisposable
{
	public enum ParameterType
	{
		Basic,
		Aisac
	}

	private struct Config
	{
		[StructLayout(LayoutKind.Explicit)]
		public struct Target
		{
			[FieldOffset(0)]
			public CriAtomEx.Parameter parameterId;

			[FieldOffset(0)]
			public uint aisacIds;
		}

		public Target target;

		public ParameterType parameterType;
	}

	private IntPtr handle = IntPtr.Zero;

	internal IntPtr nativeHandle => handle;

	public float Value => criAtomExTween_GetValue(handle);

	public bool IsActive => criAtomExTween_IsActive(handle);

	public CriAtomExTween()
		: this(CriAtomEx.Parameter.Volume)
	{
	}

	public CriAtomExTween(CriAtomEx.Parameter parameterId)
		: this(ParameterType.Basic, (uint)parameterId)
	{
	}

	public CriAtomExTween(uint aisacId)
		: this(ParameterType.Aisac, aisacId)
	{
	}

	public CriAtomExTween(ParameterType parameterType, uint targetId)
	{
		if (!CriAtomPlugin.IsLibraryInitialized())
		{
			throw new Exception("CriAtomPlugin is not initialized.");
		}
		Config config = new Config
		{
			parameterType = parameterType,
			target = 
			{
				parameterId = (CriAtomEx.Parameter)targetId
			}
		};
		handle = criAtomExTween_Create(ref config, IntPtr.Zero, 0);
		CriDisposableObjectManager.Register(this, CriDisposableObjectManager.ModuleType.Atom);
	}

	public override void Dispose()
	{
		Dispose(disposing: true);
	}

	public void MoveTo(ushort durationMs, float value)
	{
		criAtomExTween_MoveTo(handle, durationMs, value);
	}

	public void MoveFrom(ushort durationMs, float value)
	{
		criAtomExTween_MoveFrom(handle, durationMs, value);
	}

	public void Stop()
	{
		criAtomExTween_Stop(handle);
	}

	public void Reset()
	{
		criAtomExTween_Reset(handle);
	}

	~CriAtomExTween()
	{
		Dispose(disposing: false);
	}

	protected virtual void Dispose(bool disposing)
	{
		CriDisposableObjectManager.Unregister(this);
		if (handle != IntPtr.Zero)
		{
			criAtomExTween_Destroy(handle);
			handle = IntPtr.Zero;
		}
		if (disposing)
		{
			GC.SuppressFinalize(this);
		}
	}

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern IntPtr criAtomExTween_Create(ref Config config, IntPtr work, int work_size);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern void criAtomExTween_Destroy(IntPtr tween);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern float criAtomExTween_GetValue(IntPtr tween);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern void criAtomExTween_MoveTo(IntPtr tween, ushort time_ms, float value);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern void criAtomExTween_MoveFrom(IntPtr tween, ushort time_ms, float value);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern void criAtomExTween_Stop(IntPtr tween);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern void criAtomExTween_Reset(IntPtr tween);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern bool criAtomExTween_IsActive(IntPtr tween);
}
