using System;

namespace Unity;

internal sealed class ThrowStub : ObjectDisposedException
{
	public static void ThrowNotSupportedException()
	{
		throw new PlatformNotSupportedException();
	}
}
