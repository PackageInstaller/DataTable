using System;

namespace Cysharp.Threading.Tasks;

public interface IAsyncValueChangedEventHandler<T> : IDisposable
{
	UniTask<T> OnValueChangedAsync();
}
