using System.Runtime.CompilerServices;
using System.Runtime.ConstrainedExecution;
using System.Runtime.InteropServices;

namespace System.Threading;

[StructLayout(LayoutKind.Sequential)]
internal sealed class InternalThread : CriticalFinalizerObject
{
	private int lock_thread_id;

	private IntPtr handle;

	private IntPtr native_handle;

	private IntPtr name_chars;

	private int name_free;

	private int name_length;

	private ThreadState state;

	private object abort_exc;

	private int abort_state_handle;

	internal long thread_id;

	private IntPtr debugger_thread;

	private UIntPtr static_data;

	private IntPtr runtime_thread_info;

	private object current_appcontext;

	private object root_domain_thread;

	internal byte[] _serialized_principal;

	internal int _serialized_principal_version;

	private IntPtr appdomain_refs;

	private int interruption_requested;

	private IntPtr longlived;

	internal bool threadpool_thread;

	private bool thread_interrupt_requested;

	internal int stack_size;

	internal byte apartment_state;

	internal volatile int critical_region_level;

	internal int managed_id;

	private int small_id;

	private IntPtr manage_callback;

	private IntPtr flags;

	private IntPtr thread_pinning_ref;

	private IntPtr abort_protected_block_count;

	private int priority = 2;

	private IntPtr owned_mutex;

	private IntPtr suspended_event;

	private int self_suspended;

	private IntPtr thread_state;

	private IntPtr netcore0;

	private IntPtr netcore1;

	private IntPtr netcore2;

	private IntPtr last;

	[MethodImpl((MethodImplOptions)4096)]
	private extern void Thread_free_internal();

	[ReliabilityContract(Consistency.WillNotCorruptState, Cer.Success)]
	~InternalThread()
	{
		Thread_free_internal();
	}
}
