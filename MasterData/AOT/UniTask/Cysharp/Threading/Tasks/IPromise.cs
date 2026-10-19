namespace Cysharp.Threading.Tasks;

public interface IPromise<T> : IResolvePromise<T>, IRejectPromise, ICancelPromise
{
}
public interface IPromise : IResolvePromise, IRejectPromise, ICancelPromise
{
}
