using System;

namespace GameFramework.Runtime;

public interface IProxyMemberInfo
{
	Type DeclaringType { get; }

	string Name { get; }

	bool IsStatic { get; }
}
