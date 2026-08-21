using System.Runtime.InteropServices;

namespace System.Security.Permissions;

[Serializable]
[Obsolete("CAS support is not available with Silverlight applications.")]
[ComVisible(true)]
public enum SecurityAction
{
	Demand = 2,
	Assert,
	[Obsolete("This requests should not be used")]
	Deny,
	PermitOnly,
	LinkDemand,
	InheritanceDemand,
	[Obsolete("This requests should not be used")]
	RequestMinimum,
	[Obsolete("This requests should not be used")]
	RequestOptional,
	[Obsolete("This requests should not be used")]
	RequestRefuse
}
