using System.Runtime.InteropServices;

namespace System.Security.Principal;

[ComVisible(false)]
public abstract class IdentityReference
{
	public abstract string Value { get; }

	internal IdentityReference()
	{
	}

	public abstract override bool Equals(object o);

	public abstract override int GetHashCode();

	public abstract override string ToString();
}
