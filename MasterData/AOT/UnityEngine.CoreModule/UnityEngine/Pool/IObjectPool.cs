namespace UnityEngine.Pool;

public interface IObjectPool<T> where T : class
{
	void Release(T element);
}
