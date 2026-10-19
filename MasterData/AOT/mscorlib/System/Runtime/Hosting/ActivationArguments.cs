using System.Runtime.InteropServices;
using System.Security.Policy;

namespace System.Runtime.Hosting;

[Serializable]
[ComVisible(true)]
public sealed class ActivationArguments : EvidenceBase
{
	private ActivationContext _context;

	private ApplicationIdentity _identity;

	public ActivationContext ActivationContext => _context;

	public ApplicationIdentity ApplicationIdentity => _identity;

	public ActivationArguments(ActivationContext activationData)
	{
		if (activationData == null)
		{
			throw new ArgumentNullException("activationData");
		}
		_context = activationData;
		_identity = activationData.Identity;
	}
}
