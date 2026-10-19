using System;
using System.Threading;

namespace Cysharp.Threading.Tasks.Linq;

internal sealed class CancellationTokenDisposable : IDisposable
{
	private readonly CancellationTokenSource cts = new CancellationTokenSource();

	public CancellationToken Token => cts.Token;

	public void Dispose()
	{
		if (!cts.IsCancellationRequested)
		{
			cts.Cancel();
		}
	}
}
