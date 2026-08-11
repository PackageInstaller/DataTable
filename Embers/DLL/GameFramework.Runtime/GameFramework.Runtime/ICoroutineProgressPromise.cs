namespace GameFramework.Runtime;

public interface ICoroutineProgressPromise<TProgress> : IProgressPromise<TProgress>, IPromise, ICoroutinePromise
{
}
public interface ICoroutineProgressPromise<TProgress, TResult> : IProgressPromise<TProgress, TResult>, IProgressPromise<TProgress>, IPromise, IPromise<TResult>, ICoroutineProgressPromise<TProgress>, ICoroutinePromise
{
}
