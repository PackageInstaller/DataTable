using System.Collections.Generic;
using System.Diagnostics;
using System.Globalization;
using System.IO;
using System.Runtime.CompilerServices;
using System.Runtime.ConstrainedExecution;
using System.Runtime.InteropServices;
using System.Runtime.Remoting.Contexts;
using System.Runtime.Serialization.Formatters.Binary;
using System.Security.Principal;
using Internal.Runtime.Augments;
using Unity;

namespace System.Threading;

[StructLayout(LayoutKind.Sequential)]
public sealed class Thread : CriticalFinalizerObject, _Thread
{
	private static LocalDataStoreMgr s_LocalDataStoreMgr;

	[ThreadStatic]
	private static LocalDataStoreHolder s_LocalDataStore;

	[ThreadStatic]
	internal static CultureInfo m_CurrentCulture;

	[ThreadStatic]
	internal static CultureInfo m_CurrentUICulture;

	private static AsyncLocal<CultureInfo> s_asyncLocalCurrentCulture;

	private static AsyncLocal<CultureInfo> s_asyncLocalCurrentUICulture;

	private InternalThread internal_thread;

	private object m_ThreadStartArg;

	private object pending_exception;

	[ThreadStatic]
	private static Thread current_thread;

	private MulticastDelegate m_Delegate;

	private ExecutionContext m_ExecutionContext;

	private bool m_ExecutionContextBelongsToOuterScope;

	private IPrincipal principal;

	private int principal_version;

	internal bool ExecutionContextBelongsToCurrentScope
	{
		get
		{
			return !m_ExecutionContextBelongsToOuterScope;
		}
		set
		{
			m_ExecutionContextBelongsToOuterScope = !value;
		}
	}

	public ExecutionContext ExecutionContext
	{
		[ReliabilityContract(Consistency.WillNotCorruptState, Cer.MayFail)]
		get
		{
			if (this == CurrentThread)
			{
				return GetMutableExecutionContext();
			}
			return m_ExecutionContext;
		}
	}

	public ThreadPriority Priority
	{
		get
		{
			return (ThreadPriority)GetPriorityNative();
		}
		set
		{
			SetPriorityNative((int)value);
		}
	}

	public CultureInfo CurrentUICulture
	{
		get
		{
			if (AppDomain.IsAppXModel())
			{
				return CultureInfo.GetCultureInfoForUserPreferredLanguageInAppX() ?? GetCurrentUICultureNoAppX();
			}
			return GetCurrentUICultureNoAppX();
		}
		set
		{
			if (value == null)
			{
				throw new ArgumentNullException("value");
			}
			CultureInfo.VerifyCultureName(value, throwException: true);
			if (AppDomain.IsAppXModel())
			{
				CultureInfo.SetCultureInfoForUserPreferredLanguageInAppX(value);
				return;
			}
			if (m_CurrentUICulture == null && m_CurrentCulture == null)
			{
				nativeInitCultureAccessors();
			}
			if (!AppContextSwitches.NoAsyncCurrentCulture)
			{
				if (s_asyncLocalCurrentUICulture == null)
				{
					Interlocked.CompareExchange(ref s_asyncLocalCurrentUICulture, new AsyncLocal<CultureInfo>(AsyncLocalSetCurrentUICulture), null);
				}
				s_asyncLocalCurrentUICulture.Value = value;
			}
			else
			{
				m_CurrentUICulture = value;
			}
		}
	}

	public CultureInfo CurrentCulture
	{
		get
		{
			if (AppDomain.IsAppXModel())
			{
				return CultureInfo.GetCultureInfoForUserPreferredLanguageInAppX() ?? GetCurrentCultureNoAppX();
			}
			return GetCurrentCultureNoAppX();
		}
		set
		{
			if (value == null)
			{
				throw new ArgumentNullException("value");
			}
			if (AppDomain.IsAppXModel())
			{
				CultureInfo.SetCultureInfoForUserPreferredLanguageInAppX(value);
				return;
			}
			if (m_CurrentCulture == null && m_CurrentUICulture == null)
			{
				nativeInitCultureAccessors();
			}
			if (!AppContextSwitches.NoAsyncCurrentCulture)
			{
				if (s_asyncLocalCurrentCulture == null)
				{
					Interlocked.CompareExchange(ref s_asyncLocalCurrentCulture, new AsyncLocal<CultureInfo>(AsyncLocalSetCurrentCulture), null);
				}
				s_asyncLocalCurrentCulture.Value = value;
			}
			else
			{
				m_CurrentCulture = value;
			}
		}
	}

	private static LocalDataStoreMgr LocalDataStoreManager
	{
		get
		{
			if (s_LocalDataStoreMgr == null)
			{
				Interlocked.CompareExchange(ref s_LocalDataStoreMgr, new LocalDataStoreMgr(), null);
			}
			return s_LocalDataStoreMgr;
		}
	}

	private InternalThread Internal
	{
		get
		{
			if (internal_thread == null)
			{
				ConstructInternalThread();
			}
			return internal_thread;
		}
	}

	public static Context CurrentContext => AppDomain.InternalGetContext();

	public static IPrincipal CurrentPrincipal
	{
		get
		{
			Thread currentThread = CurrentThread;
			IPrincipal principal = currentThread.GetExecutionContextReader().LogicalCallContext.Principal;
			if (principal != null)
			{
				return principal;
			}
			if (currentThread.principal_version != currentThread.Internal._serialized_principal_version)
			{
				currentThread.principal = null;
			}
			if (currentThread.principal != null)
			{
				return currentThread.principal;
			}
			if (currentThread.Internal._serialized_principal != null)
			{
				try
				{
					DeserializePrincipal(currentThread);
					return currentThread.principal;
				}
				catch
				{
				}
			}
			currentThread.principal = GetDomain().DefaultPrincipal;
			currentThread.principal_version = currentThread.Internal._serialized_principal_version;
			return currentThread.principal;
		}
		set
		{
			Thread currentThread = CurrentThread;
			currentThread.GetMutableExecutionContext().LogicalCallContext.Principal = value;
			if (value != GetDomain().DefaultPrincipal)
			{
				currentThread.Internal._serialized_principal_version++;
				try
				{
					SerializePrincipal(currentThread, value);
				}
				catch (Exception)
				{
					currentThread.Internal._serialized_principal = null;
				}
				currentThread.principal_version = currentThread.Internal._serialized_principal_version;
			}
			else
			{
				currentThread.Internal._serialized_principal = null;
			}
			currentThread.principal = value;
		}
	}

	public static Thread CurrentThread
	{
		[ReliabilityContract(Consistency.WillNotCorruptState, Cer.MayFail)]
		get
		{
			Thread thread = current_thread;
			if (thread != null)
			{
				return thread;
			}
			return GetCurrentThread();
		}
	}

	internal static int CurrentThreadId => (int)CurrentThread.internal_thread.thread_id;

	[Obsolete("Deprecated in favor of GetApartmentState, SetApartmentState and TrySetApartmentState.")]
	public ApartmentState ApartmentState
	{
		get
		{
			ValidateThreadState();
			return (ApartmentState)Internal.apartment_state;
		}
		set
		{
			ValidateThreadState();
			TrySetApartmentState(value);
		}
	}

	public bool IsThreadPoolThread => IsThreadPoolThreadInternal;

	internal bool IsThreadPoolThreadInternal
	{
		get
		{
			return Internal.threadpool_thread;
		}
		set
		{
			Internal.threadpool_thread = value;
		}
	}

	public bool IsAlive
	{
		get
		{
			ThreadState state = GetState(Internal);
			if ((state & ThreadState.Aborted) != ThreadState.Running || (state & ThreadState.Stopped) != ThreadState.Running || (state & ThreadState.Unstarted) != ThreadState.Running)
			{
				return false;
			}
			return true;
		}
	}

	public bool IsBackground
	{
		get
		{
			return (ValidateThreadState() & ThreadState.Background) != 0;
		}
		set
		{
			ValidateThreadState();
			if (value)
			{
				SetState(Internal, ThreadState.Background);
			}
			else
			{
				ClrState(Internal, ThreadState.Background);
			}
		}
	}

	public string Name
	{
		get
		{
			return GetName_internal(Internal);
		}
		set
		{
			SetName_internal(Internal, value);
		}
	}

	public ThreadState ThreadState => GetState(Internal);

	internal object AbortReason => GetAbortExceptionState();

	public int ManagedThreadId
	{
		[ReliabilityContract(Consistency.WillNotCorruptState, Cer.Success)]
		get
		{
			return Internal.managed_id;
		}
	}

	private static void AsyncLocalSetCurrentCulture(AsyncLocalValueChangedArgs<CultureInfo> args)
	{
		m_CurrentCulture = args.CurrentValue;
	}

	private static void AsyncLocalSetCurrentUICulture(AsyncLocalValueChangedArgs<CultureInfo> args)
	{
		m_CurrentUICulture = args.CurrentValue;
	}

	public Thread(ThreadStart start)
	{
		if (start == null)
		{
			throw new ArgumentNullException("start");
		}
		SetStartHelper(start, 0);
	}

	public Thread(ThreadStart start, int maxStackSize)
	{
		if (start == null)
		{
			throw new ArgumentNullException("start");
		}
		if (0 > maxStackSize)
		{
			throw new ArgumentOutOfRangeException("maxStackSize", Environment.GetResourceString("Non-negative number required."));
		}
		SetStartHelper(start, maxStackSize);
	}

	public Thread(ParameterizedThreadStart start)
	{
		if (start == null)
		{
			throw new ArgumentNullException("start");
		}
		SetStartHelper(start, 0);
	}

	public Thread(ParameterizedThreadStart start, int maxStackSize)
	{
		if (start == null)
		{
			throw new ArgumentNullException("start");
		}
		if (0 > maxStackSize)
		{
			throw new ArgumentOutOfRangeException("maxStackSize", Environment.GetResourceString("Non-negative number required."));
		}
		SetStartHelper(start, maxStackSize);
	}

	[MethodImpl((MethodImplOptions)8)]
	public void Start()
	{
		StackCrawlMark stackMark = StackCrawlMark.LookForMyCaller;
		Start(ref stackMark);
	}

	[MethodImpl((MethodImplOptions)8)]
	public void Start(object parameter)
	{
		if (m_Delegate is ThreadStart)
		{
			throw new InvalidOperationException(Environment.GetResourceString("The thread was created with a ThreadStart delegate that does not accept a parameter."));
		}
		m_ThreadStartArg = parameter;
		StackCrawlMark stackMark = StackCrawlMark.LookForMyCaller;
		Start(ref stackMark);
	}

	private void Start(ref StackCrawlMark stackMark)
	{
		if ((object)m_Delegate != null)
		{
			ThreadHelper obj = (ThreadHelper)m_Delegate.Target;
			ExecutionContext executionContextHelper = ExecutionContext.Capture(ref stackMark, ExecutionContext.CaptureOptions.IgnoreSyncCtx);
			obj.SetExecutionContextHelper(executionContextHelper);
		}
		object obj2 = null;
		StartInternal(obj2, ref stackMark);
	}

	[ReliabilityContract(Consistency.WillNotCorruptState, Cer.Success)]
	internal ExecutionContext.Reader GetExecutionContextReader()
	{
		return new ExecutionContext.Reader(m_ExecutionContext);
	}

	[ReliabilityContract(Consistency.WillNotCorruptState, Cer.MayFail)]
	internal ExecutionContext GetMutableExecutionContext()
	{
		if (m_ExecutionContext == null)
		{
			m_ExecutionContext = new ExecutionContext();
		}
		else if (!ExecutionContextBelongsToCurrentScope)
		{
			ExecutionContext executionContext = m_ExecutionContext.CreateMutableCopy();
			m_ExecutionContext = executionContext;
		}
		ExecutionContextBelongsToCurrentScope = true;
		return m_ExecutionContext;
	}

	[ReliabilityContract(Consistency.WillNotCorruptState, Cer.Success)]
	internal void SetExecutionContext(ExecutionContext value, bool belongsToCurrentScope)
	{
		m_ExecutionContext = value;
		ExecutionContextBelongsToCurrentScope = belongsToCurrentScope;
	}

	[ReliabilityContract(Consistency.WillNotCorruptState, Cer.Success)]
	internal void SetExecutionContext(ExecutionContext.Reader value, bool belongsToCurrentScope)
	{
		m_ExecutionContext = value.DangerousGetRawExecutionContext();
		ExecutionContextBelongsToCurrentScope = belongsToCurrentScope;
	}

	[Obsolete("Thread.SetCompressedStack is no longer supported. Please use the System.Threading.CompressedStack class")]
	public void SetCompressedStack(CompressedStack stack)
	{
		throw new InvalidOperationException(Environment.GetResourceString("Use CompressedStack.(Capture/Run) or ExecutionContext.(Capture/Run) APIs instead."));
	}

	[Obsolete("Thread.GetCompressedStack is no longer supported. Please use the System.Threading.CompressedStack class")]
	public CompressedStack GetCompressedStack()
	{
		throw new InvalidOperationException(Environment.GetResourceString("Use CompressedStack.(Capture/Run) or ExecutionContext.(Capture/Run) APIs instead."));
	}

	public static void ResetAbort()
	{
		Thread currentThread = CurrentThread;
		if ((currentThread.ThreadState & ThreadState.AbortRequested) == 0)
		{
			throw new ThreadStateException(Environment.GetResourceString("Unable to reset abort because no abort was requested."));
		}
		currentThread.ResetAbortNative();
		currentThread.ClearAbortReason();
	}

	[MethodImpl((MethodImplOptions)4096)]
	private extern void ResetAbortNative();

	[Obsolete("Thread.Suspend has been deprecated.  Please use other classes in System.Threading, such as Monitor, Mutex, Event, and Semaphore, to synchronize Threads or protect resources.  http://go.microsoft.com/fwlink/?linkid=14202", false)]
	public void Suspend()
	{
		SuspendInternal();
	}

	[MethodImpl((MethodImplOptions)4096)]
	private extern void SuspendInternal();

	[Obsolete("Thread.Resume has been deprecated.  Please use other classes in System.Threading, such as Monitor, Mutex, Event, and Semaphore, to synchronize Threads or protect resources.  http://go.microsoft.com/fwlink/?linkid=14202", false)]
	public void Resume()
	{
		ResumeInternal();
	}

	[MethodImpl((MethodImplOptions)4096)]
	private extern void ResumeInternal();

	public void Interrupt()
	{
		InterruptInternal();
	}

	[MethodImpl((MethodImplOptions)4096)]
	private extern void InterruptInternal();

	[MethodImpl((MethodImplOptions)4096)]
	private extern int GetPriorityNative();

	[MethodImpl((MethodImplOptions)4096)]
	private extern void SetPriorityNative(int priority);

	[MethodImpl((MethodImplOptions)4096)]
	private extern bool JoinInternal(int millisecondsTimeout);

	public void Join()
	{
		JoinInternal(-1);
	}

	public bool Join(int millisecondsTimeout)
	{
		if (millisecondsTimeout < -1)
		{
			throw new ArgumentOutOfRangeException("millisecondsTimeout", Environment.GetResourceString("Number must be either non-negative and less than or equal to Int32.MaxValue or -1."));
		}
		return JoinInternal(millisecondsTimeout);
	}

	public bool Join(TimeSpan timeout)
	{
		long num = (long)timeout.TotalMilliseconds;
		if (num < -1 || num > int.MaxValue)
		{
			throw new ArgumentOutOfRangeException("timeout", Environment.GetResourceString("Number must be either non-negative and less than or equal to Int32.MaxValue or -1."));
		}
		return Join((int)num);
	}

	[MethodImpl((MethodImplOptions)4096)]
	private static extern void SleepInternal(int millisecondsTimeout);

	public static void Sleep(int millisecondsTimeout)
	{
		if (millisecondsTimeout < -1)
		{
			throw new ArgumentOutOfRangeException("millisecondsTimeout", Environment.GetResourceString("Number must be either non-negative and less than or equal to Int32.MaxValue or -1."));
		}
		SleepInternal(millisecondsTimeout);
	}

	public static void Sleep(TimeSpan timeout)
	{
		long num = (long)timeout.TotalMilliseconds;
		if (num < -1 || num > int.MaxValue)
		{
			throw new ArgumentOutOfRangeException("timeout", Environment.GetResourceString("Number must be either non-negative and less than or equal to Int32.MaxValue or -1."));
		}
		Sleep((int)num);
	}

	[MethodImpl((MethodImplOptions)4096)]
	private static extern bool YieldInternal();

	public static bool Yield()
	{
		return YieldInternal();
	}

	private void SetStartHelper(Delegate start, int maxStackSize)
	{
		maxStackSize = GetProcessDefaultStackSize(maxStackSize);
		ThreadHelper threadHelper = new ThreadHelper(start);
		if (start is ThreadStart)
		{
			SetStart(new ThreadStart(threadHelper.ThreadStart), maxStackSize);
		}
		else
		{
			SetStart(new ParameterizedThreadStart(threadHelper.ThreadStart), maxStackSize);
		}
	}

	public static LocalDataStoreSlot AllocateDataSlot()
	{
		return LocalDataStoreManager.AllocateDataSlot();
	}

	public static LocalDataStoreSlot AllocateNamedDataSlot(string name)
	{
		return LocalDataStoreManager.AllocateNamedDataSlot(name);
	}

	public static LocalDataStoreSlot GetNamedDataSlot(string name)
	{
		return LocalDataStoreManager.GetNamedDataSlot(name);
	}

	public static void FreeNamedDataSlot(string name)
	{
		LocalDataStoreManager.FreeNamedDataSlot(name);
	}

	public static object GetData(LocalDataStoreSlot slot)
	{
		LocalDataStoreHolder localDataStoreHolder = s_LocalDataStore;
		if (localDataStoreHolder == null)
		{
			LocalDataStoreManager.ValidateSlot(slot);
			return null;
		}
		return localDataStoreHolder.Store.GetData(slot);
	}

	public static void SetData(LocalDataStoreSlot slot, object data)
	{
		LocalDataStoreHolder localDataStoreHolder = s_LocalDataStore;
		if (localDataStoreHolder == null)
		{
			localDataStoreHolder = (s_LocalDataStore = LocalDataStoreManager.CreateLocalDataStore());
		}
		localDataStoreHolder.Store.SetData(slot, data);
	}

	internal CultureInfo GetCurrentUICultureNoAppX()
	{
		if (m_CurrentUICulture == null)
		{
			CultureInfo defaultThreadCurrentUICulture = CultureInfo.DefaultThreadCurrentUICulture;
			if (defaultThreadCurrentUICulture == null)
			{
				return CultureInfo.UserDefaultUICulture;
			}
			return defaultThreadCurrentUICulture;
		}
		return m_CurrentUICulture;
	}

	private CultureInfo GetCurrentCultureNoAppX()
	{
		if (m_CurrentCulture == null)
		{
			CultureInfo defaultThreadCurrentCulture = CultureInfo.DefaultThreadCurrentCulture;
			if (defaultThreadCurrentCulture == null)
			{
				return CultureInfo.UserDefaultCulture;
			}
			return defaultThreadCurrentCulture;
		}
		return m_CurrentCulture;
	}

	private static void nativeInitCultureAccessors()
	{
		m_CurrentCulture = CultureInfo.ConstructCurrentCulture();
		m_CurrentUICulture = CultureInfo.ConstructCurrentUICulture();
	}

	[MethodImpl((MethodImplOptions)4096)]
	public static extern void MemoryBarrier();

	[MethodImpl((MethodImplOptions)4096)]
	private extern void ConstructInternalThread();

	[MethodImpl((MethodImplOptions)4096)]
	private static extern byte[] ByteArrayToRootDomain(byte[] arr);

	[MethodImpl((MethodImplOptions)4096)]
	private static extern byte[] ByteArrayToCurrentDomain(byte[] arr);

	private static void DeserializePrincipal(Thread th)
	{
		MemoryStream memoryStream = new MemoryStream(ByteArrayToCurrentDomain(th.Internal._serialized_principal));
		int num = memoryStream.ReadByte();
		switch (num)
		{
		case 0:
		{
			BinaryFormatter binaryFormatter = new BinaryFormatter();
			th.principal = (IPrincipal)binaryFormatter.Deserialize(memoryStream);
			th.principal_version = th.Internal._serialized_principal_version;
			break;
		}
		case 1:
		{
			BinaryReader binaryReader = new BinaryReader(memoryStream);
			string name = binaryReader.ReadString();
			string type = binaryReader.ReadString();
			int num2 = binaryReader.ReadInt32();
			string[] array = null;
			if (num2 >= 0)
			{
				array = new string[num2];
				for (int i = 0; i < num2; i++)
				{
					array[i] = binaryReader.ReadString();
				}
			}
			th.principal = new GenericPrincipal(new GenericIdentity(name, type), array);
			break;
		}
		case 2:
		case 3:
		{
			string[] roles = ((num == 2) ? null : new string[0]);
			th.principal = new GenericPrincipal(new GenericIdentity("", ""), roles);
			break;
		}
		}
	}

	private static void SerializePrincipal(Thread th, IPrincipal value)
	{
		MemoryStream memoryStream = new MemoryStream();
		bool flag = false;
		if (value.GetType() == typeof(GenericPrincipal))
		{
			GenericPrincipal genericPrincipal = (GenericPrincipal)value;
			if (genericPrincipal.Identity != null && genericPrincipal.Identity.GetType() == typeof(GenericIdentity))
			{
				GenericIdentity genericIdentity = (GenericIdentity)genericPrincipal.Identity;
				if (genericIdentity.Name == "" && genericIdentity.AuthenticationType == "")
				{
					if (genericPrincipal.Roles == null)
					{
						memoryStream.WriteByte(2);
						flag = true;
					}
					else if (genericPrincipal.Roles.Length == 0)
					{
						memoryStream.WriteByte(3);
						flag = true;
					}
				}
				else
				{
					memoryStream.WriteByte(1);
					BinaryWriter binaryWriter = new BinaryWriter(memoryStream);
					binaryWriter.Write(genericPrincipal.Identity.Name);
					binaryWriter.Write(genericPrincipal.Identity.AuthenticationType);
					string[] roles = genericPrincipal.Roles;
					if (roles == null)
					{
						binaryWriter.Write(-1);
					}
					else
					{
						binaryWriter.Write(roles.Length);
						string[] array = roles;
						foreach (string value2 in array)
						{
							binaryWriter.Write(value2);
						}
					}
					binaryWriter.Flush();
					flag = true;
				}
			}
		}
		if (!flag)
		{
			memoryStream.WriteByte(0);
			BinaryFormatter binaryFormatter = new BinaryFormatter();
			try
			{
				binaryFormatter.Serialize(memoryStream, value);
			}
			catch
			{
			}
		}
		th.Internal._serialized_principal = ByteArrayToRootDomain(memoryStream.ToArray());
	}

	public static AppDomain GetDomain()
	{
		return AppDomain.CurrentDomain;
	}

	[MethodImpl((MethodImplOptions)4096)]
	private static extern void GetCurrentThread_icall(ref Thread thread);

	private static Thread GetCurrentThread()
	{
		Thread thread = null;
		GetCurrentThread_icall(ref thread);
		return thread;
	}

	[MethodImpl((MethodImplOptions)4096)]
	public static extern int GetDomainID();

	[MethodImpl((MethodImplOptions)4096)]
	private extern bool Thread_internal(MulticastDelegate start);

	private Thread(InternalThread it)
	{
		internal_thread = it;
	}

	[ReliabilityContract(Consistency.WillNotCorruptState, Cer.Success)]
	~Thread()
	{
	}

	[MethodImpl((MethodImplOptions)4096)]
	private static extern string GetName_internal(InternalThread thread);

	[MethodImpl((MethodImplOptions)4096)]
	private unsafe static extern void SetName_icall(InternalThread thread, char* name, int nameLength);

	private unsafe static void SetName_internal(InternalThread thread, string name)
	{
		fixed (char* name2 = name)
		{
			SetName_icall(thread, name2, name?.Length ?? 0);
		}
	}

	[MethodImpl((MethodImplOptions)4096)]
	private static extern void Abort_internal(InternalThread thread, object stateInfo);

	public void Abort()
	{
		Abort_internal(Internal, null);
	}

	public void Abort(object stateInfo)
	{
		Abort_internal(Internal, stateInfo);
	}

	[MethodImpl((MethodImplOptions)4096)]
	private extern object GetAbortExceptionState();

	private void ClearAbortReason()
	{
	}

	[MethodImpl((MethodImplOptions)4096)]
	private static extern void SpinWait_nop();

	[ReliabilityContract(Consistency.WillNotCorruptState, Cer.Success)]
	public static void SpinWait(int iterations)
	{
		if (iterations >= 0)
		{
			while (iterations-- > 0)
			{
				SpinWait_nop();
			}
		}
	}

	private void StartInternal(object principal, ref StackCrawlMark stackMark)
	{
		if (!Thread_internal(m_Delegate))
		{
			throw new SystemException("Thread creation failed.");
		}
		m_ThreadStartArg = null;
	}

	[MethodImpl((MethodImplOptions)4096)]
	private static extern void SetState(InternalThread thread, ThreadState set);

	[MethodImpl((MethodImplOptions)4096)]
	private static extern void ClrState(InternalThread thread, ThreadState clr);

	[MethodImpl((MethodImplOptions)4096)]
	private static extern ThreadState GetState(InternalThread thread);

	[MethodImpl((MethodImplOptions)4096)]
	public static extern byte VolatileRead(ref byte address);

	[MethodImpl((MethodImplOptions)4096)]
	public static extern double VolatileRead(ref double address);

	[MethodImpl((MethodImplOptions)4096)]
	public static extern short VolatileRead(ref short address);

	[MethodImpl((MethodImplOptions)4096)]
	public static extern int VolatileRead(ref int address);

	[MethodImpl((MethodImplOptions)4096)]
	public static extern long VolatileRead(ref long address);

	[MethodImpl((MethodImplOptions)4096)]
	public static extern IntPtr VolatileRead(ref IntPtr address);

	[MethodImpl((MethodImplOptions)4096)]
	public static extern object VolatileRead(ref object address);

	[MethodImpl((MethodImplOptions)4096)]
	[CLSCompliant(false)]
	public static extern sbyte VolatileRead(ref sbyte address);

	[MethodImpl((MethodImplOptions)4096)]
	public static extern float VolatileRead(ref float address);

	[MethodImpl((MethodImplOptions)4096)]
	[CLSCompliant(false)]
	public static extern ushort VolatileRead(ref ushort address);

	[MethodImpl((MethodImplOptions)4096)]
	[CLSCompliant(false)]
	public static extern uint VolatileRead(ref uint address);

	[MethodImpl((MethodImplOptions)4096)]
	[CLSCompliant(false)]
	public static extern ulong VolatileRead(ref ulong address);

	[MethodImpl((MethodImplOptions)4096)]
	[CLSCompliant(false)]
	public static extern UIntPtr VolatileRead(ref UIntPtr address);

	[MethodImpl((MethodImplOptions)4096)]
	public static extern void VolatileWrite(ref byte address, byte value);

	[MethodImpl((MethodImplOptions)4096)]
	public static extern void VolatileWrite(ref double address, double value);

	[MethodImpl((MethodImplOptions)4096)]
	public static extern void VolatileWrite(ref short address, short value);

	[MethodImpl((MethodImplOptions)4096)]
	public static extern void VolatileWrite(ref int address, int value);

	[MethodImpl((MethodImplOptions)4096)]
	public static extern void VolatileWrite(ref long address, long value);

	[MethodImpl((MethodImplOptions)4096)]
	public static extern void VolatileWrite(ref IntPtr address, IntPtr value);

	[MethodImpl((MethodImplOptions)4096)]
	public static extern void VolatileWrite(ref object address, object value);

	[MethodImpl((MethodImplOptions)4096)]
	[CLSCompliant(false)]
	public static extern void VolatileWrite(ref sbyte address, sbyte value);

	[MethodImpl((MethodImplOptions)4096)]
	public static extern void VolatileWrite(ref float address, float value);

	[MethodImpl((MethodImplOptions)4096)]
	[CLSCompliant(false)]
	public static extern void VolatileWrite(ref ushort address, ushort value);

	[MethodImpl((MethodImplOptions)4096)]
	[CLSCompliant(false)]
	public static extern void VolatileWrite(ref uint address, uint value);

	[MethodImpl((MethodImplOptions)4096)]
	[CLSCompliant(false)]
	public static extern void VolatileWrite(ref ulong address, ulong value);

	[MethodImpl((MethodImplOptions)4096)]
	[CLSCompliant(false)]
	public static extern void VolatileWrite(ref UIntPtr address, UIntPtr value);

	[MethodImpl((MethodImplOptions)4096)]
	private static extern int SystemMaxStackStize();

	private static int GetProcessDefaultStackSize(int maxStackSize)
	{
		if (maxStackSize == 0)
		{
			return 0;
		}
		if (maxStackSize < 131072)
		{
			return 131072;
		}
		int pageSize = Environment.GetPageSize();
		if (maxStackSize % pageSize != 0)
		{
			maxStackSize = maxStackSize / (pageSize - 1) * pageSize;
		}
		return Math.Min(maxStackSize, SystemMaxStackStize());
	}

	private void SetStart(MulticastDelegate start, int maxStackSize)
	{
		m_Delegate = start;
		Internal.stack_size = maxStackSize;
	}

	[ReliabilityContract(Consistency.WillNotCorruptState, Cer.MayFail)]
	public static void BeginCriticalRegion()
	{
		CurrentThread.Internal.critical_region_level++;
	}

	[ReliabilityContract(Consistency.WillNotCorruptState, Cer.Success)]
	public static void EndCriticalRegion()
	{
		CurrentThread.Internal.critical_region_level--;
	}

	[ReliabilityContract(Consistency.WillNotCorruptState, Cer.MayFail)]
	public static void BeginThreadAffinity()
	{
	}

	[ReliabilityContract(Consistency.WillNotCorruptState, Cer.MayFail)]
	public static void EndThreadAffinity()
	{
	}

	public ApartmentState GetApartmentState()
	{
		ValidateThreadState();
		return (ApartmentState)Internal.apartment_state;
	}

	public void SetApartmentState(ApartmentState state)
	{
		if (!TrySetApartmentState(state))
		{
			throw new InvalidOperationException("Failed to set the specified COM apartment state.");
		}
	}

	public bool TrySetApartmentState(ApartmentState state)
	{
		if ((ThreadState & ThreadState.Unstarted) == 0)
		{
			throw new ThreadStateException("Thread was in an invalid state for the operation being executed.");
		}
		if (Internal.apartment_state != 2 && (ApartmentState)Internal.apartment_state != state)
		{
			return false;
		}
		Internal.apartment_state = (byte)state;
		return true;
	}

	[ComVisible(false)]
	public override int GetHashCode()
	{
		return ManagedThreadId;
	}

	[MethodImpl((MethodImplOptions)4096)]
	internal static extern void GetStackTraces(out Thread[] threads, out object[] stack_frames);

	internal static Dictionary<Thread, StackTrace> Mono_GetStackTraces()
	{
		GetStackTraces(out var threads, out var stack_frames);
		Dictionary<Thread, StackTrace> dictionary = new Dictionary<Thread, StackTrace>();
		for (int i = 0; i < threads.Length; i++)
		{
			dictionary[threads[i]] = new StackTrace((StackFrame[])stack_frames[i]);
		}
		return dictionary;
	}

	public void DisableComObjectEagerCleanup()
	{
		throw new PlatformNotSupportedException();
	}

	private ThreadState ValidateThreadState()
	{
		ThreadState state = GetState(Internal);
		if ((state & ThreadState.Stopped) != ThreadState.Running)
		{
			throw new ThreadStateException("Thread is dead; state can not be accessed.");
		}
		return state;
	}

	public static int GetCurrentProcessorId()
	{
		return RuntimeThread.GetCurrentProcessorId();
	}

	void _Thread.GetIDsOfNames([In] ref Guid riid, IntPtr rgszNames, uint cNames, uint lcid, IntPtr rgDispId)
	{
		ThrowStub.ThrowNotSupportedException();
	}

	void _Thread.GetTypeInfo(uint iTInfo, uint lcid, IntPtr ppTInfo)
	{
		ThrowStub.ThrowNotSupportedException();
	}

	void _Thread.GetTypeInfoCount(out uint pcTInfo)
	{
		ThrowStub.ThrowNotSupportedException();
	}

	void _Thread.Invoke(uint dispIdMember, [In] ref Guid riid, uint lcid, short wFlags, IntPtr pDispParams, IntPtr pVarResult, IntPtr pExcepInfo, IntPtr puArgErr)
	{
		ThrowStub.ThrowNotSupportedException();
	}
}
