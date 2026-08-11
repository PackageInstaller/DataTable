using Cysharp.Threading.Tasks;

public abstract class IStaticMethod
{
	public abstract void Run();

	public abstract void Run(object a);

	public abstract void Run(object a, object b);

	public abstract void Run(object a, object b, object c);

	public abstract T Run<T>();

	public abstract UniTask RunAsync();

	public abstract UniTask RunAsync(object a);

	public abstract UniTask RunAsync(object a, object b);

	public abstract UniTask RunAsync(object a, object b, object c);

	public abstract UniTask<T> RunAsync<T>();

	public abstract UniTask<T> RunAsync<T>(object a);

	public abstract UniTask<T> RunAsync<T>(object a, object b);

	public abstract UniTask<T> RunAsync<T>(object a, object b, object c);
}
