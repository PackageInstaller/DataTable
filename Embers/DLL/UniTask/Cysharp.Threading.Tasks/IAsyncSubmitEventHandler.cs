using System;

namespace Cysharp.Threading.Tasks;

public interface IAsyncSubmitEventHandler<T> : IDisposable
{
	UniTask<T> OnSubmitAsync();
}
