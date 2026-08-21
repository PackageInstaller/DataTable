namespace Cysharp.Threading.Tasks;

public interface IResolvePromise
{
	bool TrySetResult();
}
public interface IResolvePromise<T>
{
	bool TrySetResult(T value);
}
