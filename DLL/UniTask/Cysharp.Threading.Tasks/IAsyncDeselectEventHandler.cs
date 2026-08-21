using System;

namespace Cysharp.Threading.Tasks;

public interface IAsyncDeselectEventHandler<T> : IDisposable
{
	UniTask<T> OnDeselectAsync();
}
