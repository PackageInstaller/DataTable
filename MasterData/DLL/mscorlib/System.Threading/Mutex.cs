using System.Runtime.CompilerServices;
using System.Runtime.ConstrainedExecution;
using System.Runtime.InteropServices;
using System.Security.AccessControl;

namespace System.Threading;

[ComVisible(true)]
public sealed class Mutex : WaitHandle
{
	[MethodImpl((MethodImplOptions)4096)]
	private unsafe static extern IntPtr CreateMutex_icall(bool initiallyOwned, char* name, int name_length, out bool created);

	[MethodImpl((MethodImplOptions)4096)]
	private static extern bool ReleaseMutex_internal(IntPtr handle);

	private unsafe static IntPtr CreateMutex_internal(bool initiallyOwned, string name, out bool created)
	{
		fixed (char* name2 = name)
		{
			return CreateMutex_icall(initiallyOwned, name2, name?.Length ?? 0, out created);
		}
	}

	[ReliabilityContract(Consistency.WillNotCorruptState, Cer.MayFail)]
	public Mutex()
	{
		Handle = CreateMutex_internal(initiallyOwned: false, null, out var _);
	}

	public Mutex(bool initiallyOwned, string name, out bool createdNew, MutexSecurity mutexSecurity)
	{
		throw new NotSupportedException();
	}

	[ReliabilityContract(Consistency.WillNotCorruptState, Cer.MayFail)]
	public void ReleaseMutex()
	{
		if (!ReleaseMutex_internal(Handle))
		{
			throw new ApplicationException("Mutex is not owned");
		}
	}
}
