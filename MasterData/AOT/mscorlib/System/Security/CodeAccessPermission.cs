using System.Diagnostics;
using System.Runtime.InteropServices;
using System.Security.Permissions;

namespace System.Security;

[Serializable]
[MonoTODO("CAS support is experimental (and unsupported).")]
[ComVisible(true)]
public abstract class CodeAccessPermission : IPermission, ISecurityEncodable
{
	[Conditional("MONO_FEATURE_CAS")]
	public void Demand()
	{
		if (SecurityManager.SecurityEnabled)
		{
			new PermissionSet(this).CasOnlyDemand(3);
		}
	}

	[ComVisible(false)]
	public override bool Equals(object obj)
	{
		if (obj == null)
		{
			return false;
		}
		if (obj.GetType() != GetType())
		{
			return false;
		}
		CodeAccessPermission codeAccessPermission = obj as CodeAccessPermission;
		if (IsSubsetOf(codeAccessPermission))
		{
			return codeAccessPermission.IsSubsetOf(this);
		}
		return false;
	}

	[ComVisible(false)]
	public override int GetHashCode()
	{
		return base.GetHashCode();
	}

	public abstract bool IsSubsetOf(IPermission target);

	public override string ToString()
	{
		return ToXml().ToString();
	}

	public abstract SecurityElement ToXml();

	internal static PermissionState CheckPermissionState(PermissionState state, bool allowUnrestricted)
	{
		if (state != PermissionState.None && state != PermissionState.Unrestricted)
		{
			throw new ArgumentException(string.Format(Locale.GetText("Invalid enum {0}"), state), "state");
		}
		return state;
	}

	void IPermission.Demand()
	{
	}
}
