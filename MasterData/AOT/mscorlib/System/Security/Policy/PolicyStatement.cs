using System.Runtime.InteropServices;
using System.Security.Permissions;

namespace System.Security.Policy;

[Serializable]
[ComVisible(true)]
public sealed class PolicyStatement : ISecurityEncodable
{
	private PermissionSet perms;

	private PolicyStatementAttribute attrs;

	public PermissionSet PermissionSet
	{
		get
		{
			if (perms == null)
			{
				perms = new PermissionSet(PermissionState.None);
				perms.SetReadOnly(value: true);
			}
			return perms;
		}
	}

	public PolicyStatement(PermissionSet permSet)
		: this(permSet, PolicyStatementAttribute.Nothing)
	{
	}

	public PolicyStatement(PermissionSet permSet, PolicyStatementAttribute attributes)
	{
		if (permSet != null)
		{
			perms = permSet.Copy();
			perms.SetReadOnly(value: true);
		}
		attrs = attributes;
	}

	public SecurityElement ToXml()
	{
		return ToXml(null);
	}

	public SecurityElement ToXml(PolicyLevel level)
	{
		SecurityElement securityElement = new SecurityElement("PolicyStatement");
		securityElement.AddAttribute("version", "1");
		if (attrs != PolicyStatementAttribute.Nothing)
		{
			securityElement.AddAttribute("Attributes", attrs.ToString());
		}
		securityElement.AddChild(PermissionSet.ToXml());
		return securityElement;
	}

	[ComVisible(false)]
	public override bool Equals(object obj)
	{
		if (obj == null)
		{
			return false;
		}
		if (!(obj is PolicyStatement policyStatement))
		{
			return false;
		}
		if (PermissionSet.Equals(obj))
		{
			return attrs == policyStatement.attrs;
		}
		return false;
	}

	[ComVisible(false)]
	public override int GetHashCode()
	{
		return PermissionSet.GetHashCode() ^ (int)attrs;
	}

	internal static PolicyStatement Empty()
	{
		return new PolicyStatement(new PermissionSet(PermissionState.None));
	}
}
