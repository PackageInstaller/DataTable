namespace GameFramework.Runtime;

public interface IProxyActionInfo<T> : IProxyMethodInfo, IProxyMemberInfo
{
	void Invoke(T target);
}
public interface IProxyActionInfo<T, P1> : IProxyMethodInfo, IProxyMemberInfo
{
	void Invoke(T target, P1 p1);
}
public interface IProxyActionInfo<T, P1, P2> : IProxyMethodInfo, IProxyMemberInfo
{
	void Invoke(T target, P1 p1, P2 p2);
}
public interface IProxyActionInfo<T, P1, P2, P3> : IProxyMethodInfo, IProxyMemberInfo
{
	void Invoke(T target, P1 p1, P2 p2, P3 p3);
}
