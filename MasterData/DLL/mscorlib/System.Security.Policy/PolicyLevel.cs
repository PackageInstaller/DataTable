using System.Runtime.InteropServices;
using Unity;

namespace System.Security.Policy;

[Serializable]
[ComVisible(true)]
public sealed class PolicyLevel
{
	private CodeGroup root_code_group;

	public PolicyStatement Resolve(Evidence evidence)
	{
		if (evidence == null)
		{
			throw new ArgumentNullException("evidence");
		}
		PolicyStatement policyStatement = root_code_group.Resolve(evidence);
		if (policyStatement == null)
		{
			return PolicyStatement.Empty();
		}
		return policyStatement;
	}

	internal PolicyLevel()
	{
		ThrowStub.ThrowNotSupportedException();
	}
}
