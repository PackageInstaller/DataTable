using System.Reflection;

namespace UnityEngine.Events;

internal class CachedInvokableCall<T> : InvokableCall<T>
{
	private readonly T m_Arg1;

	public CachedInvokableCall(Object target, MethodInfo theFunction, T argument)
		: base((object)target, theFunction)
	{
		m_Arg1 = argument;
	}

	public override void Invoke(object[] args)
	{
		base.Invoke(m_Arg1);
	}

	public override void Invoke(T arg0)
	{
		base.Invoke(m_Arg1);
	}
}
