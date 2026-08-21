using System;

namespace Cysharp.Threading.Tasks;

public interface IAsyncEndTextSelectionEventHandler<T> : IDisposable
{
	UniTask<T> OnEndTextSelectionAsync();
}
