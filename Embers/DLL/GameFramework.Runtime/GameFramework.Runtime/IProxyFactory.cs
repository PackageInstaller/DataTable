using System;

namespace GameFramework.Runtime;

public interface IProxyFactory
{
	IProxyType Create(Type type);
}
