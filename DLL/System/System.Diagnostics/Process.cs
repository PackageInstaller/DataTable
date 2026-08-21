using System.Collections;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.ComponentModel;
using System.ComponentModel.Design;
using System.Globalization;
using System.IO;
using System.Runtime.CompilerServices;
using System.Runtime.InteropServices;
using System.Security;
using System.Text;
using System.Threading;
using Microsoft.Win32;
using Microsoft.Win32.SafeHandles;

namespace System.Diagnostics;

[MonitoringDescription("Provides access to local and remote processes, enabling starting and stopping of local processes.")]
[DefaultEvent("Exited")]
[DefaultProperty("StartInfo")]
public class Process : Component
{
	private enum StreamReadMode
	{
		undefined,
		syncMode,
		asyncMode
	}

	private enum State
	{
		HaveId = 1,
		IsLocal = 2,
		IsNt = 4,
		HaveProcessInfo = 8,
		Exited = 16,
		Associated = 32,
		IsWin2k = 64,
		HaveNtProcessInfo = 12
	}

	private struct ProcInfo
	{
		public IntPtr process_handle;

		public int pid;

		public string[] envVariables;

		public string UserName;

		public string Domain;

		public IntPtr Password;

		public bool LoadUserProfile;
	}

	private bool haveProcessId;

	private int processId;

	private bool haveProcessHandle;

	private SafeProcessHandle m_processHandle;

	private bool isRemoteMachine;

	private string machineName;

	private int m_processAccess;

	private ProcessThreadCollection threads;

	private ProcessModuleCollection modules;

	private bool haveWorkingSetLimits;

	private IntPtr minWorkingSet;

	private IntPtr maxWorkingSet;

	private bool havePriorityClass;

	private ProcessPriorityClass priorityClass;

	private ProcessStartInfo startInfo;

	private bool watchForExit;

	private bool watchingForExit;

	private EventHandler onExited;

	private bool exited;

	private int exitCode;

	private bool signaled;

	private DateTime exitTime;

	private bool haveExitTime;

	private bool raisedOnExited;

	private RegisteredWaitHandle registeredWaitHandle;

	private WaitHandle waitHandle;

	private ISynchronizeInvoke synchronizingObject;

	private StreamReader standardOutput;

	private StreamWriter standardInput;

	private StreamReader standardError;

	private OperatingSystem operatingSystem;

	private bool disposed;

	private StreamReadMode outputStreamReadMode;

	private StreamReadMode errorStreamReadMode;

	private StreamReadMode inputStreamReadMode;

	internal AsyncStreamReader output;

	internal AsyncStreamReader error;

	internal bool pendingOutputRead;

	internal bool pendingErrorRead;

	internal static TraceSwitch processTracing;

	private string process_name;

	private static ProcessModule current_main_module;

	[DesignerSerializationVisibility(DesignerSerializationVisibility.Hidden)]
	[MonitoringDescription("Indicates if the process component is associated with a real process.")]
	[Browsable(false)]
	private bool Associated
	{
		get
		{
			if (!haveProcessId)
			{
				return haveProcessHandle;
			}
			return true;
		}
	}

	[DesignerSerializationVisibility(DesignerSerializationVisibility.Hidden)]
	[Browsable(false)]
	[MonitoringDescription("The value returned from the associated process when it terminated.")]
	public int ExitCode
	{
		get
		{
			EnsureState(State.Exited);
			if (exitCode == -1 && !RuntimeInformation.IsOSPlatform(OSPlatform.Windows))
			{
				throw new InvalidOperationException("Cannot get the exit code from a non-child process on Unix");
			}
			return exitCode;
		}
	}

	[MonitoringDescription("Indicates if the associated process has been terminated.")]
	[Browsable(false)]
	[DesignerSerializationVisibility(DesignerSerializationVisibility.Hidden)]
	public bool HasExited
	{
		get
		{
			if (!exited)
			{
				EnsureState(State.Associated);
				SafeProcessHandle safeProcessHandle = null;
				try
				{
					safeProcessHandle = GetProcessHandle(1049600, throwIfExited: false);
					int num;
					if (safeProcessHandle.IsInvalid)
					{
						exited = true;
					}
					else if (NativeMethods.GetExitCodeProcess(safeProcessHandle, out num) && num != 259)
					{
						exited = true;
						exitCode = num;
					}
					else
					{
						if (!signaled)
						{
							ProcessWaitHandle processWaitHandle = null;
							try
							{
								processWaitHandle = new ProcessWaitHandle(safeProcessHandle);
								signaled = processWaitHandle.WaitOne(0, exitContext: false);
							}
							finally
							{
								processWaitHandle?.Close();
							}
						}
						if (signaled)
						{
							if (!NativeMethods.GetExitCodeProcess(safeProcessHandle, out num))
							{
								throw new Win32Exception();
							}
							exited = true;
							exitCode = num;
						}
					}
				}
				finally
				{
					ReleaseProcessHandle(safeProcessHandle);
				}
				if (exited)
				{
					RaiseOnExited();
				}
			}
			return exited;
		}
	}

	[DesignerSerializationVisibility(DesignerSerializationVisibility.Hidden)]
	[Browsable(false)]
	[MonitoringDescription("The time that the associated process exited.")]
	public DateTime ExitTime
	{
		get
		{
			if (!haveExitTime)
			{
				EnsureState((State)20);
				exitTime = GetProcessTimes().ExitTime;
				haveExitTime = true;
			}
			return exitTime;
		}
	}

	[MonitoringDescription("Returns the native handle for this process.   The handle is only available if the process was started using this component.")]
	[Browsable(false)]
	[DesignerSerializationVisibility(DesignerSerializationVisibility.Hidden)]
	public IntPtr Handle
	{
		get
		{
			EnsureState(State.Associated);
			return OpenProcessHandle(m_processAccess).DangerousGetHandle();
		}
	}

	[Browsable(false)]
	[DesignerSerializationVisibility(DesignerSerializationVisibility.Hidden)]
	public SafeProcessHandle SafeHandle
	{
		get
		{
			EnsureState(State.Associated);
			return OpenProcessHandle(m_processAccess);
		}
	}

	[DesignerSerializationVisibility(DesignerSerializationVisibility.Hidden)]
	[MonitoringDescription("The unique identifier for the process.")]
	public int Id
	{
		get
		{
			EnsureState(State.HaveId);
			return processId;
		}
	}

	[MonitoringDescription("The name of the machine the running the process.")]
	[DesignerSerializationVisibility(DesignerSerializationVisibility.Hidden)]
	[Browsable(false)]
	public string MachineName
	{
		get
		{
			EnsureState(State.Associated);
			return machineName;
		}
	}

	[DesignerSerializationVisibility(DesignerSerializationVisibility.Hidden)]
	[MonitoringDescription("The maximum amount of physical memory the process has required since it was started.")]
	public IntPtr MaxWorkingSet
	{
		get
		{
			EnsureWorkingSetLimits();
			return maxWorkingSet;
		}
		set
		{
			SetWorkingSetLimits(null, value);
		}
	}

	[MonitoringDescription("The minimum amount of physical memory the process has required since it was started.")]
	[DesignerSerializationVisibility(DesignerSerializationVisibility.Hidden)]
	public IntPtr MinWorkingSet
	{
		get
		{
			EnsureWorkingSetLimits();
			return minWorkingSet;
		}
		set
		{
			SetWorkingSetLimits(value, null);
		}
	}

	private OperatingSystem OperatingSystem
	{
		get
		{
			if (operatingSystem == null)
			{
				operatingSystem = Environment.OSVersion;
			}
			return operatingSystem;
		}
	}

	[MonitoringDescription("The priority that the threads in the process run relative to.")]
	[DesignerSerializationVisibility(DesignerSerializationVisibility.Hidden)]
	public ProcessPriorityClass PriorityClass
	{
		get
		{
			if (!havePriorityClass)
			{
				SafeProcessHandle handle = null;
				try
				{
					handle = GetProcessHandle(1024);
					int num = NativeMethods.GetPriorityClass(handle);
					if (num == 0)
					{
						throw new Win32Exception();
					}
					priorityClass = (ProcessPriorityClass)num;
					havePriorityClass = true;
				}
				finally
				{
					ReleaseProcessHandle(handle);
				}
			}
			return priorityClass;
		}
		set
		{
			if (!Enum.IsDefined(typeof(ProcessPriorityClass), value))
			{
				throw new InvalidEnumArgumentException("value", (int)value, typeof(ProcessPriorityClass));
			}
			SafeProcessHandle handle = null;
			try
			{
				handle = GetProcessHandle(512);
				if (!NativeMethods.SetPriorityClass(handle, (int)value))
				{
					throw new Win32Exception();
				}
				priorityClass = value;
				havePriorityClass = true;
			}
			finally
			{
				ReleaseProcessHandle(handle);
			}
		}
	}

	[MonitoringDescription("The amount of CPU time the process spent inside the operating system core.")]
	[DesignerSerializationVisibility(DesignerSerializationVisibility.Hidden)]
	public TimeSpan PrivilegedProcessorTime
	{
		get
		{
			EnsureState(State.IsNt);
			return GetProcessTimes().PrivilegedProcessorTime;
		}
	}

	[DesignerSerializationVisibility(DesignerSerializationVisibility.Content)]
	[MonitoringDescription("Specifies information used to start a process.")]
	[Browsable(false)]
	public ProcessStartInfo StartInfo
	{
		get
		{
			if (startInfo == null)
			{
				startInfo = new ProcessStartInfo(this);
			}
			return startInfo;
		}
		set
		{
			if (value == null)
			{
				throw new ArgumentNullException("value");
			}
			startInfo = value;
		}
	}

	[MonitoringDescription("The time at which the process was started.")]
	[DesignerSerializationVisibility(DesignerSerializationVisibility.Hidden)]
	public DateTime StartTime
	{
		get
		{
			EnsureState(State.IsNt);
			return GetProcessTimes().StartTime;
		}
	}

	[MonitoringDescription("The object used to marshal the event handler calls issued as a result of a Process exit.")]
	[DefaultValue(null)]
	[Browsable(false)]
	public ISynchronizeInvoke SynchronizingObject
	{
		get
		{
			if (synchronizingObject == null && base.DesignMode)
			{
				IDesignerHost designerHost = (IDesignerHost)GetService(typeof(IDesignerHost));
				if (designerHost != null)
				{
					object rootComponent = designerHost.RootComponent;
					if (rootComponent != null && rootComponent is ISynchronizeInvoke)
					{
						synchronizingObject = (ISynchronizeInvoke)rootComponent;
					}
				}
			}
			return synchronizingObject;
		}
		set
		{
			synchronizingObject = value;
		}
	}

	[DesignerSerializationVisibility(DesignerSerializationVisibility.Hidden)]
	[MonitoringDescription("The amount of CPU time the process has used.")]
	public TimeSpan TotalProcessorTime
	{
		get
		{
			EnsureState(State.IsNt);
			return GetProcessTimes().TotalProcessorTime;
		}
	}

	[MonitoringDescription("The amount of CPU time the process spent outside the operating system core.")]
	[DesignerSerializationVisibility(DesignerSerializationVisibility.Hidden)]
	public TimeSpan UserProcessorTime
	{
		get
		{
			EnsureState(State.IsNt);
			return GetProcessTimes().UserProcessorTime;
		}
	}

	[DefaultValue(false)]
	[MonitoringDescription("Whether the process component should watch for the associated process to exit, and raise the Exited event.")]
	[Browsable(false)]
	public bool EnableRaisingEvents
	{
		get
		{
			return watchForExit;
		}
		set
		{
			if (value == watchForExit)
			{
				return;
			}
			if (Associated)
			{
				if (value)
				{
					OpenProcessHandle();
					EnsureWatchingForExit();
				}
				else
				{
					StopWatchingForExit();
				}
			}
			watchForExit = value;
		}
	}

	[Browsable(false)]
	[DesignerSerializationVisibility(DesignerSerializationVisibility.Hidden)]
	[MonitoringDescription("Standard input stream of the process.")]
	public StreamWriter StandardInput
	{
		get
		{
			if (standardInput == null)
			{
				throw new InvalidOperationException(global::SR.GetString("StandardIn has not been redirected."));
			}
			inputStreamReadMode = StreamReadMode.syncMode;
			return standardInput;
		}
	}

	[Browsable(false)]
	[MonitoringDescription("Standard output stream of the process.")]
	[DesignerSerializationVisibility(DesignerSerializationVisibility.Hidden)]
	public StreamReader StandardOutput
	{
		get
		{
			if (standardOutput == null)
			{
				throw new InvalidOperationException(global::SR.GetString("StandardOut has not been redirected or the process hasn't started yet."));
			}
			if (outputStreamReadMode == StreamReadMode.undefined)
			{
				outputStreamReadMode = StreamReadMode.syncMode;
			}
			else if (outputStreamReadMode != StreamReadMode.syncMode)
			{
				throw new InvalidOperationException(global::SR.GetString("Cannot mix synchronous and asynchronous operation on process stream."));
			}
			return standardOutput;
		}
	}

	[MonitoringDescription("Standard error stream of the process.")]
	[Browsable(false)]
	[DesignerSerializationVisibility(DesignerSerializationVisibility.Hidden)]
	public StreamReader StandardError
	{
		get
		{
			if (standardError == null)
			{
				throw new InvalidOperationException(global::SR.GetString("StandardError has not been redirected."));
			}
			if (errorStreamReadMode == StreamReadMode.undefined)
			{
				errorStreamReadMode = StreamReadMode.syncMode;
			}
			else if (errorStreamReadMode != StreamReadMode.syncMode)
			{
				throw new InvalidOperationException(global::SR.GetString("Cannot mix synchronous and asynchronous operation on process stream."));
			}
			return standardError;
		}
	}

	[DesignerSerializationVisibility(DesignerSerializationVisibility.Hidden)]
	[MonoTODO]
	[MonitoringDescription("Base process priority.")]
	public int BasePriority => 0;

	[DesignerSerializationVisibility(DesignerSerializationVisibility.Hidden)]
	[MonoTODO]
	[MonitoringDescription("Handles for this process.")]
	public int HandleCount => 0;

	[MonitoringDescription("The main module of the process.")]
	[Browsable(false)]
	[DesignerSerializationVisibility(DesignerSerializationVisibility.Hidden)]
	public ProcessModule MainModule
	{
		get
		{
			if (processId == NativeMethods.GetCurrentProcessId())
			{
				if (current_main_module == null)
				{
					current_main_module = Modules[0];
				}
				return current_main_module;
			}
			return Modules[0];
		}
	}

	[DesignerSerializationVisibility(DesignerSerializationVisibility.Hidden)]
	[MonitoringDescription("The handle of the main window of the process.")]
	public IntPtr MainWindowHandle => MainWindowHandle_icall(processId);

	[MonitoringDescription("The title of the main window of the process.")]
	[DesignerSerializationVisibility(DesignerSerializationVisibility.Hidden)]
	[MonoTODO]
	public string MainWindowTitle => "null";

	[DesignerSerializationVisibility(DesignerSerializationVisibility.Hidden)]
	[MonitoringDescription("The modules that are loaded as part of this process.")]
	[Browsable(false)]
	public ProcessModuleCollection Modules
	{
		get
		{
			if (modules == null)
			{
				SafeProcessHandle handle = null;
				try
				{
					handle = GetProcessHandle(1024);
					modules = new ProcessModuleCollection(GetModules_internal(handle));
				}
				finally
				{
					ReleaseProcessHandle(handle);
				}
			}
			return modules;
		}
	}

	[MonitoringDescription("The number of bytes that are not pageable.")]
	[Obsolete("Use NonpagedSystemMemorySize64")]
	[MonoTODO]
	[DesignerSerializationVisibility(DesignerSerializationVisibility.Hidden)]
	public int NonpagedSystemMemorySize => 0;

	[Obsolete("Use PagedMemorySize64")]
	[DesignerSerializationVisibility(DesignerSerializationVisibility.Hidden)]
	[MonitoringDescription("The number of bytes that are paged.")]
	public int PagedMemorySize => (int)PagedMemorySize64;

	[Obsolete("Use PagedSystemMemorySize64")]
	[DesignerSerializationVisibility(DesignerSerializationVisibility.Hidden)]
	[MonitoringDescription("The amount of paged system memory in bytes.")]
	public int PagedSystemMemorySize => (int)PagedMemorySize64;

	[MonitoringDescription("The maximum amount of paged memory used by this process.")]
	[MonoTODO]
	[Obsolete("Use PeakPagedMemorySize64")]
	[DesignerSerializationVisibility(DesignerSerializationVisibility.Hidden)]
	public int PeakPagedMemorySize => 0;

	[MonitoringDescription("The maximum amount of virtual memory used by this process.")]
	[DesignerSerializationVisibility(DesignerSerializationVisibility.Hidden)]
	[Obsolete("Use PeakVirtualMemorySize64")]
	public int PeakVirtualMemorySize
	{
		get
		{
			int num;
			return (int)GetProcessData(processId, 8, out num);
		}
	}

	[Obsolete("Use PeakWorkingSet64")]
	[MonitoringDescription("The maximum amount of system memory used by this process.")]
	[DesignerSerializationVisibility(DesignerSerializationVisibility.Hidden)]
	public int PeakWorkingSet
	{
		get
		{
			int num;
			return (int)GetProcessData(processId, 5, out num);
		}
	}

	[ComVisible(false)]
	[MonitoringDescription("The number of bytes that are not pageable.")]
	[DesignerSerializationVisibility(DesignerSerializationVisibility.Hidden)]
	[MonoTODO]
	public long NonpagedSystemMemorySize64 => 0L;

	[DesignerSerializationVisibility(DesignerSerializationVisibility.Hidden)]
	[MonitoringDescription("The number of bytes that are paged.")]
	[ComVisible(false)]
	public long PagedMemorySize64
	{
		get
		{
			int num;
			return GetProcessData(processId, 12, out num);
		}
	}

	[ComVisible(false)]
	[DesignerSerializationVisibility(DesignerSerializationVisibility.Hidden)]
	[MonitoringDescription("The amount of paged system memory in bytes.")]
	public long PagedSystemMemorySize64 => PagedMemorySize64;

	[MonoTODO]
	[DesignerSerializationVisibility(DesignerSerializationVisibility.Hidden)]
	[MonitoringDescription("The maximum amount of paged memory used by this process.")]
	[ComVisible(false)]
	public long PeakPagedMemorySize64 => 0L;

	[ComVisible(false)]
	[MonitoringDescription("The maximum amount of virtual memory used by this process.")]
	[DesignerSerializationVisibility(DesignerSerializationVisibility.Hidden)]
	public long PeakVirtualMemorySize64
	{
		get
		{
			int num;
			return GetProcessData(processId, 8, out num);
		}
	}

	[ComVisible(false)]
	[DesignerSerializationVisibility(DesignerSerializationVisibility.Hidden)]
	[MonitoringDescription("The maximum amount of system memory used by this process.")]
	public long PeakWorkingSet64
	{
		get
		{
			int num;
			return GetProcessData(processId, 5, out num);
		}
	}

	[DesignerSerializationVisibility(DesignerSerializationVisibility.Hidden)]
	[MonitoringDescription("Process will be of higher priority while it is actively used.")]
	[MonoTODO]
	public bool PriorityBoostEnabled
	{
		get
		{
			return false;
		}
		set
		{
		}
	}

	[DesignerSerializationVisibility(DesignerSerializationVisibility.Hidden)]
	[MonitoringDescription("The amount of memory exclusively used by this process.")]
	[Obsolete("Use PrivateMemorySize64")]
	public int PrivateMemorySize
	{
		get
		{
			int num;
			return (int)GetProcessData(processId, 6, out num);
		}
	}

	[MonitoringDescription("The session ID for this process.")]
	[DesignerSerializationVisibility(DesignerSerializationVisibility.Hidden)]
	[MonoNotSupported("")]
	public int SessionId => 0;

	[MonitoringDescription("The name of this process.")]
	[DesignerSerializationVisibility(DesignerSerializationVisibility.Hidden)]
	public string ProcessName
	{
		get
		{
			if (process_name == null)
			{
				SafeProcessHandle handle = null;
				try
				{
					handle = GetProcessHandle(1024);
					process_name = ProcessName_internal(handle);
					if (process_name == null)
					{
						throw new InvalidOperationException("Process has exited or is inaccessible, so the requested information is not available.");
					}
					if (process_name.EndsWith(".exe") || process_name.EndsWith(".bat") || process_name.EndsWith(".com"))
					{
						process_name = process_name.Substring(0, process_name.Length - 4);
					}
				}
				finally
				{
					ReleaseProcessHandle(handle);
				}
			}
			return process_name;
		}
	}

	[MonoTODO]
	[DesignerSerializationVisibility(DesignerSerializationVisibility.Hidden)]
	[MonitoringDescription("Allowed processor that can be used by this process.")]
	public IntPtr ProcessorAffinity
	{
		get
		{
			return (IntPtr)0;
		}
		set
		{
		}
	}

	[MonitoringDescription("Is this process responsive.")]
	[MonoTODO]
	[DesignerSerializationVisibility(DesignerSerializationVisibility.Hidden)]
	public bool Responding => false;

	[MonoTODO]
	[DesignerSerializationVisibility(DesignerSerializationVisibility.Hidden)]
	[MonitoringDescription("The number of threads of this process.")]
	public ProcessThreadCollection Threads
	{
		get
		{
			if (threads == null)
			{
				threads = new ProcessThreadCollection(new ProcessThread[GetProcessData(processId, 0, out var _)]);
			}
			return threads;
		}
	}

	[MonitoringDescription("The amount of virtual memory currently used for this process.")]
	[Obsolete("Use VirtualMemorySize64")]
	[DesignerSerializationVisibility(DesignerSerializationVisibility.Hidden)]
	public int VirtualMemorySize
	{
		get
		{
			int num;
			return (int)GetProcessData(processId, 7, out num);
		}
	}

	[Obsolete("Use WorkingSet64")]
	[DesignerSerializationVisibility(DesignerSerializationVisibility.Hidden)]
	[MonitoringDescription("The amount of physical memory currently used for this process.")]
	public int WorkingSet
	{
		get
		{
			int num;
			return (int)GetProcessData(processId, 4, out num);
		}
	}

	[MonitoringDescription("The amount of memory exclusively used by this process.")]
	[ComVisible(false)]
	[DesignerSerializationVisibility(DesignerSerializationVisibility.Hidden)]
	public long PrivateMemorySize64
	{
		get
		{
			int num;
			return GetProcessData(processId, 6, out num);
		}
	}

	[DesignerSerializationVisibility(DesignerSerializationVisibility.Hidden)]
	[ComVisible(false)]
	[MonitoringDescription("The amount of virtual memory currently used for this process.")]
	public long VirtualMemorySize64
	{
		get
		{
			int num;
			return GetProcessData(processId, 7, out num);
		}
	}

	[ComVisible(false)]
	[MonitoringDescription("The amount of physical memory currently used for this process.")]
	[DesignerSerializationVisibility(DesignerSerializationVisibility.Hidden)]
	public long WorkingSet64
	{
		get
		{
			int num;
			return GetProcessData(processId, 4, out num);
		}
	}

	private static bool IsWindows
	{
		get
		{
			PlatformID platform = Environment.OSVersion.Platform;
			if (platform == PlatformID.Win32S || platform == PlatformID.Win32Windows || platform == PlatformID.Win32NT || platform == PlatformID.WinCE)
			{
				return true;
			}
			return false;
		}
	}

	[MonitoringDescription("Indicates if the process component is associated with a real process.")]
	[Browsable(true)]
	public event DataReceivedEventHandler OutputDataReceived;

	[Browsable(true)]
	[MonitoringDescription("Indicates if the process component is associated with a real process.")]
	public event DataReceivedEventHandler ErrorDataReceived;

	[Category("Behavior")]
	[MonitoringDescription("If the WatchForExit property is set to true, then this event is raised when the associated process exits.")]
	public event EventHandler Exited
	{
		add
		{
			onExited = (EventHandler)Delegate.Combine(onExited, value);
		}
		remove
		{
			onExited = (EventHandler)Delegate.Remove(onExited, value);
		}
	}

	public Process()
	{
		machineName = ".";
		outputStreamReadMode = StreamReadMode.undefined;
		errorStreamReadMode = StreamReadMode.undefined;
		m_processAccess = 2035711;
	}

	private Process(string machineName, bool isRemoteMachine, int processId, ProcessInfo processInfo)
	{
		this.machineName = machineName;
		this.isRemoteMachine = isRemoteMachine;
		this.processId = processId;
		haveProcessId = true;
		outputStreamReadMode = StreamReadMode.undefined;
		errorStreamReadMode = StreamReadMode.undefined;
		m_processAccess = 2035711;
	}

	private ProcessThreadTimes GetProcessTimes()
	{
		ProcessThreadTimes processThreadTimes = new ProcessThreadTimes();
		SafeProcessHandle safeProcessHandle = null;
		try
		{
			int access = 1024;
			if (EnvironmentHelpers.IsWindowsVistaOrAbove())
			{
				access = 4096;
			}
			safeProcessHandle = GetProcessHandle(access, throwIfExited: false);
			if (safeProcessHandle.IsInvalid)
			{
				throw new InvalidOperationException(global::SR.GetString("Cannot process request because the process ({0}) has exited.", processId.ToString(CultureInfo.CurrentCulture)));
			}
			if (!NativeMethods.GetProcessTimes(safeProcessHandle, out processThreadTimes.create, out processThreadTimes.exit, out processThreadTimes.kernel, out processThreadTimes.user))
			{
				throw new Win32Exception();
			}
			return processThreadTimes;
		}
		finally
		{
			ReleaseProcessHandle(safeProcessHandle);
		}
	}

	private void ReleaseProcessHandle(SafeProcessHandle handle)
	{
		if (handle != null && (!haveProcessHandle || handle != m_processHandle))
		{
			handle.Close();
		}
	}

	private void CompletionCallback(object context, bool wasSignaled)
	{
		StopWatchingForExit();
		RaiseOnExited();
	}

	protected override void Dispose(bool disposing)
	{
		if (!disposed)
		{
			if (disposing)
			{
				Close();
			}
			disposed = true;
			base.Dispose(disposing);
		}
	}

	public void Close()
	{
		if (Associated)
		{
			if (haveProcessHandle)
			{
				StopWatchingForExit();
				m_processHandle.Close();
				m_processHandle = null;
				haveProcessHandle = false;
			}
			haveProcessId = false;
			isRemoteMachine = false;
			machineName = ".";
			raisedOnExited = false;
			StreamWriter streamWriter = standardInput;
			standardInput = null;
			if (inputStreamReadMode == StreamReadMode.undefined)
			{
				streamWriter?.Close();
			}
			StreamReader streamReader = standardOutput;
			standardOutput = null;
			if (outputStreamReadMode == StreamReadMode.undefined)
			{
				streamReader?.Close();
			}
			streamReader = standardError;
			standardError = null;
			if (errorStreamReadMode == StreamReadMode.undefined)
			{
				streamReader?.Close();
			}
			AsyncStreamReader asyncStreamReader = output;
			output = null;
			if (outputStreamReadMode == StreamReadMode.asyncMode && asyncStreamReader != null)
			{
				asyncStreamReader.CancelOperation();
				asyncStreamReader.Close();
			}
			asyncStreamReader = error;
			error = null;
			if (errorStreamReadMode == StreamReadMode.asyncMode && asyncStreamReader != null)
			{
				asyncStreamReader.CancelOperation();
				asyncStreamReader.Close();
			}
			Refresh();
		}
	}

	private void EnsureState(State state)
	{
		if ((state & State.Associated) != 0 && !Associated)
		{
			throw new InvalidOperationException(global::SR.GetString("No process is associated with this object."));
		}
		if ((state & State.HaveId) != 0 && !haveProcessId)
		{
			EnsureState(State.Associated);
			throw new InvalidOperationException(global::SR.GetString("Feature requires a process identifier."));
		}
		if ((state & State.IsLocal) != 0 && isRemoteMachine)
		{
			throw new NotSupportedException(global::SR.GetString("Feature is not supported for remote machines."));
		}
		if ((state & State.HaveProcessInfo) != 0)
		{
			throw new InvalidOperationException(global::SR.GetString("Process has exited, so the requested information is not available."));
		}
		if ((state & State.Exited) != 0)
		{
			if (!HasExited)
			{
				throw new InvalidOperationException(global::SR.GetString("Process must exit before requested information can be determined."));
			}
			if (!haveProcessHandle)
			{
				throw new InvalidOperationException(global::SR.GetString("Process was not started by this object, so requested information cannot be determined."));
			}
		}
	}

	private void EnsureWatchingForExit()
	{
		if (watchingForExit)
		{
			return;
		}
		lock (this)
		{
			if (!watchingForExit)
			{
				watchingForExit = true;
				try
				{
					waitHandle = new ProcessWaitHandle(m_processHandle);
					registeredWaitHandle = ThreadPool.RegisterWaitForSingleObject(waitHandle, CompletionCallback, null, -1, executeOnlyOnce: true);
					return;
				}
				catch
				{
					watchingForExit = false;
					throw;
				}
			}
		}
	}

	private void EnsureWorkingSetLimits()
	{
		EnsureState(State.IsNt);
		if (haveWorkingSetLimits)
		{
			return;
		}
		SafeProcessHandle handle = null;
		try
		{
			handle = GetProcessHandle(1024);
			if (!NativeMethods.GetProcessWorkingSetSize(handle, out var min, out var max))
			{
				throw new Win32Exception();
			}
			minWorkingSet = min;
			maxWorkingSet = max;
			haveWorkingSetLimits = true;
		}
		finally
		{
			ReleaseProcessHandle(handle);
		}
	}

	public static void EnterDebugMode()
	{
	}

	public static void LeaveDebugMode()
	{
	}

	public static Process GetProcessById(int processId)
	{
		return GetProcessById(processId, ".");
	}

	public static Process[] GetProcessesByName(string processName)
	{
		return GetProcessesByName(processName, ".");
	}

	public static Process[] GetProcesses()
	{
		return GetProcesses(".");
	}

	public static Process GetCurrentProcess()
	{
		return new Process(".", isRemoteMachine: false, NativeMethods.GetCurrentProcessId(), null);
	}

	protected void OnExited()
	{
		EventHandler eventHandler = onExited;
		if (eventHandler != null)
		{
			if (SynchronizingObject != null && SynchronizingObject.InvokeRequired)
			{
				SynchronizingObject.BeginInvoke(eventHandler, new object[2]
				{
					this,
					EventArgs.Empty
				});
			}
			else
			{
				eventHandler(this, EventArgs.Empty);
			}
		}
	}

	private SafeProcessHandle GetProcessHandle(int access, bool throwIfExited)
	{
		if (haveProcessHandle)
		{
			if (throwIfExited)
			{
				ProcessWaitHandle processWaitHandle = null;
				try
				{
					processWaitHandle = new ProcessWaitHandle(m_processHandle);
					if (processWaitHandle.WaitOne(0, exitContext: false))
					{
						if (haveProcessId)
						{
							throw new InvalidOperationException(global::SR.GetString("Cannot process request because the process ({0}) has exited.", processId.ToString(CultureInfo.CurrentCulture)));
						}
						throw new InvalidOperationException(global::SR.GetString("Cannot process request because the process has exited."));
					}
				}
				finally
				{
					processWaitHandle?.Close();
				}
			}
			return m_processHandle;
		}
		EnsureState((State)3);
		SafeProcessHandle targetHandle = SafeProcessHandle.InvalidHandle;
		IntPtr currentProcess = NativeMethods.GetCurrentProcess();
		if (!NativeMethods.DuplicateHandle(new HandleRef(this, currentProcess), new HandleRef(this, currentProcess), new HandleRef(this, currentProcess), out targetHandle, 0, bInheritHandle: false, 3))
		{
			throw new Win32Exception();
		}
		if (throwIfExited && (access & 0x400) != 0 && NativeMethods.GetExitCodeProcess(targetHandle, out exitCode) && exitCode != 259)
		{
			throw new InvalidOperationException(global::SR.GetString("Cannot process request because the process ({0}) has exited.", processId.ToString(CultureInfo.CurrentCulture)));
		}
		return targetHandle;
	}

	private SafeProcessHandle GetProcessHandle(int access)
	{
		return GetProcessHandle(access, throwIfExited: true);
	}

	private SafeProcessHandle OpenProcessHandle()
	{
		return OpenProcessHandle(2035711);
	}

	private SafeProcessHandle OpenProcessHandle(int access)
	{
		if (!haveProcessHandle)
		{
			if (disposed)
			{
				throw new ObjectDisposedException(GetType().Name);
			}
			SetProcessHandle(GetProcessHandle(access));
		}
		return m_processHandle;
	}

	public void Refresh()
	{
		threads = null;
		modules = null;
		exited = false;
		signaled = false;
		haveWorkingSetLimits = false;
		havePriorityClass = false;
		haveExitTime = false;
	}

	private void SetProcessHandle(SafeProcessHandle processHandle)
	{
		m_processHandle = processHandle;
		haveProcessHandle = true;
		if (watchForExit)
		{
			EnsureWatchingForExit();
		}
	}

	private void SetProcessId(int processId)
	{
		this.processId = processId;
		haveProcessId = true;
	}

	private void SetWorkingSetLimits(object newMin, object newMax)
	{
		EnsureState(State.IsNt);
		SafeProcessHandle handle = null;
		try
		{
			handle = GetProcessHandle(1280);
			if (!NativeMethods.GetProcessWorkingSetSize(handle, out var min, out var max))
			{
				throw new Win32Exception();
			}
			if (newMin != null)
			{
				min = (IntPtr)newMin;
			}
			if (newMax != null)
			{
				max = (IntPtr)newMax;
			}
			if ((long)min > (long)max)
			{
				if (newMin != null)
				{
					throw new ArgumentException(global::SR.GetString("Minimum working set size is invalid. It must be less than or equal to the maximum working set size."));
				}
				throw new ArgumentException(global::SR.GetString("Maximum working set size is invalid. It must be greater than or equal to the minimum working set size."));
			}
			if (!NativeMethods.SetProcessWorkingSetSize(handle, min, max))
			{
				throw new Win32Exception();
			}
			if (!NativeMethods.GetProcessWorkingSetSize(handle, out min, out max))
			{
				throw new Win32Exception();
			}
			minWorkingSet = min;
			maxWorkingSet = max;
			haveWorkingSetLimits = true;
		}
		finally
		{
			ReleaseProcessHandle(handle);
		}
	}

	public bool Start()
	{
		Close();
		ProcessStartInfo processStartInfo = StartInfo;
		if (processStartInfo.FileName.Length == 0)
		{
			throw new InvalidOperationException(global::SR.GetString("Cannot start process because a file name has not been provided."));
		}
		if (processStartInfo.UseShellExecute)
		{
			return StartWithShellExecuteEx(processStartInfo);
		}
		return StartWithCreateProcess(processStartInfo);
	}

	public static Process Start(string fileName, string userName, SecureString password, string domain)
	{
		return Start(new ProcessStartInfo(fileName)
		{
			UserName = userName,
			Password = password,
			Domain = domain,
			UseShellExecute = false
		});
	}

	public static Process Start(string fileName, string arguments, string userName, SecureString password, string domain)
	{
		return Start(new ProcessStartInfo(fileName, arguments)
		{
			UserName = userName,
			Password = password,
			Domain = domain,
			UseShellExecute = false
		});
	}

	public static Process Start(string fileName)
	{
		return Start(new ProcessStartInfo(fileName));
	}

	public static Process Start(string fileName, string arguments)
	{
		return Start(new ProcessStartInfo(fileName, arguments));
	}

	public static Process Start(ProcessStartInfo startInfo)
	{
		Process process = new Process();
		if (startInfo == null)
		{
			throw new ArgumentNullException("startInfo");
		}
		process.StartInfo = startInfo;
		if (process.Start())
		{
			return process;
		}
		return null;
	}

	public void Kill()
	{
		SafeProcessHandle safeProcessHandle = null;
		try
		{
			safeProcessHandle = GetProcessHandle(1);
			if (!NativeMethods.TerminateProcess(safeProcessHandle, -1))
			{
				throw new Win32Exception();
			}
		}
		finally
		{
			ReleaseProcessHandle(safeProcessHandle);
		}
	}

	private void StopWatchingForExit()
	{
		if (!watchingForExit)
		{
			return;
		}
		lock (this)
		{
			if (watchingForExit)
			{
				watchingForExit = false;
				registeredWaitHandle.Unregister(null);
				waitHandle.Close();
				waitHandle = null;
				registeredWaitHandle = null;
			}
		}
	}

	public override string ToString()
	{
		if (Associated)
		{
			string text = string.Empty;
			try
			{
				text = ProcessName;
			}
			catch (PlatformNotSupportedException)
			{
			}
			if (text.Length != 0)
			{
				return string.Format(CultureInfo.CurrentCulture, "{0} ({1})", base.ToString(), text);
			}
			return base.ToString();
		}
		return base.ToString();
	}

	public bool WaitForExit(int milliseconds)
	{
		SafeProcessHandle safeProcessHandle = null;
		ProcessWaitHandle processWaitHandle = null;
		bool flag;
		try
		{
			safeProcessHandle = GetProcessHandle(1048576, throwIfExited: false);
			if (safeProcessHandle.IsInvalid)
			{
				flag = true;
			}
			else
			{
				processWaitHandle = new ProcessWaitHandle(safeProcessHandle);
				if (processWaitHandle.WaitOne(milliseconds, exitContext: false))
				{
					flag = true;
					signaled = true;
				}
				else
				{
					flag = false;
					signaled = false;
				}
			}
			if (output != null && milliseconds == -1)
			{
				output.WaitUtilEOF();
			}
			if (error != null && milliseconds == -1)
			{
				error.WaitUtilEOF();
			}
		}
		finally
		{
			processWaitHandle?.Close();
			ReleaseProcessHandle(safeProcessHandle);
		}
		if (flag && watchForExit)
		{
			RaiseOnExited();
		}
		return flag;
	}

	public void WaitForExit()
	{
		WaitForExit(-1);
	}

	public bool WaitForInputIdle(int milliseconds)
	{
		SafeProcessHandle handle = null;
		try
		{
			handle = GetProcessHandle(1049600);
			return NativeMethods.WaitForInputIdle(handle, milliseconds) switch
			{
				0 => true, 
				258 => false, 
				_ => throw new InvalidOperationException(global::SR.GetString("WaitForInputIdle failed.  This could be because the process does not have a graphical interface.")), 
			};
		}
		finally
		{
			ReleaseProcessHandle(handle);
		}
	}

	public bool WaitForInputIdle()
	{
		return WaitForInputIdle(int.MaxValue);
	}

	[ComVisible(false)]
	public void BeginOutputReadLine()
	{
		if (outputStreamReadMode == StreamReadMode.undefined)
		{
			outputStreamReadMode = StreamReadMode.asyncMode;
		}
		else if (outputStreamReadMode != StreamReadMode.asyncMode)
		{
			throw new InvalidOperationException(global::SR.GetString("Cannot mix synchronous and asynchronous operation on process stream."));
		}
		if (pendingOutputRead)
		{
			throw new InvalidOperationException(global::SR.GetString("An async read operation has already been started on the stream."));
		}
		pendingOutputRead = true;
		if (output == null)
		{
			if (standardOutput == null)
			{
				throw new InvalidOperationException(global::SR.GetString("StandardOut has not been redirected or the process hasn't started yet."));
			}
			Stream baseStream = standardOutput.BaseStream;
			output = new AsyncStreamReader(this, baseStream, OutputReadNotifyUser, standardOutput.CurrentEncoding);
		}
		output.BeginReadLine();
	}

	[ComVisible(false)]
	public void BeginErrorReadLine()
	{
		if (errorStreamReadMode == StreamReadMode.undefined)
		{
			errorStreamReadMode = StreamReadMode.asyncMode;
		}
		else if (errorStreamReadMode != StreamReadMode.asyncMode)
		{
			throw new InvalidOperationException(global::SR.GetString("Cannot mix synchronous and asynchronous operation on process stream."));
		}
		if (pendingErrorRead)
		{
			throw new InvalidOperationException(global::SR.GetString("An async read operation has already been started on the stream."));
		}
		pendingErrorRead = true;
		if (error == null)
		{
			if (standardError == null)
			{
				throw new InvalidOperationException(global::SR.GetString("StandardError has not been redirected."));
			}
			Stream baseStream = standardError.BaseStream;
			error = new AsyncStreamReader(this, baseStream, ErrorReadNotifyUser, standardError.CurrentEncoding);
		}
		error.BeginReadLine();
	}

	[ComVisible(false)]
	public void CancelOutputRead()
	{
		if (output != null)
		{
			output.CancelOperation();
			pendingOutputRead = false;
			return;
		}
		throw new InvalidOperationException(global::SR.GetString("No async read operation is in progress on the stream."));
	}

	[ComVisible(false)]
	public void CancelErrorRead()
	{
		if (error != null)
		{
			error.CancelOperation();
			pendingErrorRead = false;
			return;
		}
		throw new InvalidOperationException(global::SR.GetString("No async read operation is in progress on the stream."));
	}

	internal void OutputReadNotifyUser(string data)
	{
		DataReceivedEventHandler dataReceivedEventHandler = OutputDataReceived;
		if (dataReceivedEventHandler != null)
		{
			DataReceivedEventArgs e = new DataReceivedEventArgs(data);
			if (SynchronizingObject != null && SynchronizingObject.InvokeRequired)
			{
				SynchronizingObject.Invoke(dataReceivedEventHandler, new object[2] { this, e });
			}
			else
			{
				dataReceivedEventHandler(this, e);
			}
		}
	}

	internal void ErrorReadNotifyUser(string data)
	{
		DataReceivedEventHandler dataReceivedEventHandler = ErrorDataReceived;
		if (dataReceivedEventHandler != null)
		{
			DataReceivedEventArgs e = new DataReceivedEventArgs(data);
			if (SynchronizingObject != null && SynchronizingObject.InvokeRequired)
			{
				SynchronizingObject.Invoke(dataReceivedEventHandler, new object[2] { this, e });
			}
			else
			{
				dataReceivedEventHandler(this, e);
			}
		}
	}

	private Process(SafeProcessHandle handle, int id)
	{
		SetProcessHandle(handle);
		SetProcessId(id);
	}

	[MethodImpl(MethodImplOptions.InternalCall)]
	private static extern IntPtr MainWindowHandle_icall(int pid);

	private static void AppendArguments(StringBuilder stringBuilder, Collection<string> argumentList)
	{
		if (argumentList.Count <= 0)
		{
			return;
		}
		foreach (string argument in argumentList)
		{
			System.PasteArguments.AppendArgument(stringBuilder, argument);
		}
	}

	[MethodImpl(MethodImplOptions.InternalCall)]
	private extern ProcessModule[] GetModules_icall(IntPtr handle);

	private ProcessModule[] GetModules_internal(SafeProcessHandle handle)
	{
		bool success = false;
		try
		{
			handle.DangerousAddRef(ref success);
			return GetModules_icall(handle.DangerousGetHandle());
		}
		finally
		{
			if (success)
			{
				handle.DangerousRelease();
			}
		}
	}

	[MethodImpl(MethodImplOptions.InternalCall)]
	private static extern long GetProcessData(int pid, int data_type, out int error);

	[MethodImpl(MethodImplOptions.InternalCall)]
	private static extern string ProcessName_icall(IntPtr handle);

	private static string ProcessName_internal(SafeProcessHandle handle)
	{
		bool success = false;
		try
		{
			handle.DangerousAddRef(ref success);
			return ProcessName_icall(handle.DangerousGetHandle());
		}
		finally
		{
			if (success)
			{
				handle.DangerousRelease();
			}
		}
	}

	public bool CloseMainWindow()
	{
		SafeProcessHandle safeProcessHandle = null;
		try
		{
			safeProcessHandle = GetProcessHandle(1);
			return NativeMethods.TerminateProcess(safeProcessHandle, -2);
		}
		finally
		{
			ReleaseProcessHandle(safeProcessHandle);
		}
	}

	[MethodImpl(MethodImplOptions.InternalCall)]
	private static extern IntPtr GetProcess_internal(int pid);

	[MonoTODO("There is no support for retrieving process information from a remote machine")]
	public static Process GetProcessById(int processId, string machineName)
	{
		if (machineName == null)
		{
			throw new ArgumentNullException("machineName");
		}
		if (!IsLocalMachine(machineName))
		{
			throw new NotImplementedException();
		}
		IntPtr process_internal = GetProcess_internal(processId);
		if (process_internal == IntPtr.Zero)
		{
			throw new ArgumentException("Can't find process with ID " + processId);
		}
		return new Process(new SafeProcessHandle(process_internal, ownsHandle: true), processId);
	}

	public static Process[] GetProcessesByName(string processName, string machineName)
	{
		if (machineName == null)
		{
			throw new ArgumentNullException("machineName");
		}
		if (!IsLocalMachine(machineName))
		{
			throw new NotImplementedException();
		}
		Process[] array = GetProcesses();
		if (array.Length == 0)
		{
			return array;
		}
		int newSize = 0;
		foreach (Process process in array)
		{
			try
			{
				if (string.Compare(processName, process.ProcessName, ignoreCase: true) == 0)
				{
					array[newSize++] = process;
				}
				else
				{
					process.Dispose();
				}
			}
			catch (SystemException)
			{
			}
		}
		Array.Resize(ref array, newSize);
		return array;
	}

	[MethodImpl(MethodImplOptions.InternalCall)]
	private static extern int[] GetProcesses_internal();

	[MonoTODO("There is no support for retrieving process information from a remote machine")]
	public static Process[] GetProcesses(string machineName)
	{
		if (machineName == null)
		{
			throw new ArgumentNullException("machineName");
		}
		if (!IsLocalMachine(machineName))
		{
			throw new NotImplementedException();
		}
		int[] processes_internal = GetProcesses_internal();
		if (processes_internal == null)
		{
			return new Process[0];
		}
		List<Process> list = new List<Process>(processes_internal.Length);
		for (int i = 0; i < processes_internal.Length; i++)
		{
			try
			{
				list.Add(GetProcessById(processes_internal[i]));
			}
			catch (SystemException)
			{
			}
		}
		return list.ToArray();
	}

	private static bool IsLocalMachine(string machineName)
	{
		if (machineName == "." || machineName.Length == 0)
		{
			return true;
		}
		return string.Compare(machineName, Environment.MachineName, ignoreCase: true) == 0;
	}

	[MethodImpl(MethodImplOptions.InternalCall)]
	private static extern bool ShellExecuteEx_internal(ProcessStartInfo startInfo, ref ProcInfo procInfo);

	[MethodImpl(MethodImplOptions.InternalCall)]
	private static extern bool CreateProcess_internal(ProcessStartInfo startInfo, IntPtr stdin, IntPtr stdout, IntPtr stderr, ref ProcInfo procInfo);

	private bool StartWithShellExecuteEx(ProcessStartInfo startInfo)
	{
		if (disposed)
		{
			throw new ObjectDisposedException(GetType().Name);
		}
		if (!string.IsNullOrEmpty(startInfo.UserName) || startInfo.Password != null)
		{
			throw new InvalidOperationException(global::SR.GetString("The Process object must have the UseShellExecute property set to false in order to start a process as a user."));
		}
		if (startInfo.RedirectStandardInput || startInfo.RedirectStandardOutput || startInfo.RedirectStandardError)
		{
			throw new InvalidOperationException(global::SR.GetString("The Process object must have the UseShellExecute property set to false in order to redirect IO streams."));
		}
		if (startInfo.StandardErrorEncoding != null)
		{
			throw new InvalidOperationException(global::SR.GetString("StandardErrorEncoding is only supported when standard error is redirected."));
		}
		if (startInfo.StandardOutputEncoding != null)
		{
			throw new InvalidOperationException(global::SR.GetString("StandardOutputEncoding is only supported when standard output is redirected."));
		}
		if (startInfo.environmentVariables != null)
		{
			throw new InvalidOperationException(global::SR.GetString("The Process object must have the UseShellExecute property set to false in order to use environment variables."));
		}
		ProcInfo procInfo = default(ProcInfo);
		FillUserInfo(startInfo, ref procInfo);
		bool flag;
		try
		{
			flag = ShellExecuteEx_internal(startInfo, ref procInfo);
		}
		finally
		{
			if (procInfo.Password != IntPtr.Zero)
			{
				Marshal.ZeroFreeBSTR(procInfo.Password);
			}
			procInfo.Password = IntPtr.Zero;
		}
		if (!flag)
		{
			throw new Win32Exception(-procInfo.pid);
		}
		SetProcessHandle(new SafeProcessHandle(procInfo.process_handle, ownsHandle: true));
		SetProcessId(procInfo.pid);
		return flag;
	}

	private static void CreatePipe(out IntPtr read, out IntPtr write, bool writeDirection)
	{
		if (!MonoIO.CreatePipe(out read, out write, out var monoIOError))
		{
			throw MonoIO.GetException(monoIOError);
		}
		if (!IsWindows)
		{
			return;
		}
		IntPtr target_handle = (writeDirection ? write : read);
		if (!MonoIO.DuplicateHandle(GetCurrentProcess().Handle, target_handle, GetCurrentProcess().Handle, out target_handle, 0, 0, 2, out monoIOError))
		{
			throw MonoIO.GetException(monoIOError);
		}
		if (writeDirection)
		{
			if (!MonoIO.Close(write, out monoIOError))
			{
				throw MonoIO.GetException(monoIOError);
			}
			write = target_handle;
		}
		else
		{
			if (!MonoIO.Close(read, out monoIOError))
			{
				throw MonoIO.GetException(monoIOError);
			}
			read = target_handle;
		}
	}

	private bool StartWithCreateProcess(ProcessStartInfo startInfo)
	{
		if (startInfo.StandardOutputEncoding != null && !startInfo.RedirectStandardOutput)
		{
			throw new InvalidOperationException(global::SR.GetString("StandardOutputEncoding is only supported when standard output is redirected."));
		}
		if (startInfo.StandardErrorEncoding != null && !startInfo.RedirectStandardError)
		{
			throw new InvalidOperationException(global::SR.GetString("StandardErrorEncoding is only supported when standard error is redirected."));
		}
		if (disposed)
		{
			throw new ObjectDisposedException(GetType().Name);
		}
		ProcInfo procInfo = default(ProcInfo);
		if (startInfo.HaveEnvVars)
		{
			List<string> list = new List<string>();
			foreach (DictionaryEntry environmentVariable in startInfo.EnvironmentVariables)
			{
				if (environmentVariable.Value != null)
				{
					list.Add((string)environmentVariable.Key + "=" + (string)environmentVariable.Value);
				}
			}
			procInfo.envVariables = list.ToArray();
		}
		if (startInfo.ArgumentList.Count > 0)
		{
			StringBuilder stringBuilder = new StringBuilder();
			foreach (string argument in startInfo.ArgumentList)
			{
				System.PasteArguments.AppendArgument(stringBuilder, argument);
			}
			startInfo.Arguments = stringBuilder.ToString();
		}
		IntPtr read = IntPtr.Zero;
		IntPtr write = IntPtr.Zero;
		IntPtr read2 = IntPtr.Zero;
		IntPtr write2 = IntPtr.Zero;
		IntPtr read3 = IntPtr.Zero;
		IntPtr write3 = IntPtr.Zero;
		MonoIOError monoIOError;
		try
		{
			if (startInfo.RedirectStandardInput)
			{
				CreatePipe(out read, out write, writeDirection: true);
			}
			else
			{
				read = MonoIO.ConsoleInput;
				write = IntPtr.Zero;
			}
			if (startInfo.RedirectStandardOutput)
			{
				CreatePipe(out read2, out write2, writeDirection: false);
			}
			else
			{
				read2 = IntPtr.Zero;
				write2 = MonoIO.ConsoleOutput;
			}
			if (startInfo.RedirectStandardError)
			{
				CreatePipe(out read3, out write3, writeDirection: false);
			}
			else
			{
				read3 = IntPtr.Zero;
				write3 = MonoIO.ConsoleError;
			}
			FillUserInfo(startInfo, ref procInfo);
			if (!CreateProcess_internal(startInfo, read, write2, write3, ref procInfo))
			{
				throw new Win32Exception(-procInfo.pid, "ApplicationName='" + startInfo.FileName + "', CommandLine='" + startInfo.Arguments + "', CurrentDirectory='" + startInfo.WorkingDirectory + "', Native error= " + Win32Exception.GetErrorMessage(-procInfo.pid));
			}
		}
		catch
		{
			if (startInfo.RedirectStandardInput)
			{
				if (read != IntPtr.Zero)
				{
					MonoIO.Close(read, out monoIOError);
				}
				if (write != IntPtr.Zero)
				{
					MonoIO.Close(write, out monoIOError);
				}
			}
			if (startInfo.RedirectStandardOutput)
			{
				if (read2 != IntPtr.Zero)
				{
					MonoIO.Close(read2, out monoIOError);
				}
				if (write2 != IntPtr.Zero)
				{
					MonoIO.Close(write2, out monoIOError);
				}
			}
			if (startInfo.RedirectStandardError)
			{
				if (read3 != IntPtr.Zero)
				{
					MonoIO.Close(read3, out monoIOError);
				}
				if (write3 != IntPtr.Zero)
				{
					MonoIO.Close(write3, out monoIOError);
				}
			}
			throw;
		}
		finally
		{
			if (procInfo.Password != IntPtr.Zero)
			{
				Marshal.ZeroFreeBSTR(procInfo.Password);
				procInfo.Password = IntPtr.Zero;
			}
		}
		SetProcessHandle(new SafeProcessHandle(procInfo.process_handle, ownsHandle: true));
		SetProcessId(procInfo.pid);
		if (startInfo.RedirectStandardInput)
		{
			MonoIO.Close(read, out monoIOError);
			Encoding encoding = startInfo.StandardInputEncoding ?? Encoding.Default;
			standardInput = new StreamWriter(new FileStream(write, FileAccess.Write, ownsHandle: true, 8192), encoding)
			{
				AutoFlush = true
			};
		}
		if (startInfo.RedirectStandardOutput)
		{
			MonoIO.Close(write2, out monoIOError);
			Encoding encoding2 = startInfo.StandardOutputEncoding ?? Console.OutputEncoding;
			standardOutput = new StreamReader(new FileStream(read2, FileAccess.Read, ownsHandle: true, 8192), encoding2, detectEncodingFromByteOrderMarks: true);
		}
		if (startInfo.RedirectStandardError)
		{
			MonoIO.Close(write3, out monoIOError);
			Encoding encoding3 = startInfo.StandardErrorEncoding ?? Console.OutputEncoding;
			standardError = new StreamReader(new FileStream(read3, FileAccess.Read, ownsHandle: true, 8192), encoding3, detectEncodingFromByteOrderMarks: true);
		}
		return true;
	}

	private static void FillUserInfo(ProcessStartInfo startInfo, ref ProcInfo procInfo)
	{
		if (startInfo.UserName.Length != 0)
		{
			procInfo.UserName = startInfo.UserName;
			procInfo.Domain = startInfo.Domain;
			if (startInfo.Password != null)
			{
				procInfo.Password = Marshal.SecureStringToBSTR(startInfo.Password);
			}
			else
			{
				procInfo.Password = IntPtr.Zero;
			}
			procInfo.LoadUserProfile = startInfo.LoadUserProfile;
		}
	}

	private void RaiseOnExited()
	{
		if (!watchForExit || raisedOnExited)
		{
			return;
		}
		lock (this)
		{
			if (!raisedOnExited)
			{
				raisedOnExited = true;
				OnExited();
			}
		}
	}
}
