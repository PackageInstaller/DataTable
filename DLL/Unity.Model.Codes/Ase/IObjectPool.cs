using System;
using Cysharp.Threading.Tasks;

namespace Ase;

public interface IObjectPool : IDisposable
{
	object Allocate();

	void Free(object obj);
}
public interface IObjectPool<T> : IObjectPool, IDisposable where T : class
{
	new T Allocate();

	UniTask<bool> PreLoadData();

	void Free(T obj);

	void Release(T obj);
}
