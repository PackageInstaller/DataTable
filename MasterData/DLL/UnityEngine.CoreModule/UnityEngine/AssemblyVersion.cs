using System;
using UnityEngine.Bindings;
using UnityEngine.Scripting;

namespace UnityEngine;

[NativeHeader("Runtime/Mono/AssemblyFullName.h")]
[RequiredByNativeCode(GenerateProxy = true)]
internal struct AssemblyVersion
{
	public ushort major;

	public ushort minor;

	public ushort build;

	public ushort revision;

	public static bool operator ==(AssemblyVersion lhs, AssemblyVersion rhs)
	{
		return lhs.major == rhs.major && lhs.minor == rhs.minor && lhs.build == rhs.build && lhs.revision == rhs.revision;
	}

	public override string ToString()
	{
		return $"{major}.{minor}.{build}.{revision}";
	}

	public override bool Equals(object other)
	{
		return other is AssemblyVersion assemblyVersion && major == assemblyVersion.major && minor == assemblyVersion.minor && build == assemblyVersion.build && revision == assemblyVersion.revision;
	}

	public override int GetHashCode()
	{
		return HashCode.Combine(major, minor, build, revision);
	}
}
