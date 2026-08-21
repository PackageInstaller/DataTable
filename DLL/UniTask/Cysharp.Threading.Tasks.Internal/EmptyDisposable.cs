using System;

namespace Cysharp.Threading.Tasks.Internal;

internal class EmptyDisposable : IDisposable
{
	public static EmptyDisposable Instance = new EmptyDisposable();

	private EmptyDisposable()
	{
	}

	public void Dispose()
	{
	}
}
