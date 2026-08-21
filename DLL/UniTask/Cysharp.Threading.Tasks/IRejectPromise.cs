using System;

namespace Cysharp.Threading.Tasks;

public interface IRejectPromise
{
	bool TrySetException(Exception exception);
}
