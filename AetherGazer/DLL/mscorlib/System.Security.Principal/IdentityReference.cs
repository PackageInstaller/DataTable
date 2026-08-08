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

	public abstract IdentityReference Translate(Type targetType);

	public static bool operator ==(IdentityReference left, IdentityReference right)
	{
		if ((object)left == null)
		{
			return (object)right == null;
		}
		if ((object)right == null)
		{
			return false;
		}
		return left.Value == right.Value;
	}
}
