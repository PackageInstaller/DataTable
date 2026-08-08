using System.Runtime.InteropServices;

namespace System.Security.Principal;

[ComVisible(false)]
public sealed class NTAccount : IdentityReference
{
	private string _value;

	public override string Value => _value;

	public NTAccount(string name)
	{
		if (name == null)
		{
			throw new ArgumentNullException("name");
		}
		if (name.Length == 0)
		{
			throw new ArgumentException(Locale.GetText("Empty"), "name");
		}
		_value = name;
	}

	public override bool Equals(object o)
	{
		NTAccount nTAccount = o as NTAccount;
		if (nTAccount == null)
		{
			return false;
		}
		return nTAccount.Value == Value;
	}

	public override int GetHashCode()
	{
		return Value.GetHashCode();
	}

	public override string ToString()
	{
		return Value;
	}

	public override IdentityReference Translate(Type targetType)
	{
		if (targetType == typeof(NTAccount))
		{
			return this;
		}
		if (targetType == typeof(SecurityIdentifier))
		{
			WellKnownAccount wellKnownAccount = WellKnownAccount.LookupByName(Value);
			if (wellKnownAccount == null || wellKnownAccount.Sid == null)
			{
				throw new IdentityNotMappedException("Cannot map account name: " + Value);
			}
			return new SecurityIdentifier(wellKnownAccount.Sid);
		}
		throw new ArgumentException("Unknown type", "targetType");
	}

	public static bool operator ==(NTAccount left, NTAccount right)
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
