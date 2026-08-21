using System;

namespace Mono.Btls;

[Flags]
internal enum MonoBtlsX509TrustKind
{
	DEFAULT = 0,
	TRUST_CLIENT = 1,
	TRUST_SERVER = 2,
	TRUST_ALL = 4,
	REJECT_CLIENT = 0x20,
	REJECT_SERVER = 0x40,
	REJECT_ALL = 0x80
}
