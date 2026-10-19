using System.Runtime.CompilerServices;

namespace System.Threading.Tasks;

[FriendAccessAllowed]
internal enum CausalityTraceLevel
{
	Required,
	Important,
	Verbose
}
