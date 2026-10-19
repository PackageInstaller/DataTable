using System.Runtime.InteropServices;

namespace System.Security.Permissions;

[Serializable]
[ComVisible(true)]
[AttributeUsage(AttributeTargets.Assembly | AttributeTargets.Class | AttributeTargets.Struct | AttributeTargets.Constructor | AttributeTargets.Method, AllowMultiple = true, Inherited = false)]
[Obsolete("CAS support is not available with Silverlight applications.")]
public abstract class CodeAccessSecurityAttribute : SecurityAttribute
{
	protected CodeAccessSecurityAttribute(SecurityAction action)
		: base(action)
	{
	}
}
