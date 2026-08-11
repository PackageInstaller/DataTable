using System.IO;
using System.Runtime.InteropServices;
using System.Security.AccessControl;
using Microsoft.Win32.SafeHandles;
using Unity;

namespace System.Threading;

[ComVisible(true)]
public class EventWaitHandle : WaitHandle
{
	public EventWaitHandle(bool initialState, EventResetMode mode)
		: this(initialState, mode, null)
	{
	}

	public EventWaitHandle(bool initialState, EventResetMode mode, string name)
	{
		if (name != null && 260 < name.Length)
		{
			throw new ArgumentException(Environment.GetResourceString("The name can be no more than 260 characters in length.", name));
		}
		SafeWaitHandle safeWaitHandle = null;
		safeWaitHandle = mode switch
		{
			EventResetMode.ManualReset => new SafeWaitHandle(NativeEventCalls.CreateEvent_internal(manual: true, initialState, name, out var errorCode), ownsHandle: true), 
			EventResetMode.AutoReset => new SafeWaitHandle(NativeEventCalls.CreateEvent_internal(manual: false, initialState, name, out errorCode), ownsHandle: true), 
			_ => throw new ArgumentException(Environment.GetResourceString("Value of flags is invalid.", name)), 
		};
		if (safeWaitHandle.IsInvalid)
		{
			safeWaitHandle.SetHandleAsInvalid();
			if (name != null && name.Length != 0 && 6 == errorCode)
			{
				throw new WaitHandleCannotBeOpenedException(Environment.GetResourceString("A WaitHandle with system-wide name '{0}' cannot be created. A WaitHandle of a different type might have the same name.", name));
			}
			__Error.WinIOError(errorCode, name);
		}
		SetHandleInternal(safeWaitHandle);
	}

	public EventWaitHandle(bool initialState, EventResetMode mode, string name, out bool createdNew)
		: this(initialState, mode, name, out createdNew, null)
	{
	}

	public EventWaitHandle(bool initialState, EventResetMode mode, string name, out bool createdNew, EventWaitHandleSecurity eventSecurity)
	{
		if (name != null && 260 < name.Length)
		{
			throw new ArgumentException(Environment.GetResourceString("The name can be no more than 260 characters in length.", name));
		}
		SafeWaitHandle safeWaitHandle = null;
		safeWaitHandle = new SafeWaitHandle(NativeEventCalls.CreateEvent_internal(mode switch
		{
			EventResetMode.ManualReset => true, 
			EventResetMode.AutoReset => false, 
			_ => throw new ArgumentException(Environment.GetResourceString("Value of flags is invalid.", name)), 
		}, initialState, name, out var errorCode), ownsHandle: true);
		if (safeWaitHandle.IsInvalid)
		{
			safeWaitHandle.SetHandleAsInvalid();
			if (name != null && name.Length != 0 && 6 == errorCode)
			{
				throw new WaitHandleCannotBeOpenedException(Environment.GetResourceString("A WaitHandle with system-wide name '{0}' cannot be created. A WaitHandle of a different type might have the same name.", name));
			}
			__Error.WinIOError(errorCode, name);
		}
		createdNew = errorCode != 183;
		SetHandleInternal(safeWaitHandle);
	}

	private EventWaitHandle(SafeWaitHandle handle)
	{
		SetHandleInternal(handle);
	}

	public static EventWaitHandle OpenExisting(string name)
	{
		return OpenExisting(name, (EventWaitHandleRights)0);
	}

	public static EventWaitHandle OpenExisting(string name, EventWaitHandleRights rights)
	{
		EventWaitHandle result;
		switch (OpenExistingWorker(name, rights, out result))
		{
		case OpenExistingResult.NameNotFound:
			throw new WaitHandleCannotBeOpenedException();
		case OpenExistingResult.NameInvalid:
			throw new WaitHandleCannotBeOpenedException(Environment.GetResourceString("A WaitHandle with system-wide name '{0}' cannot be created. A WaitHandle of a different type might have the same name.", name));
		case OpenExistingResult.PathNotFound:
			__Error.WinIOError(3, "");
			return result;
		default:
			return result;
		}
	}

	public static bool TryOpenExisting(string name, out EventWaitHandle result)
	{
		return OpenExistingWorker(name, (EventWaitHandleRights)0, out result) == OpenExistingResult.Success;
	}

	public static bool TryOpenExisting(string name, EventWaitHandleRights rights, out EventWaitHandle result)
	{
		return OpenExistingWorker(name, rights, out result) == OpenExistingResult.Success;
	}

	private static OpenExistingResult OpenExistingWorker(string name, EventWaitHandleRights rights, out EventWaitHandle result)
	{
		if (name == null)
		{
			throw new ArgumentNullException("name", Environment.GetResourceString("Parameter '{0}' cannot be null."));
		}
		if (name.Length == 0)
		{
			throw new ArgumentException(Environment.GetResourceString("Empty name is not legal."), "name");
		}
		if (name != null && 260 < name.Length)
		{
			throw new ArgumentException(Environment.GetResourceString("The name can be no more than 260 characters in length.", name));
		}
		result = null;
		throw new NotSupportedException();
	}

	public bool Reset()
	{
		bool num = NativeEventCalls.ResetEvent(safeWaitHandle);
		if (!num)
		{
			throw new IOException();
		}
		return num;
	}

	public bool Set()
	{
		bool num = NativeEventCalls.SetEvent(safeWaitHandle);
		if (!num)
		{
			throw new IOException();
		}
		return num;
	}

	public EventWaitHandleSecurity GetAccessControl()
	{
		return new EventWaitHandleSecurity(safeWaitHandle, AccessControlSections.Access | AccessControlSections.Owner | AccessControlSections.Group);
	}

	public void SetAccessControl(EventWaitHandleSecurity eventSecurity)
	{
		ThrowStub.ThrowNotSupportedException();
	}
}
