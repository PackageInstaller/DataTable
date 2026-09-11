using System.Runtime.InteropServices;
using System.Security.Claims;

namespace System.Security.Principal;

[Serializable]
[ComVisible(true)]
public class WindowsPrincipal : ClaimsPrincipal
{
	private WindowsIdentity _identity;

	public override IIdentity Identity => _identity;

	public WindowsPrincipal(WindowsIdentity ntIdentity)
	{
		if (ntIdentity == null)
		{
			throw new ArgumentNullException("ntIdentity");
		}
		_identity = ntIdentity;
	}
}
