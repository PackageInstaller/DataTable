using System;

namespace Cysharp.Threading.Tasks;

public interface IAsyncEndEditEventHandler<T> : IDisposable
{
	UniTask<T> OnEndEditAsync();
}
