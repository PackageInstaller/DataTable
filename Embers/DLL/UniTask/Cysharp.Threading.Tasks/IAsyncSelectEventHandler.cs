using System;

namespace Cysharp.Threading.Tasks;

public interface IAsyncSelectEventHandler<T> : IDisposable
{
	UniTask<T> OnSelectAsync();
}
