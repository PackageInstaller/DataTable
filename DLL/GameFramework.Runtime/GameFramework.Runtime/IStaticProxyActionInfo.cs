namespace GameFramework.Runtime;

public interface IStaticProxyActionInfo<T> : IProxyMethodInfo, IProxyMemberInfo
{
	void Invoke();
}
public interface IStaticProxyActionInfo<T, P1> : IProxyMethodInfo, IProxyMemberInfo
{
	void Invoke(P1 p1);
}
public interface IStaticProxyActionInfo<T, P1, P2> : IProxyMethodInfo, IProxyMemberInfo
{
	void Invoke(P1 p1, P2 p2);
}
public interface IStaticProxyActionInfo<T, P1, P2, P3> : IProxyMethodInfo, IProxyMemberInfo
{
	void Invoke(P1 p1, P2 p2, P3 p3);
}
