using System.Runtime.InteropServices;
using System.Runtime.Remoting;

namespace System;

[Serializable]
[StructLayout(LayoutKind.Sequential)]
[ComVisible(true)]
public abstract class MarshalByRefObject
{
	[NonSerialized]
	private object _identity;

	internal ServerIdentity ObjectIdentity
	{
		get
		{
			throw new NotSupportedException();
		}
		set
		{
			throw new NotSupportedException();
		}
	}

	public virtual ObjRef CreateObjRef(Type requestedType)
	{
		throw new NotSupportedException();
	}

	public virtual object InitializeLifetimeService()
	{
		throw new NotSupportedException();
	}
}
