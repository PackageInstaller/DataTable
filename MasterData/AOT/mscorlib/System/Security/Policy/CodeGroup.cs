using System.Runtime.InteropServices;

namespace System.Security.Policy;

[Serializable]
[ComVisible(true)]
public abstract class CodeGroup
{
	public abstract PolicyStatement Resolve(Evidence evidence);
}
