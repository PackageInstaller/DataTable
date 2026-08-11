using System;

namespace Cysharp.Threading.Tasks;

public interface IConnectableUniTaskAsyncEnumerable<out T> : IUniTaskAsyncEnumerable<T>
{
	IDisposable Connect();
}
