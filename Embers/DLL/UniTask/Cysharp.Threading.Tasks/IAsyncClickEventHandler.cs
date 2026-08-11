using System;

namespace Cysharp.Threading.Tasks;

public interface IAsyncClickEventHandler : IDisposable
{
	UniTask OnClickAsync();
}
