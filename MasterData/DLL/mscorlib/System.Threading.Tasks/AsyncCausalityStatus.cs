using System.Runtime.CompilerServices;

namespace System.Threading.Tasks;

[FriendAccessAllowed]
internal enum AsyncCausalityStatus
{
	Started,
	Completed,
	Canceled,
	Error
}
