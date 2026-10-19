using System;

namespace UnityEngine;

internal class GlobalJavaObjectRef
{
	private bool m_disposed = false;

	protected IntPtr m_jobject;

	public GlobalJavaObjectRef(IntPtr jobject)
	{
		m_jobject = ((jobject == IntPtr.Zero) ? IntPtr.Zero : AndroidJNI.NewGlobalRef(jobject));
	}

	~GlobalJavaObjectRef()
	{
		Dispose();
	}

	public static implicit operator IntPtr(GlobalJavaObjectRef obj)
	{
		return obj.m_jobject;
	}

	public void Dispose()
	{
		if (!m_disposed)
		{
			m_disposed = true;
			if (m_jobject != IntPtr.Zero)
			{
				AndroidJNISafe.QueueDeleteGlobalRef(m_jobject);
			}
		}
	}
}
