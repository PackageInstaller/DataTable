using System.Runtime.ConstrainedExecution;
using System.Runtime.InteropServices;

namespace System;

internal sealed class Gen2GcCallback : CriticalFinalizerObject
{
	private Func<object, bool> _callback;

	private GCHandle _weakTargetObj;

	private Gen2GcCallback()
	{
	}

	public static void Register(Func<object, bool> callback, object targetObj)
	{
		new Gen2GcCallback().Setup(callback, targetObj);
	}

	private void Setup(Func<object, bool> callback, object targetObj)
	{
		_callback = callback;
		_weakTargetObj = GCHandle.Alloc(targetObj, GCHandleType.Weak);
	}

	~Gen2GcCallback()
	{
		object target = _weakTargetObj.Target;
		if (target == null)
		{
			_weakTargetObj.Free();
			return;
		}
		try
		{
			if (!_callback(target))
			{
				return;
			}
		}
		catch
		{
		}
		if (!Environment.HasShutdownStarted)
		{
			GC.ReRegisterForFinalize(this);
		}
	}
}
