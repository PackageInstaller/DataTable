using System.Runtime.CompilerServices;
using System.Runtime.InteropServices;
using Mono.Interop;

namespace System.Threading;

internal class OSSpecificSynchronizationContext : SynchronizationContext
{
	private delegate void InvocationEntryDelegate(IntPtr arg);

	private class InvocationContext
	{
		private SendOrPostCallback m_Delegate;

		private object m_State;

		public InvocationContext(SendOrPostCallback d, object state)
		{
			m_Delegate = d;
			m_State = state;
		}

		public void Invoke()
		{
			m_Delegate(m_State);
		}
	}

	private object m_OSSynchronizationContext;

	private static readonly ConditionalWeakTable<object, OSSpecificSynchronizationContext> s_ContextCache = new ConditionalWeakTable<object, OSSpecificSynchronizationContext>();

	private OSSpecificSynchronizationContext(object osContext)
	{
		m_OSSynchronizationContext = osContext;
	}

	public static OSSpecificSynchronizationContext Get()
	{
		object oSContext = GetOSContext();
		if (oSContext == null)
		{
			return null;
		}
		return s_ContextCache.GetValue(oSContext, (object _osContext) => new OSSpecificSynchronizationContext(_osContext));
	}

	public override SynchronizationContext CreateCopy()
	{
		return new OSSpecificSynchronizationContext(m_OSSynchronizationContext);
	}

	public override void Send(SendOrPostCallback d, object state)
	{
		throw new NotSupportedException();
	}

	public override void Post(SendOrPostCallback d, object state)
	{
		IntPtr functionPointerForDelegate = Marshal.GetFunctionPointerForDelegate<InvocationEntryDelegate>(InvocationEntry);
		GCHandle value = GCHandle.Alloc(new InvocationContext(d, state));
		PostInternal(m_OSSynchronizationContext, functionPointerForDelegate, GCHandle.ToIntPtr(value));
	}

	[MonoPInvokeCallback(typeof(InvocationEntryDelegate))]
	private static void InvocationEntry(IntPtr arg)
	{
		try
		{
			GCHandle gCHandle = GCHandle.FromIntPtr(arg);
			InvocationContext obj = (InvocationContext)gCHandle.Target;
			gCHandle.Free();
			obj.Invoke();
		}
		catch (Exception exception)
		{
			Exception.ReportUnhandledException(exception);
		}
	}

	[MethodImpl((MethodImplOptions)4096)]
	private static extern object GetOSContext();

	[MethodImpl((MethodImplOptions)4096)]
	private static extern void PostInternal(object osSynchronizationContext, IntPtr callback, IntPtr arg);
}
