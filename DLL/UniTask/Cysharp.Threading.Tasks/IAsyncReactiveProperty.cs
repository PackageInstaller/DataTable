namespace Cysharp.Threading.Tasks;

public interface IAsyncReactiveProperty<T> : IReadOnlyAsyncReactiveProperty<T>, IUniTaskAsyncEnumerable<T>
{
	new T Value { get; set; }
}
