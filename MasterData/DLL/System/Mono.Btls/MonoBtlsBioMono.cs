using System;
using System.Runtime.InteropServices;
using Mono.Util;

namespace Mono.Btls;

internal class MonoBtlsBioMono : MonoBtlsBio
{
	private enum ControlCommand
	{
		Flush = 1
	}

	[UnmanagedFunctionPointer(CallingConvention.Cdecl)]
	private delegate int BioReadFunc(IntPtr bio, IntPtr data, int dataLength, out int wantMore);

	[UnmanagedFunctionPointer(CallingConvention.Cdecl)]
	private delegate int BioWriteFunc(IntPtr bio, IntPtr data, int dataLength);

	[UnmanagedFunctionPointer(CallingConvention.Cdecl)]
	private delegate long BioControlFunc(IntPtr bio, ControlCommand command, long arg);

	private GCHandle handle;

	private IntPtr instance;

	private BioReadFunc readFunc;

	private BioWriteFunc writeFunc;

	private BioControlFunc controlFunc;

	private IntPtr readFuncPtr;

	private IntPtr writeFuncPtr;

	private IntPtr controlFuncPtr;

	private IMonoBtlsBioMono backend;

	public MonoBtlsBioMono(IMonoBtlsBioMono backend)
		: base(new BoringBioHandle(mono_btls_bio_mono_new()))
	{
		this.backend = backend;
		handle = GCHandle.Alloc(this);
		instance = GCHandle.ToIntPtr(handle);
		readFunc = OnRead;
		writeFunc = OnWrite;
		controlFunc = Control;
		readFuncPtr = Marshal.GetFunctionPointerForDelegate(readFunc);
		writeFuncPtr = Marshal.GetFunctionPointerForDelegate(writeFunc);
		controlFuncPtr = Marshal.GetFunctionPointerForDelegate(controlFunc);
		mono_btls_bio_mono_initialize(base.Handle.DangerousGetHandle(), instance, readFuncPtr, writeFuncPtr, controlFuncPtr);
	}

	[DllImport("libmono-btls-shared")]
	private static extern IntPtr mono_btls_bio_mono_new();

	[DllImport("libmono-btls-shared")]
	private static extern void mono_btls_bio_mono_initialize(IntPtr handle, IntPtr instance, IntPtr readFunc, IntPtr writeFunc, IntPtr controlFunc);

	private long Control(ControlCommand command, long arg)
	{
		if (command == ControlCommand.Flush)
		{
			backend.Flush();
			return 1L;
		}
		throw new NotImplementedException();
	}

	private int OnRead(IntPtr data, int dataLength, out int wantMore)
	{
		byte[] array = new byte[dataLength];
		int num = backend.Read(array, 0, dataLength, out var wantMore2);
		wantMore = (wantMore2 ? 1 : 0);
		if (num <= 0)
		{
			return num;
		}
		Marshal.Copy(array, 0, data, num);
		return num;
	}

	[MonoPInvokeCallback(typeof(BioReadFunc))]
	private static int OnRead(IntPtr instance, IntPtr data, int dataLength, out int wantMore)
	{
		MonoBtlsBioMono monoBtlsBioMono = (MonoBtlsBioMono)GCHandle.FromIntPtr(instance).Target;
		try
		{
			return monoBtlsBioMono.OnRead(data, dataLength, out wantMore);
		}
		catch (Exception exception)
		{
			monoBtlsBioMono.SetException(exception);
			wantMore = 0;
			return -1;
		}
	}

	private int OnWrite(IntPtr data, int dataLength)
	{
		byte[] array = new byte[dataLength];
		Marshal.Copy(data, array, 0, dataLength);
		if (!backend.Write(array, 0, dataLength))
		{
			return -1;
		}
		return dataLength;
	}

	[MonoPInvokeCallback(typeof(BioWriteFunc))]
	private static int OnWrite(IntPtr instance, IntPtr data, int dataLength)
	{
		MonoBtlsBioMono monoBtlsBioMono = (MonoBtlsBioMono)GCHandle.FromIntPtr(instance).Target;
		try
		{
			return monoBtlsBioMono.OnWrite(data, dataLength);
		}
		catch (Exception exception)
		{
			monoBtlsBioMono.SetException(exception);
			return -1;
		}
	}

	[MonoPInvokeCallback(typeof(BioControlFunc))]
	private static long Control(IntPtr instance, ControlCommand command, long arg)
	{
		MonoBtlsBioMono monoBtlsBioMono = (MonoBtlsBioMono)GCHandle.FromIntPtr(instance).Target;
		try
		{
			return monoBtlsBioMono.Control(command, arg);
		}
		catch (Exception exception)
		{
			monoBtlsBioMono.SetException(exception);
			return -1L;
		}
	}

	protected override void Close()
	{
		try
		{
			if (backend != null)
			{
				backend.Close();
				backend = null;
			}
			if (handle.IsAllocated)
			{
				handle.Free();
			}
		}
		finally
		{
			base.Close();
		}
	}
}
