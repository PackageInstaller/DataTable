using System.Runtime.InteropServices;
using System.Security.Claims;

namespace System.Security.Principal;

[Serializable]
[ComVisible(true)]
public class GenericPrincipal : ClaimsPrincipal
{
	private IIdentity m_identity;

	private string[] m_roles;

	internal string[] Roles => m_roles;

	public override IIdentity Identity => m_identity;

	public GenericPrincipal(IIdentity identity, string[] roles)
	{
		if (identity == null)
		{
			throw new ArgumentNullException("identity");
		}
		m_identity = identity;
		if (roles != null)
		{
			m_roles = new string[roles.Length];
			for (int i = 0; i < roles.Length; i++)
			{
				m_roles[i] = roles[i];
			}
		}
	}
}
