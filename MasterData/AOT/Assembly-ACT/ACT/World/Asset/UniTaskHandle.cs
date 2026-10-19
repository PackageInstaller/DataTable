using System;
using System.Threading;
using Cysharp.Threading.Tasks;

namespace ACT.World.Asset;

public class UniTaskHandle
{
	public static (CancellationTokenSource, UniTask) BindCancellationToken(Func<CancellationToken, UniTask> task)
	{
		CancellationTokenSource cancellationTokenSource = new CancellationTokenSource();
		return (cancellationTokenSource, task(cancellationTokenSource.Token));
	}
}
