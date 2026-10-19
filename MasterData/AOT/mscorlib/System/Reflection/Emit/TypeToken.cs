using System.Runtime.InteropServices;

namespace System.Reflection.Emit;

[StructLayout(LayoutKind.Sequential, Size = 1)]
public readonly struct TypeToken : IEquatable<TypeToken>
{
	public override bool Equals(object obj)
	{
		throw new PlatformNotSupportedException();
	}

	public bool Equals(TypeToken obj)
	{
		throw new PlatformNotSupportedException();
	}

	public override int GetHashCode()
	{
		throw new PlatformNotSupportedException();
	}
}
