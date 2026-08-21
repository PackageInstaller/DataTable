using System;

namespace Mono.Btls;

[Flags]
internal enum MonoBtlsSslRenegotiateMode
{
	NEVER = 0,
	ONCE = 1,
	FREELY = 2,
	IGNORE = ONCE | FREELY
}
