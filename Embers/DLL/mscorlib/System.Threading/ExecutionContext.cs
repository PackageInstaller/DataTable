using System.Collections.Generic;
using System.Runtime.CompilerServices;
using System.Runtime.ConstrainedExecution;
using System.Runtime.ExceptionServices;
using System.Runtime.Remoting.Messaging;
using System.Runtime.Serialization;

namespace System.Threading;

[Serializable]
public sealed class ExecutionContext : IDisposable, ISerializable
{
	private enum Flags
	{
		None = 0,
		IsNewCapture = 1,
		IsFlowSuppressed = 2,
		IsPreAllocatedDefault = 4
	}

	internal struct Reader(ExecutionContext ec)
	{
		private ExecutionContext m_ec = ec;

		public bool IsNull => m_ec == null;

		public bool IsFlowSuppressed
		{
			[MethodImpl((MethodImplOptions)256)]
			get
			{
				if (!IsNull)
				{
					return m_ec.isFlowSuppressed;
				}
				return false;
			}
		}

		public SynchronizationContext SynchronizationContext
		{
			get
			{
				if (!IsNull)
				{
					return m_ec.SynchronizationContext;
				}
				return null;
			}
		}

		public SynchronizationContext SynchronizationContextNoFlow
		{
			get
			{
				if (!IsNull)
				{
					return m_ec.SynchronizationContextNoFlow;
				}
				return null;
			}
		}

		public LogicalCallContext.Reader LogicalCallContext => new LogicalCallContext.Reader(IsNull ? null : m_ec.LogicalCallContext);

		public ExecutionContext DangerousGetRawExecutionContext()
		{
			return m_ec;
		}

		public bool IsDefaultFTContext(bool ignoreSyncCtx)
		{
			return m_ec.IsDefaultFTContext(ignoreSyncCtx);
		}

		public bool HasSameLocalValues(ExecutionContext other)
		{
			Dictionary<IAsyncLocal, object> obj = (IsNull ? null : m_ec._localValues);
			Dictionary<IAsyncLocal, object> dictionary = other?._localValues;
			return obj == dictionary;
		}
	}

	[Flags]
	internal enum CaptureOptions
	{
		None = 0,
		IgnoreSyncCtx = 1,
		OptimizeDefaultCase = 2
	}

	private SynchronizationContext _syncContext;

	private SynchronizationContext _syncContextNoFlow;

	private LogicalCallContext _logicalCallContext;

	private IllogicalCallContext _illogicalCallContext;

	private Flags _flags;

	private Dictionary<IAsyncLocal, object> _localValues;

	private List<IAsyncLocal> _localChangeNotifications;

	private static readonly ExecutionContext s_dummyDefaultEC = new ExecutionContext(isPreAllocatedDefault: true);

	internal static readonly ExecutionContext Default = new ExecutionContext();

	internal bool isNewCapture
	{
		get
		{
			return (_flags & (Flags)5) != 0;
		}
		set
		{
			if (value)
			{
				_flags |= Flags.IsNewCapture;
			}
			else
			{
				_flags &= (Flags)(-2);
			}
		}
	}

	internal bool isFlowSuppressed
	{
		get
		{
			return (_flags & Flags.IsFlowSuppressed) != 0;
		}
		set
		{
			if (value)
			{
				_flags |= Flags.IsFlowSuppressed;
			}
			else
			{
				_flags &= (Flags)(-3);
			}
		}
	}

	internal bool IsPreAllocatedDefault
	{
		get
		{
			if ((_flags & Flags.IsPreAllocatedDefault) != Flags.None)
			{
				return true;
			}
			return false;
		}
	}

	internal LogicalCallContext LogicalCallContext
	{
		get
		{
			if (_logicalCallContext == null)
			{
				_logicalCallContext = new LogicalCallContext();
			}
			return _logicalCallContext;
		}
		set
		{
			_logicalCallContext = value;
		}
	}

	internal IllogicalCallContext IllogicalCallContext
	{
		get
		{
			if (_illogicalCallContext == null)
			{
				_illogicalCallContext = new IllogicalCallContext();
			}
			return _illogicalCallContext;
		}
		set
		{
			_illogicalCallContext = value;
		}
	}

	internal SynchronizationContext SynchronizationContext
	{
		[ReliabilityContract(Consistency.WillNotCorruptState, Cer.Success)]
		get
		{
			return _syncContext;
		}
		[ReliabilityContract(Consistency.WillNotCorruptState, Cer.Success)]
		set
		{
			_syncContext = value;
		}
	}

	internal SynchronizationContext SynchronizationContextNoFlow
	{
		[ReliabilityContract(Consistency.WillNotCorruptState, Cer.Success)]
		get
		{
			return _syncContextNoFlow;
		}
		[ReliabilityContract(Consistency.WillNotCorruptState, Cer.Success)]
		set
		{
			_syncContextNoFlow = value;
		}
	}

	[ReliabilityContract(Consistency.WillNotCorruptState, Cer.Success)]
	internal ExecutionContext()
	{
	}

	[ReliabilityContract(Consistency.WillNotCorruptState, Cer.Success)]
	internal ExecutionContext(bool isPreAllocatedDefault)
	{
		if (isPreAllocatedDefault)
		{
			_flags = Flags.IsPreAllocatedDefault;
		}
	}

	internal static void SetLocalValue(IAsyncLocal local, object newValue, bool needChangeNotifications)
	{
		ExecutionContext mutableExecutionContext = Thread.CurrentThread.GetMutableExecutionContext();
		object value = null;
		bool flag = mutableExecutionContext._localValues != null && mutableExecutionContext._localValues.TryGetValue(local, out value);
		if (value == newValue)
		{
			return;
		}
		if (mutableExecutionContext._localValues == null)
		{
			mutableExecutionContext._localValues = new Dictionary<IAsyncLocal, object>();
		}
		else
		{
			mutableExecutionContext._localValues = new Dictionary<IAsyncLocal, object>(mutableExecutionContext._localValues);
		}
		mutableExecutionContext._localValues[local] = newValue;
		if (!needChangeNotifications)
		{
			return;
		}
		if (!flag)
		{
			if (mutableExecutionContext._localChangeNotifications == null)
			{
				mutableExecutionContext._localChangeNotifications = new List<IAsyncLocal>();
			}
			else
			{
				mutableExecutionContext._localChangeNotifications = new List<IAsyncLocal>(mutableExecutionContext._localChangeNotifications);
			}
			mutableExecutionContext._localChangeNotifications.Add(local);
		}
		local.OnValueChanged(value, newValue, contextChanged: false);
	}

	[HandleProcessCorruptedStateExceptions]
	internal static void OnAsyncLocalContextChanged(ExecutionContext previous, ExecutionContext current)
	{
		List<IAsyncLocal> list = previous?._localChangeNotifications;
		if (list != null)
		{
			foreach (IAsyncLocal item in list)
			{
				object value = null;
				if (previous != null && previous._localValues != null)
				{
					previous._localValues.TryGetValue(item, out value);
				}
				object value2 = null;
				if (current != null && current._localValues != null)
				{
					current._localValues.TryGetValue(item, out value2);
				}
				if (value != value2)
				{
					item.OnValueChanged(value, value2, contextChanged: true);
				}
			}
		}
		List<IAsyncLocal> list2 = current?._localChangeNotifications;
		if (list2 == null || list2 == list)
		{
			return;
		}
		try
		{
			foreach (IAsyncLocal item2 in list2)
			{
				object value3 = null;
				if (previous == null || previous._localValues == null || !previous._localValues.TryGetValue(item2, out value3))
				{
					object value4 = null;
					if (current != null && current._localValues != null)
					{
						current._localValues.TryGetValue(item2, out value4);
					}
					if (value3 != value4)
					{
						item2.OnValueChanged(value3, value4, contextChanged: true);
					}
				}
			}
		}
		catch (Exception exception)
		{
			Environment.FailFast(Environment.GetResourceString("An exception was not handled in an AsyncLocal<T> notification callback."), exception);
		}
	}

	public void Dispose()
	{
		_ = IsPreAllocatedDefault;
	}

	public static void Run(ExecutionContext executionContext, ContextCallback callback, object state)
	{
		if (executionContext == null)
		{
			throw new InvalidOperationException(Environment.GetResourceString("Cannot call Set on a null context"));
		}
		if (!executionContext.isNewCapture)
		{
			throw new InvalidOperationException(Environment.GetResourceString("Cannot apply a context that has been marshaled across AppDomains, that was not acquired through a Capture operation or that has already been the argument to a Set call."));
		}
		Run(executionContext, callback, state, preserveSyncCtx: false);
	}

	[FriendAccessAllowed]
	internal static void Run(ExecutionContext executionContext, ContextCallback callback, object state, bool preserveSyncCtx)
	{
		RunInternal(executionContext, callback, state, preserveSyncCtx);
	}

	internal static void RunInternal(ExecutionContext executionContext, ContextCallback callback, object state)
	{
		RunInternal(executionContext, callback, state, preserveSyncCtx: false);
	}

	[HandleProcessCorruptedStateExceptions]
	internal static void RunInternal(ExecutionContext executionContext, ContextCallback callback, object state, bool preserveSyncCtx)
	{
		if (!executionContext.IsPreAllocatedDefault)
		{
			executionContext.isNewCapture = false;
		}
		Thread currentThread = Thread.CurrentThread;
		ExecutionContextSwitcher ecsw = default(ExecutionContextSwitcher);
		RuntimeHelpers.PrepareConstrainedRegions();
		try
		{
			Reader executionContextReader = currentThread.GetExecutionContextReader();
			if ((executionContextReader.IsNull || executionContextReader.IsDefaultFTContext(preserveSyncCtx)) && executionContext.IsDefaultFTContext(preserveSyncCtx) && executionContextReader.HasSameLocalValues(executionContext))
			{
				EstablishCopyOnWriteScope(currentThread, knownNullWindowsIdentity: true, ref ecsw);
			}
			else
			{
				if (executionContext.IsPreAllocatedDefault)
				{
					executionContext = new ExecutionContext();
				}
				ecsw = SetExecutionContext(executionContext, preserveSyncCtx);
			}
			callback(state);
		}
		finally
		{
			ecsw.Undo();
		}
	}

	internal static void EstablishCopyOnWriteScope(ref ExecutionContextSwitcher ecsw)
	{
		EstablishCopyOnWriteScope(Thread.CurrentThread, knownNullWindowsIdentity: false, ref ecsw);
	}

	private static void EstablishCopyOnWriteScope(Thread currentThread, bool knownNullWindowsIdentity, ref ExecutionContextSwitcher ecsw)
	{
		ecsw.outerEC = currentThread.GetExecutionContextReader();
		ecsw.outerECBelongsToScope = currentThread.ExecutionContextBelongsToCurrentScope;
		currentThread.ExecutionContextBelongsToCurrentScope = false;
		ecsw.thread = currentThread;
	}

	[MethodImpl((MethodImplOptions)8)]
	[HandleProcessCorruptedStateExceptions]
	internal static ExecutionContextSwitcher SetExecutionContext(ExecutionContext executionContext, bool preserveSyncCtx)
	{
		ExecutionContextSwitcher result = default(ExecutionContextSwitcher);
		Thread currentThread = Thread.CurrentThread;
		Reader executionContextReader = currentThread.GetExecutionContextReader();
		result.thread = currentThread;
		result.outerEC = executionContextReader;
		result.outerECBelongsToScope = currentThread.ExecutionContextBelongsToCurrentScope;
		if (preserveSyncCtx)
		{
			executionContext.SynchronizationContext = executionContextReader.SynchronizationContext;
		}
		executionContext.SynchronizationContextNoFlow = executionContextReader.SynchronizationContextNoFlow;
		currentThread.SetExecutionContext(executionContext, belongsToCurrentScope: true);
		RuntimeHelpers.PrepareConstrainedRegions();
		try
		{
			OnAsyncLocalContextChanged(executionContextReader.DangerousGetRawExecutionContext(), executionContext);
			return result;
		}
		catch
		{
			result.UndoNoThrow();
			throw;
		}
	}

	public ExecutionContext CreateCopy()
	{
		if (!isNewCapture)
		{
			throw new InvalidOperationException(Environment.GetResourceString("Only newly captured contexts can be copied"));
		}
		ExecutionContext executionContext = new ExecutionContext();
		executionContext.isNewCapture = true;
		executionContext._syncContext = ((_syncContext == null) ? null : _syncContext.CreateCopy());
		executionContext._localValues = _localValues;
		executionContext._localChangeNotifications = _localChangeNotifications;
		if (_logicalCallContext != null)
		{
			executionContext.LogicalCallContext = (LogicalCallContext)LogicalCallContext.Clone();
		}
		return executionContext;
	}

	internal ExecutionContext CreateMutableCopy()
	{
		ExecutionContext executionContext = new ExecutionContext();
		executionContext._syncContext = _syncContext;
		executionContext._syncContextNoFlow = _syncContextNoFlow;
		if (_logicalCallContext != null)
		{
			executionContext.LogicalCallContext = (LogicalCallContext)LogicalCallContext.Clone();
		}
		if (_illogicalCallContext != null)
		{
			executionContext.IllogicalCallContext = IllogicalCallContext.CreateCopy();
		}
		executionContext._localValues = _localValues;
		executionContext._localChangeNotifications = _localChangeNotifications;
		executionContext.isFlowSuppressed = isFlowSuppressed;
		return executionContext;
	}

	public static AsyncFlowControl SuppressFlow()
	{
		if (IsFlowSuppressed())
		{
			throw new InvalidOperationException(Environment.GetResourceString("Context flow is already suppressed."));
		}
		AsyncFlowControl result = default(AsyncFlowControl);
		result.Setup();
		return result;
	}

	public static void RestoreFlow()
	{
		ExecutionContext mutableExecutionContext = Thread.CurrentThread.GetMutableExecutionContext();
		if (!mutableExecutionContext.isFlowSuppressed)
		{
			throw new InvalidOperationException(Environment.GetResourceString("Cannot restore context flow when it is not suppressed."));
		}
		mutableExecutionContext.isFlowSuppressed = false;
	}

	public static bool IsFlowSuppressed()
	{
		return Thread.CurrentThread.GetExecutionContextReader().IsFlowSuppressed;
	}

	[MethodImpl((MethodImplOptions)8)]
	public static ExecutionContext Capture()
	{
		StackCrawlMark stackMark = StackCrawlMark.LookForMyCaller;
		return Capture(ref stackMark, CaptureOptions.None);
	}

	[MethodImpl((MethodImplOptions)8)]
	[FriendAccessAllowed]
	internal static ExecutionContext FastCapture()
	{
		StackCrawlMark stackMark = StackCrawlMark.LookForMyCaller;
		return Capture(ref stackMark, CaptureOptions.IgnoreSyncCtx | CaptureOptions.OptimizeDefaultCase);
	}

	internal static ExecutionContext Capture(ref StackCrawlMark stackMark, CaptureOptions options)
	{
		Reader executionContextReader = Thread.CurrentThread.GetExecutionContextReader();
		if (executionContextReader.IsFlowSuppressed)
		{
			return null;
		}
		SynchronizationContext synchronizationContext = null;
		LogicalCallContext logicalCallContext = null;
		if (!executionContextReader.IsNull)
		{
			if ((options & CaptureOptions.IgnoreSyncCtx) == 0)
			{
				synchronizationContext = ((executionContextReader.SynchronizationContext == null) ? null : executionContextReader.SynchronizationContext.CreateCopy());
			}
			if (executionContextReader.LogicalCallContext.HasInfo)
			{
				logicalCallContext = executionContextReader.LogicalCallContext.Clone();
			}
		}
		Dictionary<IAsyncLocal, object> dictionary = null;
		List<IAsyncLocal> list = null;
		if (!executionContextReader.IsNull)
		{
			dictionary = executionContextReader.DangerousGetRawExecutionContext()._localValues;
			list = executionContextReader.DangerousGetRawExecutionContext()._localChangeNotifications;
		}
		if ((options & CaptureOptions.OptimizeDefaultCase) != CaptureOptions.None && synchronizationContext == null && (logicalCallContext == null || !logicalCallContext.HasInfo) && dictionary == null && list == null)
		{
			return s_dummyDefaultEC;
		}
		return new ExecutionContext
		{
			_syncContext = synchronizationContext,
			LogicalCallContext = logicalCallContext,
			_localValues = dictionary,
			_localChangeNotifications = list,
			isNewCapture = true
		};
	}

	public void GetObjectData(SerializationInfo info, StreamingContext context)
	{
		if (info == null)
		{
			throw new ArgumentNullException("info");
		}
		if (_logicalCallContext != null)
		{
			info.AddValue("LogicalCallContext", _logicalCallContext, typeof(LogicalCallContext));
		}
	}

	private ExecutionContext(SerializationInfo info, StreamingContext context)
	{
		SerializationInfoEnumerator enumerator = info.GetEnumerator();
		while (enumerator.MoveNext())
		{
			if (enumerator.Name.Equals("LogicalCallContext"))
			{
				_logicalCallContext = (LogicalCallContext)enumerator.Value;
			}
		}
	}

	internal bool IsDefaultFTContext(bool ignoreSyncCtx)
	{
		if (!ignoreSyncCtx && _syncContext != null)
		{
			return false;
		}
		if (_logicalCallContext != null && _logicalCallContext.HasInfo)
		{
			return false;
		}
		if (_illogicalCallContext != null && _illogicalCallContext.HasUserData)
		{
			return false;
		}
		return true;
	}
}
