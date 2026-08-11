using System;
using System.Runtime.InteropServices;

namespace Cysharp.Threading.Tasks;

[StructLayout(LayoutKind.Sequential, Size = 1)]
public readonly struct AsyncUnit : IEquatable<AsyncUnit>
{
	public static readonly AsyncUnit Default;

	public override int GetHashCode()
	{
		return 0;
	}

	public bool Equals(AsyncUnit other)
	{
		return true;
	}

	public override string ToString()
	{
		return "()";
	}
}
