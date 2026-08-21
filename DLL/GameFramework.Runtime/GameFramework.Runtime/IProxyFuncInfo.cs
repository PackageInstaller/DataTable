namespace GameFramework.Runtime;

public interface IProxyFuncInfo<T, TResult> : IProxyMethodInfo, IProxyMemberInfo
{
	TResult Invoke(T target);
}
public interface IProxyFuncInfo<T, P1, TResult> : IProxyMethodInfo, IProxyMemberInfo
{
	TResult Invoke(T target, P1 p1);
}
public interface IProxyFuncInfo<T, P1, P2, TResult> : IProxyMethodInfo, IProxyMemberInfo
{
	TResult Invoke(T target, P1 p1, P2 p2);
}
public interface IProxyFuncInfo<T, P1, P2, P3, TResult> : IProxyMethodInfo, IProxyMemberInfo
{
	TResult Invoke(T target, P1 p1, P2 p2, P3 p3);
}
