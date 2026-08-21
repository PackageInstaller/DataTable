namespace GameFramework.Runtime;

public interface IStaticProxyFuncInfo<T, TResult> : IProxyMethodInfo, IProxyMemberInfo
{
	TResult Invoke();
}
public interface IStaticProxyFuncInfo<T, P1, TResult> : IProxyMethodInfo, IProxyMemberInfo
{
	TResult Invoke(P1 p1);
}
public interface IStaticProxyFuncInfo<T, P1, P2, TResult> : IProxyMethodInfo, IProxyMemberInfo
{
	TResult Invoke(P1 p1, P2 p2);
}
public interface IStaticProxyFuncInfo<T, P1, P2, P3, TResult> : IProxyMethodInfo, IProxyMemberInfo
{
	TResult Invoke(P1 p1, P2 p2, P3 p3);
}
