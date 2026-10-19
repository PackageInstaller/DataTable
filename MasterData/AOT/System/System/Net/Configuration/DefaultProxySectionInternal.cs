using System.Threading;

namespace System.Net.Configuration;

internal sealed class DefaultProxySectionInternal
{
	private IWebProxy webProxy;

	private static object classSyncObject;

	internal static object ClassSyncObject
	{
		get
		{
			if (classSyncObject == null)
			{
				object value = new object();
				Interlocked.CompareExchange(ref classSyncObject, value, null);
			}
			return classSyncObject;
		}
	}

	internal IWebProxy WebProxy => webProxy;

	private static IWebProxy GetDefaultProxy_UsingOldMonoCode()
	{
		return GetSystemWebProxy();
	}

	private static IWebProxy GetSystemWebProxy()
	{
		return System.Net.WebProxy.CreateDefaultProxy();
	}

	internal static DefaultProxySectionInternal GetSection()
	{
		lock (ClassSyncObject)
		{
			return new DefaultProxySectionInternal
			{
				webProxy = GetDefaultProxy_UsingOldMonoCode()
			};
		}
	}
}
