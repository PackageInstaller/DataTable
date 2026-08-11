using Cysharp.Threading.Tasks;

namespace Ase;

public interface IObjectFactory<T> where T : class
{
	T Create(IObjectPool<T> pool);

	void Destroy(T obj);

	void Dispose();

	void Reset(T obj);

	bool Validate(T obj);

	UniTask<bool> PreLoadData();
}
