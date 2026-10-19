using System;

namespace UnityEngine;

internal class AndroidJavaRunnableProxy : AndroidJavaProxy
{
	private AndroidJavaRunnable mRunnable;

	public AndroidJavaRunnableProxy(AndroidJavaRunnable runnable)
		: base("java/lang/Runnable")
	{
		mRunnable = runnable;
	}

	public void run()
	{
		mRunnable();
	}

	public override IntPtr Invoke(string methodName, IntPtr javaArgs)
	{
		int num = 0;
		if (javaArgs != IntPtr.Zero)
		{
			num = AndroidJNISafe.GetArrayLength(javaArgs);
		}
		if (num == 0 && methodName == "run")
		{
			run();
			return IntPtr.Zero;
		}
		return base.Invoke(methodName, javaArgs);
	}
}
