using System.Collections.Generic;
using System.Security.Claims;

namespace System.Security.Principal;

[Serializable]
public class GenericIdentity : ClaimsIdentity
{
	private readonly string m_name;

	private readonly string m_type;

	public override IEnumerable<Claim> Claims => base.Claims;

	public override string Name => m_name;

	public override string AuthenticationType => m_type;

	public override bool IsAuthenticated => !m_name.Equals("");

	public GenericIdentity(string name, string type)
	{
		if (name == null)
		{
			throw new ArgumentNullException("name");
		}
		if (type == null)
		{
			throw new ArgumentNullException("type");
		}
		m_name = name;
		m_type = type;
		AddNameClaim();
	}

	private GenericIdentity()
	{
	}

	protected GenericIdentity(GenericIdentity identity)
		: base(identity)
	{
		m_name = identity.m_name;
		m_type = identity.m_type;
	}

	public override ClaimsIdentity Clone()
	{
		return new GenericIdentity(this);
	}

	private void AddNameClaim()
	{
		if (m_name != null)
		{
			base.AddClaim(new Claim(base.NameClaimType, m_name, "http://www.w3.org/2001/XMLSchema#string", "LOCAL AUTHORITY", "LOCAL AUTHORITY", this));
		}
	}
}
