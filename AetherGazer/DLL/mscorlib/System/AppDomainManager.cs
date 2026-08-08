using System.Runtime.Hosting;
using System.Runtime.InteropServices;
using System.Security;

namespace System;

[ComVisible(true)]
public class AppDomainManager : MarshalByRefObject
{
	private ApplicationActivator _activator;

	private AppDomainManagerInitializationOptions _flags;

	public virtual ApplicationActivator ApplicationActivator
	{
		get
		{
			if (_activator == null)
			{
				_activator = new ApplicationActivator();
			}
			return _activator;
		}
	}

	public virtual HostSecurityManager HostSecurityManager => null;

	public AppDomainManager()
	{
		_flags = AppDomainManagerInitializationOptions.None;
	}
}
